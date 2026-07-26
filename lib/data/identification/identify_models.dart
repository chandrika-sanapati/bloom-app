import 'package:flutter/material.dart';

/// Ranked plant identification candidate from Pl@ntNet (or a fake for tests).
class IdentifyCandidate {
  const IdentifyCandidate({
    required this.score,
    required this.scientificName,
    required this.scientificNameWithoutAuthor,
    required this.commonNames,
    this.gbifId,
    this.family,
    this.genus,
  });

  /// Confidence in `[0, 1]`.
  final double score;
  final String scientificName;
  final String scientificNameWithoutAuthor;
  final List<String> commonNames;
  final String? gbifId;
  final String? family;
  final String? genus;

  String get primaryCommonName =>
      commonNames.isNotEmpty ? commonNames.first : scientificNameWithoutAuthor;

  String get confidenceLabel {
    final pct = (score * 100).round();
    if (score >= 0.7) {
      return '$pct% — high confidence';
    }
    if (score >= 0.35) {
      return '$pct% — moderate confidence';
    }
    return '$pct% — low confidence';
  }

  /// Strong green for high confidence; softer green then muted yellow for low.
  Color get confidenceColor {
    if (score >= 0.7) {
      return const Color(0xFF2AAA8A);
    }
    if (score >= 0.35) {
      return const Color(0xFF7BA17D);
    }
    return const Color(0xFFC4A35A);
  }

  Color get confidenceFill =>
      confidenceColor.withValues(alpha: score >= 0.7 ? 0.16 : 0.12);
}

class IdentifyResult {
  const IdentifyResult({
    required this.candidates,
    this.bestMatch,
    this.remainingRequests,
    this.isDemo = false,
  });

  final List<IdentifyCandidate> candidates;
  final String? bestMatch;
  final int? remainingRequests;

  /// True when results came from [FakeIdentifyRepository] (no live API).
  final bool isDemo;
}

class IdentifyException implements Exception {
  const IdentifyException(this.message, {this.isRateLimit = false});

  final String message;
  final bool isRateLimit;

  @override
  String toString() => message;
}
