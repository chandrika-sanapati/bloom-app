/// Public-facing trust constants. Support identity remains provisional until
/// store clearance (see docs/BLOOM_EXECUTION_PLAN.md §0.2).
abstract final class BloomLegal {
  static const appName = 'Bloom';
  static const versionLabel = '1.0.0+1';
  static const developerName = 'Sanapati Chandrika';

  /// Provisional until a permanent public support address is chosen.
  static const supportEmail = 'chandrika.sanapati@gmail.com';
  static const supportEmailIsProvisional = true;

  static const privacyAssetPath = 'assets/legal/privacy.md';
  static const attributionAssetPath = 'assets/legal/attribution.md';

  static Uri get supportMailto => Uri(
    scheme: 'mailto',
    path: supportEmail,
    queryParameters: {'subject': 'Bloom support'},
  );
}
