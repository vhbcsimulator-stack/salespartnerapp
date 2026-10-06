enum DiscountBasis {
  totalTcp,
  downPayment,
  none,
}

class PaymentSchemeModel {
  final String id;
  final String projectCode;
  final String schemeName;
  final String schemeCode;
  final double dpPercentage;
  final double discountPercentage;
  final DiscountBasis discountBasis;
  final int dpMonths; // Months to pay down payment (e.g. 1 for spot, 24 for stretched)
  final int balanceMonths;
  final double interestRate; // Annual rate, e.g. 0.0 or 0.075
  final double reservationFee;
  final double miscFeePercentage;
  final String description;
  final String? badgeText;

  const PaymentSchemeModel({
    required this.id,
    required this.projectCode,
    required this.schemeName,
    required this.schemeCode,
    required this.dpPercentage,
    required this.discountPercentage,
    required this.discountBasis,
    this.dpMonths = 1,
    required this.balanceMonths,
    required this.interestRate,
    this.reservationFee = 20000.0,
    this.miscFeePercentage = 8.0,
    required this.description,
    this.badgeText,
  });

  bool get isSpotCash => dpPercentage >= 100 && balanceMonths == 0;
  bool get isZeroInterest => interestRate <= 0;

  PaymentSchemeModel copyWith({
    String? id,
    String? projectCode,
    String? schemeName,
    String? schemeCode,
    double? dpPercentage,
    double? discountPercentage,
    DiscountBasis? discountBasis,
    int? dpMonths,
    int? balanceMonths,
    double? interestRate,
    double? reservationFee,
    double? miscFeePercentage,
    String? description,
    String? badgeText,
  }) {
    return PaymentSchemeModel(
      id: id ?? this.id,
      projectCode: projectCode ?? this.projectCode,
      schemeName: schemeName ?? this.schemeName,
      schemeCode: schemeCode ?? this.schemeCode,
      dpPercentage: dpPercentage ?? this.dpPercentage,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountBasis: discountBasis ?? this.discountBasis,
      dpMonths: dpMonths ?? this.dpMonths,
      balanceMonths: balanceMonths ?? this.balanceMonths,
      interestRate: interestRate ?? this.interestRate,
      reservationFee: reservationFee ?? this.reservationFee,
      miscFeePercentage: miscFeePercentage ?? this.miscFeePercentage,
      description: description ?? this.description,
      badgeText: badgeText ?? this.badgeText,
    );
  }
}

