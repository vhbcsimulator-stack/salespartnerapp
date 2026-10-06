import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_image.dart';
import '../../models/map_lot_model.dart';
import '../../models/phase1_annotations_data.dart';
import '../../models/phase2_annotations_data.dart';
import '../../models/phase3_annotations_data.dart';
import '../../models/erhd_annotations_data.dart';
import '../../models/phase1_commercial_annotations_data.dart';

/// Interactive Canvas rendering the Subdivision Masterplan
/// using the official blueprint from Supabase `uploads` table or vector fallback.
class SalesMapCanvas extends StatelessWidget {
  final String? mapImageUrl;
  final int? activePhase;
  final bool isPhase1;
  final bool isPhase2;
  final bool isPhase3;
  final bool isCommercial;
  final bool isErhd;
  final bool isMscc;
  final int? selectedAnnotationId;
  final String? selectedAnnotationName;
  final ValueChanged<PhaseLotAnnotation>? onAnnotationTapped;
  final VoidCallback? onMapTapOutside;
  final Map<String, String>? lotStatuses;
  final List<MapLotModel>? lots;
  final MapLotModel? selectedLot;
  final ValueChanged<MapLotModel>? onLotTapped;
  final TransformationController? transformationController;
  final Size? viewportSize;

  /// Optional dynamically fetched annotations from `annotated_images` table.
  final List<PhaseLotAnnotation>? annotations;

  /// Optional native image dimensions for the active map blueprint.
  final Size? nativeImageSize;

  const SalesMapCanvas({
    super.key,
    this.mapImageUrl,
    this.activePhase,
    this.isPhase1 = false,
    this.isPhase2 = false,
    this.isPhase3 = false,
    this.isCommercial = false,
    this.isErhd = false,
    this.isMscc = false,
    this.selectedAnnotationId,
    this.selectedAnnotationName,
    this.onAnnotationTapped,
    this.onMapTapOutside,
    this.lotStatuses,
    this.lots,
    this.selectedLot,
    this.onLotTapped,
    this.transformationController,
    this.viewportSize,
    this.annotations,
    this.nativeImageSize,
  });

  static const double canvasWidth = 540.0;
  static const double canvasHeight = 480.0;

  /// High-resolution base width for uploaded blueprint phases
  static const double hiResCanvasWidth = 1080.0;

