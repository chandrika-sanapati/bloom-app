import 'package:bloom/shared/widgets/bloom_placeholder_body.dart';
import 'package:flutter/material.dart';

class PlantsScreen extends StatelessWidget {
  const PlantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BloomPlaceholderBody(
      icon: Icons.local_florist_outlined,
      title: 'My Plants',
      message:
          'Your saved houseplant collection will live here. Add plants from Discover.',
    );
  }
}
