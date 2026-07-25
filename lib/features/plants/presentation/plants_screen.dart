import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/features/plants/presentation/plant_navigation.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/widgets/plant_card.dart';
import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key, this.onAddPlant});

  final VoidCallback? onAddPlant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final plants = BloomFixtures.plants;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              BloomSpacing.screenMargin,
              BloomSpacing.screenMargin,
              BloomSpacing.screenMargin,
              BloomSpacing.x3,
            ),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${plants.length} plants in your collection',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: onAddPlant,
                    child: const Text('Add plant'),
                  ),
                ],
              ),
            ),
          ),
          if (plants.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(BloomSpacing.x6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_florist_outlined,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: BloomSpacing.x4),
                    Text('No plants yet', style: theme.textTheme.titleMedium),
                    const SizedBox(height: BloomSpacing.x2),
                    Text(
                      'Add your first houseplant from Discover by search or scan.',
                      style: theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: BloomSpacing.x4),
                    FilledButton(
                      onPressed: onAddPlant,
                      child: const Text('Go to Discover'),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                BloomSpacing.screenMargin,
                0,
                BloomSpacing.screenMargin,
                BloomSpacing.screenMargin,
              ),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: BloomSpacing.x3,
                  crossAxisSpacing: BloomSpacing.x3,
                  childAspectRatio: 0.72,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  final plant = plants[index];
                  return PlantCard(
                    plant: plant,
                    onTap: () => openPlantDetail(context, plant.id),
                  );
                }, childCount: plants.length),
              ),
            ),
        ],
      ),
    );
  }
}
