import 'package:flutter/material.dart';

/// Base class representing a single annotated lot polygon from the COCO dataset
/// for a subdivision phase (e.g. Phase 2 or Phase 3).
class PhaseLotAnnotation {
  final int id;
  final int categoryId;
  final String name; // e.g. "B1 L3"
  final Rect bbox;
  final List<Offset> points;
  final double originalImageWidth;
  final double originalImageHeight;

  const PhaseLotAnnotation({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.bbox,
    required this.points,
    required this.originalImageWidth,
    required this.originalImageHeight,
  });

  /// Factory constructor to parse a single annotation object from COCO dataset JSON.
  factory PhaseLotAnnotation.fromCocoJson({
    required Map<String, dynamic> json,
    required Map<int, String> categoryNames,
    required double imageWidth,
    required double imageHeight,
  }) {
    final id = json['id'] is int
        ? json['id'] as int
        : int.tryParse(json['id']?.toString() ?? '0') ?? 0;
    final catId = json['category_id'] is int
        ? json['category_id'] as int
        : int.tryParse(json['category_id']?.toString() ?? '0') ?? 0;
    final name =
        categoryNames[catId] ?? (json['name']?.toString() ?? 'Lot $id');

    // Parse Bounding Box [x, y, width, height]
    Rect bbox = Rect.zero;
    if (json['bbox'] is List && (json['bbox'] as List).length >= 4) {
      final b = json['bbox'] as List;
      final bx = double.tryParse(b[0].toString()) ?? 0.0;
      final by = double.tryParse(b[1].toString()) ?? 0.0;
      final bw = double.tryParse(b[2].toString()) ?? 0.0;
      final bh = double.tryParse(b[3].toString()) ?? 0.0;
      bbox = Rect.fromLTWH(bx, by, bw, bh);
    }

    // Parse Segmentation Points [[x1, y1, x2, y2, ...]] or [x1, y1, ...]
    final points = <Offset>[];
    final seg = json['segmentation'];
    if (seg is List && seg.isNotEmpty) {
      List<dynamic> coords = [];
      if (seg.first is List) {
        coords = seg.first as List<dynamic>;
      } else {
        coords = seg;
      }
      for (int i = 0; i < coords.length - 1; i += 2) {
        final px = double.tryParse(coords[i].toString());
        final py = double.tryParse(coords[i + 1].toString());
        if (px != null && py != null) {
          points.add(Offset(px, py));
        }
      }
    }

    return PhaseLotAnnotation(
      id: id,
      categoryId: catId,
      name: name,
      bbox: bbox,
      points: points,
      originalImageWidth: imageWidth,
      originalImageHeight: imageHeight,
    );
  }

