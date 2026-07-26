import 'package:bloom/shared/care/bloom_care_content.dart';
import 'package:bloom/shared/fixtures/bloom_catalog.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/plants/bloom_plant_images.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('catalog has forty searchable houseplants with care plans', () {
    expect(BloomCatalog.entries, hasLength(40));
    expect(BloomFixtures.catalog, hasLength(40));

    for (final entry in BloomCatalog.entries) {
      final plan = BloomCatalog.suggestedCarePlan(entry);
      expect(plan, isNotEmpty, reason: entry.id);
      expect(plan.first.kind.name, anyOf('water', 'light'));
      for (final item in plan) {
        expect(item.sourceUrl, BloomCareContent.interimSourceUrl);
        expect(item.careContentVersion, BloomCareContent.version);
      }
      expect(
        BloomPlantImages.assetFor(entry.id),
        isNotNull,
        reason: 'missing image for ${entry.id}',
      );
    }
  });

  test('money plant reuses pothos photo', () {
    expect(
      BloomPlantImages.assetFor('catalog-money-plant'),
      'assets/plants/pothos.jpg',
    );
  });
}
