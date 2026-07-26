import 'package:bloom/data/identification/fake_identify_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fake identify returns demo ranked candidates', () async {
    final repo = FakeIdentifyRepository();
    final result = await repo.identify(imagePath: '/tmp/unused.jpg');

    expect(repo.isDemo, isTrue);
    expect(result.isDemo, isTrue);
    expect(result.candidates, isNotEmpty);
    expect(result.candidates.first.scientificNameWithoutAuthor, 'Dracaena trifasciata');
  });
}
