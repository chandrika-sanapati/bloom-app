import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/shared/fixtures/bloom_catalog.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter/material.dart';

/// Maps an identification candidate onto the Bloom Discover catalog when possible.
FixtureCatalogEntry catalogEntryForCandidate(IdentifyCandidate candidate) {
  final scientific = candidate.scientificNameWithoutAuthor.toLowerCase();
  final common = candidate.commonNames.map((n) => n.toLowerCase()).toList();

  for (final entry in BloomCatalog.entries) {
    if (entry.scientificName.toLowerCase() == scientific) {
      return entry;
    }
  }
  for (final entry in BloomCatalog.entries) {
    if (entry.scientificName.toLowerCase().startsWith(scientific) ||
        scientific.startsWith(entry.scientificName.toLowerCase())) {
      return entry;
    }
  }
  for (final entry in BloomCatalog.entries) {
    final entryCommon = entry.commonName.toLowerCase();
    if (common.any(
      (name) => name == entryCommon || name.contains(entryCommon),
    )) {
      return entry;
    }
  }

  final slug = scientific
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  return FixtureCatalogEntry(
    id: 'catalog-scan-${candidate.gbifId ?? slug}',
    commonName: candidate.primaryCommonName,
    scientificName: candidate.scientificNameWithoutAuthor,
    difficulty: PlantDifficulty.moderate,
    accent: const Color(0xFF6B8F71),
    overview:
        'Identified via Pl@ntNet. Review the suggested plan and adjust for your home — '
        'this species is not in Bloom’s curated care set yet.',
  );
}
