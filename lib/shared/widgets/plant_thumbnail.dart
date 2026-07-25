import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/shared/plants/bloom_plant_images.dart';
import 'package:flutter/material.dart';

/// Accent fallback + bundled plant photo when a catalog slug is known.
class PlantThumbnail extends StatelessWidget {
  const PlantThumbnail({
    required this.plantKey,
    required this.accent,
    this.width,
    this.height,
    this.borderRadius,
    this.icon = Icons.local_florist,
    this.iconSize = 40,
    this.semanticLabel,
    super.key,
  });

  /// Plant id, catalog id, species id, or common name.
  final String plantKey;
  final Color accent;
  final double? width;
  final double? height;
  final double? borderRadius;
  final IconData icon;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BloomRadii.image;
    final asset = BloomPlantImages.assetFor(plantKey);
    final fallback = ColoredBox(
      color: accent.withValues(alpha: 0.18),
      child: Center(
        child: Icon(icon, size: iconSize, color: accent),
      ),
    );

    final child = asset == null
        ? fallback
        : Image.asset(
            asset,
            fit: BoxFit.cover,
            width: width ?? double.infinity,
            height: height ?? double.infinity,
            filterQuality: FilterQuality.medium,
            semanticLabel: semanticLabel,
            errorBuilder: (_, _, _) => fallback,
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
