/// Model representing a phase pricing record from Supabase `mvlc_price` table.
class MvlcPriceModel {
  final int id;
  final int phase;
  final double? regular;
  final double? regularCorner;
  final double? prime;
  final double? primeCorner;
  final double? commercial;
  final double? commercialCorner;
  final double? primeCommercial;
  final double? primeCommercialCorner;

  const MvlcPriceModel({
    required this.id,
    required this.phase,
    this.regular,
    this.regularCorner,
    this.prime,
    this.primeCorner,
    this.commercial,
    this.commercialCorner,
    this.primeCommercial,
    this.primeCommercialCorner,
  });

  factory MvlcPriceModel.fromJson(Map<String, dynamic> json) {
    return MvlcPriceModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      phase: json['phase'] is int
          ? json['phase'] as int
          : int.tryParse(json['phase']?.toString() ?? '0') ?? 0,
      regular: (json['regular'] as num?)?.toDouble(),
      regularCorner: (json['regular_corner'] as num?)?.toDouble(),
      prime: (json['prime'] as num?)?.toDouble(),
      primeCorner: (json['prime_corner'] as num?)?.toDouble(),
      commercial: (json['commercial'] as num?)?.toDouble(),
      commercialCorner: (json['commercial_corner'] as num?)?.toDouble(),
      primeCommercial: (json['prime_commercial'] as num?)?.toDouble(),
      primeCommercialCorner:
          (json['prime_commercial_corner'] as num?)?.toDouble(),
    );
  }

  /// Resolve price per sqm for a given lot category.
  double? getPriceForCategory(String category) {
    final norm = category
        .trim()
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('-', '_');

    if (norm.contains('commercial')) {
      if (norm.contains('prime') && norm.contains('corner')) {
        return primeCommercialCorner ?? commercialCorner ?? commercial ?? regularCorner ?? regular;
      }
      if (norm.contains('prime')) {
        return primeCommercial ?? commercial ?? regular;
      }
      if (norm.contains('corner')) {
        return commercialCorner ?? commercial ?? regularCorner ?? regular;
      }
      return commercial ?? regular;
    }

    if (norm.contains('prime')) {
      if (norm.contains('corner')) {
        return primeCorner ?? prime ?? regularCorner ?? regular;
      }
      return prime ?? regular;
    }

    if (norm.contains('corner')) {
      return regularCorner ?? regular;
    }

    return regular;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phase': phase,
      'regular': regular,
      'regular_corner': regularCorner,
      'prime': prime,
      'prime_corner': primeCorner,
      'commercial': commercial,
      'commercial_corner': commercialCorner,
      'prime_commercial': primeCommercial,
      'prime_commercial_corner': primeCommercialCorner,
    };
  }
}