  /// Returns the effective canvas size for the given phase flags.
  /// Phase 1 is portrait (7073×8851). Its canvas adapts to its exact aspect
  /// ratio and is sized larger (1080×1351.5) so that the map has high definition,
  /// perfectly fills the canvas without letterboxing, and aligns 1:1 with annotations.
  static Size effectiveSize({
    int? activePhase,
    bool isPhase1 = false,
    bool isPhase2 = false,
    bool isPhase3 = false,
    bool isCommercial = false,
    bool isErhd = false,
    bool isMscc = false,
    Size? imageSize,
    List<PhaseLotAnnotation>? annotations,
  }) {
    if (imageSize != null && imageSize.width > 0 && imageSize.height > 0) {
      final aspectRatio = imageSize.width / imageSize.height;
      return Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    if (annotations != null && annotations.isNotEmpty) {
      final first = annotations.first;
      if (first.originalImageWidth > 0 && first.originalImageHeight > 0) {
        final aspectRatio =
            first.originalImageWidth / first.originalImageHeight;
        return Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
      }
    }

    final phase1 = isPhase1 || (activePhase == 1 && !isCommercial && !isErhd && !isMscc);
    final phase2 = isPhase2 || (activePhase == 2 && !isCommercial && !isErhd && !isMscc);
    final phase3 = isPhase3 || (activePhase == 3 && !isCommercial && !isErhd && !isMscc);

    if (phase1) {
      // Portrait canvas matching Phase 1 (7073×8851)
      const aspectRatio = Phase1LotAnnotation.baseImageWidth /
          Phase1LotAnnotation.baseImageHeight;
      return const Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    if (isCommercial) {
      const aspectRatio = Phase1CommercialLotAnnotation.baseImageWidth /
          Phase1CommercialLotAnnotation.baseImageHeight;
      return const Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    if (isErhd) {
      const aspectRatio = ErhdLotAnnotation.baseImageWidth /
          ErhdLotAnnotation.baseImageHeight;
      return const Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    if (phase2) {
      const aspectRatio = Phase2LotAnnotation.baseImageWidth /
          Phase2LotAnnotation.baseImageHeight;
      return const Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    if (phase3) {
      const aspectRatio = Phase3LotAnnotation.baseImageWidth /
          Phase3LotAnnotation.baseImageHeight;
      return const Size(hiResCanvasWidth, hiResCanvasWidth / aspectRatio);
    }
    return const Size(canvasWidth, canvasHeight);
  }

  /// The effective canvas size for this widget instance.
  Size get _effectiveSize => effectiveSize(
        activePhase: activePhase,
        isPhase1: isPhase1,
        isPhase2: isPhase2,
        isPhase3: isPhase3,
        isCommercial: isCommercial,
        isErhd: isErhd,
        isMscc: isMscc,
        imageSize: nativeImageSize,
        annotations: annotations,
      );

  List<PhaseLotAnnotation> get _activeAnnotations {
    if (annotations != null) {
      return annotations!;
    }
    if (isCommercial) {
      return Phase1CommercialAnnotationsData.annotations;
    }
    if (isErhd) {
      return ErhdAnnotationsData.annotations;
    }
    if (isMscc) {
      return const [];
    }
    if (activePhase == 3 || isPhase3) {
      return Phase3AnnotationsData.annotations;
    }
    if (activePhase == 2 || isPhase2) {
      return Phase2AnnotationsData.annotations;
    }
    if (isPhase1 || (activePhase == 1 && !isCommercial)) {
      return Phase1AnnotationsData.annotations;
    }
    return const [];
  }

  /// The native pixel dimensions of the blueprint image for the active phase.
  Size get _nativeSize {
    if (nativeImageSize != null &&
        nativeImageSize!.width > 0 &&
        nativeImageSize!.height > 0) {
      return nativeImageSize!;
    }
    if (annotations != null && annotations!.isNotEmpty) {
      final first = annotations!.first;
      if (first.originalImageWidth > 0 && first.originalImageHeight > 0) {
        return Size(first.originalImageWidth, first.originalImageHeight);
      }
    }
    if (isCommercial) {
      return const Size(Phase1CommercialLotAnnotation.baseImageWidth,
          Phase1CommercialLotAnnotation.baseImageHeight);
    }
    if (isErhd) {
      return const Size(ErhdLotAnnotation.baseImageWidth,
          ErhdLotAnnotation.baseImageHeight);
    }
    if (activePhase == 3 || isPhase3) {
      return const Size(Phase3LotAnnotation.baseImageWidth,
          Phase3LotAnnotation.baseImageHeight);
    }
    if (activePhase == 2 || isPhase2) {
      return const Size(Phase2LotAnnotation.baseImageWidth,
          Phase2LotAnnotation.baseImageHeight);
    }
    if (isPhase1 || (activePhase == 1 && !isCommercial)) {
      return const Size(Phase1LotAnnotation.baseImageWidth,
          Phase1LotAnnotation.baseImageHeight);
    }
    return const Size(canvasWidth, canvasHeight);
  }

  @override
  Widget build(BuildContext context) {
    final nativeSize = _nativeSize;
    final size = _effectiveSize;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: nativeSize.width,
          height: nativeSize.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background: real uploaded masterplan blueprint or fallback vector drawing
              Positioned.fill(
                child: mapImageUrl != null && mapImageUrl!.isNotEmpty
                    ? AppImage(
                        imageUrl: mapImageUrl!,
                        fit: BoxFit.fill,
                        disableCache: true,
                        placeholder: (context) => Container(
                          color: AppColors.surfaceContainerLow,
                          child: const Center(
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ),
                        errorWidget: (context, error) => CustomPaint(
                          size: nativeSize,
                          painter: _SubdivisionMapPainter(),
                        ),
                      )
                    : CustomPaint(
                        size: nativeSize,
                        painter: _SubdivisionMapPainter(),
                      ),
              ),

              // Annotations overlay: locks 1:1 on the exact same size as the blueprint image
              if (_activeAnnotations.isNotEmpty)
                Positioned.fill(
                  child: _PhaseInteractiveOverlay(
                    annotations: _activeAnnotations,
                    selectedAnnotationId: selectedAnnotationId,
                    selectedAnnotationName: selectedAnnotationName,
                    onAnnotationTapped: onAnnotationTapped,
                    onMapTapOutside: onMapTapOutside,
                    lotStatuses: lotStatuses,
                    selectedLot: selectedLot,
                    lots: lots,
                    transformationController: transformationController,
                    viewportSize: viewportSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Interactive touch overlay for lot annotations.
/// Uses LayoutBuilder to guarantee touch hit-testing matches the exact visual rendering size.
class _PhaseInteractiveOverlay extends StatefulWidget {
  final List<PhaseLotAnnotation> annotations;
  final int? selectedAnnotationId;
  final String? selectedAnnotationName;
  final ValueChanged<PhaseLotAnnotation>? onAnnotationTapped;
  final VoidCallback? onMapTapOutside;
  final Map<String, String>? lotStatuses;
  final MapLotModel? selectedLot;
  final List<MapLotModel>? lots;
  final TransformationController? transformationController;
  final Size? viewportSize;

  const _PhaseInteractiveOverlay({
    required this.annotations,
    this.selectedAnnotationId,
    required this.selectedAnnotationName,
    required this.onAnnotationTapped,
    this.onMapTapOutside,
    this.lotStatuses,
    this.selectedLot,
    this.lots,
    this.transformationController,
    this.viewportSize,
  });

  @override
  State<_PhaseInteractiveOverlay> createState() =>
      _PhaseInteractiveOverlayState();
}

class _PhaseInteractiveOverlayState extends State<_PhaseInteractiveOverlay> {
  final Map<int, Offset> _pointerPositions = <int, Offset>{};
  bool _isMultiTouch = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final currentSize = Size(constraints.maxWidth, constraints.maxHeight);

        return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            _pointerPositions[event.pointer] = event.localPosition;
            if (_pointerPositions.length > 1) {
              _isMultiTouch = true;
            }
          },
          onPointerCancel: (event) {
            _pointerPositions.remove(event.pointer);
            if (_pointerPositions.isEmpty) {
              _isMultiTouch = false;
            }
          },
          onPointerUp: (event) {
            final downPos = _pointerPositions.remove(event.pointer);
            final wasMultiTouch = _isMultiTouch;
            if (_pointerPositions.isEmpty) {
              _isMultiTouch = false;
            }

            // Only trigger lot selection/unselection if it was a single-touch tap (not during a pinch or pan)
            if (!wasMultiTouch && downPos != null) {
              final dist = (event.localPosition - downPos).distance;
              if (dist < 15.0) {
                final hit = PhaseLotAnnotation.hitTestList(
                  widget.annotations,
                  event.localPosition,
                  currentSize,
                );
                if (hit != null) {
                  widget.onAnnotationTapped?.call(hit);
                } else {
                  widget.onMapTapOutside?.call();
                }
              }
            }
          },
          child: widget.transformationController != null
              ? ListenableBuilder(
                  listenable: widget.transformationController!,
                  builder: (context, _) {
                    final scale = widget.transformationController!.value
                        .getMaxScaleOnAxis();
                    return CustomPaint(
                      size: currentSize,
                      painter: _PhaseAnnotationsPainter(
                        annotations: widget.annotations,
                        selectedAnnotationId: widget.selectedAnnotationId,
                        selectedAnnotationName: widget.selectedAnnotationName,
                        lotStatuses: widget.lotStatuses,
                        selectedLot: widget.selectedLot,
                        lots: widget.lots,
                        currentScale: scale,
                        viewportSize: widget.viewportSize,
                      ),
                    );
                  },
                )
              : CustomPaint(
                  size: currentSize,
                  painter: _PhaseAnnotationsPainter(
                    annotations: widget.annotations,
                    selectedAnnotationId: widget.selectedAnnotationId,
                    selectedAnnotationName: widget.selectedAnnotationName,
                    lotStatuses: widget.lotStatuses,
                    selectedLot: widget.selectedLot,
                    lots: widget.lots,
                    currentScale: 1.0,
                    viewportSize: widget.viewportSize,
                  ),
                ),
        );
      },
    );
  }
}

/// CustomPainter rendering lot segmentation polygons from Roboflow COCO dataset
class _PhaseAnnotationsPainter extends CustomPainter {
  final List<PhaseLotAnnotation> annotations;
  final int? selectedAnnotationId;
  final String? selectedAnnotationName;
  final Map<String, String>? lotStatuses;
  final MapLotModel? selectedLot;
  final List<MapLotModel>? lots;
  final double currentScale;
  final Size? viewportSize;

  _PhaseAnnotationsPainter({
    required this.annotations,
    this.selectedAnnotationId,
    this.selectedAnnotationName,
    this.lotStatuses,
    this.selectedLot,
    this.lots,
    this.currentScale = 1.0,
    this.viewportSize,
  });

  String? _resolveLotSize(String annotationName) {
    if (selectedLot != null && selectedLot!.sizeSqm > 0) {
      final normAnn = annotationName.replaceAll(' ', '').toUpperCase();
      final normSel =
          selectedLot!.shortLotCode.replaceAll(' ', '').toUpperCase();
      if (normAnn == normSel ||
          normAnn.contains(normSel) ||
          normSel.contains(normAnn) ||
          normAnn.replaceAll('C', '') == normSel) {
        return selectedLot!.sizeSqm % 1 == 0
            ? '${selectedLot!.sizeSqm.toInt()} sqm'
            : '${selectedLot!.sizeSqm.toStringAsFixed(1)} sqm';
      }
      return selectedLot!.sizeSqm % 1 == 0
          ? '${selectedLot!.sizeSqm.toInt()} sqm'
          : '${selectedLot!.sizeSqm.toStringAsFixed(1)} sqm';
    }

    if (lots != null && lots!.isNotEmpty) {
      final normAnn = annotationName.replaceAll(' ', '').toUpperCase();
      for (final l in lots!) {
        final normL = l.shortLotCode.replaceAll(' ', '').toUpperCase();
        if ((normAnn == normL || normAnn.replaceAll('C', '') == normL) &&
            l.sizeSqm > 0) {
          return l.sizeSqm % 1 == 0
              ? '${l.sizeSqm.toInt()} sqm'
              : '${l.sizeSqm.toStringAsFixed(1)} sqm';
        }
      }
    }
    return null;
  }

  @override
  bool hitTest(Offset position) => false;

  @override
  void paint(Canvas canvas, Size size) {
    // No overlay drawings on unselected lots so the map looks completely normal and clean.
    final hasSelection = (selectedAnnotationId != null) ||
        (selectedAnnotationName != null && selectedAnnotationName!.isNotEmpty);
    if (!hasSelection) {
      return;
    }

    final selectedAnnotation = annotations
        .where((ann) =>
            (selectedAnnotationId != null && ann.id == selectedAnnotationId) ||
            ann.name == selectedAnnotationName)
        .firstOrNull;

    // Draw only the selected polygon with vibrant highlight and floating name badge
    if (selectedAnnotation != null) {
      final path = selectedAnnotation.getPath(size);

      // `size` is the canvas's native (unscaled) pixel size, e.g. 7073x8851
      // for Phase 1. InteractiveViewer defaults to `constrained: true`,
      // which forces SalesMapCanvas down to the actual on-screen viewport
      // size rather than its nominal `effectiveSize`/hiResCanvasWidth, so
      // the real content-fit scale-down is BoxFit.contain against
      // `viewportSize`: min(viewportSize.width / size.width,
      // viewportSize.height / size.height). `baseScale` is the reciprocal
      // of that. Combined with dividing by `currentScale` (the
      // InteractiveViewer zoom) below, this keeps the selected-lot label a
      // constant on-screen pixel size no matter how far the map is zoomed
      // or how the surrounding layout is resized — only its position (via
      // `centroid`/`anchor`) moves with the lot. Falls back to the old
      // hiResCanvasWidth-based estimate if the viewport size isn't known yet.
      final vp = viewportSize;
      final baseScale = (vp != null && vp.width > 0 && vp.height > 0)
          ? math.max(size.width / vp.width, size.height / vp.height)
          : size.width / SalesMapCanvas.hiResCanvasWidth;
      final effectiveScale = currentScale > 0 ? currentScale : 1.0;

      // Highlight Fill
      final selFill = Paint()
        ..color = const Color(0x9000E676)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, selFill);

      // Outer glow - adapt stroke width to zoom level so it stays crisp
      final glowPaint = Paint()
        ..color = const Color(0xCC00E676)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (4.5 * baseScale / effectiveScale).clamp(1.0 * baseScale, 4.5 * baseScale)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3.5 * baseScale);
      canvas.drawPath(path, glowPaint);

      // Crisp inner border - adapt stroke width to zoom level
      final selStroke = Paint()
        ..color = const Color(0xFF003822)
        ..style = PaintingStyle.stroke
        ..strokeWidth = (2.5 * baseScale / effectiveScale).clamp(0.8 * baseScale, 2.5 * baseScale);
      canvas.drawPath(path, selStroke);

      final centroid = selectedAnnotation.getCentroid(size);
      _drawCentroidLabel(canvas, selectedAnnotation.lotNumber, centroid, true, baseScale);

      // Floating Name & Size Badge: prominently displays the exact name and lot size of the clicked area
      final lotSize = _resolveLotSize(selectedAnnotation.name);
      _drawFloatingBadge(
        canvas,
        selectedAnnotation.name,
        lotSize,
        centroid,
        size,
        baseScale,
      );
    }
  }

  void _drawCentroidLabel(
    Canvas canvas,
    String lotNum,
    Offset center,
    bool isSelected,
    double baseScale,
  ) {
    if (!isSelected) return;

    final s = baseScale / (currentScale > 0 ? currentScale : 1.0);
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(s, s);

    final textPainter = TextPainter(
      text: TextSpan(
        text: lotNum,
        style: const TextStyle(
          fontFamily: 'Plus Jakarta Sans',
          fontSize: 12.0,
          fontWeight: FontWeight.w900,
          color: Color(0xFF003822),
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final pillRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset.zero,
        width: textPainter.width + 10.0,
        height: textPainter.height + 6.0,
      ),
      const Radius.circular(4),
    );
    final bgPaint = Paint()
      ..color = const Color(0xFF00E676)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(pillRect, bgPaint);

    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ),
    );

    canvas.restore();
  }

  void _drawFloatingBadge(
    Canvas canvas,
    String name,
    String? lotSize,
    Offset anchor,
    Size size,
    double baseScale,
  ) {
    final s = baseScale / (currentScale > 0 ? currentScale : 1.0);
    canvas.save();
    canvas.translate(anchor.dx, anchor.dy);
    canvas.scale(s, s);

    final textSpan = TextSpan(
      children: [
        TextSpan(
          text: name,
          style: const TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: 0.5,
            shadows: [
              Shadow(color: Colors.black54, blurRadius: 2, offset: Offset(0, 1)),
            ],
          ),
        ),
        if (lotSize != null && lotSize.isNotEmpty) ...[
          const TextSpan(
            text: '  •  ',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF00E676),
            ),
          ),
          TextSpan(
            text: lotSize,
            style: const TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Color(0xFF00E676),
              letterSpacing: 0.3,
            ),
          ),
        ],
      ],
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    )..layout();

    const dotRadius = 4.0;
    const dotGap = 6.0;
    const paddingH = 12.0;
    const paddingV = 6.0;

    final badgeWidth =
        textPainter.width + paddingH * 2 + dotRadius * 2 + dotGap;
    final badgeHeight = textPainter.height + paddingV * 2;

    // In local units (screen pixels), anchor is at local (0, 0).
    // Canvas bounds in local units:
    final scale = (currentScale > 0 ? currentScale : 1.0) / baseScale;
    final canvasMinX = -anchor.dx * scale;
    final canvasMaxX = (size.width - anchor.dx) * scale;
    final canvasMinY = -anchor.dy * scale;

    // Determine vertical placement: above anchor unless too close to canvas top
    final placeAbove = (-18.0 - badgeHeight) >= (canvasMinY + 8.0);
    final badgeTop = placeAbove ? (-18.0 - badgeHeight) : 18.0;

    // Clamp horizontal placement so it never bleeds off canvas edges
    final rawBadgeLeft = -badgeWidth / 2;
    final minLeft = canvasMinX + 8.0;
    final maxLeft = canvasMaxX - badgeWidth - 8.0;
    final badgeLeft = minLeft < maxLeft
        ? rawBadgeLeft.clamp(minLeft, maxLeft)
        : rawBadgeLeft;

    final badgeRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(badgeLeft, badgeTop, badgeWidth, badgeHeight),
      const Radius.circular(8),
    );

    // Drop shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawRRect(badgeRect.shift(const Offset(0, 3)), shadowPaint);

    // Background: High-contrast Dark Emerald
    final bgPaint = Paint()
      ..color = const Color(0xFF07271A)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(badgeRect, bgPaint);

    // Vibrant Neon Emerald Border
    final borderPaint = Paint()
      ..color = const Color(0xFF00E676)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(badgeRect, borderPaint);

    // Pointer arrow
    final arrowPath = Path();
    final arrowX = 0.0.clamp(badgeLeft + 10.0, badgeLeft + badgeWidth - 10.0);

    if (placeAbove) {
      arrowPath.moveTo(arrowX - 6, badgeTop + badgeHeight);
      arrowPath.lineTo(arrowX, -10.0);
      arrowPath.lineTo(arrowX + 6, badgeTop + badgeHeight);
    } else {
      arrowPath.moveTo(arrowX - 6, badgeTop);
      arrowPath.lineTo(arrowX, 10.0);
      arrowPath.lineTo(arrowX + 6, badgeTop);
    }
    arrowPath.close();

    canvas.drawPath(arrowPath, bgPaint);
    canvas.drawPath(arrowPath, borderPaint);

    // Active Green Beacon Dot
    final dotCenter = Offset(
      badgeLeft + paddingH + dotRadius,
      badgeTop + badgeHeight / 2,
    );
    final beaconPaint = Paint()
      ..color = const Color(0xFF00E676)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(dotCenter, dotRadius, beaconPaint);

    // Paint Annotation Name Text inside Badge
    textPainter.paint(
      canvas,
      Offset(
        badgeLeft + paddingH + dotRadius * 2 + dotGap,
        badgeTop + paddingV,
      ),
    );

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _PhaseAnnotationsPainter oldDelegate) {
    return oldDelegate.selectedAnnotationName != selectedAnnotationName ||
        oldDelegate.selectedLot != selectedLot ||
        oldDelegate.lots != lots ||
        oldDelegate.currentScale != currentScale ||
        oldDelegate.viewportSize != viewportSize ||
        oldDelegate.annotations != annotations;
  }
}

