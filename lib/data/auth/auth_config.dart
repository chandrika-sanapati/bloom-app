/// Compile-time auth configuration (dart-defines / `.env` via `tool/run_dev.sh`).
abstract final class AuthConfig {
  static const supabaseUrl = String.fromEnvironment('BLOOM_SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment(
    'BLOOM_SUPABASE_ANON_KEY',
  );

  /// Google Cloud **Web** OAuth client ID (used as `serverClientId`).
  static const googleServerClientId = String.fromEnvironment(
    'BLOOM_GOOGLE_SERVER_CLIENT_ID',
  );

  /// Must match Supabase Authentication → URL configuration (Site URL + Redirect URLs).
  static const emailRedirectTo = 'io.supabase.bloom://login-callback/';

  static bool get isConfigured =>
      supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;

  static bool get googleSignInConfigured =>
      isConfigured && googleServerClientId.trim().isNotEmpty;
}
