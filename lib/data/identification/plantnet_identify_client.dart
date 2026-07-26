import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/data/identification/identify_repository.dart';
import 'package:bloom/data/identification/plantnet_response_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

/// Live Pl@ntNet identify client.
///
/// Prefer [PlantNetIdentifyClient.proxy] so the vendor API key stays server-side.
class PlantNetIdentifyClient implements IdentifyRepository {
  PlantNetIdentifyClient._({
    required this.endpoint,
    required this._httpClient,
    this.apiKeyQueryParam,
  });

  /// Calls a Bloom-controlled proxy that accepts multipart `images` and
  /// forwards to Pl@ntNet with the server-held key.
  factory PlantNetIdentifyClient.proxy({
    required String baseUrl,
    http.Client? client,
  }) {
    final normalized = baseUrl.endsWith('/')
        ? '${baseUrl}identify'
        : '$baseUrl/identify';
    return PlantNetIdentifyClient._(
      endpoint: Uri.parse(normalized),
      httpClient: client ?? http.Client(),
    );
  }

  /// Direct Pl@ntNet call — debug / closed-beta only via dart-define.
  factory PlantNetIdentifyClient.direct({
    required String apiKey,
    http.Client? client,
    String project = 'all',
  }) {
    return PlantNetIdentifyClient._(
      endpoint: Uri.https('my-api.plantnet.org', '/v2/identify/$project'),
      httpClient: client ?? http.Client(),
      apiKeyQueryParam: apiKey,
    );
  }

  final Uri endpoint;
  final String? apiKeyQueryParam;
  final http.Client _httpClient;

  @override
  bool get isDemo => false;

  @override
  Future<IdentifyResult> identify({
    required String imagePath,
    int maxResults = 5,
  }) async {
    final file = File(imagePath);
    if (!await file.exists()) {
      throw const IdentifyException('That photo could not be read.');
    }

    final uri = apiKeyQueryParam == null
        ? endpoint.replace(
            queryParameters: {
              ...endpoint.queryParameters,
              'lang': 'en',
              'nb-results': '$maxResults',
            },
          )
        : endpoint.replace(
            queryParameters: {
              'api-key': apiKeyQueryParam!,
              'lang': 'en',
              'nb-results': '$maxResults',
            },
          );

    final request = http.MultipartRequest('POST', uri);
    final filename = p.basename(imagePath);
    request.files.add(
      await http.MultipartFile.fromPath(
        'images',
        file.path,
        filename: filename.isEmpty ? 'plant.jpg' : filename,
      ),
    );
    request.fields['organs'] = 'auto';

    late http.StreamedResponse streamed;
    try {
      streamed = await _httpClient
          .send(request)
          .timeout(const Duration(seconds: 20));
    } on TimeoutException {
      throw const IdentifyException(
        'Identification timed out. Try again or search by name.',
      );
    } on SocketException {
      throw const IdentifyException(
        'Could not reach identification. Check your connection and try again.',
      );
    } on http.ClientException {
      throw const IdentifyException(
        'Could not reach identification. Check your connection and try again.',
      );
    }

    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode == 429) {
      throw const IdentifyException(
        'Daily identification limit reached. Try again tomorrow or use search.',
        isRateLimit: true,
      );
    }
    if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
      throw IdentifyException(
        'Identification failed (${streamed.statusCode}). Use search or retake.',
      );
    }

    late final Map<String, dynamic> json;
    try {
      final decoded = jsonDecode(body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('not a map');
      }
      json = decoded;
    } on FormatException {
      throw const IdentifyException('Identification response was unreadable.');
    }

    final result = parsePlantNetIdentifyResponse(json);
    if (result.candidates.isEmpty) {
      throw const IdentifyException(
        'No plant matches found. Try another photo or search by name.',
      );
    }
    return result;
  }
}
