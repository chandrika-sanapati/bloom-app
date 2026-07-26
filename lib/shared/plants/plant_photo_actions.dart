import 'package:bloom/shared/plants/plant_photo_store.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Shared gallery/camera import helpers for user plant photos.
abstract final class PlantPhotoActions {
  static final ImagePicker _picker = ImagePicker();
  static const PlantPhotoStore store = PlantPhotoStore();

  static Future<String?> pickAndImport({
    required BuildContext context,
    required String userPlantId,
    required ImageSource source,
    String? previousPath,
  }) async {
    try {
      final picked = await _picker.pickImage(
        source: source,
        maxWidth: 1600,
        maxHeight: 1600,
        imageQuality: 85,
        requestFullMetadata: false,
      );
      if (picked == null) {
        return null;
      }
      final path = await store.importPhoto(
        userPlantId: userPlantId,
        sourcePath: picked.path,
      );
      if (previousPath != null && previousPath != path) {
        await store.deletePhoto(previousPath);
      }
      return path;
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not save that photo. Try another image.'),
          ),
        );
      }
      return null;
    }
  }

  static Future<ImageSource?> chooseSource(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera_outlined),
                title: const Text('Take photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }
}
