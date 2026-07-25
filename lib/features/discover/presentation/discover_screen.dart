import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/features/discover/presentation/add_plant_screen.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/plant_thumbnail.dart';
import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<FixtureCatalogEntry> get _results {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) {
      return BloomFixtures.catalog;
    }

    return BloomFixtures.catalog.where((entry) {
      return entry.commonName.toLowerCase().contains(query) ||
          entry.scientificName.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _openAddPlant(FixtureCatalogEntry entry) async {
    final nickname = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(builder: (_) => AddPlantScreen(entry: entry)),
    );
    if (!mounted || nickname == null) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$nickname added to My Plants.')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final results = _results;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          Text(
            'Search is always available next to scanning.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x4),
          SearchBar(
            controller: _controller,
            hintText: 'Search for plants',
            leading: const Icon(Icons.search),
            trailing: [
              if (_query.isNotEmpty)
                IconButton(
                  tooltip: 'Clear search',
                  onPressed: () {
                    _controller.clear();
                    setState(() => _query = '');
                  },
                  icon: const Icon(Icons.close),
                ),
            ],
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: BloomSpacing.x4),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.document_scanner_outlined,
                color: theme.colorScheme.primary,
              ),
              title: const Text('Scan a plant'),
              subtitle: const Text(
                'Camera identification will land here after the technical spike.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Scanning is not wired yet. Use search for now.',
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: BloomSpacing.x5),
          Text(
            _query.isEmpty ? 'Popular houseplants' : 'Search results',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: BloomSpacing.x3),
          if (results.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(BloomSpacing.x5),
                child: Text(
                  'No matches for “$_query”. Try another common or scientific name.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            )
          else
            ...results.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: _CatalogResultRow(
                  entry: entry,
                  onTap: () => _openAddPlant(entry),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CatalogResultRow extends StatelessWidget {
  const _CatalogResultRow({required this.entry, required this.onTap});

  final FixtureCatalogEntry entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: BloomColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BloomRadii.card),
        side: const BorderSide(color: BloomColors.borderSubtle),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(BloomRadii.card),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(BloomSpacing.x3),
          child: Row(
            children: [
              PlantThumbnail(
                plantKey: entry.id,
                accent: entry.accent,
                width: 56,
                height: 56,
                icon: Icons.eco_outlined,
                iconSize: 28,
                semanticLabel: '${entry.commonName} photo',
              ),
              const SizedBox(width: BloomSpacing.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.commonName, style: theme.textTheme.titleSmall),
                    const SizedBox(height: BloomSpacing.x1),
                    Text(
                      entry.scientificName,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: BloomSpacing.x2),
                    BloomStatusChip(
                      label: BloomFixtures.difficultyLabel(entry.difficulty),
                      color: BloomColors.brandGreen,
                      icon: Icons.spa_outlined,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
