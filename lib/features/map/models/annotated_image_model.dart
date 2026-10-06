import 'phase_lot_annotation.dart';

/// Model representing a row from the Supabase `annotated_images` table,
/// including its parsed COCO annotations and image dimensions.
class AnnotatedImageModel {
  final int id;
  final String? project;
  final String? phase;
  final String? slot;
  final String? mapSection;
  final String? imageLink;
  final String? storagePath;
  final double imageWidth;
  final double imageHeight;
  final List<PhaseLotAnnotation> annotations;

  const AnnotatedImageModel({
    required this.id,
    this.project,
    this.phase,
    this.slot,
    this.mapSection,
    this.imageLink,
    this.storagePath,
    required this.imageWidth,
    required this.imageHeight,
    required this.annotations,
  });

  /// Whether map_section is explicitly specified on this record.
  bool get hasMapSection =>
      mapSection != null && mapSection!.trim().isNotEmpty;

  /// Normalized map section string, e.g. "East" -> "east", "E" -> "east".
  String? get normalizedMapSection {
    if (!hasMapSection) return null;
    final s = mapSection!.trim().toLowerCase();
    if (s == 'e' || s == 'east') return 'east';
    if (s == 'w' || s == 'west') return 'west';
    if (s == 'n' || s == 'north') return 'north';
    if (s == 's' || s == 'south') return 'south';
    return s;
  }

  /// Extracts the integer phase number if present (e.g. "2" -> 2, "phase-2" -> 2).
  int? get phaseNumber {
    if (phase != null) {
      final parsed = int.tryParse(phase!.trim());
      if (parsed != null) return parsed;
      final m = RegExp(r'(\d+)').firstMatch(phase!);
      if (m != null) return int.tryParse(m.group(1)!);
    }
    if (slot != null) {
      final m = RegExp(r'phase[-_\s]*(\d+)', caseSensitive: false)
          .firstMatch(slot!);
      if (m != null) return int.tryParse(m.group(1)!);
    }
    return null;
  }

  /// Whether this annotated image represents commercial parcels (e.g. slot = 'commercial').
  bool get isCommercial {
    final s = (slot ?? '').toLowerCase();
    final p = (phase ?? '').toLowerCase();
    return s.contains('commercial') || p.contains('commercial');
  }

  /// Whether this annotated image represents ERHD project.
  bool get isErhd {
    final proj = (project ?? '').toUpperCase();
    final s = (slot ?? '').toLowerCase();
    return proj.contains('ERHD') || s == 'whole';
  }

  /// Parses a record from the `annotated_images` table.
  factory AnnotatedImageModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] is int
        ? json['id'] as int
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    final project = json['project'] as String?;
    final phase = json['phase']?.toString();
    final slot = json['slot'] as String?;
    final mapSection = json['map_section']?.toString();
    final imageLink = json['image_link'] as String?;
    final storagePath = json['storage_path'] as String?;

    // Default fallback image dimensions
    double width = 2048.0;
    double height = 1448.0;

    final coco = json['coco_json'];
    final annotations = <PhaseLotAnnotation>[];

    if (coco is Map) {
      // 1. Extract image dimensions from coco_json['images']
      final images = coco['images'];
      if (images is List && images.isNotEmpty && images.first is Map) {
        final img = images.first as Map;
        final w = double.tryParse(img['width']?.toString() ?? '');
        final h = double.tryParse(img['height']?.toString() ?? '');
        if (w != null && w > 0) width = w;
        if (h != null && h > 0) height = h;
      }

      // 2. Build category ID -> name lookup from coco_json['categories']
      final categoryNames = <int, String>{};
      final categories = coco['categories'];
      if (categories is List) {
        for (final cat in categories) {
          if (cat is Map) {
            final catId = cat['id'] is int
                ? cat['id'] as int
                : int.tryParse(cat['id']?.toString() ?? '0') ?? 0;
            final catName = cat['name']?.toString() ?? '';
            categoryNames[catId] = catName;
          }
        }
      }

      // 3. Parse annotations list from coco_json['annotations']
      final rawAnns = coco['annotations'];
      if (rawAnns is List) {
        for (final item in rawAnns) {
          if (item is Map) {
            try {
              final ann = PhaseLotAnnotation.fromCocoJson(
                json: Map<String, dynamic>.from(item),
                categoryNames: categoryNames,
                imageWidth: width,
                imageHeight: height,
              );
              annotations.add(ann);
            } catch (_) {
              // Ignore individual malformed annotations
            }
          }
        }
      }
    }

    return AnnotatedImageModel(
      id: id,
      project: project,
      phase: phase,
      slot: slot,
      mapSection: mapSection,
      imageLink: imageLink,
      storagePath: storagePath,
      imageWidth: width,
      imageHeight: height,
      annotations: annotations,
    );
  }
}
