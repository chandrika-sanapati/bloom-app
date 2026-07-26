import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/legal/bloom_legal.dart';
import 'package:bloom/shared/legal/markdown_document_screen.dart';
import 'package:bloom/shared/widgets/bloom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBloomScreen extends StatelessWidget {
  const AboutBloomScreen({super.key});

  Future<void> _contactSupport(BuildContext context) async {
    final uri = BloomLegal.supportMailto;
    final launched = await launchUrl(uri);
    if (launched || !context.mounted) {
      return;
    }
    await Clipboard.setData(ClipboardData(text: BloomLegal.supportEmail));
    if (!context.mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Could not open mail. Copied ${BloomLegal.supportEmail}.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('About Bloom')),
      body: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          const Center(child: BloomLogo(size: 88, showWordmark: true)),
          const SizedBox(height: BloomSpacing.x3),
          Text(
            'Local-first plant care for a small indoor collection.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: BloomSpacing.x6),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: const Text('Version'),
                  subtitle: Text(BloomLegal.versionLabel),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Developer'),
                  subtitle: Text(
                    BloomLegal.supportEmailIsProvisional
                        ? '${BloomLegal.developerName} (provisional public identity)'
                        : BloomLegal.developerName,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.mail_outline),
                  title: const Text('Support'),
                  subtitle: Text(
                    BloomLegal.supportEmailIsProvisional
                        ? '${BloomLegal.supportEmail} (provisional)'
                        : BloomLegal.supportEmail,
                  ),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _contactSupport(context),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined),
                  title: const Text('Attribution'),
                  subtitle: const Text('Catalog photo licenses and credits'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const MarkdownDocumentScreen(
                          title: 'Attribution',
                          assetPath: BloomLegal.attributionAssetPath,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: BloomSpacing.x4),
          Text(
            'Care schedules are suggestions for typical indoor conditions. '
            'Bloom does not diagnose pests or disease.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
