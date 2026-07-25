import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/presentation/care_ui_mappers.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/care_task_row.dart';
import 'package:flutter/material.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({required this.plantId, super.key});

  final String plantId;

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  int _tabIndex = 0;
  var _loading = true;
  var _started = false;
  FixturePlant? _plant;
  List<FixtureCareTask> _openTasks = const [];
  List<FixtureCareHistoryEvent> _history = const [];
  List<FixtureCarePlanItem> _carePlan = const [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    _reload();
  }

  Future<void> _reload() async {
    final care = BloomScope.of(context).care;
    final record = await care.getUserPlantRecord(widget.plantId);
    if (record == null) {
      if (mounted) {
        setState(() {
          _plant = null;
          _loading = false;
        });
      }
      return;
    }

    final tasks = await care.listTasksForPlant(widget.plantId);
    final events = await care.listCareEvents(widget.plantId);
    final plan = await care.getCarePlan(widget.plantId);
    final accent = Color(record.species.accentArgb);

    if (!mounted) {
      return;
    }

    setState(() {
      _plant = toFixturePlant(record);
      _openTasks = [
        for (final task in tasks.where((t) => !t.isDone))
          toFixtureTask(
            task: task,
            plantName: record.plant.displayName,
            accent: accent,
          ),
      ];
      _history = events.map(toFixtureHistoryEvent).toList();
      _carePlan = plan.map(toFixturePlanItem).toList();
      _loading = false;
    });
  }

  Future<void> _setTaskDone(FixtureCareTask task, bool isDone) async {
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
    await _reload();
  }

  Future<void> _logCare() async {
    final services = BloomScope.of(context).services;
    await services.care.addCareEvent(
      domain.CareEvent(
        id: 'event-log-${widget.plantId}-${DateTime.now().millisecondsSinceEpoch}',
        userPlantId: widget.plantId,
        kind: domain.CareActionKind.water,
        label: 'Logged care',
        occurredAt: DateTime.now(),
      ),
    );
    if (!mounted) {
      return;
    }
    services.notifyDataChanged();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Care logged to timeline.')));
    await _reload();
  }

  Future<void> _confirmDeletePlant() async {
    final plant = _plant;
    if (plant == null) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove ${plant.commonName}?'),
          content: const Text(
            'This deletes the plant, its care plan, open tasks, and timeline '
            'from this device. Scheduled reminders for it are cleared.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Remove plant'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) {
      return;
    }

    final services = BloomScope.of(context).services;
    final name = plant.commonName;
    await services.deleteUserPlant(widget.plantId);
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$name removed from My Plants.')));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Plant')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final plant = _plant;
    if (plant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Plant')),
        body: const Center(child: Text('Plant not found.')),
      );
    }

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plant.commonName, style: theme.textTheme.titleMedium),
            Text(
              plant.scientificName,
              style: theme.textTheme.bodySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Remove plant',
            onPressed: _confirmDeletePlant,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 160,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: plant.accent.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(BloomRadii.card),
                  border: Border.all(color: BloomColors.borderSubtle),
                ),
                child: Icon(Icons.local_florist, size: 64, color: plant.accent),
              ),
            ),
            const SizedBox(height: BloomSpacing.x4),
            Row(
              children: [
                BloomStatusChip(
                  label: BloomFixtures.difficultyLabel(plant.difficulty),
                  color: BloomColors.brandGreen,
                  icon: Icons.spa_outlined,
                ),
                const SizedBox(width: BloomSpacing.x2),
                BloomStatusChip(
                  label: plant.statusLabel,
                  color: BloomColors.statusDueToday,
                  icon: Icons.eco_outlined,
                ),
              ],
            ),
            const SizedBox(height: BloomSpacing.x4),
            SegmentedButton<int>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: 0, label: Text('Care')),
                ButtonSegment(value: 1, label: Text('About')),
              ],
              selected: {_tabIndex},
              onSelectionChanged: (value) {
                setState(() => _tabIndex = value.first);
              },
            ),
            const SizedBox(height: BloomSpacing.x5),
            if (_tabIndex == 0) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Open tasks',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: _logCare,
                    child: const Text('Log care'),
                  ),
                ],
              ),
              const SizedBox(height: BloomSpacing.x3),
              if (_openTasks.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BloomSpacing.x5),
                    child: Text(
                      'No open tasks for this plant right now.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                )
              else
                ..._openTasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                    child: CareTaskRow(
                      task: task,
                      isDone: false,
                      onToggle: (done) => _setTaskDone(task, done),
                    ),
                  ),
                ),
              const SizedBox(height: BloomSpacing.x5),
              Text('Timeline', style: theme.textTheme.titleMedium),
              const SizedBox(height: BloomSpacing.x3),
              if (_history.isEmpty)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BloomSpacing.x5),
                    child: Text(
                      'No care history yet. Logged actions will appear here.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                )
              else
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(BloomSpacing.x4),
                    child: Column(
                      children: [
                        for (var i = 0; i < _history.length; i++) ...[
                          _TimelineRow(event: _history[i]),
                          if (i != _history.length - 1)
                            const Divider(height: BloomSpacing.x6),
                        ],
                      ],
                    ),
                  ),
                ),
            ] else ...[
              Text('Plant overview', style: theme.textTheme.titleMedium),
              const SizedBox(height: BloomSpacing.x3),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(BloomSpacing.x4),
                  child: Text(
                    plant.overview,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: BloomSpacing.x5),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Care plan',
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Care plan editing UI comes next.'),
                        ),
                      );
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
              Text(
                'Suggested guidance — adjust to your home. No exact volumes yet.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: BloomSpacing.x3),
              Card(
                child: Column(
                  children: [
                    for (var i = 0; i < _carePlan.length; i++) ...[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: BloomFixtures.careActionColor(
                            _carePlan[i].kind,
                          ).withValues(alpha: 0.15),
                          child: Icon(
                            BloomFixtures.careActionIcon(_carePlan[i].kind),
                            color: BloomFixtures.careActionColor(
                              _carePlan[i].kind,
                            ),
                          ),
                        ),
                        title: Text(_carePlan[i].title),
                        subtitle: Text(_carePlan[i].cadenceLabel),
                      ),
                      if (i != _carePlan.length - 1) const Divider(height: 1),
                    ],
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.event});

  final FixtureCareHistoryEvent event;

  static const _weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = event.occurredOn;
    final weekday = _weekdays[date.weekday - 1];
    final month = _months[date.month - 1];
    final color = BloomFixtures.careActionColor(event.kind);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 56,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${date.day}', style: theme.textTheme.titleMedium),
              Text('$weekday · $month', style: theme.textTheme.labelSmall),
            ],
          ),
        ),
        const SizedBox(width: BloomSpacing.x3),
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(
            BloomFixtures.careActionIcon(event.kind),
            size: 18,
            color: color,
          ),
        ),
        const SizedBox(width: BloomSpacing.x3),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: BloomSpacing.x2),
            child: Text(event.label, style: theme.textTheme.titleSmall),
          ),
        ),
      ],
    );
  }
}
