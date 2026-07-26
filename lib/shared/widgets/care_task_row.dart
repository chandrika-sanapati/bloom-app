import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/plant_thumbnail.dart';
import 'package:flutter/material.dart';

enum CareTaskMenuAction { snooze, skip, reschedule }

class CareTaskRow extends StatelessWidget {
  const CareTaskRow({
    required this.task,
    required this.isDone,
    required this.onToggle,
    this.onOpenPlant,
    this.onMenuAction,
    super.key,
  });

  final FixtureCareTask task;
  final bool isDone;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onOpenPlant;
  final ValueChanged<CareTaskMenuAction>? onMenuAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final urgency = isDone ? CareUrgency.done : task.urgency;
    final urgencyColor = BloomFixtures.urgencyColor(urgency);
    final titleStyle = theme.textTheme.titleSmall?.copyWith(
      color: isDone ? BloomColors.labelTertiary : BloomColors.labelPrimary,
      decoration: isDone ? TextDecoration.lineThrough : null,
    );

    return Material(
      color: BloomColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BloomRadii.card),
        side: const BorderSide(color: BloomColors.borderSubtle),
      ),
      child: Padding(
        padding: const EdgeInsets.all(BloomSpacing.x3),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(BloomRadii.card),
                onTap: onOpenPlant ?? () => onToggle(!isDone),
                child: Row(
                  children: [
                    PlantThumbnail(
                      plantKey: task.plantId,
                      accent: task.accent,
                      photoPath: task.photoPath,
                      width: 56,
                      height: 56,
                      icon: Icons.eco_outlined,
                      iconSize: 28,
                      semanticLabel: '${task.plantName} photo',
                    ),
                    const SizedBox(width: BloomSpacing.x3),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(task.plantName, style: titleStyle),
                          const SizedBox(height: BloomSpacing.x1),
                          Text(
                            task.actionLabel,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDone
                                  ? BloomColors.labelTertiary
                                  : BloomColors.labelSecondary,
                            ),
                          ),
                          const SizedBox(height: BloomSpacing.x2),
                          BloomStatusChip(
                            label: BloomFixtures.urgencyLabel(urgency),
                            color: urgencyColor,
                            icon: BloomFixtures.urgencyIcon(urgency),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!isDone && onMenuAction != null) ...[
              PopupMenuButton<CareTaskMenuAction>(
                tooltip: 'Task actions',
                onSelected: onMenuAction,
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: CareTaskMenuAction.snooze,
                    child: Text('Snooze'),
                  ),
                  PopupMenuItem(
                    value: CareTaskMenuAction.skip,
                    child: Text('Skip'),
                  ),
                  PopupMenuItem(
                    value: CareTaskMenuAction.reschedule,
                    child: Text('Reschedule'),
                  ),
                ],
              ),
            ],
            Checkbox(
              value: isDone,
              onChanged: (value) => onToggle(value ?? false),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BloomRadii.control),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
