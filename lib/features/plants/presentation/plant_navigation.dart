import 'package:bloom/features/plants/presentation/plant_detail_screen.dart';
import 'package:flutter/material.dart';

Future<void> openPlantDetail(BuildContext context, String plantId) {
  return Navigator.of(context).push<void>(
    MaterialPageRoute<void>(
      builder: (_) => PlantDetailScreen(plantId: plantId),
    ),
  );
}
