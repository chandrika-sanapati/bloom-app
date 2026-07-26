import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/models/fixture_models.dart';

/// Merges catalog care suggestions without overwriting user-edited rules.
abstract final class CarePlanMerge {
  static List<domain.CarePlanItem> mergeCatalogSuggestions({
    required String userPlantId,
    required List<domain.CarePlanItem> existing,
    required List<FixtureCarePlanItem> catalog,
  }) {
    final byKind = {
      for (final item in existing) item.kind: item,
    };
    final merged = <domain.CarePlanItem>[];

    for (var i = 0; i < catalog.length; i++) {
      final suggestion = catalog[i];
      final kind = _toDomainKind(suggestion.kind);
      final previous = byKind.remove(kind);
      final suggested = suggestion.cadenceLabel;

      if (previous != null && previous.isUserModified) {
        merged.add(
          domain.CarePlanItem(
            id: previous.id,
            userPlantId: userPlantId,
            kind: kind,
            title: previous.title,
            cadenceLabel: previous.cadenceLabel,
            sortOrder: i,
            suggestedCadenceLabel: suggested,
            isUserModified: true,
            sourceUrl: suggestion.sourceUrl ?? previous.sourceUrl,
            careContentVersion:
                suggestion.careContentVersion ?? previous.careContentVersion,
          ),
        );
        continue;
      }

      merged.add(
        domain.CarePlanItem(
          id: previous?.id ?? 'plan-$userPlantId-$i',
          userPlantId: userPlantId,
          kind: kind,
          title: suggestion.title,
          cadenceLabel: suggested,
          sortOrder: i,
          suggestedCadenceLabel: suggested,
          isUserModified: false,
          sourceUrl: suggestion.sourceUrl,
          careContentVersion: suggestion.careContentVersion,
        ),
      );
    }

    // Keep leftover user-modified extras that catalog no longer lists.
    for (final leftover in byKind.values) {
      if (leftover.isUserModified) {
        merged.add(
          domain.CarePlanItem(
            id: leftover.id,
            userPlantId: userPlantId,
            kind: leftover.kind,
            title: leftover.title,
            cadenceLabel: leftover.cadenceLabel,
            sortOrder: merged.length,
            suggestedCadenceLabel: leftover.suggestedCadenceLabel,
            isUserModified: true,
            sourceUrl: leftover.sourceUrl,
            careContentVersion: leftover.careContentVersion,
          ),
        );
      }
    }

    return merged;
  }

  static bool isModifiedRelativeToSuggestion({
    required String cadenceLabel,
    required String? suggestedCadenceLabel,
  }) {
    final suggested = suggestedCadenceLabel ?? cadenceLabel;
    return cadenceLabel.trim() != suggested.trim();
  }

  static domain.CareActionKind _toDomainKind(CareActionKind kind) {
    return switch (kind) {
      CareActionKind.water => domain.CareActionKind.water,
      CareActionKind.fertilise => domain.CareActionKind.fertilise,
      CareActionKind.prune => domain.CareActionKind.prune,
      CareActionKind.check => domain.CareActionKind.check,
      CareActionKind.light => domain.CareActionKind.light,
    };
  }
}
