import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/computation/services/computation_service.dart';
import 'package:vhbc_broker_app/features/inventory/models/lot_model.dart';

void main() {
  group('MSCC Inventory and Unit Representation', () {
    test('SupabaseService routes MSCC to mscc_lots table', () {
      expect(SupabaseService.lotTableForProject('MSCC'), equals('mscc_lots'));
      expect(SupabaseService.lotTableForProject('mscc'), equals('mscc_lots'));
      expect(SupabaseService.lotTableForProject('Mountain Suites Country Club'), equals('mscc_lots'));
      expect(SupabaseService.lotTableForProject('MVLC'), equals('mvlc_lots'));
      expect(SupabaseService.lotTableForProject('ERHD'), equals('erhd_lots'));
    });

    test('LotModel correctly displays Unit terminology for MSCC records', () {
      final msccJson = {
        'id': 101,
        'lot_no': '201',
        'size_sqm': 45.0,
        'price_per_sqm': 110000.0,
        'total': 4950000.0,
        'category': '2_bedroom',
        'phase': 1,
        'status': 'available',
        'unit_type': '2 Bedroom',
        'floor_level': '2nd Floor',
        'project': 'MSCC',
      };

      final lot = LotModel.fromJson(msccJson);

      expect(lot.isMscc, isTrue);
      expect(lot.formattedLotNo, equals('Unit 201'));
      expect(lot.categoryDisplay, equals('2 Bedroom Unit'));
      expect(lot.phaseLocationText, equals('2nd Floor • 2 Bedroom Unit'));
      expect(lot.floorLevel, equals('2nd Floor'));
      expect(lot.unitType, equals('2 Bedroom'));
    });

    test('LotModel correctly falls back to Lot terminology for non-MSCC records', () {
      final mvlcJson = {
        'id': 1,
        'lot_no': 'B2 L15',
        'size_sqm': 240.0,
        'price_per_sqm': 12000.0,
        'total': 2880000.0,
        'category': 'Regular',
        'phase': 2,
        'status': 'available',
        'project': 'MVLC',
      };

      final lot = LotModel.fromJson(mvlcJson);

      expect(lot.isMscc, isFalse);
      expect(lot.formattedLotNo, equals('Block 2 • Lot 15'));
      expect(lot.categoryDisplay, equals('Regular Lot'));
    });

    test('ComputationService provides unit types and pricing for MSCC', () {
      final types = ComputationService.getLotTypesForProject('MSCC');
      expect(types, contains('Studio Unit'));
      expect(types, contains('1 Bedroom Unit'));
      expect(types, contains('2 Bedroom Unit'));
      expect(types, contains('2 Bedroom Deluxe Unit'));
      expect(types, contains('Penthouse Unit'));

      final price = ComputationService.getPricePerSqm(
        projectCode: 'MSCC',
        lotType: '2 Bedroom Unit',
      );
      expect(price, equals(110000.0));
    });
  });

  group('Soon to Rise Projects (LCN, MCVC, RHM, RHN, GLS)', () {
    test('ComputationService excludes soon to rise projects from calculator', () {
      expect(ComputationService.isProjectEligibleForCalculator('GLS', 'Green Landscape Sanctuary'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('LCN', 'Lakeshore Community North'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('MCVC', 'Mini Complete Vacation Community'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('RHM', 'Resort Hub Muños'), isFalse);
      expect(ComputationService.isProjectEligibleForCalculator('RHN', 'Resort Hub Nasugbu'), isFalse);
      // Active projects should remain eligible
      expect(ComputationService.isProjectEligibleForCalculator('MVLC', 'Mountain View Leisure Community'), isTrue);
      expect(ComputationService.isProjectEligibleForCalculator('ERHD', 'Eastwest Resort Hub and Development'), isTrue);
    });
  });
}
