import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/data/domain/plant_environment.dart';
import 'package:bloom/shared/care/care_plan_merge.dart';
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
  var _environment = PlantEnvironmentAnswers.defaults;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.entry.commonName);
    _planRows = _buildPlanRows(_environment);
  }

  List<_EditablePlanRow> _buildPlanRows(PlantEnvironmentAnswers environment) {
    return BloomFixtures.suggestedCarePlan(
      widget.entry,
      environment: environment,
    ).map(_EditablePlanRow.fromFixture).toList();
  }

  void _setEnvironment(PlantEnvironmentAnswers next) {
    for (final row in _planRows) {
      row.dispose();
    }
    setState(() {
      _environment = next;
      _planRows = _buildPlanRows(next);
    });
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
          lightLevel: _environment.light,
          homeClimate: _environment.climate,
          pottingSize: _environment.potting,
          experienceLevel: _environment.experience,
        ),
      );
      final planItems = <domain.CarePlanItem>[];
      for (var i = 0; i < _planRows.length; i++) {
        final row = _planRows[i];
        final cadence = row.cadenceController.text.trim().isEmpty
            ? row.title
            : row.cadenceController.text.trim();
        final suggested = row.suggestedCadence;
        planItems.add(
          domain.CarePlanItem(
            id: 'plan-$plantId-$i',
            userPlantId: plantId,
            kind: _actionKind(row.kind),
            title: row.title,
            cadenceLabel: cadence,
            sortOrder: i,
            suggestedCadenceLabel: suggested,
            isUserModified: CarePlanMerge.isModifiedRelativeToSuggestion(
              cadenceLabel: cadence,
              suggestedCadenceLabel: suggested,
            ),
          ),
        );
      }
      await care.replaceCarePlan(userPlantId: plantId, items: planItems);

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
          Text('Your conditions', style: theme.textTheme.titleMedium),
          const SizedBox(height: BloomSpacing.x1),
          Text(
            'Suggested for typical indoor conditions — edit to match your home.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: BloomSpacing.x3),
          _EnvironmentSection(
            title: 'Light',
            child: Wrap(
              spacing: BloomSpacing.x2,
              runSpacing: BloomSpacing.x2,
              children: [
                for (final value in LightLevel.values)
                  ChoiceChip(
                    label: Text(lightLevelLabel(value)),
                    selected: _environment.light == value,
                    onSelected: (_) =>
                        _setEnvironment(_environment.copyWith(light: value)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: BloomSpacing.x3),
          _EnvironmentSection(
            title: 'Home climate',
            child: Wrap(
              spacing: BloomSpacing.x2,
              runSpacing: BloomSpacing.x2,
              children: [
                for (final value in HomeClimate.values)
                  ChoiceChip(
                    label: Text(homeClimateLabel(value)),
                    selected: _environment.climate == value,
                    onSelected: (_) =>
                        _setEnvironment(_environment.copyWith(climate: value)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: BloomSpacing.x3),
          _EnvironmentSection(
            title: 'Pot size',
            child: Wrap(
              spacing: BloomSpacing.x2,
              runSpacing: BloomSpacing.x2,
              children: [
                for (final value in PottingSize.values)
                  ChoiceChip(
                    label: Text(pottingSizeLabel(value)),
                    selected: _environment.potting == value,
                    onSelected: (_) =>
                        _setEnvironment(_environment.copyWith(potting: value)),
                  ),
              ],
            ),
          ),
          const SizedBox(height: BloomSpacing.x3),
          _EnvironmentSection(
            title: 'Experience',
            child: Wrap(
              spacing: BloomSpacing.x2,
              runSpacing: BloomSpacing.x2,
              children: [
                for (final value in ExperienceLevel.values)
                  ChoiceChip(
                    label: Text(experienceLevelLabel(value)),
                    selected: _environment.experience == value,
                    onSelected: (_) => _setEnvironment(
                      _environment.copyWith(experience: value),
                    ),
                  ),
              ],
            ),
          ),
          if (_environment.experience == ExperienceLevel.novice) ...[
            const SizedBox(height: BloomSpacing.x3),
            Text(
              'When unsure, wait and check the soil rather than watering on a '
              'fixed day. Bloom does not diagnose pests or disease.',
              style: theme.textTheme.bodySmall,
            ),
          ],
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

class _EnvironmentSection extends StatelessWidget {
  const _EnvironmentSection({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: BloomSpacing.x2),
        child,
      ],
    );
  }
}

class _EditablePlanRow {
  _EditablePlanRow({
    required this.kind,
    required this.title,
    required String cadence,
    required this.suggestedCadence,
  }) : cadenceController = TextEditingController(text: cadence);

  factory _EditablePlanRow.fromFixture(FixtureCarePlanItem item) {
    return _EditablePlanRow(
      kind: item.kind,
      title: item.title,
      cadence: item.cadenceLabel,
      suggestedCadence: item.cadenceLabel,
    );
  }

  final CareActionKind kind;
  final String title;
  final String suggestedCadence;
  final TextEditingController cadenceController;

  void dispose() => cadenceController.dispose();
}
