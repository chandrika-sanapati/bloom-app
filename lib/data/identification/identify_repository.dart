import 'package:bloom/data/identification/fake_identify_repository.dart';
import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/data/identification/plantnet_identify_client.dart';

abstract class IdentifyRepository {
  /// Whether results are demo/sample (no live Pl@ntNet call).
  bool get isDemo;

  Future<IdentifyResult> identify({
    required String imagePath,
    int maxResults = 5,
  });
}

/// Resolves the identify backend from compile-time dart-defines.
///
/// Production / preferred: `--dart-define=BLOOM_IDENTIFY_PROXY_URL=https://…`
/// (proxy origin only; app calls `{url}/v1/identify`). Keep the PlantNet key
/// on the Worker. Optional `--dart-define=BLOOM_IDENTIFY_APP_TOKEN=…` when the
/// proxy enforces a Bearer token.
///
/// Closed-beta debug only: `--dart-define=BLOOM_PLANTNET_API_KEY=…`
/// (do not use in store builds).
///
/// Otherwise falls back to [FakeIdentifyRepository] so Scan UI works offline.
IdentifyRepository resolveIdentifyRepository({
  String proxyUrl = const String.fromEnvironment('BLOOM_IDENTIFY_PROXY_URL'),
  String apiKey = const String.fromEnvironment('BLOOM_PLANTNET_API_KEY'),
  String appToken = const String.fromEnvironment('BLOOM_IDENTIFY_APP_TOKEN'),
}) {
  final trimmedProxy = proxyUrl.trim();
  if (trimmedProxy.isNotEmpty) {
    return PlantNetIdentifyClient.proxy(
      baseUrl: trimmedProxy,
      appToken: appToken.trim().isEmpty ? null : appToken.trim(),
    );
  }
  final trimmedKey = apiKey.trim();
  if (trimmedKey.isNotEmpty) {
    return PlantNetIdentifyClient.direct(apiKey: trimmedKey);
  }
  return FakeIdentifyRepository();
}
