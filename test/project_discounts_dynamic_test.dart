import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/computation/models/project_discount_model.dart';
import 'package:vhbc_broker_app/features/computation/services/computation_service.dart';

void main() {
  group('ProjectDiscountModel Tests', () {
    test('JSON serialization & deserialization', () {
      final json = {
        'project_code': '*',
        'option': 'cash',
        'discount': 50,
        'interest': 0,
        'updated_at': '2026-03-09T08:58:36.568289+00:00',
        'user_id': null,
      };

      final model = ProjectDiscountModel.fromJson(json);
      expect(model.projectCode, '*');
      expect(model.option, 'cash');
      expect(model.discount, 50.0);
      expect(model.interest, 0.0);
      expect(model.updatedAt, isNotNull);

      final backToJson = model.toJson();
      expect(backToJson['project_code'], '*');
      expect(backToJson['option'], 'cash');
      expect(backToJson['discount'], 50.0);
      expect(backToJson['interest'], 0.0);
    });
  });

  group('Dynamic Project Discounts in ComputationService', () {
    test('Resolves dynamic 50% cash discount from project_discounts', () {
      final dynamicDiscounts = [
        const ProjectDiscountModel(
          projectCode: '*',
          option: 'cash',
          discount: 50.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: '*',
          option: '50',
          discount: 30.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: '*',
          option: '30',
          discount: 20.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: '*',
          option: '20',
          discount: 10.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: '*',
          option: '0',
          discount: 0.0,
          interest: 0.0,
        ),
      ];

      final schemes = ComputationService.getPaymentSchemesForProject(
        'MVLC',
        discounts: dynamicDiscounts,
      );

      final cashScheme = schemes.firstWhere((s) => s.schemeCode == 'CASH_100');
      expect(cashScheme.discountPercentage, 50.0);
      expect(cashScheme.badgeText, '50% OFF TCP');
      expect(cashScheme.description, contains('50% Discount'));

      // Calculate with 50% discount
      final result = ComputationService.calculate(
        projectName: 'Mountain View Leisure Community',
        projectCode: 'MVLC',
        blockNumber: '1',
        lotNumber: '1',
        lotSize: 200,
        lotType: 'Regular Residential',
        pricePerSqm: 10000,
        scheme: cashScheme,
      );

      // Original TCP: 200 * 10,000 = 2,000,000
      expect(result.originalTCP, 2000000.0);
      // 50% Discount on TCP: 1,000,000
      expect(result.discountAmount, 1000000.0);
      expect(result.tcpAfterDiscount, 1000000.0);
      expect(result.discountedDownPayment, 1000000.0);
      expect(result.balance, 0.0);
    });

    test('Project-specific override takes precedence over wildcard *', () {
      final customDiscounts = [
        const ProjectDiscountModel(
          projectCode: '*',
          option: 'cash',
          discount: 40.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: 'ERHD',
          option: 'cash',
          discount: 45.0,
          interest: 0.0,
        ),
        const ProjectDiscountModel(
          projectCode: 'MVLC',
          option: 'cash',
          discount: 50.0,
          interest: 0.0,
        ),
      ];

      final erhdSchemes = ComputationService.getPaymentSchemesForProject(
        'ERHD',
        discounts: customDiscounts,
      );
      final mvlcSchemes = ComputationService.getPaymentSchemesForProject(
        'MVLC',
        discounts: customDiscounts,
      );
      final otherSchemes = ComputationService.getPaymentSchemesForProject(
        'EWBLF',
        discounts: customDiscounts,
      );

      expect(
        erhdSchemes.firstWhere((s) => s.schemeCode == 'CASH_100').discountPercentage,
        45.0,
      );
      expect(
        mvlcSchemes.firstWhere((s) => s.schemeCode == 'CASH_100').discountPercentage,
        50.0,
      );
      expect(
        otherSchemes.firstWhere((s) => s.schemeCode == 'CASH_100').discountPercentage,
        40.0,
      );
    });

    test('Reads from SupabaseService.cachedProjectDiscounts when no explicit discounts passed', () {
      SupabaseService.setMockData(
        projectDiscounts: [
          const ProjectDiscountModel(
            projectCode: '*',
            option: 'cash',
            discount: 55.0,
            interest: 0.0,
          ),
          const ProjectDiscountModel(
            projectCode: '*',
            option: '50',
            discount: 35.0,
            interest: 0.0,
          ),
        ],
      );

      final schemes = ComputationService.getPaymentSchemesForProject('MVLC');
      final cashScheme = schemes.firstWhere((s) => s.schemeCode == 'CASH_100');
      final spot50Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_50');

      expect(cashScheme.discountPercentage, 55.0);
      expect(cashScheme.badgeText, '55% OFF TCP');
      expect(spot50Scheme.discountPercentage, 35.0);
      expect(spot50Scheme.badgeText, '35% OFF DP • 0% INT');

      // Clear mock
      SupabaseService.clearCache();
    });

    test('Fallback to defaults when discounts list is empty', () {
      SupabaseService.clearCache();

      final schemes = ComputationService.getPaymentSchemesForProject(
        'MVLC',
        discounts: const [],
      );

      final cashScheme = schemes.firstWhere((s) => s.schemeCode == 'CASH_100');
      final spot50Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_50');
      final spot30Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_30');
      final spot20Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_20');
      final spot0Scheme = schemes.firstWhere((s) => s.schemeCode == 'SPOT_DP_0');

      expect(cashScheme.discountPercentage, 40.0);
      expect(spot50Scheme.discountPercentage, 30.0);
      expect(spot30Scheme.discountPercentage, 20.0);
      expect(spot20Scheme.discountPercentage, 10.0);
      expect(spot0Scheme.discountPercentage, 0.0);
    });
  });
}