/// CustomPainter rendering the map canvas topography, roads, and masterplan elements
class _SubdivisionMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 1. Background Fill
    final bgPaint = Paint()..color = AppColors.surfaceContainerLow;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // 2. Micro Dot Grid Pattern
    final dotPaint = Paint()
      ..color = AppColors.outlineVariant.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    for (double x = 8; x < size.width; x += 16) {
      for (double y = 8; y < size.height; y += 16) {
        canvas.drawCircle(Offset(x, y), 0.8, dotPaint);
      }
    }

    // 3. Pinecrest Eco-Park Buffer (Top-Left Reserve)
    final parkPath = Path()
      ..moveTo(0, 0)
      ..lineTo(210, 0)
      ..cubicTo(200, 60, 160, 110, 80, 120)
      ..lineTo(0, 130)
      ..close();

    final parkPaint = Paint()
      ..color = AppColors.primaryFixed.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;
    canvas.drawPath(parkPath, parkPaint);

    // Subtle park hatch lines
    final hatchPaint = Paint()
      ..color = AppColors.primaryFixedDim.withValues(alpha: 0.3)
      ..strokeWidth = 1.2;
    canvas.save();
    canvas.clipPath(parkPath);
    for (double i = -50; i < 250; i += 12) {
      canvas.drawLine(Offset(i, 0), Offset(i + 130, 130), hatchPaint);
    }
    canvas.restore();

    // Park labels
    _drawText(
      canvas: canvas,
      text: 'PINECREST ECO-PARK',
      offset: const Offset(35, 45),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.2,
        color: Color(0xFF224F3E),
      ),
    );
    _drawText(
      canvas: canvas,
      text: 'PROTECTED GREEN CANOPY',
      offset: const Offset(35, 60),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 8.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: Color(0xFF224F3E),
      ),
    );

    // 4. Sunset Ridge Bluff (Bottom-Right Buffer)
    final bluffPath = Path()
      ..moveTo(320, 480)
      ..cubicTo(370, 410, 440, 430, 540, 380)
      ..lineTo(540, 480)
      ..close();

    final bluffPaint = Paint()
      ..color = AppColors.primaryFixed.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;
    canvas.drawPath(bluffPath, bluffPaint);

    _drawText(
      canvas: canvas,
      text: 'SUNSET RIDGE BLUFF',
      offset: const Offset(400, 448),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 9,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: Color(0xFF224F3E),
      ),
    );

    // 5. Road Network

    // Pinecrest Way (Vertical cul-de-sac)
    final roadCasingPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.square;
    canvas.drawLine(
      const Offset(270, 200),
      const Offset(270, 60),
      roadCasingPaint,
    );
    // Cul-de-sac roundabout circle
    canvas.drawCircle(const Offset(270, 55), 28, roadCasingPaint);

    // Valley View Circle (South Loop Road)
    final loopPath = Path()
      ..moveTo(130, 200)
      ..lineTo(130, 370)
      ..cubicTo(130, 420, 230, 420, 230, 370)
      ..lineTo(230, 200);
    final loopPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 24
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(loopPath, loopPaint);

    // Ridge Avenue (Main Arterial)
    final ridgeOuterPaint = Paint()
      ..color = AppColors.surfaceContainerHighest
      ..strokeWidth = 36
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      const Offset(20, 200),
      const Offset(520, 200),
      ridgeOuterPaint,
    );

    final ridgeInnerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 32
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      const Offset(20, 200),
      const Offset(520, 200),
      ridgeInnerPaint,
    );

    // Dashed road center line
    final dashPaint = Paint()
      ..color = AppColors.outlineVariant
      ..strokeWidth = 1.5;
    for (double x = 30; x < 510; x += 16) {
      canvas.drawLine(Offset(x, 200), Offset(x + 8, 200), dashPaint);
    }

    // Road Labels
    _drawText(
      canvas: canvas,
      text: 'RIDGE AVENUE (14M R.O.W.)',
      offset: const Offset(200, 194),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 9.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.0,
        color: AppColors.outline,
      ),
    );

    // Pinecrest Way Label (Rotated -90 deg)
    canvas.save();
    canvas.translate(274, 150);
    canvas.rotate(-math.pi / 2);
    _drawText(
      canvas: canvas,
      text: 'PINECREST WAY',
      offset: Offset.zero,
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 8.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: AppColors.outline,
      ),
    );
    canvas.restore();

    _drawText(
      canvas: canvas,
      text: 'VALLEY VIEW CIRCLE',
      offset: const Offset(136, 335),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 8,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: AppColors.outline,
      ),
    );

    // 6. Block Titles
    _drawText(
      canvas: canvas,
      text: 'BLOCK 4',
      offset: const Offset(365, 48),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
        color: AppColors.outline,
      ),
    );

    _drawText(
      canvas: canvas,
      text: 'BLOCK 5 (PRIME RIDGE SERIES)',
      offset: const Offset(200, 240),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.8,
        color: AppColors.outline,
      ),
    );

    _drawText(
      canvas: canvas,
      text: 'BLOCK 6',
      offset: const Offset(70, 148),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: AppColors.outline,
      ),
    );

    // 7. Masterplan Compass Rose (Top Right)
    const compassCenter = Offset(485, 42);
    final compassBg = Paint()..color = Colors.white;
    final compassBorder = Paint()
      ..color = AppColors.outlineVariant
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(compassCenter, 15, compassBg);
    canvas.drawCircle(compassCenter, 15, compassBorder);

    // North Needle (Red)
    final northPath = Path()
      ..moveTo(compassCenter.dx, compassCenter.dy - 11)
      ..lineTo(compassCenter.dx + 4, compassCenter.dy - 2)
      ..lineTo(compassCenter.dx - 4, compassCenter.dy - 2)
      ..close();
    canvas.drawPath(northPath, Paint()..color = AppColors.error);

    // South Needle (Grey)
    final southPath = Path()
      ..moveTo(compassCenter.dx, compassCenter.dy + 11)
      ..lineTo(compassCenter.dx + 4, compassCenter.dy + 2)
      ..lineTo(compassCenter.dx - 4, compassCenter.dy + 2)
      ..close();
    canvas.drawPath(southPath, Paint()..color = AppColors.outline);

    // North Indicator 'N'
    _drawText(
      canvas: canvas,
      text: 'N',
      offset: Offset(compassCenter.dx - 3.5, compassCenter.dy - 24),
      style: const TextStyle(
        fontFamily: 'Plus Jakarta Sans',
        fontSize: 8,
        fontWeight: FontWeight.w800,
        color: AppColors.onSurface,
      ),
    );
  }

  void _drawText({
    required Canvas canvas,
    required String text,
    required Offset offset,
    required TextStyle style,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
