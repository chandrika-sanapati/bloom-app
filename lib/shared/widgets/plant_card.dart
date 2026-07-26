import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/plant_thumbnail.dart';
import 'package:flutter/material.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({required this.plant, this.onTap, super.key});

  final FixturePlant plant;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: BloomColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BloomRadii.card),
        side: const BorderSide(color: BloomColors.borderSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: PlantThumbnail(
                plantKey: plant.id,
                accent: plant.accent,
                photoPath: plant.photoPath,
                borderRadius: 0,
                iconSize: 40,
                semanticLabel: '${plant.commonName} photo',
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(BloomSpacing.x3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.commonName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: BloomSpacing.x1),
                    Text(
                      plant.statusLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    BloomStatusChip(
                      label: BloomFixtures.difficultyLabel(plant.difficulty),
                      color: BloomColors.brandGreen,
                      icon: Icons.spa_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
