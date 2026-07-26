/// Catalog care provenance defaults until species-level URLs are authored.
///
/// Locked rules: [`docs/phase2/CARE_CONTENT_DECISION.md`].
abstract final class BloomCareContent {
  static const version = '2026.07';

  /// Interim reviewable source for Bloom-authored qualitative bands.
  /// Species-specific public URLs replace this during horticultural authoring.
  static const interimSourceUrl =
      'https://www.rhs.org.uk/plants/types/houseplants';
}
