/// Resolves bundled placeholder photos for the starter catalog species.
abstract final class BloomPlantImages {
  static const assetDirectory = 'assets/plants';

  static const slugs = <String>{
    'snake',
    'pothos',
    'aloe',
    'monstera',
    'rubber',
    'lily',
  };

  static const _aliases = <String, String>{
    'snake': 'snake',
    'snake-plant': 'snake',
    'pothos': 'pothos',
    'aloe': 'aloe',
    'aloe-vera': 'aloe',
    'monstera': 'monstera',
    'rubber': 'rubber',
    'rubber-plant': 'rubber',
    'lily': 'lily',
    'peace-lily': 'lily',
  };

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

    // task ids look like snake-water — keep the species token.
    final dash = value.indexOf('-');
    if (dash > 0 && !_aliases.containsKey(value) && !slugs.contains(value)) {
      final head = value.substring(0, dash);
      if (slugs.contains(head) || _aliases.containsKey(head)) {
        value = head;
      }
    }

    value = value.replaceAll(RegExp(r'[\s_]+'), '-');
    final slug = _aliases[value] ?? (slugs.contains(value) ? value : null);
    return slug;
  }
}
