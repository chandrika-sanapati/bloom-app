class AuthUser {
  const AuthUser({required this.id, this.email, this.displayName});

  final String id;
  final String? email;
  final String? displayName;

  String get label {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) {
      return name;
    }
    final mail = email?.trim();
    if (mail != null && mail.isNotEmpty) {
      return mail;
    }
    return 'Signed in';
  }
}
