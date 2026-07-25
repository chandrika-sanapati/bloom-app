import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/plant_thumbnail.dart';
import 'package:flutter/material.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({required this.entry, super.key});

  final FixtureCatalogEntry entry;

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  late final TextEditingController _nameController;
  late List<_EditablePlanRow> _planRows;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.entry.commonName);
    _planRows = BloomFixtures.suggestedCarePlan(
      widget.entry,
    ).map(_EditablePlanRow.fromFixture).toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final row in _planRows) {
      row.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final nickname = _nameController.text.trim();
    if (nickname.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Give this plant a name.')));
      return;
    }

    setState(() => _saving = true);
    final scope = BloomScope.of(context);
    final care = scope.care;
    final entry = widget.entry;
    final stamp = DateTime.now().millisecondsSinceEpoch;
    final speciesId = 'species-${entry.id}';
    final plantId = 'plant-${entry.id}-$stamp';

    try {
      await care.upsertSpecies(
        domain.PlantSpecies(
          id: speciesId,
          commonName: entry.commonName,
          scientificName: entry.scientificName,
          difficulty: _difficulty(entry.difficulty),
          overview: entry.overview,
          accentArgb: entry.accent.toARGB32(),
        ),
      );
      await care.upsertUserPlant(
        domain.UserPlant(
          id: plantId,
          speciesId: speciesId,
          displayName: nickname,
          statusLabel: 'Just added',
        ),
      );
      await care.replaceCarePlan(
        userPlantId: plantId,
        items: [
          for (var i = 0; i < _planRows.length; i++)
            domain.CarePlanItem(
              id: 'plan-$plantId-$i',
              userPlantId: plantId,
              kind: _actionKind(_planRows[i].kind),
              title: _planRows[i].title,
              cadenceLabel: _planRows[i].cadenceController.text.trim().isEmpty
                  ? _planRows[i].title
                  : _planRows[i].cadenceController.text.trim(),
              sortOrder: i,
            ),
        ],
      );

      _EditablePlanRow? waterRow;
      for (final row in _planRows) {
        if (row.kind == CareActionKind.water) {
          waterRow = row;
          break;
        }
      }
      waterRow ??= _planRows.isEmpty ? null : _planRows.first;
      if (waterRow != null) {
        await care.upsertCareTask(
          domain.CareTask(
            id: 'task-$plantId-water',
            userPlantId: plantId,
            actionLabel: waterRow.title,
            urgency: domain.CareUrgency.dueToday,
            dueAt: DateTime.now(),
            isDone: false,
          ),
        );
      }

      scope.services.notifyDataChanged();
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(nickname);
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entry = widget.entry;

    return Scaffold(
      appBar: AppBar(title: const Text('Add plant')),
      body: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BloomRadii.card),
              border: Border.all(color: BloomColors.borderSubtle),
            ),
            child: PlantThumbnail(
              plantKey: entry.id,
              accent: entry.accent,
              height: 140,
              borderRadius: BloomRadii.card,
              iconSize: 56,
              semanticLabel: '${entry.commonName} photo',
            ),
          ),
          const SizedBox(height: BloomSpacing.x4),
          Text(entry.commonName, style: theme.textTheme.titleLarge),
          Text(
            entry.scientificName,
            style: theme.textTheme.bodySmall?.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: BloomSpacing.x3),
          BloomStatusChip(
            label: BloomFixtures.difficultyLabel(entry.difficulty),
            color: BloomColors.brandGreen,
            icon: Icons.spa_outlined,
          ),
          const SizedBox(height: BloomSpacing.x4),
          Text(entry.overview, style: theme.textTheme.bodyMedium),
          const SizedBox(height: BloomSpacing.x5),
          Text('Nickname', style: theme.textTheme.titleMedium),
          const SizedBox(height: BloomSpacing.x2),
          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Optional custom name',
            ),
          ),
          const SizedBox(height: BloomSpacing.x5),
          Text('Suggested care plan', style: theme.textTheme.titleMedium),
          const SizedBox(height: BloomSpacing.x1),
          Text(
            'Edit the guidance for your home. No exact volumes.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x3),
          Card(
            child: Column(
              children: [
                for (var i = 0; i < _planRows.length; i++) ...[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: BloomFixtures.careActionColor(
                        _planRows[i].kind,
                      ).withValues(alpha: 0.15),
                      child: Icon(
                        BloomFixtures.careActionIcon(_planRows[i].kind),
                        color: BloomFixtures.careActionColor(_planRows[i].kind),
                      ),
                    ),
                    title: Text(_planRows[i].title),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: BloomSpacing.x2),
                      child: TextField(
                        controller: _planRows[i].cadenceController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(),
                          labelText: 'Cadence',
                        ),
                      ),
                    ),
                  ),
                  if (i != _planRows.length - 1) const Divider(height: 1),
                ],
              ],
            ),
          ),
          const SizedBox(height: BloomSpacing.x6),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Text(_saving ? 'Adding…' : 'Add to My Plants'),
          ),
        ],
      ),
    );
  }

  static domain.PlantDifficulty _difficulty(PlantDifficulty value) {
    return switch (value) {
      PlantDifficulty.easy => domain.PlantDifficulty.easy,
      PlantDifficulty.moderate => domain.PlantDifficulty.moderate,
    };
  }

  static domain.CareActionKind _actionKind(CareActionKind value) {
    return switch (value) {
      CareActionKind.water => domain.CareActionKind.water,
      CareActionKind.fertilise => domain.CareActionKind.fertilise,
      CareActionKind.prune => domain.CareActionKind.prune,
      CareActionKind.check => domain.CareActionKind.check,
      CareActionKind.light => domain.CareActionKind.light,
    };
  }
}

class _EditablePlanRow {
  _EditablePlanRow({
    required this.kind,
    required this.title,
    required String cadence,
  }) : cadenceController = TextEditingController(text: cadence);

  factory _EditablePlanRow.fromFixture(FixtureCarePlanItem item) {
    return _EditablePlanRow(
      kind: item.kind,
      title: item.title,
      cadence: item.cadenceLabel,
    );
  }

  final CareActionKind kind;
  final String title;
  final TextEditingController cadenceController;

  void dispose() => cadenceController.dispose();
}
