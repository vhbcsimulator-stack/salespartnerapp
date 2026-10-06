import 'dart:ui';
import 'package:intl/intl.dart';
import '../../inventory/models/lot_model.dart';
import '../../inventory/models/mvlc_price_model.dart';
import '../../computation/services/computation_service.dart';
import 'phase2_annotations_data.dart';

enum MapLotStatus {
  available,
  reserved,
  sold,
  hold,
}

/// Static geometry and metadata definitions for parcels on the 540x480 subdivision canvas.
class MapLotDefinition {
  final int block;
  final int lot;
  final Rect bounds;
  final String viewOrientation;
  final String defaultDescription;
  final bool hasStar;

  const MapLotDefinition({
    required this.block,
    required this.lot,
    required this.bounds,
    required this.viewOrientation,
    required this.defaultDescription,
    this.hasStar = false,
  });

  static const List<MapLotDefinition> masterplanLots = [
    // Block 4 (Top East Parcels)
    MapLotDefinition(
      block: 4,
      lot: 1,
      bounds: Rect.fromLTWH(320, 65, 46, 56),
      viewOrientation: 'North-East Ridge Canopy',
      defaultDescription: 'Overlooking the protected Pinecrest green canopy.',
    ),
    MapLotDefinition(
      block: 4,
      lot: 2,
      bounds: Rect.fromLTWH(370, 65, 46, 56),
      viewOrientation: 'North-East Ridge Canopy',
      defaultDescription: 'Direct view of Pinecrest Way cul-de-sac canopy.',
    ),
    MapLotDefinition(
      block: 4,
      lot: 3,
      bounds: Rect.fromLTWH(420, 65, 46, 56),
      viewOrientation: 'East Morning Sunrise',
      defaultDescription: 'High vantage point overlooking Sierra Madre foothills.',
    ),
    MapLotDefinition(
      block: 4,
      lot: 4,
      bounds: Rect.fromLTWH(470, 65, 46, 56),
      viewOrientation: 'Panoramic North-East Skyline',
      defaultDescription: 'Spacious corner parcel with dual road frontage.',
      hasStar: true,
    ),

    // Block 5 (Central Hero Focus Area - Prime Ridge Series)
    MapLotDefinition(
      block: 5,
      lot: 8,
      bounds: Rect.fromLTWH(40, 260, 48, 62),
      viewOrientation: 'South Valley Panorama',
      defaultDescription: 'Fronting Valley View Circle interior loop.',
    ),
    MapLotDefinition(
      block: 5,
      lot: 9,
      bounds: Rect.fromLTWH(92, 260, 48, 62),
      viewOrientation: 'South Valley Panorama',
      defaultDescription: 'Adjacent to sunset green reserve slope.',
    ),
    MapLotDefinition(
      block: 5,
      lot: 10,
      bounds: Rect.fromLTWH(144, 260, 50, 62),
      viewOrientation: 'Ridge Avenue Frontage',
      defaultDescription:
          'Prime regular parcel with 12m frontage along 14m R.O.W.',
    ),
    MapLotDefinition(
      block: 5,
      lot: 11,
      bounds: Rect.fromLTWH(198, 260, 50, 62),
      viewOrientation: 'Ridge Avenue Frontage',
      defaultDescription:
          'Direct access to main Ridge Avenue corridor with cool breezes.',
    ),
    MapLotDefinition(
      block: 5,
      lot: 12,
      bounds: Rect.fromLTWH(252, 256, 56, 70),
      viewOrientation: 'Morning Sun Ridge Facing',
      defaultDescription:
          'Direct mountain breeze corridor with clear view of Club Leisure Lagoon.',
      hasStar: true,
    ),
    MapLotDefinition(
      block: 5,
      lot: 14,
      bounds: Rect.fromLTWH(316, 260, 50, 62),
      viewOrientation: 'East Morning Sunrise',
      defaultDescription:
          'Prime elevation with unobstructed Sierra Madre backdrop.',
    ),
    MapLotDefinition(
      block: 5,
      lot: 15,
      bounds: Rect.fromLTWH(370, 260, 50, 62),
      viewOrientation: 'East Sunrise & Lagoon Corridor',
      defaultDescription:
          'Wide corner lot with generous garden frontage and vista.',
      hasStar: true,
    ),
    MapLotDefinition(
      block: 5,
      lot: 16,
      bounds: Rect.fromLTWH(424, 260, 52, 62),
      viewOrientation: 'Lagoon & Clubhouse Panorama',
      defaultDescription:
          'Designated showcase villa parcel with premium landscaping.',
    ),

    // Block 6 (North Ridge Facing View Lots)
    MapLotDefinition(
      block: 6,
      lot: 1,
      bounds: Rect.fromLTWH(70, 100, 45, 42),
      viewOrientation: 'Pinecrest Park Facing',
      defaultDescription: 'Directly across Pinecrest protected park reserve.',
    ),
    MapLotDefinition(
      block: 6,
      lot: 2,
      bounds: Rect.fromLTWH(120, 100, 45, 42),
      viewOrientation: 'Pinecrest Park Facing',
      defaultDescription: 'Park facing boundary with mature pine canopy view.',
    ),
    MapLotDefinition(
      block: 6,
      lot: 3,
      bounds: Rect.fromLTWH(170, 100, 45, 42),
      viewOrientation: 'Pinecrest Park Facing',
      defaultDescription: 'Close proximity to pedestrian trail entrance.',
    ),
  ];
}

