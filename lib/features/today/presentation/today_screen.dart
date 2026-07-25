import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/widgets/care_task_row.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  final Set<String> _completedTaskIds = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remaining = BloomFixtures.tasks
        .where((task) => !_completedTaskIds.contains(task.id))
        .toList();
    final completed = BloomFixtures.tasks
        .where((task) => _completedTaskIds.contains(task.id))
        .toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          Text('Good day', style: theme.textTheme.titleLarge),
          const SizedBox(height: BloomSpacing.x1),
          Text(
            remaining.isEmpty
                ? 'All caught up — your garden is thriving.'
                : 'Here is what needs care today.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x5),
          Text("Today's tasks", style: theme.textTheme.titleMedium),
          const SizedBox(height: BloomSpacing.x3),
          if (remaining.isEmpty)
            _AllCaughtUpCard(onReset: () => setState(_completedTaskIds.clear))
          else
            ...remaining.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: CareTaskRow(
                  task: task,
                  isDone: false,
                  onToggle: (_) {
                    setState(() => _completedTaskIds.add(task.id));
                  },
                ),
              ),
            ),
          if (completed.isNotEmpty) ...[
            const SizedBox(height: BloomSpacing.x4),
            Text('Completed', style: theme.textTheme.titleMedium),
            const SizedBox(height: BloomSpacing.x3),
            ...completed.map(
              (task) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: CareTaskRow(
                  task: task,
                  isDone: true,
                  onToggle: (_) {
                    setState(() => _completedTaskIds.remove(task.id));
                  },
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

  final VoidCallback onReset;

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
              'Your plants are happy. Fixture tasks can be restored to keep exploring the UI.',
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
