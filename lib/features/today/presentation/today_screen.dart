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
          ),
      ];
      _loading = false;
    });
  }

  Future<void> _setDone(FixtureCareTask task, bool isDone) async {
    final services = BloomScope.of(context).services;
    final care = services.care;
    final existing = await care.getCareTask(task.id);
    if (existing == null) {
      return;
    }
    await care.upsertCareTask(
      domain.CareTask(
        id: existing.id,
        userPlantId: existing.userPlantId,
        actionLabel: existing.actionLabel,
        urgency: existing.urgency,
        dueAt: existing.dueAt,
        isDone: isDone,
      ),
    );
    if (isDone) {
      await care.addCareEvent(
        domain.CareEvent(
          id: 'event-${task.id}-${DateTime.now().millisecondsSinceEpoch}',
          userPlantId: task.plantId,
          kind: domain.CareActionKind.check,
          label: '${task.actionLabel} done',
          occurredAt: DateTime.now(),
        ),
      );
    }
    services.notifyDataChanged();
  }

  Future<void> _restore() async {
    final services = BloomScope.of(context).services;
    await services.seeder.restoreSampleTasks();
    services.notifyDataChanged();
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
            _AllCaughtUpCard(onReset: _restore)
          else
            ..._open.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: CareTaskRow(
                  task: task,
                  isDone: false,
                  onOpenPlant: () => openPlantDetail(context, task.plantId),
                  onToggle: (_) => _setDone(task, true),
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

class _AllCaughtUpCard extends StatelessWidget {
  const _AllCaughtUpCard({required this.onReset});

  final Future<void> Function() onReset;

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
              'Your plants are happy. Restore sample tasks to keep exploring.',
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: BloomSpacing.x4),
            FilledButton.tonal(
              onPressed: onReset,
              child: const Text('Restore sample tasks'),
            ),
          ],
        ),
      ),
    );
  }
}
