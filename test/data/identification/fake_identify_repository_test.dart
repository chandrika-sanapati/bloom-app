import 'package:bloom/data/identification/fake_identify_repository.dart';
import 'package:bloom/data/identification/identify_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fake identify returns demo ranked candidates', () async {
    final repo = FakeIdentifyRepository();
    final result = await repo.identify(imagePath: '/tmp/unused.jpg');

    expect(repo.isDemo, isTrue);
    expect(result.isDemo, isTrue);
    expect(result.candidates, isNotEmpty);
    expect(
      result.candidates.first.scientificNameWithoutAuthor,
      'Dracaena trifasciata',
    );
  });

  test('confidenceColor strengthens with score', () {
    const high = IdentifyCandidate(
      score: 0.9,
      scientificName: 'A',
      scientificNameWithoutAuthor: 'A',
      commonNames: [],
    );
    const mid = IdentifyCandidate(
      score: 0.4,
      scientificName: 'B',
      scientificNameWithoutAuthor: 'B',
      commonNames: [],
    );
    const low = IdentifyCandidate(
      score: 0.1,
      scientificName: 'C',
      scientificNameWithoutAuthor: 'C',
      commonNames: [],
    );

    expect(high.confidenceColor, const Color(0xFF2AAA8A));
    expect(mid.confidenceColor, const Color(0xFF7BA17D));
    expect(low.confidenceColor, const Color(0xFFC4A35A));
  });
}
