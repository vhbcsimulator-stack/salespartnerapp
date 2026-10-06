import 'package:intl/intl.dart';

/// Strongly-typed model representing a real estate lot record from Supabase `lots` table.
class LotModel {
  final int id;
  final String lotNo;
  final double sizeSqm;
  final double pricePerSqm;
  final double total;
  final String category;
  final int? phase;
  final String status;
  final DateTime? lastUpdated;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;
  final String? project;
  final String? mapSection;
  final String? floorLevel;
  final String? unitType;

  const LotModel({
    required this.id,
    required this.lotNo,
    required this.sizeSqm,
    required this.pricePerSqm,
    required this.total,
    required this.category,
    this.phase,
    required this.status,
    this.lastUpdated,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.project,
    this.mapSection,
    this.floorLevel,
    this.unitType,
  });

  factory LotModel.fromJson(Map<String, dynamic> json) {
    return LotModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      lotNo: json['lot_no'] as String? ?? 'Lot',
      sizeSqm: (json['size_sqm'] as num?)?.toDouble() ?? 0.0,
      pricePerSqm: (json['price_per_sqm'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] as String? ?? 'regular',
      phase: json['phase'] is int
          ? json['phase'] as int
          : int.tryParse(json['phase']?.toString() ?? ''),
      status: (json['status'] as String? ?? 'available').toLowerCase(),
      lastUpdated: json['last_updated'] != null
          ? DateTime.tryParse(json['last_updated'].toString())
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
      userId: json['user_id'] as String?,
      project: json['project'] as String? ?? 'MVLC',
      mapSection: json['map_section']?.toString() ?? json['mapSection']?.toString(),
      floorLevel: json['floor_level']?.toString(),
      unitType: json['unit_type']?.toString(),
    );
  }

  LotModel copyWith({
    int? id,
    String? lotNo,
    double? sizeSqm,
    double? pricePerSqm,
    double? total,
    String? category,
    int? phase,
    String? status,
    DateTime? lastUpdated,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
    String? project,
    String? mapSection,
    String? floorLevel,
    String? unitType,
  }) {
    return LotModel(
      id: id ?? this.id,
      lotNo: lotNo ?? this.lotNo,
      sizeSqm: sizeSqm ?? this.sizeSqm,
      pricePerSqm: pricePerSqm ?? this.pricePerSqm,
      total: total ?? this.total,
      category: category ?? this.category,
      phase: phase ?? this.phase,
      status: status ?? this.status,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      project: project ?? this.project,
      mapSection: mapSection ?? this.mapSection,
      floorLevel: floorLevel ?? this.floorLevel,
      unitType: unitType ?? this.unitType,
    );
  }

  static final _currencyFormatter = NumberFormat.currency(
    symbol: '₱',
    decimalDigits: 0,
    locale: 'en_PH',
  );

  /// Converts shorthand "B6 L17" -> "Block 6 • Lot 17", "L1" -> "Commercial • Lot 1", or for MSCC "201" -> "Unit 201"
  String get formattedLotNo {
    if (isMscc) {
      final clean = lotNo.trim();
      if (clean.toLowerCase().startsWith('unit')) {
        return clean;
      }
      return 'Unit $clean';
    }
    final regex = RegExp(r'^B(\d+)\s*L(\d+)$', caseSensitive: false);
    final match = regex.firstMatch(lotNo.trim());
    if (match != null) {
      final block = match.group(1);
      final lot = match.group(2);
      return 'Block $block • Lot $lot';
    }
    final commMatch = RegExp(r'^L\s*(\d+)$', caseSensitive: false).firstMatch(lotNo.trim());
    if (commMatch != null) {
      return 'Commercial • Lot ${commMatch.group(1)}';
    }
    return lotNo;
  }

  String get formattedPricePerSqm => _currencyFormatter.format(pricePerSqm);

  String get formattedTotal => _currencyFormatter.format(total);

  String get formattedSize => '${sizeSqm.toStringAsFixed(0)} sqm';

