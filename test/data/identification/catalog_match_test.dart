import 'package:bloom/data/identification/catalog_match.dart';
import 'package:bloom/data/identification/identify_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('matches curated catalog by scientific name', () {
    const candidate = IdentifyCandidate(
      score: 0.9,
      scientificName: 'Dracaena trifasciata (Prain) Mabb.',
      scientificNameWithoutAuthor: 'Dracaena trifasciata',
      commonNames: ['Snake Plant'],
      gbifId: '1',
    );

    final entry = catalogEntryForCandidate(candidate);
    expect(entry.id, 'catalog-snake');
    expect(entry.commonName, 'Snake Plant');
  });

  test('builds synthetic entry when species is outside catalog', () {
    const candidate = IdentifyCandidate(
      score: 0.5,
      scientificName: 'Ajuga genevensis L.',
      scientificNameWithoutAuthor: 'Ajuga genevensis',
      commonNames: ['Blue bugleweed'],
      gbifId: '2927079',
    );

    final entry = catalogEntryForCandidate(candidate);
    expect(entry.id, 'catalog-scan-2927079');
    expect(entry.commonName, 'Blue bugleweed');
    expect(entry.scientificName, 'Ajuga genevensis');
    expect(entry.overview, contains('Pl@ntNet'));
  });
}
