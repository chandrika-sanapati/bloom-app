import 'package:bloom/data/auth/auth_config.dart';
import 'package:bloom/data/auth/auth_repository.dart';
import 'package:bloom/data/auth/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository({SupabaseClient? client, GoogleSignIn? googleSignIn})
    : _client = client ?? Supabase.instance.client,
      _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final SupabaseClient _client;
  final GoogleSignIn _googleSignIn;
  var _googleReady = false;

  @override
  bool get isConfigured => true;

  @override
  bool get supportsGoogleSignIn => AuthConfig.googleSignInConfigured;

  @override
  AuthUser? get currentUser => _mapUser(_client.auth.currentUser);

  @override
  Stream<AuthUser?> authStateChanges() {
    return _client.auth.onAuthStateChange.map(
      (event) => _mapUser(event.session?.user),
    );
  }

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final user = _mapUser(response.user);
      if (user == null) {
        throw const BloomAuthException('Sign-in did not return a user.');
      }
      return user;
    } on BloomAuthException {
      rethrow;
    } on AuthApiException catch (e) {
      throw BloomAuthException(e.message);
    } catch (_) {
      throw const BloomAuthException(
        'Could not sign in. Check email and password.',
      );
    }
  }

  @override
  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email.trim(),
        password: password,
      );
      final user = _mapUser(response.user);
      if (user == null) {
        throw const BloomAuthException(
          'Check your email to confirm the account, then sign in.',
        );
      }
      // Email-confirm projects return a user with no session until confirmed.
      if (_client.auth.currentSession == null) {
        throw const BloomAuthException(
          'Account created. Confirm your email, then sign in.',
        );
      }
      return user;
    } on BloomAuthException {
      rethrow;
    } on AuthApiException catch (e) {
      throw BloomAuthException(e.message);
    } catch (_) {
      throw const BloomAuthException(
        'Could not create that account. Try again.',
      );
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    if (!supportsGoogleSignIn) {
      throw const BloomAuthException(
        'Google sign-in needs BLOOM_GOOGLE_SERVER_CLIENT_ID in .env.',
      );
    }
    try {
      await _ensureGoogleInitialized();
      final account = await _googleSignIn.authenticate();
      const scopes = ['email', 'profile'];
      final authorization =
          await account.authorizationClient.authorizationForScopes(scopes) ??
          await account.authorizationClient.authorizeScopes(scopes);
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const BloomAuthException(
          'Google did not return an ID token. Check the Web client ID.',
        );
      }
      final response = await _client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      final user = _mapUser(response.user);
      if (user == null) {
        throw const BloomAuthException('Google sign-in did not return a user.');
      }
      return user;
    } on BloomAuthException {
      rethrow;
    } on AuthApiException catch (e) {
      throw BloomAuthException(e.message);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const BloomAuthException('Google sign-in was cancelled.');
      }
      throw BloomAuthException('Google sign-in failed (${e.code.name}).');
    } catch (_) {
      throw const BloomAuthException('Google sign-in failed. Try again.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (_googleReady) {
        await _googleSignIn.signOut();
      }
    } catch (_) {
      // Continue signing out of Supabase even if Google cleanup fails.
    }
    await _client.auth.signOut();
  }

  Future<void> _ensureGoogleInitialized() async {
    if (_googleReady) {
      return;
    }
    await _googleSignIn.initialize(
      serverClientId: AuthConfig.googleServerClientId.trim(),
    );
    _googleReady = true;
  }

  AuthUser? _mapUser(User? user) {
    if (user == null) {
      return null;
    }
    final meta = user.userMetadata;
    final name = meta?['full_name'] as String? ?? meta?['name'] as String?;
    return AuthUser(id: user.id, email: user.email, displayName: name);
  }
}