  String get categoryDisplay {
    if (isMscc) {
      if (unitType != null && unitType!.trim().isNotEmpty) {
        final ut = unitType!.trim();
        return ut.toLowerCase().endsWith('unit') ? ut : '$ut Unit';
      }
      final norm = category.toLowerCase().trim().replaceAll(' ', '_').replaceAll('-', '_');
      if (norm.contains('2_bedroom_deluxe') || norm.contains('deluxe')) {
        return '2 Bedroom Deluxe Unit';
      } else if (norm.contains('2_bedroom') || norm.contains('2br')) {
        return '2 Bedroom Unit';
      } else if (norm.contains('1_bedroom') || norm.contains('1br')) {
        return '1 Bedroom Unit';
      } else if (norm.contains('studio')) {
        return 'Studio Unit';
      }
      return 'Condo Unit';
    }
    final norm = category.toLowerCase().trim().replaceAll(' ', '_').replaceAll('-', '_');
    switch (norm) {
      case 'commercial':
        return 'Commercial Lot';
      case 'commercial_corner':
        return 'Commercial Corner Lot';
      case 'prime':
        return 'Prime Residential Lot';
      case 'prime_corner':
        return 'Prime Corner Lot';
      case 'prime_commercial':
        return 'Prime Commercial Lot';
      case 'prime_commercial_corner':
        return 'Prime Commercial Corner Lot';
      case 'corner':
      case 'regular_corner':
        return 'Regular Corner Lot';
      case 'regular':
      default:
        return 'Regular Lot';
    }
  }


  /// Extracts commercial lot identifier from annotation name or search string
  /// (e.g. "C L1" -> "L1", "C L10" -> "L10", "CL1" -> "L1", "C 1" -> "L1", "Commercial Lot 1" -> "L1").
  static String? extractCommercialLotNo(String input) {
    final clean = input.trim();
    final match = RegExp(
      r'^(?:C(?:ommercial)?)[-_\s]*L?(?:ot)?\s*(\d+)$',
      caseSensitive: false,
    ).firstMatch(clean);
    if (match != null) {
      return 'L${match.group(1)}';
    }
    final directLMatch = RegExp(r'^L\s*(\d+)$', caseSensitive: false).firstMatch(clean);
    if (directLMatch != null) {
      return 'L${directLMatch.group(1)}';
    }
    return null;
  }

  /// Normalize lot annotation string (e.g. "B24 10" -> "B24 L10", "b27 l1" -> "B27 L1", "B6 L 10" -> "B6 L10", "B6 L4-1" -> "B6 L4-1")
  static String normalizeLotNo(String input) {
    final clean = input.trim();
    final comm = extractCommercialLotNo(clean);
    if (comm != null) {
      return comm;
    }
    final bMatch = RegExp(
      r'B(?:lock)?\s*(\d+)\s*(?:L(?:ot)?\s*|(?=\d))(\d+(?:-[0-9a-zA-Z]+)?)',
      caseSensitive: false,
    ).firstMatch(clean);
    if (bMatch != null) {
      return 'B${bMatch.group(1)} L${bMatch.group(2)}';
    }
    return clean;
  }

  bool get isCorner =>
      category.toLowerCase().contains('corner') ||
      category.toLowerCase().contains('prime');

  bool get isCommercial =>
      category.toLowerCase().contains('commercial') ||
      lotNo.trim().toUpperCase().startsWith('C L') ||
      lotNo.trim().toUpperCase().startsWith('C ');

  bool get isAvailable => status == 'available';

  bool get isReserved => status == 'reserved' || status == 'rsv-p';

  bool get isHold => status == 'hold';

  bool get isSold => status == 'sold';

  String get statusBadgeText {
    if (isAvailable) return 'AVAILABLE';
    if (isHold) return 'HOLD';
    if (isReserved) return 'RESERVED';
    if (isSold) return 'SOLD OUT';
    return status.toUpperCase();
  }

  String get phaseLocationText {
    if (isMscc) {
      final fl = (floorLevel != null && floorLevel!.trim().isNotEmpty)
          ? floorLevel!.trim()
          : (phase != null ? 'Floor $phase' : 'MSCC Condo');
      return '$fl • $categoryDisplay';
    }
    final p = phase != null ? 'Phase $phase' : 'Lot Inventory';
    return '$p • $categoryDisplay';
  }

