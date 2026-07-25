import 'package:flutter/material.dart';

/// Placeholder brand mark until a final logo is commissioned.
class BloomLogo extends StatelessWidget {
  const BloomLogo({super.key, this.size = 72, this.showWordmark = false});

  final double size;
  final bool showWordmark;

  static const assetPath = 'assets/brand/bloom_logo_mark.png';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mark = Image.asset(
      assetPath,
      width: size,
      height: size,
      filterQuality: FilterQuality.high,
      semanticLabel: 'Bloom logo',
    );

    if (!showWordmark) {
      return mark;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(height: 12),
        Text(
          'Bloom',
          style: theme.textTheme.titleLarge?.copyWith(letterSpacing: 0.2),
        ),
      ],
    );
  }
}
