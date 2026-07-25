import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
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
  final Set<String> _completedTaskIds = {};

  @override
  Widget build(BuildContext context) {
    final plant = BloomFixtures.plantById(widget.plantId);
    if (plant == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Plant')),
        body: const Center(child: Text('Plant not found.')),
      );
    }

    final theme = Theme.of(context);
    final openTasks = BloomFixtures.tasksForPlant(
      plant.id,
    ).where((task) => !_completedTaskIds.contains(task.id)).toList();
    final history = BloomFixtures.historyForPlant(plant.id);
    final carePlan = BloomFixtures.carePlanForPlant(plant.id);

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
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Log care will write to history after persistence lands.',
                          ),
                        ),
                      );
                    },
                    child: const Text('Log care'),
                  ),
                ],
              ),
              const SizedBox(height: BloomSpacing.x3),
              if (openTasks.isEmpty)
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
                ...openTasks.map(
                  (task) => Padding(
                    padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                    child: CareTaskRow(
                      task: task,
                      isDone: false,
                      onToggle: (done) {
                        setState(() {
                          if (done) {
                            _completedTaskIds.add(task.id);
                          } else {
                            _completedTaskIds.remove(task.id);
                          }
                        });
                      },
                    ),
                  ),
                ),
              const SizedBox(height: BloomSpacing.x5),
              Text('Timeline', style: theme.textTheme.titleMedium),
              const SizedBox(height: BloomSpacing.x3),
              if (history.isEmpty)
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
                        for (var i = 0; i < history.length; i++) ...[
                          _TimelineRow(event: history[i]),
                          if (i != history.length - 1)
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
                          content: Text(
                            'Editing the care plan comes with persistence.',
                          ),
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
                    for (var i = 0; i < carePlan.length; i++) ...[
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: BloomFixtures.careActionColor(
                            carePlan[i].kind,
                          ).withValues(alpha: 0.15),
                          child: Icon(
                            BloomFixtures.careActionIcon(carePlan[i].kind),
                            color: BloomFixtures.careActionColor(
                              carePlan[i].kind,
                            ),
                          ),
                        ),
                        title: Text(carePlan[i].title),
                        subtitle: Text(carePlan[i].cadenceLabel),
                      ),
                      if (i != carePlan.length - 1) const Divider(height: 1),
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
