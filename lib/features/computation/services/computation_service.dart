import 'dart:math' as math;
import '../../../core/services/supabase_service.dart';
import '../../inventory/models/mvlc_price_model.dart';
import '../../inventory/models/project_model.dart';
import '../models/computation_result_model.dart';
import '../models/payment_scheme_model.dart';
import '../models/project_discount_model.dart';

class ComputationService {
  ComputationService._();

  /// Determine project code identifier (e.g. ERHD, MVLC, EWBLF, LCN)
  static String normalizeProjectCode(String? code, String? name) {
    final combined = '${code ?? ''} ${name ?? ''}'.toLowerCase();
    if (combined.contains('erhd') ||
        combined.contains('eastwest resort') ||
        combined.contains('east west resort') ||
        combined.contains('resorts hub')) {
      return 'ERHD';
    }
    if (combined.contains('mvlc') ||
        combined.contains('mountain view') ||
        combined.contains('leisure community')) {
      return 'MVLC';
    }
    if (combined.contains('breeze') || combined.contains('ewblf')) {
      return 'EWBLF';
    }
    if (combined.contains('lakeshore') || combined.contains('lcn')) {
      return 'LCN';
    }
    return code?.trim().toUpperCase() ?? 'MVLC';
  }

  /// Returns whether a project is eligible to be included on the price calculator.
  /// If [paused] is true (from projects table), it is marked as Soon to Rise and excluded from calculations.
  /// EBLF (sold out) is also excluded.
  static bool isProjectEligibleForCalculator(
    String? code,
    String? name, {
    bool? paused,
    List<ProjectModel>? projects,
  }) {
    // 1. Explicit paused check
    if (paused == true) {
      return false;
    }

    final c = (code ?? '').trim().toUpperCase();
    final n = (name ?? '').trim().toUpperCase();
    final combined = '$c $n';

    // 2. Check if matching project is paused in provided projects list
    if (projects != null && projects.isNotEmpty) {
      for (final p in projects) {
        final pCode = (p.code ?? '').trim().toUpperCase();
        final pName = (p.name ?? p.displayName).trim().toUpperCase();
        if ((c.isNotEmpty && (pCode == c || pName == c)) ||
            (n.isNotEmpty && (pCode == n || pName == n))) {
          if (p.paused) return false;
        }
      }
    }

    // 3. Check dynamic paused state from SupabaseService cache / fallback
    if (SupabaseService.isProjectPaused(c, n)) {
      return false;
    }

    // 4. Sold out projects (e.g. EBLF)
    if (c == 'EBLF' ||
        combined.contains('EBLF') ||
        combined.contains('EASTWEST BREEZE') ||
        combined.contains('BREEZE LEISURE FARM')) {
      return false;
    }

    if (combined.contains('SOON TO RISE')) {
      return false;
    }

    return true;
  }

  /// Supported Lot Types per Project
  static List<String> getLotTypesForProject(String projectCode) {
    switch (projectCode) {
      case 'MSCC':
        return [
          'Studio Unit',
          '1 Bedroom Unit',
          '2 Bedroom Unit',
          '2 Bedroom Deluxe Unit',
          'Penthouse Unit',
        ];
      case 'ERHD':
        return ['Regular', 'Prime', 'Prime Corner'];
      case 'MVLC':
        return [
          'Regular Residential',
          'Regular Corner',
          'Prime Residential',
          'Prime Corner',
          'Commercial Regular',
          'Commercial Corner',
        ];
      case 'EWBLF':
      case 'LCN':
      default:
        return ['Regular', 'Corner', 'Prime'];
    }
  }

