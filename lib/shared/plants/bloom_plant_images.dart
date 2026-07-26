import 'package:bloom/shared/fixtures/bloom_catalog.dart';

/// Resolves bundled placeholder photos for catalog species.
abstract final class BloomPlantImages {
  static const assetDirectory = 'assets/plants';

  static Set<String> get slugs => BloomCatalog.imageSlugs;

  /// Returns `assets/plants/{slug}.jpg` for known plant/catalog/species ids
  /// or common names; otherwise `null`.
  static String? assetFor(String? idOrName) {
    final slug = slugFor(idOrName);
    if (slug == null) {
      return null;
    }
    return '$assetDirectory/$slug.jpg';
  }

  static String? slugFor(String? idOrName) {
    if (idOrName == null) {
      return null;
    }
    var value = idOrName.trim().toLowerCase();
    if (value.isEmpty) {
      return null;
    }

    const prefixes = <String>[
      'species-catalog-',
      'species-plant-',
      'catalog-',
      'plant-',
      'species-',
      'task-',
    ];
    for (final prefix in prefixes) {
      if (value.startsWith(prefix)) {
        value = value.substring(prefix.length);
        break;
      }
    }

    value = value.replaceAll(RegExp(r'[\s_]+'), '-');
    // Normalize curly apostrophes from authored copy.
    value = value.replaceAll('’', "'").replaceAll("'", '');

    final aliases = BloomCatalog.imageAliases;
    if (aliases.containsKey(value)) {
      return aliases[value];
    }
    if (slugs.contains(value)) {
      return value;
    }

    // task ids look like snake-water — keep the species token.
    final dash = value.indexOf('-');
    if (dash > 0) {
      final head = value.substring(0, dash);
      if (aliases.containsKey(head) || slugs.contains(head)) {
        return aliases[head] ?? head;
      }
    }

    // Multi-token common names already hyphenated above.
    return aliases[value];
  }
}
