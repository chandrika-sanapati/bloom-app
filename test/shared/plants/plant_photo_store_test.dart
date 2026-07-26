import 'dart:io';

import 'package:bloom/shared/plants/plant_photo_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

void main() {
  test('imports and deletes plant photos in private storage', () async {
    final temp = await Directory.systemTemp.createTemp('bloom_photo_');
    addTearDown(() async {
      if (temp.existsSync()) {
        await temp.delete(recursive: true);
      }
    });

    final source = File(p.join(temp.path, 'source.jpg'));
    await source.writeAsBytes(List<int>.filled(32, 7));

    final store = PlantPhotoStore(overrideDirectory: temp);
    final path = await store.importPhoto(
      userPlantId: 'plant-1',
      sourcePath: source.path,
    );

    expect(File(path).existsSync(), isTrue);
    expect(await File(path).length(), 32);
    expect(p.basename(path), 'plant-1.jpg');

    await store.deletePhoto(path);
    expect(File(path).existsSync(), isFalse);
  });

  test('rejects missing source photos', () async {
    final temp = await Directory.systemTemp.createTemp('bloom_photo_missing_');
    addTearDown(() async {
      if (temp.existsSync()) {
        await temp.delete(recursive: true);
      }
    });

    final store = PlantPhotoStore(overrideDirectory: temp);
    expect(
      () => store.importPhoto(
        userPlantId: 'plant-1',
        sourcePath: p.join(temp.path, 'missing.jpg'),
      ),
      throwsStateError,
    );
  });
}
