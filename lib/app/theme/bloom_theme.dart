import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/app/theme/bloom_radii.dart';
import 'package:flutter/material.dart';

ThemeData buildBloomTheme() {
  final colorScheme =
      ColorScheme.fromSeed(
        seedColor: BloomColors.brandGreen,
        brightness: Brightness.light,
      ).copyWith(
        primary: BloomColors.brandGreen,
        surface: BloomColors.canvas,
        onSurface: BloomColors.labelPrimary,
        onSurfaceVariant: BloomColors.labelTertiary,
        outline: BloomColors.borderSubtle,
        secondaryContainer: BloomColors.brandGreenLight,
        onSecondaryContainer: BloomColors.labelPrimary,
      );

  final baseTextTheme =
      Typography.material2021(platform: TargetPlatform.android).black.apply(
        bodyColor: BloomColors.labelPrimary,
        displayColor: BloomColors.labelPrimary,
      );

  // Poppins will be bundled later; sizes/weights follow the design system now.
  final textTheme = baseTextTheme.copyWith(
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: BloomColors.labelPrimary,
    ),
    titleMedium: baseTextTheme.titleMedium?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: BloomColors.labelPrimary,
    ),
    titleSmall: baseTextTheme.titleSmall?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: BloomColors.labelPrimary,
    ),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: BloomColors.labelPrimary,
    ),
    bodySmall: baseTextTheme.bodySmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: BloomColors.labelSecondary,
    ),
    labelMedium: baseTextTheme.labelMedium?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: BloomColors.brandGreen,
    ),
    labelSmall: baseTextTheme.labelSmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: BloomColors.labelTertiary,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: BloomColors.canvas,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: BloomColors.card,
      foregroundColor: BloomColors.labelPrimary,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      centerTitle: false,
      titleTextStyle: textTheme.titleMedium,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: BloomColors.card,
      indicatorColor: BloomColors.brandGreenLight,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return selected ? textTheme.labelMedium : textTheme.labelSmall;
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? BloomColors.brandGreen : BloomColors.labelTertiary,
        );
      }),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BloomRadii.button),
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: BloomColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BloomRadii.card),
        side: const BorderSide(color: BloomColors.borderSubtle),
      ),
    ),
  );
}
