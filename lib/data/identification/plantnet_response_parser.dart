import 'package:bloom/data/identification/identify_models.dart';

/// Parses Pl@ntNet `/v2/identify/{project}` JSON into domain models.
IdentifyResult parsePlantNetIdentifyResponse(
  Map<String, dynamic> json, {
  bool isDemo = false,
}) {
  final results = json['results'];
  if (results is! List) {
    throw const IdentifyException('Identification response was incomplete.');
  }

  final candidates = <IdentifyCandidate>[];
  for (final raw in results) {
    if (raw is! Map) {
      continue;
    }
    final map = Map<String, dynamic>.from(raw);
    final species = map['species'];
    if (species is! Map) {
      continue;
    }
    final speciesMap = Map<String, dynamic>.from(species);
    final scientificWithoutAuthor =
        (speciesMap['scientificNameWithoutAuthor'] as String?)?.trim() ?? '';
    final scientific =
        (speciesMap['scientificName'] as String?)?.trim() ??
        scientificWithoutAuthor;
    if (scientificWithoutAuthor.isEmpty && scientific.isEmpty) {
      continue;
    }

    final commonRaw = speciesMap['commonNames'];
    final commonNames = <String>[];
    if (commonRaw is List) {
      for (final name in commonRaw) {
        if (name is String && name.trim().isNotEmpty) {
          commonNames.add(name.trim());
        }
      }
    }

    String? family;
    final familyRaw = speciesMap['family'];
    if (familyRaw is Map) {
      family = familyRaw['scientificNameWithoutAuthor'] as String?;
    }

    String? genus;
    final genusRaw = speciesMap['genus'];
    if (genusRaw is Map) {
      genus = genusRaw['scientificNameWithoutAuthor'] as String?;
    }

    String? gbifId;
    final gbif = map['gbif'];
    if (gbif is Map) {
      final id = gbif['id'];
      if (id != null) {
        gbifId = id.toString();
      }
    }

    final scoreRaw = map['score'];
    final score = scoreRaw is num ? scoreRaw.toDouble() : 0.0;

    candidates.add(
      IdentifyCandidate(
        score: score.clamp(0.0, 1.0),
        scientificName: scientific,
        scientificNameWithoutAuthor: scientificWithoutAuthor.isNotEmpty
            ? scientificWithoutAuthor
            : scientific,
        commonNames: commonNames,
        gbifId: gbifId,
        family: family,
        genus: genus,
      ),
    );
  }

  final remaining = json['remainingIdentificationRequests'];
  return IdentifyResult(
    candidates: candidates,
    bestMatch: json['bestMatch'] as String?,
    remainingRequests: remaining is num ? remaining.toInt() : null,
    isDemo: isDemo,
  );
}
