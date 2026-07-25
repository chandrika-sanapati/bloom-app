import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/widgets/bloom_logo.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var _loading = true;
  var _started = false;
  var _remindersEnabled = false;
  var _busy = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    _load();
  }

  Future<void> _load() async {
    final enabled = await BloomScope.of(context).settings.getRemindersEnabled();
    if (!mounted) {
      return;
    }
    setState(() {
      _remindersEnabled = enabled;
      _loading = false;
    });
  }

  Future<void> _onRemindersChanged(bool value) async {
    final services = BloomScope.of(context).services;
    setState(() => _busy = true);
    try {
      if (value) {
        final granted = await services.reminders.enableReminders();
        if (!mounted) {
          return;
        }
        setState(() => _remindersEnabled = granted);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              granted
                  ? 'Care reminders enabled for open tasks.'
                  : 'Notification permission was not granted.',
            ),
          ),
        );
      } else {
        await services.reminders.disableReminders();
        if (!mounted) {
          return;
        }
        setState(() => _remindersEnabled = false);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

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
          _SettingsSection(
            title: 'Reminders',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Care reminders'),
                subtitle: const Text(
                  'Schedule inexact care windows from open tasks. Permission is requested here.',
                ),
                value: _remindersEnabled,
                onChanged: (_loading || _busy) ? null : _onRemindersChanged,
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
