import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:bloom/app/theme/bloom_spacing.dart';
import 'package:flutter/material.dart';

class BloomStatusChip extends StatelessWidget {
  const BloomStatusChip({
    required this.label,
    required this.color,
    required this.icon,
    super.key,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: BloomSpacing.x2 + 2,
        vertical: BloomSpacing.x1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(BloomRadii.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: BloomSpacing.x1),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
