import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/features/plants/presentation/plant_navigation.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/presentation/care_ui_mappers.dart';
import 'package:bloom/shared/widgets/care_task_row.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  var _loading = true;
  var _started = false;
  List<FixtureCareTask> _open = const [];
  List<FixtureCareTask> _completed = const [];
  ValueNotifier<int>? _revision;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final revision = BloomScope.of(context).services.dataRevision;
    if (_revision != revision) {
      _revision?.removeListener(_reload);
      _revision = revision;
      _revision!.addListener(_reload);
    }
    if (_started) {
      return;
    }
    _started = true;
    _reload();
  }

  @override
  void dispose() {
    _revision?.removeListener(_reload);
    super.dispose();
  }

  Future<void> _reload() async {
    final care = BloomScope.of(context).care;
    final openTasks = await care.listOpenTasksForToday();
    final doneTasks = await care.listCompletedTasks();
    final records = {
      for (final record in await care.listUserPlantRecords())
        record.plant.id: record,
    };

    if (!mounted) {
      return;
    }

    setState(() {
      _open = [
        for (final task in openTasks)
          toFixtureTask(
            task: task,
            plantName: records[task.userPlantId]?.plant.displayName ?? 'Plant',
            accent: Color(
              records[task.userPlantId]?.species.accentArgb ?? 0xFF2AAA8A,
            ),
            photoPath: records[task.userPlantId]?.plant.photoPath,
          ),
      ];
      _completed = [
        for (final task in doneTasks)
          toFixtureTask(
            task: task,
            plantName: records[task.userPlantId]?.plant.displayName ?? 'Plant',
            accent: Color(
              records[task.userPlantId]?.species.accentArgb ?? 0xFF2AAA8A,
            ),
            photoPath: records[task.userPlantId]?.plant.photoPath,
          ),
      ];
      _loading = false;
    });
  }

  Future<void> _setDone(FixtureCareTask task, bool isDone) async {
    final services = BloomScope.of(context).services;
    if (isDone) {
      await services.reminders.completeTask(task.id);
      return;
    }

    final existing = await services.care.getCareTask(task.id);
    if (existing == null) {
      return;
    }
    await services.care.upsertCareTask(
      domain.CareTask(
        id: existing.id,
        userPlantId: existing.userPlantId,
        actionLabel: existing.actionLabel,
        urgency: existing.urgency,
        dueAt: existing.dueAt,
        isDone: false,
      ),
    );
    services.notifyDataChanged();
  }

  Future<void> _onMenuAction(
    FixtureCareTask task,
    CareTaskMenuAction action,
  ) async {
    switch (action) {
      case CareTaskMenuAction.snooze:
        await _snoozeTask(task);
      case CareTaskMenuAction.skip:
        await _skipTask(task);
      case CareTaskMenuAction.reschedule:
        await _rescheduleTask(task);
    }
  }

  Future<void> _snoozeTask(FixtureCareTask task) async {
    final choice = await showModalBottomSheet<_SnoozeChoice>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Snooze 1 hour'),
                onTap: () => Navigator.pop(context, _SnoozeChoice.oneHour),
              ),
              ListTile(
                title: const Text('Snooze 3 hours'),
                onTap: () => Navigator.pop(context, _SnoozeChoice.threeHours),
              ),
              ListTile(
                title: const Text('Tomorrow morning'),
                subtitle: const Text('9:00 AM'),
                onTap: () =>
                    Navigator.pop(context, _SnoozeChoice.tomorrowMorning),
              ),
            ],
          ),
        );
      },
    );
    if (choice == null || !mounted) {
      return;
    }

    final reminders = BloomScope.of(context).services.reminders;
    switch (choice) {
      case _SnoozeChoice.oneHour:
        await reminders.snoozeTask(task.id);
      case _SnoozeChoice.threeHours:
        await reminders.snoozeTask(task.id, delay: const Duration(hours: 3));
      case _SnoozeChoice.tomorrowMorning:
        final now = DateTime.now();
        final nextDay = DateTime(
          now.year,
          now.month,
          now.day,
        ).add(const Duration(days: 1));
        final tomorrowMorning = DateTime(
          nextDay.year,
          nextDay.month,
          nextDay.day,
          9,
        );
        await reminders.snoozeTask(task.id, until: tomorrowMorning);
    }
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Snoozed')));
  }

  Future<void> _skipTask(FixtureCareTask task) async {
    await BloomScope.of(context).services.reminders.skipTask(task.id);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Skipped')));
  }

  Future<void> _rescheduleTask(FixtureCareTask task) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now.add(const Duration(hours: 1))),
    );
    if (time == null || !mounted) {
      return;
    }

    final dueAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    await BloomScope.of(
      context,
    ).services.reminders.rescheduleTask(task.id, dueAt);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Rescheduled')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          Text('Good day', style: theme.textTheme.titleLarge),
          const SizedBox(height: BloomSpacing.x1),
          Text(
            _open.isEmpty
                ? 'All caught up — your garden is thriving.'
                : 'Here is what needs care today.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x5),
          Text("Today's tasks", style: theme.textTheme.titleMedium),
          const SizedBox(height: BloomSpacing.x3),
          if (_open.isEmpty)
            const _AllCaughtUpCard()
          else
            ..._open.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: CareTaskRow(
                  task: task,
                  isDone: false,
                  onOpenPlant: () => openPlantDetail(context, task.plantId),
                  onToggle: (_) => _setDone(task, true),
                  onMenuAction: (action) => _onMenuAction(task, action),
                ),
              ),
            ),
          if (_completed.isNotEmpty) ...[
            const SizedBox(height: BloomSpacing.x4),
            Text('Completed', style: theme.textTheme.titleMedium),
            const SizedBox(height: BloomSpacing.x3),
            ..._completed.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: CareTaskRow(
                  task: task,
                  isDone: true,
                  onOpenPlant: () => openPlantDetail(context, task.plantId),
                  onToggle: (_) => _setDone(task, false),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum _SnoozeChoice { oneHour, threeHours, tomorrowMorning }

class _AllCaughtUpCard extends StatelessWidget {
  const _AllCaughtUpCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(BloomSpacing.x6),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 40,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: BloomSpacing.x3),
            Text('All done for today!', style: theme.textTheme.titleMedium),
            const SizedBox(height: BloomSpacing.x2),
            Text(
              'Your plants are happy. Add more from Discover, or check '
              'My Plants anytime.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
