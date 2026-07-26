import 'dart:io';

import 'package:bloom/app/bloom_scope.dart';
import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:bloom/data/identification/catalog_match.dart';
import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/features/discover/presentation/add_plant_screen.dart';
import 'package:bloom/shared/plants/plant_photo_actions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Capture or import a photo, identify via Pl@ntNet (or demo), confirm a candidate.
class ScanPlantScreen extends StatefulWidget {
  const ScanPlantScreen({super.key});

  @override
  State<ScanPlantScreen> createState() => _ScanPlantScreenState();
}

class _ScanPlantScreenState extends State<ScanPlantScreen> {
  static final _picker = ImagePicker();

  String? _imagePath;
  IdentifyResult? _result;
  var _busy = false;
  String? _error;

  Future<void> _pick(ImageSource source) async {
    setState(() {
      _error = null;
      _result = null;
    });
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (picked == null || !mounted) {
        return;
      }
      setState(() => _imagePath = picked.path);
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = source == ImageSource.camera
            ? 'Camera unavailable. Allow camera permission or pick from gallery.'
            : 'Could not open that photo. Try another image.';
      });
    }
  }

  Future<void> _chooseSource() async {
    final source = await PlantPhotoActions.chooseSource(context);
    if (source == null || !mounted) {
      return;
    }
    await _pick(source);
  }

  Future<void> _identify() async {
    final path = _imagePath;
    if (path == null) {
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
      _result = null;
    });
    try {
      final identify = BloomScope.of(context).services.identify;
      final result = await identify.identify(imagePath: path);
      if (!mounted) {
        return;
      }
      setState(() => _result = result);
    } on IdentifyException catch (e) {
      if (!mounted) {
        return;
      }
      setState(() => _error = e.message);
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _error = 'Identification failed. Try again or search by name.';
      });
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _confirm(IdentifyCandidate candidate) async {
    final entry = catalogEntryForCandidate(candidate);
    final nickname = await Navigator.of(context).push<String>(
      MaterialPageRoute<String>(builder: (_) => AddPlantScreen(entry: entry)),
    );
    if (!mounted || nickname == null) {
      return;
    }
    Navigator.of(context).pop(nickname);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final identify = BloomScope.of(context).services.identify;
    final path = _imagePath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan a plant'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Search instead'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(BloomSpacing.screenMargin),
        children: [
          Text(
            'Take or choose a clear photo of one plant. Confirm a match — '
            'Bloom never adds a plant without your choice.',
            style: theme.textTheme.bodySmall,
          ),
          if (identify.isDemo) ...[
            const SizedBox(height: BloomSpacing.x3),
            Card(
              color: BloomColors.brandGreen.withValues(alpha: 0.12),
              child: const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Demo identification'),
                subtitle: Text(
                  'Live Pl@ntNet needs a Bloom proxy URL or debug API key '
                  '(dart-define). Sample ranked results are shown for now.',
                ),
              ),
            ),
          ],
          const SizedBox(height: BloomSpacing.x4),
          AspectRatio(
            aspectRatio: 1,
            child: Material(
              color: BloomColors.card,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BloomRadii.card),
                side: const BorderSide(color: BloomColors.borderSubtle),
              ),
              clipBehavior: Clip.antiAlias,
              child: path == null
                  ? InkWell(
                      onTap: _busy ? null : _chooseSource,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.document_scanner_outlined,
                              size: 48,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: BloomSpacing.x3),
                            Text(
                              'Tap to take or choose a photo',
                              style: theme.textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Image.file(File(path), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: BloomSpacing.x4),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _busy ? null : _chooseSource,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: Text(path == null ? 'Add photo' : 'Retake'),
                ),
              ),
              const SizedBox(width: BloomSpacing.x3),
              Expanded(
                child: FilledButton.icon(
                  onPressed: path == null || _busy ? null : _identify,
                  icon: _busy
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.search),
                  label: Text(_busy ? 'Identifying…' : 'Identify'),
                ),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: BloomSpacing.x4),
            Text(
              _error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Use manual search'),
            ),
          ],
          if (_result != null) ...[
            const SizedBox(height: BloomSpacing.x5),
            Text('Possible matches', style: theme.textTheme.titleMedium),
            const SizedBox(height: BloomSpacing.x2),
            Text(
              'Pick the best match or search by name if none look right.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: BloomSpacing.x3),
            ..._result!.candidates.map(
              (c) => Padding(
                padding: const EdgeInsets.only(bottom: BloomSpacing.x3),
                child: _CandidateTile(
                  candidate: c,
                  onTap: () => _confirm(c),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('None of these — search by name'),
            ),
          ],
        ],
      ),
    );
  }
}

class _CandidateTile extends StatelessWidget {
  const _CandidateTile({required this.candidate, required this.onTap});

  final IdentifyCandidate candidate;
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.primaryCommonName,
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: BloomSpacing.x1),
                    Text(
                      candidate.scientificNameWithoutAuthor,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: BloomSpacing.x2),
                    Text(
                      candidate.confidenceLabel,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
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
