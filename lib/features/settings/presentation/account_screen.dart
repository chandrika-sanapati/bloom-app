import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/auth/auth_repository.dart';
import 'package:bloom/data/auth/auth_user.dart';
import 'package:flutter/material.dart';

/// Optional account. Local care data does not require sign-in.
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _busy = false;
  var _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  AuthRepository get _auth => BloomScope.of(context).services.auth;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } on BloomAuthException catch (e) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (_) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Something went wrong. Try again.')),
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _signIn() async {
    await _run(() async {
      await _auth.signInWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Signed in.')));
    });
  }

  Future<void> _signUp() async {
    final password = _passwordController.text;
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Use a password with at least 6 characters.'),
        ),
      );
      return;
    }
    await _run(() async {
      await _auth.signUpWithEmail(
        email: _emailController.text,
        password: password,
      );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Account ready.')));
    });
  }

  Future<void> _google() async {
    await _run(() async {
      await _auth.signInWithGoogle();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Signed in with Google.')));
    });
  }

  Future<void> _signOut() async {
    await _run(() async {
      await _auth.signOut();
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Signed out.')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = _auth;

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: StreamBuilder<AuthUser?>(
        stream: auth.authStateChanges(),
        initialData: auth.currentUser,
        builder: (context, snapshot) {
          final user = snapshot.data ?? auth.currentUser;
          return ListView(
            padding: const EdgeInsets.all(BloomSpacing.screenMargin),
            children: [
              Text(
                'Optional — Bloom works fully offline without an account. '
                'Sign-in is for identity only; plants stay on this device for now.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: BloomSpacing.x5),
              if (!auth.isConfigured)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('Supabase not configured'),
                    subtitle: const Text(
                      'Add BLOOM_SUPABASE_URL and BLOOM_SUPABASE_ANON_KEY to '
                      '.env, then restart with ./tool/run_dev.sh. '
                      'See docs/AUTH_SUPABASE.md.',
                    ),
                  ),
                )
              else if (user != null) ...[
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(user.label),
                  subtitle: Text(user.email ?? user.id),
                ),
                const SizedBox(height: BloomSpacing.x3),
                FilledButton(
                  onPressed: _busy ? null : _signOut,
                  child: const Text('Sign out'),
                ),
              ] else ...[
                if (auth.supportsGoogleSignIn) ...[
                  FilledButton.icon(
                    onPressed: _busy ? null : _google,
                    icon: const Icon(Icons.login),
                    label: const Text('Continue with Google'),
                  ),
                  const SizedBox(height: BloomSpacing.x4),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: BloomSpacing.x3,
                        ),
                        child: Text(
                          'or email',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: BloomSpacing.x4),
                ],
                TextField(
                  controller: _emailController,
                  enabled: !_busy,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: BloomSpacing.x3),
                TextField(
                  controller: _passwordController,
                  enabled: !_busy,
                  obscureText: _obscure,
                  autofillHints: const [AutofillHints.password],
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: BloomSpacing.x4),
                FilledButton(
                  onPressed: _busy ? null : _signIn,
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: BloomSpacing.x2),
                OutlinedButton(
                  onPressed: _busy ? null : _signUp,
                  child: const Text('Create account'),
                ),
                if (!auth.supportsGoogleSignIn) ...[
                  const SizedBox(height: BloomSpacing.x4),
                  Text(
                    'Google one-tap needs BLOOM_GOOGLE_SERVER_CLIENT_ID '
                    '(Web client ID) in .env.',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ],
              if (_busy) ...[
                const SizedBox(height: BloomSpacing.x5),
                const Center(child: CircularProgressIndicator()),
              ],
            ],
          );
        },
      ),
    );
  }
}
