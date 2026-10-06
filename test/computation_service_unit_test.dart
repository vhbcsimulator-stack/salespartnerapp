import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/computation/models/computation_result_model.dart';
import 'package:vhbc_broker_app/features/computation/models/payment_scheme_model.dart';
import 'package:vhbc_broker_app/features/computation/services/computation_service.dart';

void main() {
  group('ComputationService.calculate - Unit Tests', () {
    const lotSize = 150.0;
    const pricePerSqm = 10000.0;
    // Expected original TCP = 150 * 10,000 = 1,500,000.0

    test('100% Cash Payment: calculates full TCP discount, zero balance, and misc fee', () {
      const scheme = PaymentSchemeModel(
        id: 'test_cash',
        projectCode: 'MVLC',
        schemeName: 'Cash',
        schemeCode: 'CASH_100',
        dpPercentage: 100.0,
        discountPercentage: 40.0,
        discountBasis: DiscountBasis.totalTcp,
        balanceMonths: 0,
        interestRate: 0.0,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '100% Spot Payment',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '10',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.originalTCP, 1500000.0);
      expect(result.discountAmount, 600000.0); // 40% of 1.5M
      expect(result.tcpAfterDiscount, 900000.0);
      expect(result.grossDownPayment, 1500000.0);
      expect(result.discountedDownPayment, 900000.0);
      expect(result.reservationFee, 20000.0);
      expect(result.remainingDownPayment, 880000.0); // 900k - 20k
      expect(result.balance, 0.0);
      expect(result.monthlyAmortization, 0.0);
      expect(result.miscellaneousFee, 72000.0); // 8% of 900k
    });

    test('20% Spot DP: applies discount strictly to down payment and amortizes remaining 80% balance @ 0%', () {
      const scheme = PaymentSchemeModel(
        id: 'test_20_spot',
        projectCode: 'MVLC',
        schemeName: '20% Spot DP',
        schemeCode: 'SPOT_DP_20',
        dpPercentage: 20.0,
        discountPercentage: 10.0,
        discountBasis: DiscountBasis.downPayment,
        balanceMonths: 60,
        interestRate: 0.0,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '20% Spot Down Payment',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '2',
        lotNumber: '5',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.originalTCP, 1500000.0);
      expect(result.grossDownPayment, 300000.0); // 20% of 1.5M
      expect(result.discountAmount, 30000.0); // 10% of 300k
      expect(result.discountedDownPayment, 270000.0);
      expect(result.tcpAfterDiscount, 1470000.0); // 1.5M - 30k discount
      expect(result.remainingDownPayment, 250000.0); // 270k - 20k reservation
      expect(result.balance, 1200000.0); // 80% balance
      expect(result.balanceMonths, 60);
      expect(result.monthlyAmortization, 20000.0); // 1.2M / 60
      expect(result.miscellaneousFee, 117600.0); // 8% of 1,470,000
    });

    test('Amortization with compound interest (> 0% interest per annum)', () {
      const scheme = PaymentSchemeModel(
        id: 'test_interest',
        projectCode: 'MVLC',
        schemeName: '20% DP with 12% Interest',
        schemeCode: 'DP_20_INT_12',
        dpPercentage: 20.0,
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        balanceMonths: 60,
        interestRate: 0.12, // 12% annual interest (0.12)
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '20% DP with interest',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '3',
        lotNumber: '1',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.balance, 1200000.0);
      // Formula: P * [ r(1+r)^n ] / [ (1+r)^n - 1 ]
      // Where P = 1,200,000, r = 0.12 / 12 = 0.01, n = 60 => PMT ~= 26,693.33
      expect(result.monthlyAmortization, closeTo(26693.33, 0.05));
    });

    test('0% Spot DP: credits reservation fee directly against TCP balance', () {
      const scheme = PaymentSchemeModel(
        id: 'test_0_spot',
        projectCode: 'MVLC',
        schemeName: '0% Spot DP',
        schemeCode: 'SPOT_DP_0',
        dpPercentage: 0.0,
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        balanceMonths: 60,
        interestRate: 0.0,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '0% Spot Down Payment',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '4',
        lotNumber: '20',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.originalTCP, 1500000.0);
      expect(result.grossDownPayment, 0.0);
      expect(result.discountAmount, 0.0);
      expect(result.discountedDownPayment, 0.0);
      expect(result.remainingDownPayment, 0.0);
      // Balance is TCP (1.5M) minus 20k reservation fee = 1,480,000.0
      expect(result.balance, 1480000.0);
      expect(result.monthlyAmortization, closeTo(1480000.0 / 60, 0.01));
    });

    test('Edge Case: Reservation fee exceeds down payment amount does not produce negative remainingDownPayment', () {
      const scheme = PaymentSchemeModel(
        id: 'test_small_dp',
        projectCode: 'MVLC',
        schemeName: 'Small DP',
        schemeCode: 'SMALL_DP',
        dpPercentage: 5.0, // 5% of 200,000 = 10,000
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        balanceMonths: 12,
        interestRate: 0.0,
        reservationFee: 20000.0, // 20k > 10k DP
        miscFeePercentage: 0.0,
        description: 'Small DP scheme',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '1',
        lotSize: 20.0,
        lotType: 'Regular',
        pricePerSqm: 10000.0, // TCP = 200,000
        scheme: scheme,
      );

      expect(result.grossDownPayment, 10000.0);
      expect(result.discountedDownPayment, 10000.0);
      // Must clamp to 0.0, never negative (-10000.0)
      expect(result.remainingDownPayment, 0.0);
      expect(result.remainingDownPayment, isNot(isNegative));
    });

    test('Edge Case: Stretched down payment across multiple months (dpMonths > 1)', () {
      const scheme = PaymentSchemeModel(
        id: 'test_stretched_dp',
        projectCode: 'MVLC',
        schemeName: '20% Stretched DP over 6 months',
        schemeCode: 'DP_STRETCHED',
        dpPercentage: 20.0, // 20% of 1.5M = 300,000
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        dpMonths: 6, // 6 months to pay DP
        balanceMonths: 60,
        interestRate: 0.0,
        reservationFee: 20000.0, // Remaining DP = 280,000
        miscFeePercentage: 8.0,
        description: 'Stretched DP scheme',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '1',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.remainingDownPayment, 280000.0);
      expect(result.dpMonths, 6);
      expect(result.monthlyDownPayment, closeTo(280000.0 / 6, 0.01));
    });

    test('Edge Case: Zero balance months does not trigger division by zero error', () {
      const scheme = PaymentSchemeModel(
        id: 'test_zero_months',
        projectCode: 'MVLC',
        schemeName: 'Zero Balance Months',
        schemeCode: 'ZERO_MOS',
        dpPercentage: 50.0,
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        balanceMonths: 0,
        interestRate: 0.0,
        reservationFee: 0.0,
        miscFeePercentage: 0.0,
        description: 'Zero balance months scheme',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '1',
        lotSize: lotSize,
        lotType: 'Regular',
        pricePerSqm: pricePerSqm,
        scheme: scheme,
      );

      expect(result.balanceMonths, 0);
      expect(result.monthlyAmortization, 0.0);
    });

    test('Edge Case: Negative lot size or negative pricePerSqm are safely clamped to 0.0', () {
      const scheme = PaymentSchemeModel(
        id: 'test_clamp',
        projectCode: 'MVLC',
        schemeName: 'Cash',
        schemeCode: 'CASH_100',
        dpPercentage: 100.0,
        discountPercentage: 0.0,
        discountBasis: DiscountBasis.none,
        balanceMonths: 0,
        interestRate: 0.0,
        reservationFee: 0.0,
        miscFeePercentage: 0.0,
        description: 'Clamp negative inputs',
      );

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Club',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '1',
        lotSize: -150.0,
        lotType: 'Regular',
        pricePerSqm: -10000.0,
        scheme: scheme,
      );

      expect(result.lotSize, 0.0);
      expect(result.pricePerSqm, 0.0);
      expect(result.originalTCP, 0.0);
      expect(result.tcpAfterDiscount, 0.0);
      expect(result.balance, 0.0);
    });
  });
}
