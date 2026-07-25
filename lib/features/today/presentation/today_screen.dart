import 'package:bloom/shared/widgets/bloom_placeholder_body.dart';
import 'package:flutter/material.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BloomPlaceholderBody(
      icon: Icons.wb_sunny_outlined,
      title: 'Today',
      message:
          'Your overdue, due, and upcoming care tasks will appear here once plants are added.',
    );
  }
}
