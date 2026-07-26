import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/data/identification/plantnet_response_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses ranked Pl@ntNet candidates with GBIF ids', () {
    final result = parsePlantNetIdentifyResponse({
      'bestMatch': 'Ajuga genevensis L.',
      'remainingIdentificationRequests': 498,
      'results': [
        {
          'score': 0.90734,
          'species': {
            'scientificNameWithoutAuthor': 'Ajuga genevensis',
            'scientificName': 'Ajuga genevensis L.',
            'commonNames': ['Blue bugleweed', 'Blue bugle'],
            'genus': {'scientificNameWithoutAuthor': 'Ajuga'},
            'family': {'scientificNameWithoutAuthor': 'Lamiaceae'},
          },
          'gbif': {'id': '2927079'},
        },
        {
          'score': 0.05933,
          'species': {
            'scientificNameWithoutAuthor': 'Ajuga orientalis',
            'scientificName': 'Ajuga orientalis L.',
            'commonNames': ['Eastern bugle'],
          },
          'gbif': {'id': 7307097},
        },
      ],
    });

    expect(result.bestMatch, 'Ajuga genevensis L.');
    expect(result.remainingRequests, 498);
    expect(result.candidates, hasLength(2));
    expect(result.candidates.first.scientificNameWithoutAuthor, 'Ajuga genevensis');
    expect(result.candidates.first.primaryCommonName, 'Blue bugleweed');
    expect(result.candidates.first.gbifId, '2927079');
    expect(result.candidates.first.score, closeTo(0.90734, 0.0001));
    expect(result.candidates[1].gbifId, '7307097');
  });

  test('throws when results list is missing', () {
    expect(
      () => parsePlantNetIdentifyResponse({'bestMatch': 'x'}),
      throwsA(isA<IdentifyException>()),
    );
  });
}