  /// Default active price per sqm for the given project & lot type
  static double getPricePerSqm({
    required String projectCode,
    required String lotType,
    int? phase,
    List<MvlcPriceModel>? mvlcPrices,
  }) {
    final normLotType = lotType.toLowerCase().trim();

    if (projectCode == 'MSCC') {
      return 110000.0;
    }

    if (projectCode == 'ERHD') {
      if (normLotType.contains('prime') && normLotType.contains('corner')) {
        return 16800.0;
      } else if (normLotType.contains('prime')) {
        return 14400.0;
      } else {
        return 12000.0;
      }
    }

    if (projectCode == 'MVLC') {
      final targetPhase = phase ?? 2;

      // 1. Try to find matching price from dynamic mvlcPrices matrix from mvlc_price table
      if (mvlcPrices != null && mvlcPrices.isNotEmpty) {
        for (final p in mvlcPrices) {
          if (p.phase == targetPhase) {
            final resolvedPrice = p.getPriceForCategory(normLotType);
            if (resolvedPrice != null && resolvedPrice > 0) {
              return resolvedPrice;
            }
          }
        }
      }

      // 2. Exact pricing from public.mvlc_price table in Supabase
      if (targetPhase == 1) {
        if (normLotType.contains('commercial')) {
          if (normLotType.contains('prime') && normLotType.contains('corner')) return 19260.0;
          if (normLotType.contains('prime')) return 16300.0;
          if (normLotType.contains('corner')) return 16860.0;
          return 14300.0;
        }
        if (normLotType.contains('corner')) return 13260.0;
        return 11300.0;
      } else if (targetPhase == 3) {
        if (normLotType.contains('commercial')) {
          if (normLotType.contains('corner')) return 19260.0;
          return 16300.0;
        }
        if (normLotType.contains('corner')) return 13260.0;
        return 11300.0;
      } else {
        // Phase 2 (default)
        if (normLotType.contains('prime')) {
          if (normLotType.contains('corner')) return 13120.0;
          return 11460.0;
        }
        if (normLotType.contains('corner')) return 11460.0;
        return 9800.0;
      }
    }

    // Default for EWBLF / Lakeshore / other developments
    if (normLotType.contains('prime')) {
      return 12000.0;
    } else if (normLotType.contains('corner')) {
      return 10500.0;
    } else {
      return 9500.0;
    }
  }

  /// Finds matching discount rule for a project and payment option.
  /// Looks for exact projectCode match first, then wildcard '*', then returns null.
  static ProjectDiscountModel? findDiscountRule({
    required String projectCode,
    required String optionKey,
    List<ProjectDiscountModel>? discounts,
  }) {
    final list = discounts ?? SupabaseService.cachedProjectDiscounts;
    if (list.isEmpty) return null;

    final normProject = projectCode.trim().toUpperCase();
    final normOption = optionKey.trim().toLowerCase();

    // 1. Try project-specific match
    for (final d in list) {
      if (d.projectCode.trim().toUpperCase() == normProject &&
          d.option.trim().toLowerCase() == normOption) {
        return d;
      }
    }

    // 2. Try wildcard match ('*' or empty)
    for (final d in list) {
      final pCode = d.projectCode.trim();
      if ((pCode == '*' || pCode.isEmpty) &&
          d.option.trim().toLowerCase() == normOption) {
        return d;
      }
    }

    return null;
  }

  /// Helper to get discount percentage with fallback
  static double getDiscountPercentage({
    required String projectCode,
    required String optionKey,
    required double fallbackDiscount,
    List<ProjectDiscountModel>? discounts,
  }) {
    final rule = findDiscountRule(
      projectCode: projectCode,
      optionKey: optionKey,
      discounts: discounts,
    );
    return rule?.discount ?? fallbackDiscount;
  }

  /// Helper to get interest rate with fallback
  static double getInterestRate({
    required String projectCode,
    required String optionKey,
    required double fallbackInterest,
    List<ProjectDiscountModel>? discounts,
  }) {
    final rule = findDiscountRule(
      projectCode: projectCode,
      optionKey: optionKey,
      discounts: discounts,
    );
    return rule?.interest ?? fallbackInterest;
  }