  String get reservationFeeText {
    if (isMscc) {
      return '₱25,000 Reservation Fee';
    }
    return '₱20,000 Reservation Fee';
  }

  bool get isMscc {
    final p = (project ?? '').trim().toUpperCase();
    return p.contains('MSCC') ||
        p.contains('MOUNTAIN SUITES') ||
        floorLevel != null ||
        unitType != null;
  }

  bool get isErhd {
    if (isMscc) return false;
    final p = (project ?? '').trim().toUpperCase();
    return p.contains('ERHD') ||
        p.contains('EAST RIDGE') ||
        p.contains('RESORT') ||
        p.contains('EASTWEST');
  }

  bool get isMvlc {
    if (isErhd || isMscc) return false;
    final p = (project ?? '').trim().toUpperCase();
    if (p.contains('EBLF') ||
        p.contains('GLS') ||
        p.contains('LCN') ||
        p.contains('MCVC') ||
        p.contains('RHM') ||
        p.contains('RHN')) {
      return false;
    }
    return true;
  }

  /// Photographic assets: returns local asset for MSCC, ERHD, and MVLC lots
  String get imageUrl {
    if (isMscc) {
      return 'asset/mscc.jpg';
    }
    if (isErhd) {
      return 'asset/erhd.jpeg';
    }
    if (isMvlc) {
      return 'asset/mvlc.jpg';
    }
    if (isCommercial) {
      return 'https://lh3.googleusercontent.com/aida-public/AB6AXuAszfUIOx_IICHi6Xa_vCos4RYlDEXxB4Oxti49OR7zZKbRmmiLSkuzKutxapktoR5Gryhz5QOQmnIVkb49Ufej8YwrHwXRlWRRrIWieFvIdxrHFVhj1xPQ7vJej_pu6RTvESpkAW7E2zgG6fAGnX-oOxzuov2DyDZGFX0uRr1UZyAnkXgvQhu9wloXdzWto1zrwqpmZDjGB5jdwM3DUe2nM4rR52FVeO60is3yxsss3xJHbZCUz5A9eQ';
    }

    if (phase == 1) {
      return 'https://lh3.googleusercontent.com/aida-public/AB6AXuCk6uWr9vgrBChlR-F1rLJO4OjuNZH2iVniCskLCceD8yQAuXpR73U1B8ezNQa5GTSkxE2qSLK6CawWKF3kWVImAaJOWGCMMHn-M13jbUjs3--6VeW9kDRq11fPrBCHsq6TNugMGGBiZtrzBGJGLEuY3QOlSUez3KnhD8L8hHGJpChbQGnYqbboO5nbd7a280_kDirBFqV0mbLUaZBWeG7Ft2QXy3OxqPjWnij6WYRzo6yvOn5WREi1QQ';
    }
    if (phase == 3) {
      return 'https://lh3.googleusercontent.com/aida-public/AB6AXuBuunvHKAOfmtjWtw0snn_aGQcZ7bsF_x7yygvHzuD75WjzuLVQ0dlbu2CTf9ntzrRzxXeOnDUlUWObujI29LIn_cesC-7Uguqs1TzngxbOTu_nSTjausTSmceAFU6rleTgtdV6LBEe4VVEypAEYgaUAUO3O7Jh0lq46tP922jQnyQH8MKDYUz5789oXJBPEDIuYaixtCprBHZ1laYQvxIpHCtJjtLHWGOP0cdZ66GUl7a9RLZ2703EiA';
    }
    return 'https://lh3.googleusercontent.com/aida-public/AB6AXuC19McYx0GiYWejfaIJDifczC3qVyKUOWVc7dNm1XRe1RQaZcP1vOYQB6BO19yJLXfwSnO77M4bEP-Hs_PlzYvoe9AA2is5sUEnQT_QDyefN2ITAG-xA-RUNawjUI4iudfAinPBBAWGdfPTevamr5E0EgOoOqDvwa5wqa6E932m_sU_nycOtkHWVp17qqLCamRqRepFA05nVypamxZhEZQTECgi1-2eRGNz3o2FAiOZE3MWFK4FSLzWgA';
  }
}
