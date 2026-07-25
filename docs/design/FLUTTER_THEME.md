# Flutter Theme Mapping (Not Implemented Yet)

**Last reviewed:** 2026-07-25

This note describes how [`../DESIGN.md`](../DESIGN.md) should map into Flutter later. It is documentation only; no theme package is required until the Phase 5 foundation pass.

## Seed and scheme

```dart
const bloomSeed = Color(0xFF2AAA8A);

final colorScheme = ColorScheme.fromSeed(
  seedColor: bloomSeed,
  brightness: Brightness.light,
).copyWith(
  primary: const Color(0xFF2AAA8A),
  surface: const Color(0xFFFBFCFD),
  onSurface: const Color(0xFF343A40),
  onSurfaceVariant: const Color(0xFF6C757D),
  outline: const Color(0xFFCED4DA),
  secondaryContainer: const Color(0xFFD8F3DC),
);
```

Use `ColorScheme.fromSeed` as the base, then override the brand-critical roles above so Figma primary green stays exact.

## Typography

- Add Poppins via `google_fonts` or bundled font files when the foundation theme lands.
- Map DESIGN.md styles into `TextTheme` (`titleLarge`, `titleMedium`, `bodyMedium`, `bodySmall`, `labelMedium`).
- Keep Material 3 component text styles unless a screen specifically needs a display greeting.

## Component defaults

| Design | Flutter |
|---|---|
| Screen canvas | `Scaffold(backgroundColor: colorScheme.surface)` |
| Bottom destinations | `NavigationBar` with three destinations |
| Primary CTA | `FilledButton` |
| Tonal CTA | `FilledButton.tonal` |
| Search | Material 3 `SearchBar` or decorated `TextField` |
| Task row | Custom bordered `Card` / `InkWell` row, not dense `ListTile` alone |
| Status chip | `Chip` / custom chip with icon + label |
| Sheets | `showModalBottomSheet` with 20 radius top corners |
| Switches | Material 3 `Switch` |

## Layout constants

```dart
abstract final class BloomSpace {
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double screenMargin = 16;
  static const double contentWidthPhone = 345;
}

abstract final class BloomRadius {
  static const double control = 8;
  static const double image = 12;
  static const double card = 16;
  static const double chip = 20;
  static const double button = 24;
}
```

## Implementation gate

Introduce `lib/app/theme/` only after Phase 2 validation and before or during Phase 5 skeleton work. Until then, keep the seed colour in `lib/main.dart` compatible with `brand.green`.
