# Optional Supabase auth (Email + Google)

**Status:** Optional sign-in only. Local Drift plants/tasks do **not** require an account. Cloud sync is still out of scope.

## Create a Supabase project

1. Sign up at [supabase.com](https://supabase.com) and create a project (e.g. `bloom-app`).
2. Project Settings → **API**: copy **Project URL** and **anon public** key.
3. Authentication → Providers → **Email**: enable. Turn **Confirm email** on when you want the deep-link flow.
4. Authentication → URL configuration — must match the app constant `AuthConfig.emailRedirectTo`:
   - **Site URL:** `io.supabase.bloom://login-callback/`
   - **Redirect URLs:** add `io.supabase.bloom://login-callback/`

The Android app declares that custom scheme on `MainActivity`. Signup passes the same URL as `emailRedirectTo`. Open confirmation emails **on the phone** so Android can hand the link to Bloom (not a desktop browser).

## Google Sign-In (native + Supabase)

App code is already wired (`Continue with Google` on Account). You need **two** OAuth clients in the same Google Cloud project, plus Supabase Google enabled.

### A. Google Cloud Console

1. Open [Google Cloud Console](https://console.cloud.google.com/) → create or select a project (e.g. `bloom-app`).
2. **APIs & Services → OAuth consent screen**
   - User type: **External**
   - App name: Bloom; support email: yours
   - Add yourself as a **Test user** while the app is in Testing
3. **APIs & Services → Credentials → Create credentials → OAuth client ID**

   **Client 1 — Web application** (required)
   - Name: `Bloom Web (Supabase)`
   - Authorized redirect URIs: add your Supabase callback:

     `https://<YOUR_PROJECT_REF>.supabase.co/auth/v1/callback`

   - Copy **Client ID** and **Client secret**

   **Client 2 — Android** (required for the phone)
   - Name: `Bloom Android debug`
   - Package name: `design.chandrika.bloom`
   - SHA-1 (this machine’s debug keystore):

     `07:61:9A:C1:59:7D:40:8F:56:BF:7A:54:BF:2C:A4:8D:B6:A2:BB:8A`

   Re-print SHA-1 later with Android Studio’s keytool if needed:

```bash
"/Applications/Android Studio.app/Contents/jbr/Contents/Home/bin/keytool" \
  -list -v -alias androiddebugkey \
  -keystore ~/.android/debug.keystore -storepass android -keypass android
```

### B. Supabase dashboard

1. Authentication → Providers → **Google** → Enable
2. **Client ID** / **Client Secret**: paste the **Web** client values (not the Android client)
3. Enable **Skip nonce check** (required for native mobile id-token sign-in)

### C. Local `.env`

```bash
BLOOM_SUPABASE_URL=https://YOUR_PROJECT.supabase.co
BLOOM_SUPABASE_ANON_KEY=your-anon-key
# Must be the Web OAuth client ID from step A
BLOOM_GOOGLE_SERVER_CLIENT_ID=xxxxx.apps.googleusercontent.com
```

Full restart (defines are compile-time):

```bash
./tool/run_dev.sh -d <device-id>
```

In the app: **Settings → Sign in → Continue with Google**.

Use a Google account listed as a consent-screen **Test user** until the OAuth app is published.

## Security notes

- Only the **anon** key belongs in the app (dart-define). Never ship the service role key.
- Auth does not upload plant photos or care data yet.
- Identify proxy still uses its own secrets; wiring Supabase JWT to the Worker is a later step.
