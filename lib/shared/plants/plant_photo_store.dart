import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Copies user plant photos into app-private storage.
class PlantPhotoStore {
  const PlantPhotoStore({this.overrideDirectory});

  /// Test-only root directory. When null, uses application support.
  final Directory? overrideDirectory;

  Future<Directory> _photosDirectory() async {
    final root =
        overrideDirectory ?? await getApplicationSupportDirectory();
    final directory = Directory(p.join(root.path, 'plant_photos'));
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  /// Imports [sourcePath] for [userPlantId], replacing any previous copy.
  Future<String> importPhoto({
    required String userPlantId,
    required String sourcePath,
  }) async {
    final source = File(sourcePath);
    if (!source.existsSync()) {
      throw StateError('Selected photo is no longer available.');
    }

    final directory = await _photosDirectory();
    final extension = p.extension(sourcePath).toLowerCase();
    final safeExtension = extension.isEmpty || extension.length > 5
        ? '.jpg'
        : extension;
    final destination = File(
      p.join(directory.path, '$userPlantId$safeExtension'),
    );

    if (destination.existsSync()) {
      await destination.delete();
    }
    await source.copy(destination.path);
    return destination.path;
  }

  Future<void> deletePhoto(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
