import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/features/plants/presentation/plant_navigation.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/presentation/care_ui_mappers.dart';
import 'package:bloom/shared/widgets/plant_card.dart';
import 'package:flutter/material.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({super.key, this.onAddPlant});

  final VoidCallback? onAddPlant;

  @override
  State<PlantsScreen> createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  var _loading = true;
  var _started = false;
  List<FixturePlant> _plants = const [];

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
    final records = await BloomScope.of(context).care.listUserPlantRecords();
    if (!mounted) {
      return;
    }
    setState(() {
      _plants = records.map(toFixturePlant).toList();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

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
                      '${_plants.length} plants in your collection',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                  FilledButton.tonal(
                    onPressed: widget.onAddPlant,
                    child: const Text('Add plant'),
                  ),
                ],
              ),
            ),
          ),
          if (_plants.isEmpty)
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
                      onPressed: widget.onAddPlant,
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
                  final plant = _plants[index];
                  return PlantCard(
                    plant: plant,
                    onTap: () async {
                      await openPlantDetail(context, plant.id);
                      if (mounted) {
                        await _reload();
                      }
                    },
                  );
                }, childCount: _plants.length),
              ),
            ),
        ],
      ),
    );
  }
}
