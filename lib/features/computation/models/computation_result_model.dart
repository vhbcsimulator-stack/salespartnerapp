import 'payment_scheme_model.dart';

class ComputationResultModel {
  final String? projectId;
  final String projectName;
  final String projectCode;
  final int? lotId;
  final int? phase;
  final String blockNumber;
  final String lotNumber;
  final double lotSize;
  final String lotType;
  final double pricePerSqm;
  final String paymentSchemeName;
  final double downPaymentPercentage;
  final double discountPercentage;
  final DiscountBasis discountBasis;
  final double originalTCP;
  final double grossDownPayment;
  final double discountAmount;
  final double discountedDownPayment;
  final double reservationFee;
  final double remainingDownPayment;
  final int dpMonths;
  final double monthlyDownPayment;
  final double balance;
  final int balanceMonths;
  final double interestRate;
  final double monthlyAmortization;
  final double miscellaneousFee;
  final double tcpAfterDiscount;
  final DateTime computedAt;

  const ComputationResultModel({
    this.projectId,
    required this.projectName,
    required this.projectCode,
    this.lotId,
    this.phase,
    required this.blockNumber,
    required this.lotNumber,
    required this.lotSize,
    required this.lotType,
    required this.pricePerSqm,
    required this.paymentSchemeName,
    required this.downPaymentPercentage,
    required this.discountPercentage,
    required this.discountBasis,
    required this.originalTCP,
    required this.grossDownPayment,
    required this.discountAmount,
    required this.discountedDownPayment,
    required this.reservationFee,
    required this.remainingDownPayment,
    this.dpMonths = 1,
    this.monthlyDownPayment = 0.0,
    required this.balance,
    required this.balanceMonths,
    required this.interestRate,
    required this.monthlyAmortization,
    required this.miscellaneousFee,
    required this.tcpAfterDiscount,
    required this.computedAt,
  });

  String get lotDisplay {
    if (blockNumber.isNotEmpty) {
      return 'Block $blockNumber – Lot $lotNumber';
    }
    return 'Lot $lotNumber';
  }

  Map<String, dynamic> toSnapshotJson({String? brokerId, String? clientId}) {
    return {
      'project_id': projectId,
      'project_name': projectName,
      'lot_id': lotId,
      'block_number': blockNumber,
      'lot_number': lotNumber,
      'lot_size': lotSize,
      'lot_type_name': lotType,
      'price_per_sqm_used': pricePerSqm,
      'payment_scheme_name': paymentSchemeName,
      'dp_percentage_used': downPaymentPercentage,
      'discount_percentage_used': discountPercentage,
      'discount_basis': discountBasis.name.toUpperCase(),
      'original_tcp': originalTCP,
      'discount_amount': discountAmount,
      'tcp_after_discount': tcpAfterDiscount,
      'reservation_fee_used': reservationFee,
      'remaining_dp_payable': remainingDownPayment,
      'balance': balance,
      'balance_months': balanceMonths,
      'interest_rate_used': interestRate,
      'monthly_amortization': monthlyAmortization,
      'miscellaneous_fee': miscellaneousFee,
      'broker_id': brokerId,
      'client_id': clientId,
      'created_at': computedAt.toIso8601String(),
    };
  }
}
