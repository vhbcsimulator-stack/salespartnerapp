import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/theme/app_colors.dart';
import 'package:vhbc_broker_app/features/computation/presentation/computation_page.dart';
import 'package:vhbc_broker_app/features/computation/services/computation_service.dart';
import 'package:vhbc_broker_app/features/inventory/models/project_model.dart';
import 'package:vhbc_broker_app/features/inventory/models/lot_model.dart';
import 'package:vhbc_broker_app/features/inventory/models/mvlc_price_model.dart';
import 'package:vhbc_broker_app/features/map/models/map_lot_model.dart';
import 'package:vhbc_broker_app/features/map/presentation/widgets/quick_amortization_modal.dart';
import 'package:vhbc_broker_app/features/home/presentation/widgets/featured_development_card.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  group('ComputationService Calculation Tests (Prompt Specification Verification)', () {
    test('ERHD 50% Spot DP exact prompt match: 700 sqm @ ₱12,000', () {
      final schemes = ComputationService.getPaymentSchemesForProject('ERHD');
      final spot50Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_50');

      final result = ComputationService.calculate(
        projectName: 'EastWest Resorts Hub Development',
        projectCode: 'ERHD',
        blockNumber: '2',
        lotNumber: '15',
        lotSize: 700,
        lotType: 'Regular',
        pricePerSqm: 12000,
        scheme: spot50Scheme,
      );

      // Section 10 Formula Verification:
      // Original TCP = 700 * 12,000 = 8,400,000
      expect(result.originalTCP, 8400000.0);
      // Spot DP = 8,400,000 * 50% = 4,200,000
      expect(result.grossDownPayment, 4200000.0);
      // Discount Amount = 4,200,000 * 30% = 1,260,000
      expect(result.discountAmount, 1260000.0);
      // Discounted DP = 4,200,000 - 1,260,000 = 2,940,000
      expect(result.discountedDownPayment, 2940000.0);
      // TCP After Discount = 8,400,000 - 1,260,000 = 7,140,000
      expect(result.tcpAfterDiscount, 7140000.0);
      // Reservation Fee = 20,000
      expect(result.reservationFee, 20000.0);
      // Remaining DP Payable = 2,940,000 - 20,000 = 2,920,000
      expect(result.remainingDownPayment, 2920000.0);
      // Balance = 8,400,000 - 4,200,000 = 4,200,000
      expect(result.balance, 4200000.0);
      // Term = 60 Months
      expect(result.balanceMonths, 60);
      // Monthly Amortization = 4,200,000 / 60 = 70,000
      expect(result.monthlyAmortization, 70000.0);
      // Miscellaneous Fee (8%) = 7,140,000 * 0.08 = 571,200
      expect(result.miscellaneousFee, 571200.0);
    });

    test('ERHD Cash exact prompt match: 700 sqm @ ₱12,000, 40% discount', () {
      final schemes = ComputationService.getPaymentSchemesForProject('ERHD');
      final cashScheme = schemes.firstWhere((s) => s.schemeCode == 'CASH_100');

      final result = ComputationService.calculate(
        projectName: 'EastWest Resorts Hub Development',
        projectCode: 'ERHD',
        blockNumber: '2',
        lotNumber: '15',
        lotSize: 700,
        lotType: 'Regular',
        pricePerSqm: 12000,
        scheme: cashScheme,
      );

      // Section 11 Formula Verification:
      // Original TCP = 8,400,000
      expect(result.originalTCP, 8400000.0);
      // Discount = 8,400,000 * 40% = 3,360,000
      expect(result.discountAmount, 3360000.0);
      // TCP After Discount = 8,400,000 - 3,360,000 = 5,040,000
      expect(result.tcpAfterDiscount, 5040000.0);
      expect(result.balance, 0.0);
      expect(result.monthlyAmortization, 0.0);
    });

    test('ERHD 0% Spot DP: 700 sqm @ ₱12,000, 60 mos @ 0%', () {
      final schemes = ComputationService.getPaymentSchemesForProject('ERHD');
      final zeroDpScheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_0');

      final result = ComputationService.calculate(
        projectName: 'EastWest Resorts Hub Development',
        projectCode: 'ERHD',
        blockNumber: '2',
        lotNumber: '15',
        lotSize: 700,
        lotType: 'Regular',
        pricePerSqm: 12000,
        scheme: zeroDpScheme,
      );

      expect(result.originalTCP, 8400000.0);
      expect(result.discountAmount, 0.0);
      expect(result.tcpAfterDiscount, 8400000.0);
      expect(result.reservationFee, 20000.0);
      // Reservation fee of 20,000 is credited against the balance
      expect(result.balance, 8380000.0);
      expect(result.balanceMonths, 60);
      expect(result.monthlyAmortization, 8380000.0 / 60);
      // Total buyer payments = Reservation Fee (20,000) + Balance (8,380,000) = 8,400,000 exact TCP
      expect(result.reservationFee + result.balance, result.tcpAfterDiscount);
    });

    test('ERHD Pricing per sqm retrieves correct active values', () {
      expect(
        ComputationService.getPricePerSqm(projectCode: 'ERHD', lotType: 'Regular'),
        12000.0,
      );
      expect(
        ComputationService.getPricePerSqm(projectCode: 'ERHD', lotType: 'Prime'),
        14400.0,
      );
      expect(
        ComputationService.getPricePerSqm(projectCode: 'ERHD', lotType: 'Prime Corner'),
        16800.0,
      );
    });

    test('MVLC Price per sqm matches mvlc_price table for all phases and lot types', () {
      // Phase 1 from mvlc_price table
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular', phase: 1), 11300.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular Corner', phase: 1), 13260.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Commercial', phase: 1), 14300.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Commercial Corner', phase: 1), 16860.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Prime Commercial', phase: 1), 16300.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Prime Commercial Corner', phase: 1), 19260.0);

      // Phase 2 from mvlc_price table
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular', phase: 2), 9800.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular Corner', phase: 2), 11460.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Prime', phase: 2), 11460.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Prime Corner', phase: 2), 13120.0);

      // Phase 3 from mvlc_price table
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular', phase: 3), 11300.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular Corner', phase: 3), 13260.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Commercial', phase: 3), 16300.0);
      expect(ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Commercial Corner', phase: 3), 19260.0);
    });

    test('MVLC Price per sqm dynamically resolves from passed List<MvlcPriceModel>', () {
      final dynamicList = [
        const MvlcPriceModel(id: 1, phase: 2, regular: 9800, regularCorner: 11460, prime: 11460, primeCorner: 13120),
        const MvlcPriceModel(id: 4, phase: 1, regular: 11300, regularCorner: 13260, commercial: 14300, commercialCorner: 16860),
      ];

      expect(
        ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Regular', phase: 2, mvlcPrices: dynamicList),
        9800.0,
      );
      expect(
        ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Prime Corner', phase: 2, mvlcPrices: dynamicList),
        13120.0,
      );
      expect(
        ComputationService.getPricePerSqm(projectCode: 'MVLC', lotType: 'Commercial', phase: 1, mvlcPrices: dynamicList),
        14300.0,
      );
    });

    test('MVLC 20% Spot DP (same as ERHD): 200 sqm @ ₱13,000, 10% discount on DP, 60 mos @ 0%', () {
      final schemes = ComputationService.getPaymentSchemesForProject('MVLC');
      final spot20Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_20');

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Community',
        projectCode: 'MVLC',
        phase: 2,
        blockNumber: '6',
        lotNumber: '17',
        lotSize: 200,
        lotType: 'Regular',
        pricePerSqm: 13000,
        scheme: spot20Scheme,
      );

      // Original TCP = 200 * 13,000 = 2,600,000
      expect(result.originalTCP, 2600000.0);
      // Down Payment (20%) = 520,000
      expect(result.grossDownPayment, 520000.0);
      // 10% Discount on DP = 52,000
      expect(result.discountAmount, 52000.0);
      // Discounted DP = 520,000 - 52,000 = 468,000
      expect(result.discountedDownPayment, 468000.0);
      // TCP After Discount = 2,600,000 - 52,000 = 2,548,000
      expect(result.tcpAfterDiscount, 2548000.0);
      // Reservation Fee = 20,000
      expect(result.reservationFee, 20000.0);
      // Remaining Spot DP Due = 468,000 - 20,000 = 448,000
      expect(result.remainingDownPayment, 448000.0);
      // 80% Balance = 2,080,000
      expect(result.balance, 2080000.0);
      // 60 Months Term @ 0% Interest
      expect(result.balanceMonths, 60);
      // Monthly Balance Amortization = 2,080,000 / 60 = 34,666.67 / month
      expect(result.monthlyAmortization, closeTo(34666.67, 0.01));
      // Misc Fee (8%) = 2,548,000 * 0.08 = 203,840
      expect(result.miscellaneousFee, 203840.0);
    });

    test('MVLC Cash (same as ERHD): 200 sqm @ ₱13,000, 40% discount', () {
      final schemes = ComputationService.getPaymentSchemesForProject('MVLC');
      final cashScheme = schemes.firstWhere((s) => s.schemeCode == 'CASH_100');

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Community',
        projectCode: 'MVLC',
        phase: 2,
        blockNumber: '6',
        lotNumber: '17',
        lotSize: 200,
        lotType: 'Regular',
        pricePerSqm: 13000,
        scheme: cashScheme,
      );

      // 2,600,000 - 40% (1,040,000) = 1,560,000
      expect(result.originalTCP, 2600000.0);
      expect(result.discountAmount, 1040000.0);
      expect(result.tcpAfterDiscount, 1560000.0);
      expect(result.reservationFee, 20000.0);
      expect(result.balance, 0.0);
      expect(result.monthlyAmortization, 0.0);
    });

    test('MVLC 0% Spot DP (same as ERHD): 200 sqm @ ₱13,000, 60 mos @ 0%', () {
      final schemes = ComputationService.getPaymentSchemesForProject('MVLC');
      final zeroScheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_0');

      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Community',
        projectCode: 'MVLC',
        phase: 2,
        blockNumber: '6',
        lotNumber: '17',
        lotSize: 200,
        lotType: 'Regular',
        pricePerSqm: 13000,
        scheme: zeroScheme,
      );

      expect(result.originalTCP, 2600000.0);
      expect(result.reservationFee, 20000.0);
      // Net Balance = 2,600,000 - 20,000 = 2,580,000
      expect(result.balance, 2580000.0);
      expect(result.balanceMonths, 60);
      // Monthly Amortization = 2,580,000 / 60 = 43,000
      expect(result.monthlyAmortization, 43000.0);
    });
  });

  group('ComputationPage Widget Tests', () {
    testWidgets('renders Price Computation title and does NOT automatically select project on standalone open',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              initialProjects: [
                ProjectModel(
                  id: '1',
                  code: 'MVLC',
                  name: 'Mountain View Leisure Community',
                  description: 'Mountain View Leisure Community',
                ),
                ProjectModel(
                  id: '2',
                  code: 'ERHD',
                  name: 'EastWest Resorts Hub Development',
                  description: 'EastWest Resorts Hub Development',
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      // Check title
      expect(find.text('Price Computation'), findsOneWidget);

      // Section 1: Do not automatically select a project
      expect(find.text('Select Project...'), findsOneWidget);
      expect(find.text('Begin Price Computation'), findsOneWidget);
    });

    test('MapLotModel MVLC getters correctly deduct reservation fee for 24-mo DP', () {
      const lot = MapLotModel(
        id: 'test_lot',
        block: 5,
        lot: 12,
        phase: 'Phase 2',
        status: MapLotStatus.available,
        sizeSqm: 200,
        pricePerSqm: 13000,
        totalPrice: 2600000,
        reservationFee: 20000,
        lotType: 'Prime',
        viewOrientation: 'Morning Sunrise',
        description: 'Prime ridge parcel',
        bounds: Rect.zero,
      );

      // Gross 20% DP = 2,600,000 * 0.20 = 520,000
      expect(lot.downPayment20, 520000.0);
      expect(lot.formattedDownPayment20, '₱520,000');

      // Net DP after deducting 20,000 reservation fee = 500,000
      expect(lot.netDownPayment20, 500000.0);
      expect(lot.formattedNetDownPayment20, '₱500,000');

      // Monthly DP over 24 months = 500,000 / 24 = 20,833.33 / mo
      expect(lot.monthly24Mo, closeTo(20833.33, 0.01));
      expect(lot.formattedMonthly24Mo, '₱20,833 / mo');

      // 80% Balance = 2,080,000
      expect(lot.bankBalance80, 2080000.0);
      expect(lot.formattedBankBalance80, '₱2,080,000');

      // 15-Yr Bank Loan @ 7.5% p.a.
      expect(lot.monthlyBankEst15Yr, closeTo(19281.86, 0.02));
      expect(lot.formattedMonthlyBankEst15Yr, '₱19,282 / mo');

      // 10-Yr Bank Loan @ 7.5% p.a.
      expect(lot.monthlyBankEst10Yr, closeTo(24689.97, 0.02));
      expect(lot.formattedMonthlyBankEst10Yr, '₱24,690 / mo');
    });

    testWidgets('QuickAmortizationModal renders MVLC 24-month DP and 15-Yr Bank Loan', (tester) async {
      tester.view.physicalSize = const Size(1600, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const lot = MapLotModel(
        id: 'test_lot',
        block: 5,
        lot: 12,
        phase: 'Phase 2',
        status: MapLotStatus.available,
        sizeSqm: 196,
        pricePerSqm: 13000,
        totalPrice: 2548000,
        reservationFee: 20000,
        lotType: 'Prime',
        viewOrientation: 'Morning Sunrise',
        description: 'Prime ridge parcel',
        bounds: Rect.zero,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: QuickAmortizationModal(lot: lot),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Quick Amortization'), findsOneWidget);
      expect(find.text('₱2,548,000'), findsWidgets);
      expect(find.text('₱20,000'), findsWidgets);
      // Check that payment schemes are identical to computation page options
      expect(find.text('Cash'), findsOneWidget);
      expect(find.text('50% Spot DP'), findsOneWidget);
      expect(find.text('30% Spot DP'), findsOneWidget);
      expect(find.text('20% Spot DP'), findsOneWidget);
      expect(find.text('0% Spot DP'), findsOneWidget);
      // Default payment option on quick amortization is Cash (40% OFF TCP)
      expect(find.text('Net Spot Cash Due (30 Days)'), findsOneWidget);
      expect(find.text('₱1,508,800'), findsOneWidget);

      // Switch to 20% Spot DP option
      await tester.tap(find.widgetWithText(ChoiceChip, '20% Spot DP'), warnIfMissed: false);
      await tester.pumpAndSettle();

      // 80% Balance over 60 mos @ 0% interest = 2,038,400 / 60 = 33,973 / mo
      expect(find.text('₱33,973 / mo'), findsOneWidget);
    });

    testWidgets('ComputationPage lot and payment scheme are synchronized when initialSchemeCode is passed',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const lot = MapLotModel(
        id: 'test_lot',
        block: 5,
        lot: 12,
        phase: 'Phase 2',
        status: MapLotStatus.available,
        sizeSqm: 200,
        pricePerSqm: 13000,
        totalPrice: 2600000,
        reservationFee: 20000,
        lotType: 'Prime',
        viewOrientation: 'Morning Sunrise',
        description: 'Prime ridge parcel',
        bounds: Rect.zero,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              lot: lot,
              initialSchemeCode: 'SPOT_DP_50',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Ensure 50% Spot DP is synchronized and selected
      expect(find.text('50% Spot DP'), findsWidgets);
      // MVLC Phase 2 Prime: 11,460/sqm * 200 = 2,292,000. Balance 50%: 1,146,000 / 60 = 19,100 / mo
      expect(find.text('₱19,100 / mo'), findsWidgets);
    });

    testWidgets('ComputationPage opened with lot from sales map brings block/lot as selected lot and defaults to Cash',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      const lot = MapLotModel(
        id: 'test_lot',
        block: 8,
        lot: 19,
        phase: 'Phase 2',
        status: MapLotStatus.available,
        sizeSqm: 200,
        pricePerSqm: 13000,
        totalPrice: 2600000,
        reservationFee: 20000,
        lotType: 'Prime',
        viewOrientation: 'Morning Sunrise',
        description: 'Prime ridge parcel',
        bounds: Rect.zero,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              lot: lot,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Block and lot should be selected in the lot selection card
      expect(find.textContaining('Block 8 • Lot 19'), findsWidgets);
      // Payment scheme defaults to Cash
      expect(find.text('Cash'), findsWidgets);
      expect(find.text('PRICE COMPUTATION SUMMARY'), findsOneWidget);
      expect(find.text('TCP AFTER DISCOUNT'), findsOneWidget);
      expect(find.textContaining('40% Off'), findsWidgets);
    });

    testWidgets('project selection does not duplicate projects even if duplicate entries exist in initial list',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              initialProjects: [
                ProjectModel(
                  id: '1',
                  code: 'MVLC',
                  name: 'MVLC',
                ),
                ProjectModel(
                  id: '14',
                  code: 'MVLC',
                  name: 'MVLC',
                ),
                ProjectModel(
                  id: '2',
                  code: 'ERHD',
                  name: 'ERHD',
                ),
                ProjectModel(
                  id: '15',
                  code: 'ERHD',
                  name: 'ERHD',
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open project picker
      await tester.tap(find.text('Select Project...'));
      await tester.pumpAndSettle();

      // Ensure MVLC and ERHD appear exactly once in the picker
      expect(find.text('MVLC'), findsOneWidget);
      expect(find.text('ERHD'), findsOneWidget);

      // Tap on MVLC to select it
      await tester.tap(find.text('MVLC'));
      await tester.pumpAndSettle();

      // MVLC is selected in the card
      expect(find.text('MVLC'), findsOneWidget);

      // Re-open project picker to ensure selected project is not duplicated
      await tester.tap(find.text('MVLC'));
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.text('MVLC'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BottomSheet),
          matching: find.text('ERHD'),
        ),
        findsOneWidget,
      );
    });

    test('isProjectEligibleForCalculator excludes EBLF, GLS, and MSCC and includes MVLC and ERHD', () {
      // Excluded projects
      expect(ComputationService.isProjectEligibleForCalculator('EBLF', 'Eastwest Breeze Leisure Farm'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('eblf', ''), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator(null, 'Eastwest Breeze'), isFalse);

      expect(ComputationService.isProjectEligibleForCalculator('GLS', 'Green Landscape Sanctuary'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('gls', ''), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator(null, 'Green Landscape Sanctuary'), isFalse);

      expect(ComputationService.isProjectEligibleForCalculator('MSCC', 'Mountain Suites Country Club'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('mscc', ''), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator(null, 'Mountain Suites'), isFalse);

      // Eligible projects
      expect(ComputationService.isProjectEligibleForCalculator('MVLC', 'Mountain View Leisure Community'), isTrue);
      expect(ComputationService.isProjectEligibleForCalculator('ERHD', 'Eastwest Resort Hub and Development'), isTrue);
    });

    testWidgets('calculator excludes EBLF, GLS, and MSCC from project selection modal', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              initialProjects: [
                ProjectModel(id: '1', code: 'MVLC', name: 'Mountain View Leisure Community'),
                ProjectModel(id: '2', code: 'ERHD', name: 'Eastwest Resort Hub and Development'),
                ProjectModel(id: '3', code: 'MSCC', name: 'Mountain Suites Country Club'),
                ProjectModel(id: '4', code: 'EBLF', name: 'Eastwest Breeze Leisure Farm'),
                ProjectModel(id: '5', code: 'GLS', name: 'Green Landscape Sanctuary'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open project picker
      await tester.tap(find.text('Select Project...'));
      await tester.pumpAndSettle();

      // MVLC and ERHD should be present
      expect(find.text('Mountain View Leisure Community'), findsOneWidget);
      expect(find.text('Eastwest Resort Hub and Development'), findsOneWidget);

      // MSCC, EBLF, GLS should NOT be present in the calculator's project selector
      expect(find.text('Mountain Suites Country Club'), findsNothing);
      expect(find.text('MSCC'), findsNothing);
      expect(find.text('Eastwest Breeze Leisure Farm'), findsNothing);
      expect(find.text('EBLF'), findsNothing);
      expect(find.text('Green Landscape Sanctuary'), findsNothing);
      expect(find.text('GLS'), findsNothing);
    });

    test('MVLC lot details and inventory lots use asset/mvlc.jpg as their image', () {
      // Inventory lot model
      const inventoryLot = LotModel(
        id: 101,
        lotNo: 'B2 L5',
        sizeSqm: 200,
        pricePerSqm: 11460,
        total: 2292000,
        category: 'Regular',
        phase: 2,
        status: 'available',
        project: 'MVLC',
      );
      expect(inventoryLot.isMvlc, isTrue);
      expect(inventoryLot.imageUrl, 'asset/mvlc.jpg');

      // Sales map lot model
      const mapLot = MapLotModel(
        id: 'B2_L5',
        block: 2,
        lot: 5,
        phase: 'Phase 2',
        status: MapLotStatus.available,
        sizeSqm: 200,
        pricePerSqm: 11460,
        totalPrice: 2292000,
        lotType: 'Regular',
        viewOrientation: 'Morning Sunrise',
        description: 'MVLC parcel',
        bounds: Rect.zero,
      );
      expect(mapLot.isMvlc, isTrue);
      expect(mapLot.imageUrl, 'asset/mvlc.jpg');

      // Featured development card uses asset/mvlc.jpg
      expect(FeaturedDevelopmentCard.imageUrl, 'asset/mvlc.jpg');

      // ERHD lot model should not be treated as MVLC
      const erhdLot = LotModel(
        id: 102,
        lotNo: 'B1 L1',
        sizeSqm: 700,
        pricePerSqm: 12000,
        total: 8400000,
        category: 'Regular',
        status: 'available',
        project: 'ERHD',
      );
      expect(erhdLot.isMvlc, isFalse);
      expect(erhdLot.isErhd, isTrue);
      expect(erhdLot.imageUrl, 'asset/erhd.jpeg');

      // MSCC lot model should use asset/mscc.jpg
      const msccLot = LotModel(
        id: 201,
        lotNo: 'Unit 301',
        sizeSqm: 50,
        pricePerSqm: 180000,
        total: 9000000,
        category: 'Condo Suite',
        status: 'available',
        project: 'MSCC',
      );
      expect(msccLot.isMvlc, isFalse);
      expect(msccLot.isMscc, isTrue);
      expect(msccLot.imageUrl, 'asset/mscc.jpg');

      const msccMapLot = MapLotModel(
        id: 'U301',
        block: 0,
        lot: 301,
        phase: 'MSCC Suite',
        status: MapLotStatus.available,
        sizeSqm: 50,
        pricePerSqm: 180000,
        totalPrice: 9000000,
        lotType: 'Condo Suite',
        viewOrientation: 'Mountain View',
        description: 'MSCC Luxury Unit',
        bounds: Rect.zero,
      );
      expect(msccMapLot.isMscc, isTrue);
      expect(msccMapLot.imageUrl, 'asset/mscc.jpg');
    });

    test('ERHD lots deserialized from erhd_lots table retain ERHD project and do not mix with MVLC', () {
      final json = {
        'id': 1,
        'lot_no': 'B1 L1',
        'size_sqm': 700,
        'price_per_sqm': 12000,
        'total': 8400000,
        'category': 'Regular',
        'status': 'available',
        'project': 'ERHD',
      };
      final lot = LotModel.fromJson(json);
      expect(lot.project, equals('ERHD'));
      expect(lot.isMvlc, isFalse);
      expect(lot.lotNo, equals('B1 L1'));
      expect(lot.sizeSqm, equals(700));
      expect(lot.pricePerSqm, equals(12000));
      expect(lot.total, equals(8400000));
    });

    testWidgets('Instant Reserve button on ComputationPage renders with primaryContainer style', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ComputationPage(
              lotModel: LotModel(
                id: 1,
                lotNo: 'B1 L1',
                sizeSqm: 200,
                pricePerSqm: 10000,
                total: 2000000,
                category: 'Regular',
                status: 'available',
                phase: 2,
              ),
              initialProjects: [
                ProjectModel(id: '1', code: 'MVLC', name: 'Mountain View Leisure Community'),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final reserveBtnFinder = find.widgetWithText(ElevatedButton, 'Instant Reserve');
      expect(reserveBtnFinder, findsOneWidget);

      final elevatedBtn = tester.widget<ElevatedButton>(reserveBtnFinder);
      expect(elevatedBtn.style?.backgroundColor?.resolve({}), AppColors.primaryContainer);
      expect(elevatedBtn.style?.foregroundColor?.resolve({}), AppColors.onPrimary);
    });
  });
}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _TestHttpClient();
  }
}

class _TestHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _TestHttpClientRequest();
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _TestHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _TestHttpClientResponse();
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _TestHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([
      [
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
        0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
        0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
        0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
        0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
        0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
      ]
    ]).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}
