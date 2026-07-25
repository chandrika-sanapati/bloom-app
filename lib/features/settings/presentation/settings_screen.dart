import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/widgets/bloom_logo.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          const Center(child: BloomLogo(size: 88, showWordmark: true)),
          const SizedBox(height: BloomSpacing.x2),
          Text(
            'Placeholder brand mark',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x6),
          const _SettingsSection(
            title: 'Reminders',
            children: [
              ListTile(
                leading: Icon(Icons.notifications_outlined),
                title: Text('Care reminders'),
                subtitle: Text('Coming in the reminder spike'),
              ),
            ],
          ),
          const _SettingsSection(
            title: 'Preferences',
            children: [
              ListTile(
                leading: Icon(Icons.straighten_outlined),
                title: Text('Units'),
                subtitle: Text('Metric by default'),
              ),
            ],
          ),
          const _SettingsSection(
            title: 'Trust',
            children: [
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined),
                title: Text('Privacy'),
                subtitle: Text('Local-first; policy copy comes later'),
              ),
              ListTile(
                leading: Icon(Icons.delete_outline),
                title: Text('Delete all local data'),
                subtitle: Text('Not wired yet'),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('About Bloom'),
                subtitle: Text('Version 1.0.0+1'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: BloomSpacing.x6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: BloomSpacing.x2,
              bottom: BloomSpacing.x2,
            ),
            child: Text(
              title.toUpperCase(),
              style: theme.textTheme.labelSmall?.copyWith(letterSpacing: 0.6),
            ),
          ),
          Card(child: Column(children: children)),
        ],
      ),
    );
  }
}
