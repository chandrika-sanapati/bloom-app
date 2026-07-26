# Optional Supabase auth (Email + Google)

**Status:** Optional sign-in only. Local Drift plants/tasks do **not** require an account. Cloud sync is still out of scope.

## Create a Supabase project

1. Sign up at [supabase.com](https://supabase.com) and create a project (e.g. `bloom-app`).
2. Project Settings → **API**: copy **Project URL** and **anon public** key.
3. Authentication → Providers → **Email**: enable. For closed-beta speed, you may turn off **Confirm email** under Authentication → Providers → Email (or Auth settings).
4. Authentication → URL configuration: set Site URL to a placeholder (e.g. `https://bloom-app.workers.dev`) until you have a marketing site.

## Google one-tap

1. [Google Cloud Console](https://console.cloud.google.com/) → create/select a project.
2. APIs & Services → **OAuth consent screen** → External → fill app name + support email.
3. Credentials → **Create OAuth client ID**:
   - **Web application** (required for Supabase / `serverClientId`) — copy Client ID (+ secret for Supabase dashboard).
   - **Android** — package `design.chandrika.bloom`, SHA-1 from debug keystore:

```bash
keytool -list -v -alias androiddebugkey \
  -keystore ~/.android/debug.keystore -storepass android -keypass android
```

4. Supabase → Authentication → Providers → **Google**:
   - Enable
   - Client IDs: paste the **Web** client ID (and secret)
   - Enable **Skip nonce check** (needed for native mobile id-token flow)

## Local `.env`

```bash
BLOOM_SUPABASE_URL=https://YOUR_PROJECT.supabase.co
BLOOM_SUPABASE_ANON_KEY=your-anon-key
BLOOM_GOOGLE_SERVER_CLIENT_ID=xxxxx.apps.googleusercontent.com
```

Restart with:

```bash
./tool/run_dev.sh -d <device-id>
```

In the app: **Settings → Sign in**.

## Security notes

- Only the **anon** key belongs in the app (dart-define). Never ship the service role key.
- Auth does not upload plant photos or care data yet.
- Identify proxy still uses its own secrets; wiring Supabase JWT to the Worker is a later step.