  /// Payment Schemes configured per Project
  /// Dynamically looks up discount and interest rates from Supabase table `project_discounts`.
  /// - Cash: Discount on Total TCP (defaults to 40% if offline, or from project_discounts e.g. 50%)
  /// - 50% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (defaults to 30%)
  /// - 30% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (defaults to 20%)
  /// - 20% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (defaults to 10%)
  /// - 0% Spot DP: ₱20,000 Reservation Fee • Balance 60 mos @ 0% Interest
  static List<PaymentSchemeModel> getPaymentSchemesForProject(
    String projectCode, {
    List<ProjectDiscountModel>? discounts,
  }) {
    final code = projectCode.trim().toUpperCase();

    final cashDisc = getDiscountPercentage(
      projectCode: code,
      optionKey: 'cash',
      fallbackDiscount: 40.0,
      discounts: discounts,
    );
    final cashInt = getInterestRate(
      projectCode: code,
      optionKey: 'cash',
      fallbackInterest: 0.0,
      discounts: discounts,
    );

    final dp50Disc = getDiscountPercentage(
      projectCode: code,
      optionKey: '50',
      fallbackDiscount: 30.0,
      discounts: discounts,
    );
    final dp50Int = getInterestRate(
      projectCode: code,
      optionKey: '50',
      fallbackInterest: 0.0,
      discounts: discounts,
    );

    final dp30Disc = getDiscountPercentage(
      projectCode: code,
      optionKey: '30',
      fallbackDiscount: 20.0,
      discounts: discounts,
    );
    final dp30Int = getInterestRate(
      projectCode: code,
      optionKey: '30',
      fallbackInterest: 0.0,
      discounts: discounts,
    );

    final dp20Disc = getDiscountPercentage(
      projectCode: code,
      optionKey: '20',
      fallbackDiscount: 10.0,
      discounts: discounts,
    );
    final dp20Int = getInterestRate(
      projectCode: code,
      optionKey: '20',
      fallbackInterest: 0.0,
      discounts: discounts,
    );

    final dp0Disc = getDiscountPercentage(
      projectCode: code,
      optionKey: '0',
      fallbackDiscount: 0.0,
      discounts: discounts,
    );
    final dp0Int = getInterestRate(
      projectCode: code,
      optionKey: '0',
      fallbackInterest: 0.0,
      discounts: discounts,
    );

    String fmtNum(double val) => val % 1 == 0 ? val.toInt().toString() : val.toString();

    String spotBadge(double disc, double interest) {
      final dStr = fmtNum(disc);
      final iStr = interest == 0 ? '0% INT' : '${fmtNum(interest)}% INT';
      return disc > 0 ? '$dStr% OFF DP • $iStr' : iStr;
    }

    String spotDesc(double disc, double interest) {
      final dStr = fmtNum(disc);
      final iStr = interest == 0 ? '0% Interest' : '${fmtNum(interest)}% Interest';
      return disc > 0
          ? '$dStr% Discount on Spot DP • Balance 60 mos @ $iStr'
          : 'Balance 60 mos @ $iStr';
    }

    return [
      PaymentSchemeModel(
        id: '${code.toLowerCase()}_cash',
        projectCode: code,
        schemeName: 'Cash',
        schemeCode: 'CASH_100',
        dpPercentage: 100.0,
        discountPercentage: cashDisc,
        discountBasis: DiscountBasis.totalTcp,
        balanceMonths: 0,
        interestRate: cashInt,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '100% Spot Payment • ${fmtNum(cashDisc)}% Discount on Total TCP',
        badgeText: '${fmtNum(cashDisc)}% OFF TCP',
      ),
      PaymentSchemeModel(
        id: '${code.toLowerCase()}_50_spot',
        projectCode: code,
        schemeName: '50% Spot DP',
        schemeCode: 'SPOT_DP_50',
        dpPercentage: 50.0,
        discountPercentage: dp50Disc,
        discountBasis: DiscountBasis.downPayment,
        balanceMonths: 60,
        interestRate: dp50Int,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: spotDesc(dp50Disc, dp50Int),
        badgeText: spotBadge(dp50Disc, dp50Int),
      ),
      PaymentSchemeModel(
        id: '${code.toLowerCase()}_30_spot',
        projectCode: code,
        schemeName: '30% Spot DP',
        schemeCode: 'SPOT_DP_30',
        dpPercentage: 30.0,
        discountPercentage: dp30Disc,
        discountBasis: DiscountBasis.downPayment,
        balanceMonths: 60,
        interestRate: dp30Int,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: spotDesc(dp30Disc, dp30Int),
        badgeText: spotBadge(dp30Disc, dp30Int),
      ),
      PaymentSchemeModel(
        id: '${code.toLowerCase()}_20_spot',
        projectCode: code,
        schemeName: '20% Spot DP',
        schemeCode: 'SPOT_DP_20',
        dpPercentage: 20.0,
        discountPercentage: dp20Disc,
        discountBasis: DiscountBasis.downPayment,
        balanceMonths: 60,
        interestRate: dp20Int,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: spotDesc(dp20Disc, dp20Int),
        badgeText: spotBadge(dp20Disc, dp20Int),
      ),
      PaymentSchemeModel(
        id: '${code.toLowerCase()}_0_spot',
        projectCode: code,
        schemeName: '0% Spot DP',
        schemeCode: 'SPOT_DP_0',
        dpPercentage: 0.0,
        discountPercentage: dp0Disc,
        discountBasis: dp0Disc > 0 ? DiscountBasis.downPayment : DiscountBasis.none,
        balanceMonths: 60,
        interestRate: dp0Int,
        reservationFee: 20000.0,
        miscFeePercentage: 8.0,
        description: '₱20,000 Reservation Fee • Balance payable over 60 mos @ ${dp0Int == 0 ? "0%" : "${fmtNum(dp0Int)}%"} Interest',
        badgeText: '₱20K RES • 60 MOS @ ${dp0Int == 0 ? "0%" : "${fmtNum(dp0Int)}%"}',
      ),
    ];
  }

