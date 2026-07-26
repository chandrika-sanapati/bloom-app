import 'package:bloom/data/auth/auth_user.dart';

/// Optional account identity. Local plants/tasks stay on-device regardless.
abstract class AuthRepository {
  /// False when Supabase dart-defines are missing (auth UI shows setup hint).
  bool get isConfigured;

  bool get supportsGoogleSignIn;

  AuthUser? get currentUser;

  Stream<AuthUser?> authStateChanges();

  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> signInWithGoogle();

  Future<void> signOut();
}

class BloomAuthException implements Exception {
  const BloomAuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