  /// Get the closed Path scaled to the exact image rect within renderSize.
  Path getPath(Size renderSize) {
    final fittedSizes = applyBoxFit(
      BoxFit.contain,
      Size(originalImageWidth, originalImageHeight),
      renderSize,
    );
    final imageRect = Alignment.center.inscribe(
      fittedSizes.destination,
      Offset.zero & renderSize,
    );

    final path = Path();
    if (points.isEmpty) return path;

    path.moveTo(
      imageRect.left + (points[0].dx / originalImageWidth) * imageRect.width,
      imageRect.top + (points[0].dy / originalImageHeight) * imageRect.height,
    );
    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        imageRect.left + (points[i].dx / originalImageWidth) * imageRect.width,
        imageRect.top + (points[i].dy / originalImageHeight) * imageRect.height,
      );
    }
    path.close();
    return path;
  }

  /// Get the centroid of the polygon scaled to the exact image rect within renderSize.
  Offset getCentroid(Size renderSize) {
    final fittedSizes = applyBoxFit(
      BoxFit.contain,
      Size(originalImageWidth, originalImageHeight),
      renderSize,
    );
    final imageRect = Alignment.center.inscribe(
      fittedSizes.destination,
      Offset.zero & renderSize,
    );

    if (points.isEmpty) {
      return Offset(
        imageRect.left + (bbox.center.dx / originalImageWidth) * imageRect.width,
        imageRect.top + (bbox.center.dy / originalImageHeight) * imageRect.height,
      );
    }

    double sumX = 0;
    double sumY = 0;
    for (final p in points) {
      sumX += p.dx;
      sumY += p.dy;
    }
    final avgX = sumX / points.length;
    final avgY = sumY / points.length;

    return Offset(
      imageRect.left + (avgX / originalImageWidth) * imageRect.width,
      imageRect.top + (avgY / originalImageHeight) * imageRect.height,
    );
  }

  /// Check if a tap/click local offset falls inside this polygon.
  bool contains(Offset localPoint, Size renderSize) {
    return getPath(renderSize).contains(localPoint);
  }

  /// Extract lot number from name (e.g. "B27 L10" -> "10")
  String get lotNumber {
    final match = RegExp(r'L(\d+)').firstMatch(name);
    return match != null ? match.group(1)! : name;
  }

  /// Extract block number from name (e.g. "B27 L10" -> "27")
  String get blockNumber {
    final match = RegExp(r'B(\d+)').firstMatch(name);
    return match != null ? match.group(1)! : '';
  }

  /// Static helper to hit test a list of annotations against local touch coordinates
  static T? hitTestList<T extends PhaseLotAnnotation>(
    List<T> annotations,
    Offset localPos,
    Size renderSize,
  ) {
    // 1. Fast bounding box check + direct path containment check
    for (final ann in annotations) {
      final path = ann.getPath(renderSize);
      if (path.getBounds().contains(localPos) && path.contains(localPos)) {
        return ann;
      }
    }

    // 2. Inflated bounding rect check (14px touch buffer around exact polygon bounds)
    T? bestCandidate;
    double minCandidateDist = double.infinity;

    for (final ann in annotations) {
      final path = ann.getPath(renderSize);
      final bounds = path.getBounds().inflate(14.0);
      if (bounds.contains(localPos)) {
        final dist = (ann.getCentroid(renderSize) - localPos).distance;
        if (dist < minCandidateDist) {
          minCandidateDist = dist;
          bestCandidate = ann;
        }
      }
    }

    if (bestCandidate != null) {
      return bestCandidate;
    }

    // 3. Proximity check with touch radius (up to 35 points from centroid)
    T? closest;
    double minDistance = 35.0;
    for (final ann in annotations) {
      final centroid = ann.getCentroid(renderSize);
      final dist = (centroid - localPos).distance;
      if (dist < minDistance) {
        minDistance = dist;
        closest = ann;
      }
    }

    return closest;
  }
}

/// Single annotated lot polygon from the COCO dataset for Phase 1.
class Phase1LotAnnotation extends PhaseLotAnnotation {
  static const double baseImageWidth = 7073.0;
  static const double baseImageHeight = 8851.0;

  const Phase1LotAnnotation({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.bbox,
    required super.points,
    super.originalImageWidth = baseImageWidth,
    super.originalImageHeight = baseImageHeight,
  });
}

/// Single annotated lot polygon from the COCO dataset for Phase 2.
class Phase2LotAnnotation extends PhaseLotAnnotation {
  static const double baseImageWidth = 2048.0;
  static const double baseImageHeight = 1448.0;

  const Phase2LotAnnotation({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.bbox,
    required super.points,
    super.originalImageWidth = baseImageWidth,
    super.originalImageHeight = baseImageHeight,
  });
}

/// Single annotated lot polygon from the COCO dataset for Phase 3.
class Phase3LotAnnotation extends PhaseLotAnnotation {
  static const double baseImageWidth = 6869.0;
  static const double baseImageHeight = 5724.0;

  const Phase3LotAnnotation({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.bbox,
    required super.points,
    super.originalImageWidth = baseImageWidth,
    super.originalImageHeight = baseImageHeight,
  });
}

/// Single annotated lot polygon from the COCO dataset for ERHD.
class ErhdLotAnnotation extends PhaseLotAnnotation {
  static const double baseImageWidth = 4961.0;
  static const double baseImageHeight = 3508.0;

  const ErhdLotAnnotation({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.bbox,
    required super.points,
    super.originalImageWidth = baseImageWidth,
    super.originalImageHeight = baseImageHeight,
  });
}

/// Single annotated lot polygon from the COCO dataset for Phase 1 Commercial.
class Phase1CommercialLotAnnotation extends PhaseLotAnnotation {
  static const double baseImageWidth = 4961.0;
  static const double baseImageHeight = 3508.0;

  const Phase1CommercialLotAnnotation({
    required super.id,
    required super.categoryId,
    required super.name,
    required super.bbox,
    required super.points,
    super.originalImageWidth = baseImageWidth,
    super.originalImageHeight = baseImageHeight,
  });
}


