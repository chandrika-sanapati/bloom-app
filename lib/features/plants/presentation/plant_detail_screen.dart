import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/care/care_plan_merge.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:bloom/shared/plants/plant_photo_actions.dart';
import 'package:bloom/shared/presentation/care_ui_mappers.dart';
import 'package:bloom/shared/widgets/bloom_status_chip.dart';
import 'package:bloom/shared/widgets/care_task_row.dart';
import 'package:bloom/shared/widgets/plant_thumbnail.dart';
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
  domain.UserPlantRecord? _record;
  List<FixtureCareTask> _openTasks = const [];
  List<FixtureCareHistoryEvent> _history = const [];
  List<FixtureCarePlanItem> _carePlan = const [];
  List<domain.CarePlanItem> _domainPlan = const [];

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
          _record = null;
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
      _record = record;
      _plant = toFixturePlant(record);
      _openTasks = [
        for (final task in tasks.where((t) => !t.isDone))
          toFixtureTask(
            task: task,
            plantName: record.plant.displayName,
            accent: accent,
            photoPath: record.plant.photoPath,
          ),
      ];
      _history = events.map(toFixtureHistoryEvent).toList();
      _domainPlan = plan;
      _carePlan = plan.map(toFixturePlanItem).toList();
      _loading = false;
    });
  }

  Future<void> _editNickname() async {
    final record = _record;
    if (record == null) {
      return;
    }
    final next = await showDialog<String>(
      context: context,
      builder: (context) =>
          _NicknameDialog(initialValue: record.plant.displayName),
    );
    if (next == null || next.isEmpty || !mounted) {
      return;
    }

    final services = BloomScope.of(context).services;
    await services.care.upsertUserPlant(
      domain.UserPlant(
        id: record.plant.id,
        speciesId: record.plant.speciesId,
        displayName: next,
        statusLabel: record.plant.statusLabel,
        notes: record.plant.notes,
        lightLevel: record.plant.lightLevel,
        homeClimate: record.plant.homeClimate,
        pottingSize: record.plant.pottingSize,
        experienceLevel: record.plant.experienceLevel,
        photoPath: record.plant.photoPath,
      ),
    );
    services.notifyDataChanged();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Nickname updated.')));
    await _reload();
  }

  Future<void> _editPhoto() async {
    final record = _record;
    if (record == null) {
      return;
    }
    final source = await PlantPhotoActions.chooseSource(context);
    if (source == null || !mounted) {
      return;
    }
    final path = await PlantPhotoActions.pickAndImport(
      context: context,
      userPlantId: record.plant.id,
      source: source,
      previousPath: record.plant.photoPath,
    );
    if (path == null || !mounted) {
      return;
    }
    final services = BloomScope.of(context).services;
    await services.care.upsertUserPlant(
      domain.UserPlant(
        id: record.plant.id,
        speciesId: record.plant.speciesId,
        displayName: record.plant.displayName,
        statusLabel: record.plant.statusLabel,
        notes: record.plant.notes,
        lightLevel: record.plant.lightLevel,
        homeClimate: record.plant.homeClimate,
        pottingSize: record.plant.pottingSize,
        experienceLevel: record.plant.experienceLevel,
        photoPath: path,
      ),
    );
    services.notifyDataChanged();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Photo updated.')));
    await _reload();
  }

  Future<void> _removePhoto() async {
    final record = _record;
    if (record == null || record.plant.photoPath == null) {
      return;
    }
    final services = BloomScope.of(context).services;
    await PlantPhotoActions.store.deletePhoto(record.plant.photoPath);
    await services.care.upsertUserPlant(
      domain.UserPlant(
        id: record.plant.id,
        speciesId: record.plant.speciesId,
        displayName: record.plant.displayName,
        statusLabel: record.plant.statusLabel,
        notes: record.plant.notes,
        lightLevel: record.plant.lightLevel,
        homeClimate: record.plant.homeClimate,
        pottingSize: record.plant.pottingSize,
        experienceLevel: record.plant.experienceLevel,
      ),
    );
    services.notifyDataChanged();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Photo removed.')));
    await _reload();
  }

  Future<void> _editCarePlan() async {
    if (_domainPlan.isEmpty) {
      return;
    }
    final rows = [
      for (final item in _domainPlan)
        (
          item: item,
          controller: TextEditingController(text: item.cadenceLabel),
        ),
    ];

    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('Edit care plan')),
            body: ListView(
              padding: const EdgeInsets.all(BloomSpacing.screenMargin),
              children: [
                Text(
                  'Suggested for typical indoor conditions — edit to match '
                  'your home. No exact volumes.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: BloomSpacing.x4),
                Card(
                  child: Column(
                    children: [
                      for (var i = 0; i < rows.length; i++) ...[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: BloomFixtures.careActionColor(
                              toFixtureActionKind(rows[i].item.kind),
                            ).withValues(alpha: 0.15),
                            child: Icon(
                              BloomFixtures.careActionIcon(
                                toFixtureActionKind(rows[i].item.kind),
                              ),
                              color: BloomFixtures.careActionColor(
                                toFixtureActionKind(rows[i].item.kind),
                              ),
                            ),
                          ),
                          title: Text(rows[i].item.title),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(
                              top: BloomSpacing.x2,
                            ),
                            child: TextField(
                              controller: rows[i].controller,
                              decoration: const InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                labelText: 'Cadence',
                              ),
                            ),
                          ),
                        ),
                        if (i != rows.length - 1) const Divider(height: 1),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: BloomSpacing.x6),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Save care plan'),
                ),
              ],
            ),
          );
        },
      ),
    );

    final cadences = [for (final row in rows) row.controller.text.trim()];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (final row in rows) {
        row.controller.dispose();
      }
    });
    if (saved != true || !mounted) {
      return;
    }

    final services = BloomScope.of(context).services;
    final nextPlan = <domain.CarePlanItem>[];
    for (var i = 0; i < _domainPlan.length; i++) {
      final previous = _domainPlan[i];
      final cadence = cadences[i].isEmpty ? previous.cadenceLabel : cadences[i];
      final suggested = previous.suggestedCadenceLabel ?? previous.cadenceLabel;
      nextPlan.add(
        domain.CarePlanItem(
          id: previous.id,
          userPlantId: widget.plantId,
          kind: previous.kind,
          title: previous.title,
          cadenceLabel: cadence,
          sortOrder: i,
          suggestedCadenceLabel: suggested,
          isUserModified: CarePlanMerge.isModifiedRelativeToSuggestion(
            cadenceLabel: cadence,
            suggestedCadenceLabel: suggested,
          ),
          sourceUrl: previous.sourceUrl,
          careContentVersion: previous.careContentVersion,
        ),
      );
    }
    await services.care.replaceCarePlan(
      userPlantId: widget.plantId,
      items: nextPlan,
    );
    services.notifyDataChanged();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Care plan updated.')));
    await _reload();
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
            tooltip: 'Edit nickname',
            onPressed: _editNickname,
            icon: const Icon(Icons.edit_outlined),
          ),
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
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(BloomRadii.card),
                border: Border.all(color: BloomColors.borderSubtle),
              ),
              child: PlantThumbnail(
                plantKey: plant.id,
                accent: plant.accent,
                photoPath: plant.photoPath,
                height: 160,
                borderRadius: BloomRadii.card,
                iconSize: 64,
                semanticLabel: '${plant.commonName} photo',
              ),
            ),
            const SizedBox(height: BloomSpacing.x3),
            Wrap(
              spacing: BloomSpacing.x2,
              children: [
                TextButton.icon(
                  onPressed: _editPhoto,
                  icon: const Icon(Icons.add_a_photo_outlined),
                  label: Text(
                    plant.photoPath == null ? 'Add photo' : 'Change photo',
                  ),
                ),
                if (plant.photoPath != null)
                  TextButton(
                    onPressed: _removePhoto,
                    child: const Text('Remove photo'),
                  ),
              ],
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
                    onPressed: _editCarePlan,
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
                        subtitle: Text(
                          [
                            _carePlan[i].cadenceLabel,
                            if (i < _domainPlan.length &&
                                _domainPlan[i].careContentVersion != null)
                              'Content ${_domainPlan[i].careContentVersion}',
                          ].join('\n'),
                        ),
                        isThreeLine:
                            i < _domainPlan.length &&
                            _domainPlan[i].careContentVersion != null,
                        trailing:
                            i < _domainPlan.length &&
                                _domainPlan[i].isUserModified
                            ? Text(
                                'Edited',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: BloomColors.labelTertiary,
                                ),
                              )
                            : null,
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

class _NicknameDialog extends StatefulWidget {
  const _NicknameDialog({required this.initialValue});

  final String initialValue;

  @override
  State<_NicknameDialog> createState() => _NicknameDialogState();
}

class _NicknameDialogState extends State<_NicknameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit nickname'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Plant nickname',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, _controller.text.trim()),
          child: const Text('Save'),
        ),
      ],
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