  /// Calculates the price computation snapshot
  static ComputationResultModel calculate({
    required String projectName,
    required String projectCode,
    String? projectId,
    int? lotId,
    int? phase,
    required String blockNumber,
    required String lotNumber,
    required double lotSize,
    required String lotType,
    required double pricePerSqm,
    required PaymentSchemeModel scheme,
  }) {
    final safeLotSize = math.max(0.0, lotSize);
    final safePricePerSqm = math.max(0.0, pricePerSqm);
    final originalTCP = safeLotSize * safePricePerSqm;
    final dpPct = scheme.dpPercentage / 100.0;
    final discountPct = scheme.discountPercentage / 100.0;

    double grossDownPayment = 0.0;
    double discountAmount = 0.0;
    double discountedDownPayment = 0.0;
    double tcpAfterDiscount = originalTCP;
    double balance = 0.0;

    if (scheme.discountBasis == DiscountBasis.totalTcp) {
      // Discount applies to entire TCP
      discountAmount = originalTCP * discountPct;
      tcpAfterDiscount = originalTCP - discountAmount;
      grossDownPayment = originalTCP;
      discountedDownPayment = tcpAfterDiscount;
      balance = 0.0;
    } else if (scheme.discountBasis == DiscountBasis.downPayment) {
      // Discount applies only to the Spot Down Payment
      grossDownPayment = originalTCP * dpPct;
      discountAmount = grossDownPayment * discountPct;
      discountedDownPayment = grossDownPayment - discountAmount;
      tcpAfterDiscount = originalTCP - discountAmount;
      balance = originalTCP - grossDownPayment;
    } else {
      // DiscountBasis.none
      grossDownPayment = originalTCP * dpPct;
      discountAmount = 0.0;
      discountedDownPayment = grossDownPayment;
      tcpAfterDiscount = originalTCP;
      if (dpPct == 0.0) {
        // For 0% down payment, reservation fee is the initial cash out and credits against the balance
        balance = math.max(0.0, tcpAfterDiscount - scheme.reservationFee);
      } else {
        balance = originalTCP - grossDownPayment;
      }
    }

    final reservationFee = scheme.reservationFee;
    final remainingDownPayment = math.max(0.0, discountedDownPayment - reservationFee);

    // Monthly Amortization
    double monthlyAmortization = 0.0;
    if (scheme.balanceMonths > 0 && balance > 0) {
      if (scheme.interestRate > 0) {
        final monthlyRate = scheme.interestRate / 12.0;
        final n = scheme.balanceMonths;
        final compound = math.pow(1.0 + monthlyRate, n).toDouble();
        monthlyAmortization = balance * (monthlyRate * compound) / (compound - 1.0);
      } else {
        monthlyAmortization = balance / scheme.balanceMonths;
      }
    }

    // Stretched Down Payment Monthly Amortization
    final dpMonths = scheme.dpMonths > 0 ? scheme.dpMonths : 1;
    final monthlyDownPayment = dpMonths > 1
        ? (remainingDownPayment > 0 ? remainingDownPayment / dpMonths : 0.0)
        : 0.0;

    // Miscellaneous Fee (e.g. 8% of TCP After Discount)
    final miscellaneousFee = tcpAfterDiscount * (scheme.miscFeePercentage / 100.0);

    return ComputationResultModel(
      projectId: projectId,
      projectName: projectName,
      projectCode: projectCode,
      lotId: lotId,
      phase: phase,
      blockNumber: blockNumber,
      lotNumber: lotNumber,
      lotSize: safeLotSize,
      lotType: lotType,
      pricePerSqm: safePricePerSqm,
      paymentSchemeName: scheme.schemeName,
      downPaymentPercentage: scheme.dpPercentage,
      discountPercentage: scheme.discountPercentage,
      discountBasis: scheme.discountBasis,
      originalTCP: originalTCP,
      grossDownPayment: grossDownPayment,
      discountAmount: discountAmount,
      discountedDownPayment: discountedDownPayment,
      reservationFee: reservationFee,
      remainingDownPayment: remainingDownPayment,
      dpMonths: dpMonths,
      monthlyDownPayment: monthlyDownPayment,
      balance: balance,
      balanceMonths: scheme.balanceMonths,
      interestRate: scheme.interestRate,
      monthlyAmortization: monthlyAmortization,
      miscellaneousFee: miscellaneousFee,
      tcpAfterDiscount: tcpAfterDiscount,
      computedAt: DateTime.now(),
    );
  }
}
