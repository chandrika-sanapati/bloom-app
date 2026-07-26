import 'package:bloom/data/identification/identify_models.dart';
import 'package:bloom/data/identification/identify_repository.dart';

/// Deterministic sample results for tests and builds without a proxy/key.
class FakeIdentifyRepository implements IdentifyRepository {
  FakeIdentifyRepository({this.delay = Duration.zero});

  final Duration delay;

  @override
  bool get isDemo => true;

  @override
  Future<IdentifyResult> identify({
    required String imagePath,
    int maxResults = 5,
  }) async {
    if (delay > Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final all = const [
      IdentifyCandidate(
        score: 0.86,
        scientificName: 'Dracaena trifasciata (Prain) Mabb.',
        scientificNameWithoutAuthor: 'Dracaena trifasciata',
        commonNames: ['Snake Plant', 'Mother-in-law\'s tongue'],
        gbifId: '2772677',
        family: 'Asparagaceae',
        genus: 'Dracaena',
      ),
      IdentifyCandidate(
        score: 0.09,
        scientificName: 'Dracaena angolensis (Welw. ex Carrière) Byng & Christenh.',
        scientificNameWithoutAuthor: 'Dracaena angolensis',
        commonNames: ['African spear'],
        gbifId: '2772598',
        family: 'Asparagaceae',
        genus: 'Dracaena',
      ),
      IdentifyCandidate(
        score: 0.04,
        scientificName: 'Epipremnum aureum (Linden & André) G.S.Bunting',
        scientificNameWithoutAuthor: 'Epipremnum aureum',
        commonNames: ['Pothos', 'Devil\'s ivy'],
        gbifId: '2870752',
        family: 'Araceae',
        genus: 'Epipremnum',
      ),
    ];
    return IdentifyResult(
      candidates: all.take(maxResults).toList(),
      bestMatch: all.first.scientificName,
      isDemo: true,
    );
  }
}
