import 'package:bloom/shared/care/bloom_care_content.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter/material.dart';

/// Curated v1 Discover catalog (~40 houseplants). Bloom-authored plans;
/// qualitative cadences only — no exact volumes or toxicity claims.
abstract final class BloomCatalog {
  static const careContentVersion = BloomCareContent.version;

  static const entries = <FixtureCatalogEntry>[
    FixtureCatalogEntry(
      id: 'catalog-snake',
      commonName: 'Snake Plant',
      scientificName: 'Dracaena trifasciata',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6B8F71),
      overview:
          'A hardy houseplant with stiff, upright leaves. Let the soil dry between drinks.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-pothos',
      commonName: 'Pothos',
      scientificName: 'Epipremnum aureum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7BA17D),
      overview:
          'A trailing vine that tolerates lower light. Water when the top of the soil feels dry.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-aloe',
      commonName: 'Aloe Vera',
      scientificName: 'Aloe vera',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF9BB89A),
      overview:
          'A succulent that stores water in thick leaves. Prefer bright light and infrequent watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-monstera',
      commonName: 'Monstera',
      scientificName: 'Monstera deliciosa',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF4F7F57),
      overview:
          'Famous for split leaves. Likes bright indirect light and watering when the top of the soil has dried out.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-rubber',
      commonName: 'Rubber Plant',
      scientificName: 'Ficus elastica',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF5C7A6A),
      overview:
          'A bold indoor tree with thick, shiny leaves. Prefers bright indirect light and moderate watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-lily',
      commonName: 'Peace Lily',
      scientificName: 'Spathiphyllum wallisii',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF8FAE8B),
      overview:
          'Known for glossy leaves and white blooms. Enjoys evenly moist soil and medium light.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-zz',
      commonName: 'ZZ Plant',
      scientificName: 'Zamioculcas zamiifolia',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF5F8A6E),
      overview:
          'A tough indoor plant with glossy leaflets. Forgiving if you forget to water.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-spider',
      commonName: 'Spider Plant',
      scientificName: 'Chlorophytum comosum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7C9E76),
      overview:
          'Arching striped leaves and easy plantlets. Tolerates a range of indoor light.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-jade',
      commonName: 'Jade Plant',
      scientificName: 'Crassula ovata',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF8A9E6B),
      overview:
          'A classic succulent shrub with plump leaves. Prefers bright light and careful watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-boston-fern',
      commonName: 'Boston Fern',
      scientificName: 'Nephrolepis exaltata',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF6A9B72),
      overview:
          'A lush fern that likes humidity and evenly moist soil. Avoid letting the root ball dry hard.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-areca',
      commonName: 'Areca Palm',
      scientificName: 'Dypsis lutescens',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF6F8F5E),
      overview:
          'A popular indoor palm with arching fronds. Prefers bright light and consistent moisture checks.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-money-plant',
      commonName: 'Money Plant',
      scientificName: 'Epipremnum aureum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7BA17D),
      overview:
          'Trade name often used for pothos in India. Same care as Epipremnum aureum — trailing and forgiving.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-philodendron-brasil',
      commonName: 'Philodendron Brasil',
      scientificName: 'Philodendron hederaceum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6E9A68),
      overview:
          'A variegated heartleaf philodendron with lime streaks. Easy trailing houseplant.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-heartleaf',
      commonName: 'Heartleaf Philodendron',
      scientificName: 'Philodendron hederaceum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF65946A),
      overview:
          'Classic heart-shaped leaves on trailing stems. Tolerates lower light better than many vines.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-aglaonema',
      commonName: 'Chinese Evergreen',
      scientificName: 'Aglaonema commutatum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7A8F6A),
      overview:
          'Patterned foliage that handles lower light well. Keep away from cold drafts.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-calathea',
      commonName: 'Calathea Orbifolia',
      scientificName: 'Goeppertia orbifolia',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF5C8A75),
      overview:
          'Broad striped leaves that prefer humidity and gentle, consistent moisture.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-prayer',
      commonName: 'Prayer Plant',
      scientificName: 'Maranta leuconeura',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF6B8B6A),
      overview:
          'Leaves fold upward at night. Likes humidity and evenly moist soil.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-fiddle-leaf',
      commonName: 'Fiddle-Leaf Fig',
      scientificName: 'Ficus lyrata',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF547A5C),
      overview:
          'Large violin-shaped leaves. Prefers stable bright light and careful watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-weeping-fig',
      commonName: 'Weeping Fig',
      scientificName: 'Ficus benjamina',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF5A7F62),
      overview:
          'A classic indoor tree that may drop leaves when moved. Prefers bright, steady conditions.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-bird-of-paradise',
      commonName: 'Bird of Paradise',
      scientificName: 'Strelitzia reginae',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF6D8B58),
      overview:
          'Bold tropical leaves and eventual blooms in bright homes. Needs space and patience.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-birds-nest-fern',
      commonName: "Bird's Nest Fern",
      scientificName: 'Asplenium nidus',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF6F9670),
      overview:
          'A rosette fern with wavy fronds. Keep the center dry while soil stays lightly moist.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-ivy',
      commonName: 'English Ivy',
      scientificName: 'Hedera helix',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF5E8A64),
      overview:
          'A trailing or climbing vine. Prefers cooler rooms and evenly moist soil.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-string-of-pearls',
      commonName: 'String of Pearls',
      scientificName: 'Curio rowleyanus',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF8BA86A),
      overview:
          'Trailing succulent beads. Needs bright light and very careful watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-haworthia',
      commonName: 'Haworthia',
      scientificName: 'Haworthiopsis attenuata',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF8A9B6E),
      overview:
          'A compact striped succulent for bright windowsills. Easy and slow-growing.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-echeveria',
      commonName: 'Echeveria',
      scientificName: 'Echeveria elegans',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF9BAA72),
      overview:
          'A rosette succulent that likes bright light and dry spells between waterings.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-orchid',
      commonName: 'Moth Orchid',
      scientificName: 'Phalaenopsis',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF8FA88C),
      overview:
          'Long-lasting blooms on aerial roots. Prefer bright shade and careful watering.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-anthurium',
      commonName: 'Anthurium',
      scientificName: 'Anthurium andraeanum',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF7A8F66),
      overview:
          'Glossy leaves and colorful spathes. Likes humidity and evenly moist soil.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-dieffenbachia',
      commonName: 'Dieffenbachia',
      scientificName: 'Dieffenbachia seguine',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6E9168),
      overview:
          'Broad patterned leaves for medium light. Keep soil lightly moist and avoid cold drafts.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-dracaena-marginata',
      commonName: 'Dracaena Marginata',
      scientificName: 'Dracaena reflexa var. angustifolia',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6A7F5E),
      overview:
          'Slim trunks with spiky foliage. Forgiving about light and watering gaps.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-yucca',
      commonName: 'Yucca',
      scientificName: 'Yucca elephantipes',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7D8F5A),
      overview:
          'A sturdy indoor tree with sword-like leaves. Prefers bright light and dry soil between waterings.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-croton',
      commonName: 'Croton',
      scientificName: 'Codiaeum variegatum',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF8B7A4A),
      overview:
          'Colorful foliage that needs bright light to keep its patterns vivid.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-begonia-rex',
      commonName: 'Begonia Rex',
      scientificName: 'Begonia rex-cultorum',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF8A6F7A),
      overview:
          'Dramatic patterned leaves. Prefers humidity and careful watering around the foliage.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-peperomia',
      commonName: 'Peperomia',
      scientificName: 'Peperomia obtusifolia',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6F8F6A),
      overview:
          'Compact, waxy leaves on a tidy plant. Good for desks and shelves.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-tradescantia',
      commonName: 'Tradescantia Zebrina',
      scientificName: 'Tradescantia zebrina',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6A7A8F),
      overview:
          'Fast trailing stems with striped leaves. Bright light keeps the color strong.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-syngonium',
      commonName: 'Syngonium',
      scientificName: 'Syngonium podophyllum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6E946C),
      overview:
          'Arrowhead-shaped leaves that climb or trail. Easy and adaptable indoors.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-bamboo-palm',
      commonName: 'Bamboo Palm',
      scientificName: 'Chamaedorea seifrizii',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF5F8A66),
      overview:
          'A clumping indoor palm for medium light. Prefers evenly moist soil without sitting wet.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-parlor-palm',
      commonName: 'Parlor Palm',
      scientificName: 'Chamaedorea elegans',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6A8F68),
      overview:
          'A compact palm for lower light rooms. Slow-growing and beginner-friendly.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-schefflera',
      commonName: 'Schefflera',
      scientificName: 'Heptapleurum arboricola',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF5F7F5A),
      overview:
          'Umbrella-like leaflets on an upright shrub. Bright light keeps growth sturdy.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-hoya',
      commonName: 'Hoya Carnosa',
      scientificName: 'Hoya carnosa',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7A8A6A),
      overview:
          'Waxy trailing leaves and clusters of blooms when mature. Prefers bright light and drying between waterings.',
    ),
    FixtureCatalogEntry(
      id: 'catalog-lavender',
      commonName: 'Lavender',
      scientificName: 'Lavandula angustifolia',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF7A7A9A),
      overview:
          'A fragrant windowsill herb that needs strong light and excellent drainage indoors.',
    ),
  ];

  static const carePlans = <String, List<FixtureCarePlanItem>>{
    'catalog-snake': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is fully dry — often every 2–3 weeks',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Light feed in spring and summer (suggested)',
      ),
    ],
    'catalog-pothos': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim long vines to keep shape',
      ),
    ],
    'catalog-aloe': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Sparingly — only when soil is fully dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; some direct sun is fine',
      ),
    ],
    'catalog-monstera': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil has dried out',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Provide a stake or moss pole as it climbs',
      ),
    ],
    'catalog-rubber': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Monthly in growing season (suggested)',
      ),
    ],
    'catalog-lily': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist; water when leaves droop',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Remove spent blooms and yellow leaves as needed',
      ),
    ],
    'catalog-zz': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is fully dry — often every 2–4 weeks',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Light feed in the growing season (suggested)',
      ),
    ],
    'catalog-spider': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim brown tips and divide crowded clumps as needed',
      ),
    ],
    'catalog-jade': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Only when soil is fully dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; some direct sun helps',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Light feed in spring and summer (suggested)',
      ),
    ],
    'catalog-boston-fern': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil evenly moist — not soggy',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim brown fronds; misting is optional',
      ),
    ],
    'catalog-areca': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Wipe dust from fronds as needed',
      ),
    ],
    'catalog-money-plant': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim long vines to keep shape',
      ),
    ],
    'catalog-philodendron-brasil': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Pinch tips to encourage bushiness',
      ),
    ],
    'catalog-heartleaf': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim leggy stems as needed',
      ),
    ],
    'catalog-aglaonema': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to medium indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Wipe leaves to keep patterns bright',
      ),
    ],
    'catalog-calathea': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist; avoid soaking',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light — avoid harsh sun',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Optional misting in dry rooms',
      ),
    ],
    'catalog-prayer': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim spent leaves as needed',
      ),
    ],
    'catalog-fiddle-leaf': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Dust large leaves regularly',
      ),
    ],
    'catalog-weeping-fig': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Prune for shape in growing season',
      ),
    ],
    'catalog-bird-of-paradise': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; some direct sun is fine',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Wipe leaves; rotate for even growth',
      ),
    ],
    'catalog-birds-nest-fern': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist; avoid pouring into the crown',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Remove damaged fronds at the base',
      ),
    ],
    'catalog-ivy': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect to medium light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim to control spread',
      ),
    ],
    'catalog-string-of-pearls': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Sparingly — only when soil is dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Avoid wetting the pearls when watering',
      ),
    ],
    'catalog-haworthia': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Only when soil is fully dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; soft morning sun is fine',
      ),
    ],
    'catalog-echeveria': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Only when soil is fully dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; some direct sun helps',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Remove dried lower leaves as needed',
      ),
    ],
    'catalog-orchid': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Water when roots look silvery; avoid standing water',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim spent flower spikes after blooms fade',
      ),
    ],
    'catalog-anthurium': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Wipe leaves; remove spent blooms',
      ),
    ],
    'catalog-dieffenbachia': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Wipe dust from large leaves',
      ),
    ],
    'catalog-dracaena-marginata': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is mostly dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim brown leaf tips as needed',
      ),
    ],
    'catalog-yucca': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is fully dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; some direct sun is fine',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Wipe dusty leaves',
      ),
    ],
    'catalog-croton': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Mist optionally in dry air; avoid cold drafts',
      ),
    ],
    'catalog-begonia-rex': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Remove damaged leaves; avoid wetting foliage heavily',
      ),
    ],
    'catalog-peperomia': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Pinch tips for a fuller shape',
      ),
    ],
    'catalog-tradescantia': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Pinch often to prevent legginess',
      ),
    ],
    'catalog-syngonium': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim to shape; provide support if climbing',
      ),
    ],
    'catalog-bamboo-palm': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Dust fronds; trim brown tips',
      ),
    ],
    'catalog-parlor-palm': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to medium indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim brown fronds at the base',
      ),
    ],
    'catalog-schefflera': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Prune for height and shape',
      ),
    ],
    'catalog-hoya': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is mostly dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Check',
        cadenceLabel: 'Avoid moving flowering stems; let vines trail or climb',
      ),
    ],
    'catalog-lavender': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is dry; avoid constant dampness',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright light; as much sun as you can give',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Trim after flowering to keep compact',
      ),
    ],
  };

  static List<FixtureCarePlanItem> suggestedCarePlan(
    FixtureCatalogEntry entry,
  ) {
    final raw =
        carePlans[entry.id] ??
        const [
          FixtureCarePlanItem(
            kind: CareActionKind.water,
            title: 'Water',
            cadenceLabel: 'When the top of the soil feels dry',
          ),
          FixtureCarePlanItem(
            kind: CareActionKind.light,
            title: 'Light',
            cadenceLabel: 'Bright indirect light',
          ),
        ];
    return [for (final item in raw) withProvenance(item)];
  }

  /// Stamps interim source + content version when a rule omits them.
  static FixtureCarePlanItem withProvenance(FixtureCarePlanItem item) {
    return FixtureCarePlanItem(
      kind: item.kind,
      title: item.title,
      cadenceLabel: item.cadenceLabel,
      sourceUrl: item.sourceUrl ?? BloomCareContent.interimSourceUrl,
      careContentVersion:
          item.careContentVersion ?? BloomCareContent.version,
    );
  }

  static const imageSlugs = <String>{
    'snake',
    'pothos',
    'aloe',
    'monstera',
    'rubber',
    'lily',
    'zz',
    'spider',
    'jade',
    'boston-fern',
    'areca',
    'philodendron-brasil',
    'heartleaf',
    'aglaonema',
    'calathea',
    'prayer',
    'fiddle-leaf',
    'weeping-fig',
    'bird-of-paradise',
    'birds-nest-fern',
    'ivy',
    'string-of-pearls',
    'haworthia',
    'echeveria',
    'orchid',
    'anthurium',
    'dieffenbachia',
    'dracaena-marginata',
    'yucca',
    'croton',
    'begonia-rex',
    'peperomia',
    'tradescantia',
    'syngonium',
    'bamboo-palm',
    'parlor-palm',
    'schefflera',
    'hoya',
    'lavender',
  };

  /// Maps catalog/plant ids and common names to image asset slugs.
  static const imageAliases = <String, String>{
    'aglaonema': 'aglaonema',
    'aloe': 'aloe',
    'aloe-vera': 'aloe',
    'anthurium': 'anthurium',
    'areca': 'areca',
    'areca-palm': 'areca',
    'bamboo-palm': 'bamboo-palm',
    'begonia-rex': 'begonia-rex',
    'bird-of-paradise': 'bird-of-paradise',
    'birds-nest-fern': 'birds-nest-fern',
    'boston-fern': 'boston-fern',
    'calathea': 'calathea',
    'calathea-orbifolia': 'calathea',
    'chinese-evergreen': 'aglaonema',
    'croton': 'croton',
    'dieffenbachia': 'dieffenbachia',
    'dracaena-marginata': 'dracaena-marginata',
    'echeveria': 'echeveria',
    'english-ivy': 'ivy',
    'fiddle-leaf': 'fiddle-leaf',
    'fiddle-leaf-fig': 'fiddle-leaf',
    'haworthia': 'haworthia',
    'heartleaf': 'heartleaf',
    'heartleaf-philodendron': 'heartleaf',
    'hoya': 'hoya',
    'hoya-carnosa': 'hoya',
    'ivy': 'ivy',
    'jade': 'jade',
    'jade-plant': 'jade',
    'lavender': 'lavender',
    'lily': 'lily',
    'money-plant': 'pothos',
    'monstera': 'monstera',
    'moth-orchid': 'orchid',
    'orchid': 'orchid',
    'parlor-palm': 'parlor-palm',
    'peace-lily': 'lily',
    'peperomia': 'peperomia',
    'philodendron-brasil': 'philodendron-brasil',
    'pothos': 'pothos',
    'prayer': 'prayer',
    'prayer-plant': 'prayer',
    'rubber': 'rubber',
    'rubber-plant': 'rubber',
    'schefflera': 'schefflera',
    'snake': 'snake',
    'snake-plant': 'snake',
    'spider': 'spider',
    'spider-plant': 'spider',
    'string-of-pearls': 'string-of-pearls',
    'syngonium': 'syngonium',
    'tradescantia': 'tradescantia',
    'weeping-fig': 'weeping-fig',
    'yucca': 'yucca',
    'zz': 'zz',
    'zz-plant': 'zz',
  };
}
