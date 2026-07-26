import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/measurement_units.dart';
import 'package:bloom/features/settings/presentation/about_bloom_screen.dart';
import 'package:bloom/features/settings/presentation/account_screen.dart';
import 'package:bloom/shared/legal/bloom_legal.dart';
import 'package:bloom/shared/legal/markdown_document_screen.dart';
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
  var _units = MeasurementUnits.defaultUnits;
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
    final settings = BloomScope.of(context).settings;
    final enabled = await settings.getRemindersEnabled();
    final units = MeasurementUnits.fromStorage(await settings.getUnits());
    if (!mounted) {
      return;
    }
    setState(() {
      _remindersEnabled = enabled;
      _units = units;
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
                  : 'Notification permission was not granted. You can enable '
                        'it later in system settings for Bloom.',
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

  Future<void> _pickUnits() async {
    final selected = await showModalBottomSheet<MeasurementUnits>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(MeasurementUnits.metric.label),
                trailing: _units == MeasurementUnits.metric
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.pop(context, MeasurementUnits.metric),
              ),
              ListTile(
                title: Text(MeasurementUnits.imperial.label),
                trailing: _units == MeasurementUnits.imperial
                    ? const Icon(Icons.check)
                    : null,
                onTap: () => Navigator.pop(context, MeasurementUnits.imperial),
              ),
            ],
          ),
        );
      },
    );
    if (selected == null || !mounted) {
      return;
    }
    await BloomScope.of(context).settings.setUnits(selected.storageValue);
    if (!mounted) {
      return;
    }
    setState(() => _units = selected);
  }

  Future<void> _confirmDeleteAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete all local data?'),
          content: const Text(
            'This removes your plants, care history, tasks, and preferences '
            'from this device. Scheduled care reminders are cancelled. '
            'This cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete everything'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) {
      return;
    }

    final services = BloomScope.of(context).services;
    setState(() => _busy = true);
    try {
      await services.deleteAllLocalData();
      if (!mounted) {
        return;
      }
      setState(() {
        _remindersEnabled = false;
        _units = MeasurementUnits.defaultUnits;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All local Bloom data deleted.')),
      );
      Navigator.of(context).pop();
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final interactive = !_loading && !_busy;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          const Center(child: BloomLogo(size: 88, showWordmark: true)),
          const SizedBox(height: BloomSpacing.x2),
          Text(
            'Local-first plant care',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x6),
          _SettingsSection(
            title: 'Account',
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Sign in'),
                subtitle: Text(
                  BloomScope.of(context).services.auth.currentUser?.label ??
                      'Optional — plants stay on this device',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: interactive
                    ? () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const AccountScreen(),
                          ),
                        );
                        if (mounted) {
                          setState(() {});
                        }
                      }
                    : null,
              ),
            ],
          ),
          _SettingsSection(
            title: 'Reminders',
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_outlined),
                title: const Text('Care reminders'),
                subtitle: const Text(
                  'Schedule inexact care windows from open tasks. '
                  'Permission is requested when you turn this on, or after '
                  'you add your first plant.',
                ),
                value: _remindersEnabled,
                onChanged: interactive ? _onRemindersChanged : null,
              ),
              const ListTile(
                leading: Icon(Icons.battery_saver_outlined),
                title: Text('Battery restrictions'),
                subtitle: Text(
                  'Some phones pause background apps. If reminders are late, '
                  'check system battery settings for Bloom.',
                ),
              ),
            ],
          ),
          _SettingsSection(
            title: 'Preferences',
            children: [
              ListTile(
                leading: const Icon(Icons.straighten_outlined),
                title: const Text('Units'),
                subtitle: Text(_units.label),
                trailing: const Icon(Icons.chevron_right),
                onTap: interactive ? _pickUnits : null,
              ),
            ],
          ),
          _SettingsSection(
            title: 'Trust',
            children: [
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy'),
                subtitle: const Text(
                  'What Bloom stores on this device and how to delete it',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: interactive
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const MarkdownDocumentScreen(
                              title: 'Privacy',
                              assetPath: BloomLegal.privacyAssetPath,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                ),
                title: Text(
                  'Delete all local data',
                  style: TextStyle(color: theme.colorScheme.error),
                ),
                subtitle: const Text(
                  'Remove plants, history, tasks, photos, and preferences',
                ),
                onTap: interactive ? _confirmDeleteAll : null,
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About Bloom'),
                subtitle: Text(
                  'Version ${BloomLegal.versionLabel} · support & attribution',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: interactive
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const AboutBloomScreen(),
                          ),
                        );
                      }
                    : null,
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
