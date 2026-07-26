import 'package:bloom/data/auth/auth_repository.dart';
import 'package:bloom/data/auth/auth_user.dart';

/// Used when Supabase is not configured — app stays fully local.
class DisabledAuthRepository implements AuthRepository {
  @override
  bool get isConfigured => false;

  @override
  bool get supportsGoogleSignIn => false;

  @override
  AuthUser? get currentUser => null;

  @override
  Stream<AuthUser?> authStateChanges() => Stream<AuthUser?>.value(null);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) {
    throw const BloomAuthException(
      'Sign-in is not configured. Add Supabase keys to .env.',
    );
  }

  @override
  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
  }) {
    throw const BloomAuthException(
      'Sign-in is not configured. Add Supabase keys to .env.',
    );
  }

  @override
  Future<AuthUser> signInWithGoogle() {
    throw const BloomAuthException(
      'Google sign-in is not configured. Add Supabase and Google client IDs.',
    );
  }

  @override
  Future<void> signOut() async {}
}
