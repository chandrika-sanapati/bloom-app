import 'package:bloom/shared/plants/bloom_plant_images.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('resolves plant, catalog, and species ids to asset paths', () {
    expect(BloomPlantImages.assetFor('plant-snake'), 'assets/plants/snake.jpg');
    expect(
      BloomPlantImages.assetFor('catalog-pothos'),
      'assets/plants/pothos.jpg',
    );
    expect(
      BloomPlantImages.assetFor('species-plant-monstera'),
      'assets/plants/monstera.jpg',
    );
    expect(
      BloomPlantImages.assetFor('species-catalog-aloe'),
      'assets/plants/aloe.jpg',
    );
    expect(BloomPlantImages.assetFor('Peace Lily'), 'assets/plants/lily.jpg');
    expect(
      BloomPlantImages.assetFor('Rubber Plant'),
      'assets/plants/rubber.jpg',
    );
    expect(BloomPlantImages.assetFor('catalog-zz'), 'assets/plants/zz.jpg');
    expect(
      BloomPlantImages.assetFor('Money Plant'),
      'assets/plants/pothos.jpg',
    );
  });

  test('returns null for unknown keys', () {
    expect(BloomPlantImages.assetFor('plant-unknown'), isNull);
    expect(BloomPlantImages.assetFor(''), isNull);
    expect(BloomPlantImages.assetFor(null), isNull);
  });
}