class MapLotModel {
  final String id;
  final int block;
  final int lot;
  final String phase;
  final String cluster;
  final MapLotStatus status;
  final double sizeSqm;
  final double pricePerSqm;
  final double totalPrice;
  final double reservationFee;
  final String lotType;
  final String viewOrientation;
  final String description;
  final String _imageUrl;
  final Rect bounds;
  final bool hasStar;
  final String? badgeText;

  const MapLotModel({
    required this.id,
    required this.block,
    required this.lot,
    this.phase = 'Phase 2',
    this.cluster = 'Phase 2',
    required this.status,
    required this.sizeSqm,
    required this.pricePerSqm,
    required this.totalPrice,
    this.reservationFee = 20000.0,
    required this.lotType,
    required this.viewOrientation,
    required this.description,
    String imageUrl = 'asset/mvlc.jpg',
    required this.bounds,
    this.hasStar = false,
    this.badgeText,
  }) : _imageUrl = imageUrl;

  bool get isErhd {
    final p = phase.toLowerCase();
    final c = cluster.toLowerCase();
    return p.contains('erhd') ||
        p.contains('resort') ||
        p.contains('eastwest') ||
        c.contains('erhd') ||
        c.contains('resort') ||
        c.contains('eastwest');
  }

  bool get isMscc {
    final p = phase.toLowerCase();
    final c = cluster.toLowerCase();
    return p.contains('mscc') ||
        p.contains('mountain') ||
        c.contains('mscc') ||
        c.contains('mountain');
  }

  bool get isMvlc => !isErhd && !isMscc;

  String get imageUrl => isMscc
      ? 'asset/mscc.jpg'
      : (isErhd ? 'asset/erhd.jpeg' : (isMvlc ? 'asset/mvlc.jpg' : _imageUrl));

  String get blockLotText => block > 0 ? 'Block $block • Lot $lot' : 'Lot $lot';
  String get shortLotCode => block > 0 ? 'B$block L$lot' : 'L$lot';

