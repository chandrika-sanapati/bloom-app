import { Hono } from 'hono';
import { HTTPException } from 'hono/http-exception';

type Env = {
  PLANTNET_API_KEY: string;
  BLOOM_APP_TOKEN?: string;
  PLANTNET_PROJECT?: string;
  RATE_LIMIT_PER_HOUR?: string;
  MAX_UPLOAD_BYTES?: string;
};

const app = new Hono<{ Bindings: Env }>();

/** Per-isolate sliding window. Good enough for closed-beta abuse dampening. */
const rateBuckets = new Map<string, number[]>();

app.get('/health', (c) =>
  c.json({
    ok: true,
    service: 'bloom-identify-proxy',
    version: '0.1.0',
  }),
);

app.post('/v1/identify', async (c) => {
  const apiKey = c.env.PLANTNET_API_KEY?.trim();
  if (!apiKey) {
    throw new HTTPException(500, {
      message: 'Identify proxy is not configured.',
    });
  }

  assertClientToken(c.req.header('authorization'), c.env.BLOOM_APP_TOKEN);
  enforceRateLimit(
    clientKey(c.req.raw),
    Number.parseInt(c.env.RATE_LIMIT_PER_HOUR ?? '60', 10) || 60,
  );

  const contentType = c.req.header('content-type') ?? '';
  if (!contentType.includes('multipart/form-data')) {
    throw new HTTPException(415, {
      message: 'Expected multipart/form-data with an images file.',
    });
  }

  const form = await c.req.formData();
  const image = firstImage(form);
  if (!image) {
    throw new HTTPException(400, {
      message: 'Missing images file field.',
    });
  }

  const maxBytes =
    Number.parseInt(c.env.MAX_UPLOAD_BYTES ?? '5242880', 10) || 5_242_880;
  if (image.size > maxBytes) {
    throw new HTTPException(413, {
      message: 'Image is too large. Use a smaller photo.',
    });
  }

  const lang = c.req.query('lang') ?? 'en';
  const nbResults = c.req.query('nb-results') ?? '5';
  const project = c.env.PLANTNET_PROJECT?.trim() || 'all';
  const plantNetUrl = new URL(
    `https://my-api.plantnet.org/v2/identify/${encodeURIComponent(project)}`,
  );
  plantNetUrl.searchParams.set('api-key', apiKey);
  plantNetUrl.searchParams.set('lang', lang);
  plantNetUrl.searchParams.set('nb-results', nbResults);

  const forward = new FormData();
  forward.append('images', image, image.name || 'plant.jpg');
  forward.append('organs', String(form.get('organs') ?? 'auto'));

  let upstream: Response;
  try {
    upstream = await fetch(plantNetUrl.toString(), {
      method: 'POST',
      body: forward,
      signal: AbortSignal.timeout(18_000),
    });
  } catch {
    throw new HTTPException(502, {
      message: 'Could not reach Pl@ntNet. Try again shortly.',
    });
  }

  const bodyText = await upstream.text();

  if (upstream.status === 429) {
    return c.json(
      {
        error: 'rate_limit',
        message: 'Daily identification limit reached.',
      },
      429,
    );
  }

  if (!upstream.ok) {
    console.warn('plantnet_upstream_error', {
      status: upstream.status,
      // Never log image bytes or the API key.
      bytes: image.size,
    });
    return c.json(
      {
        error: 'upstream_error',
        message: 'Identification failed.',
        status: upstream.status,
      },
      upstream.status >= 500 ? 502 : 400,
    );
  }

  // Image bytes live only in this request; nothing is written to durable storage.
  console.info('identify_ok', {
    status: upstream.status,
    bytes: image.size,
  });

  return new Response(bodyText, {
    status: 200,
    headers: {
      'content-type': 'application/json; charset=utf-8',
      'cache-control': 'no-store',
    },
  });
});

app.notFound((c) => c.json({ error: 'not_found' }, 404));

app.onError((err, c) => {
  if (err instanceof HTTPException) {
    return c.json({ error: 'request_error', message: err.message }, err.status);
  }
  console.error('identify_proxy_error', String(err));
  return c.json({ error: 'internal_error', message: 'Unexpected error.' }, 500);
});

function assertClientToken(
  authorization: string | undefined,
  expected: string | undefined,
): void {
  const token = expected?.trim();
  if (!token) {
    return;
  }
  const presented = authorization?.replace(/^Bearer\s+/i, '').trim();
  if (!presented || presented !== token) {
    throw new HTTPException(401, {
      message: 'Unauthorized identify client.',
    });
  }
}

function clientKey(request: Request): string {
  return (
    request.headers.get('cf-connecting-ip') ??
    request.headers.get('x-forwarded-for')?.split(',')[0]?.trim() ??
    'unknown'
  );
}

function enforceRateLimit(key: string, limitPerHour: number): void {
  const now = Date.now();
  const windowMs = 60 * 60 * 1000;
  const prior = rateBuckets.get(key) ?? [];
  const recent = prior.filter((ts) => now - ts < windowMs);
  if (recent.length >= limitPerHour) {
    throw new HTTPException(429, {
      message: 'Too many identification requests. Try again later.',
    });
  }
  recent.push(now);
  rateBuckets.set(key, recent);
}

function firstImage(form: FormData): File | null {
  const values = form.getAll('images');
  for (const value of values) {
    if (value instanceof File && value.size > 0) {
      return value;
    }
  }
  // Some clients send a single `image` field.
  const alt = form.get('image');
  if (alt instanceof File && alt.size > 0) {
    return alt;
  }
  return null;
}

export default app;