  String get formattedTcp {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(totalPrice.round())}';
  }

  String get formattedPricePerSqm {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(pricePerSqm.round())}';
  }

  String get formattedReservationFee {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(reservationFee.round())}';
  }

  double get downPayment20 => totalPrice * 0.20;
  String get formattedDownPayment20 {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(downPayment20.round())}';
  }

  /// Net 20% downpayment after deducting ₱20,000 reservation fee
  double get netDownPayment20 =>
      (downPayment20 - reservationFee).clamp(0.0, double.infinity);
  String get formattedNetDownPayment20 {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(netDownPayment20.round())}';
  }

  /// 20% DP stretched over 24 months (0% interest) after reservation fee credit
  double get monthly24Mo => netDownPayment20 / 24;
  String get formattedMonthly24Mo {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthly24Mo.round())} / mo';
  }

  double get bankBalance80 => totalPrice * 0.80;
  String get formattedBankBalance80 {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(bankBalance80.round())}';
  }

  /// 80% balance payable over 60 months @ 0% interest (standard 20% Spot DP scheme)
  double get monthly60Mo => bankBalance80 / 60;
  String get formattedMonthly60Mo {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthly60Mo.round())} / mo';
  }

  /// 0% DP scheme: Total TCP minus ₱20,000 reservation fee, over 60 months @ 0%
  double get monthlyZeroDp60Mo =>
      (totalPrice - reservationFee).clamp(0.0, double.infinity) / 60;
  String get formattedMonthlyZeroDp60Mo {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthlyZeroDp60Mo.round())} / mo';
  }

  /// 15 years at 7.5% per annum fixed (MVLC standard bank loan term)
  double get monthlyBankEst15Yr {
    return bankBalance80 * 0.009270125;
  }

  String get formattedMonthlyBankEst15Yr {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthlyBankEst15Yr.round())} / mo';
  }

  /// 10 years at 7.5% per annum fixed
  double get monthlyBankEst10Yr {
    return bankBalance80 * 0.01187018;
  }

  String get formattedMonthlyBankEst10Yr {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthlyBankEst10Yr.round())} / mo';
  }

  /// 5 years at 7.5% per annum fixed
  double get monthlyBankEst5Yr {
    return bankBalance80 * 0.02003795;
  }

  String get formattedMonthlyBankEst5Yr {
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(monthlyBankEst5Yr.round())} / mo';
  }

  /// Constructs a [MapLotModel] by binding live [LotModel] from Supabase to a [MapLotDefinition]
  factory MapLotModel.fromDefinitionAndLiveLot({
    required MapLotDefinition def,
    LotModel? liveLot,
    String currentPhase = 'Phase 2 East',
  }) {
    MapLotStatus mapStatus = MapLotStatus.available;
    double size = 200.0;
    String category = 'Prime View';
    String? badge;
    int phaseNum = 2;
    if (liveLot?.phase != null) {
      phaseNum = liveLot!.phase!;
    } else if (currentPhase.contains('1')) {
      phaseNum = 1;
    } else if (currentPhase.contains('3')) {
      phaseNum = 3;
    }

    if (liveLot != null) {
      final s = liveLot.status.toLowerCase();
      if (s == 'available') {
        mapStatus = MapLotStatus.available;
      } else if (s == 'reserved' || s == 'rsv-p') {
        mapStatus = MapLotStatus.reserved;
        badge = 'RESERVED';
      } else if (s == 'sold') {
        mapStatus = MapLotStatus.sold;
      } else {
        mapStatus = MapLotStatus.hold;
        badge = 'HOLD';
      }

      if (liveLot.sizeSqm > 0) size = liveLot.sizeSqm;
      category = liveLot.categoryDisplay;
    }

    final pricePerSqm = ComputationService.getPricePerSqm(
      projectCode: 'MVLC',
      lotType: category,
      phase: phaseNum,
    );
    final total = size * pricePerSqm;

    if (mapStatus == MapLotStatus.available && def.hasStar) {
      badge = 'ACTIVE';
    }

    return MapLotModel(
      id: 'B${def.block}_L${def.lot}',
      block: def.block,
      lot: def.lot,
      phase: liveLot?.phase != null ? 'Phase ${liveLot!.phase}' : currentPhase,
      cluster: liveLot?.phase != null ? 'Phase ${liveLot!.phase}' : currentPhase,
      status: mapStatus,
      sizeSqm: size,
      pricePerSqm: pricePerSqm,
      totalPrice: total,
      reservationFee: 20000.0,
      lotType: category,
      viewOrientation: def.viewOrientation,
      description: def.defaultDescription,
      bounds: def.bounds,
      hasStar: def.hasStar,
      badgeText: badge,
    );
  }

  /// Builds the complete masterplan lot models populated with live Supabase lots
  static List<MapLotModel> buildFromLiveLots(
    List<LotModel> liveLots, {
    String currentPhase = 'Phase 2',
  }) {
    return MapLotDefinition.masterplanLots.map((def) {
      // Find matching live record from Supabase
      LotModel? match;
      for (final lot in liveLots) {
        final raw = lot.lotNo.toUpperCase().replaceAll(' ', '');
        final target = 'B${def.block}L${def.lot}';
        if (raw == target) {
          match = lot;
          break;
        }
      }

      return MapLotModel.fromDefinitionAndLiveLot(
        def: def,
        liveLot: match,
        currentPhase: currentPhase,
      );
    }).toList();
  }

  /// Construct a [MapLotModel] from a live [LotModel] queried from Supabase `lots` table,
  /// resolving its price per sqm using the phase number and lot type (category)
  /// from [MvlcPriceModel].
  factory MapLotModel.fromLotModelAndAnnotation({
    required LotModel lot,
    MvlcPriceModel? priceModel,
    int? phaseNumber,
    PhaseLotAnnotation? annotation,
  }) {
    final phaseNum = lot.phase ?? phaseNumber ?? 2;
    // Resolve price per sqm based on phase number and lot type directly from mvlc_price table
    final resolvedPricePerSqm = priceModel?.getPriceForCategory(lot.category) ??
        ComputationService.getPricePerSqm(
          projectCode: 'MVLC',
          lotType: lot.category,
          phase: phaseNum,
        );
    final size = lot.sizeSqm > 0 ? lot.sizeSqm : 150.0;
    final total = (size > 0 && resolvedPricePerSqm > 0)
        ? (size * resolvedPricePerSqm)
        : (lot.total > 0 ? lot.total : size * resolvedPricePerSqm);

    MapLotStatus mapStatus = MapLotStatus.available;
    final s = lot.status.toLowerCase();
    String? badge;
    if (s == 'available') {
      mapStatus = MapLotStatus.available;
    } else if (s == 'reserved' || s == 'rsv-p') {
      mapStatus = MapLotStatus.reserved;
      badge = 'RESERVED';
    } else if (s == 'sold') {
      mapStatus = MapLotStatus.sold;
      badge = 'SOLD';
    } else {
      mapStatus = MapLotStatus.hold;
      badge = 'HOLD';
    }

    int blockNum = 0;
    int lotNum = 0;
    if (annotation != null) {
      blockNum = int.tryParse(annotation.blockNumber) ?? 0;
      lotNum = int.tryParse(annotation.lotNumber) ?? 0;
    }
    if (blockNum == 0 || lotNum == 0) {
      final match = RegExp(
        r'B(?:lock)?\s*(\d+)\s*(?:L(?:ot)?)?\s*(\d+)',
        caseSensitive: false,
      ).firstMatch(lot.lotNo);
      if (match != null) {
        blockNum = int.tryParse(match.group(1) ?? '0') ?? 0;
        lotNum = int.tryParse(match.group(2) ?? '0') ?? 0;
      } else if (lotNum == 0) {
        final matchL = RegExp(
          r'L(?:ot)?\s*(\d+)',
          caseSensitive: false,
        ).firstMatch(lot.lotNo);
        if (matchL != null) {
          lotNum = int.tryParse(matchL.group(1) ?? '0') ?? 0;
        }
      }
    }

    final isCommercialLot =
        lot.isCommercial || blockNum == 0 || (annotation?.name.toUpperCase().startsWith('C ') ?? false);

    final bounds = annotation?.bbox ??
        Rect.fromCenter(
          center: const Offset(1024, 724),
          width: 50,
          height: 50,
        );

    final lotCategoryDisplay = lot.categoryDisplay;

    final isErhd = lot.project?.toUpperCase() == 'ERHD' ||
        ((lot.project ?? '').toUpperCase() != 'MVLC' &&
            lot.phase == null &&
            phaseNumber == null);
    final phaseDisplay = isErhd
        ? 'ERHD'
        : isCommercialLot
            ? 'Phase 1 Commercial'
            : 'Phase $phaseNum';

    return MapLotModel(
      id: lot.id > 0 ? 'lot_${lot.id}' : (blockNum > 0 ? 'B${blockNum}_L$lotNum' : 'L$lotNum'),
      block: blockNum,
      lot: lotNum,
      phase: phaseDisplay,
      cluster: phaseDisplay,
      status: mapStatus,
      sizeSqm: size,
      pricePerSqm: resolvedPricePerSqm,
      totalPrice: total,
      reservationFee: 20000.0,
      lotType: lotCategoryDisplay,
      viewOrientation: isErhd
          ? 'ERHD Estate Parcel'
          : isCommercialLot
              ? 'Commercial Boulevard Frontage'
              : 'Phase $phaseNum Parcel',
      description: isErhd
          ? 'ERHD • Block $blockNum Lot $lotNum ($lotCategoryDisplay).'
          : isCommercialLot
              ? 'Phase 1 Commercial • Lot $lotNum ($lotCategoryDisplay).'
              : 'Phase $phaseNum • Block $blockNum Lot $lotNum ($lotCategoryDisplay).',
      bounds: bounds,
      badgeText: badge,
    );
  }
}
