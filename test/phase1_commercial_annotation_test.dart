import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/core/config/supabase_config.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/inventory/models/lot_model.dart';
import 'package:vhbc_broker_app/features/map/models/map_lot_model.dart';
import 'package:vhbc_broker_app/features/map/models/phase1_commercial_annotations_data.dart';

void main() {
  setUpAll(() async {
    SupabaseService.client =
        SupabaseClient(SupabaseConfig.url, SupabaseConfig.anonKey);
  });

  test('Phase 1 Commercial annotations data is correctly populated and hit-testable', () {
    expect(Phase1CommercialAnnotationsData.annotations.length, equals(20));

    final firstAnn = Phase1CommercialAnnotationsData.annotations.first;
    expect(firstAnn.name, equals('C L1'));
    expect(firstAnn.originalImageWidth, equals(4961.0));
    expect(firstAnn.originalImageHeight, equals(3508.0));
    expect(firstAnn.points.length, greaterThanOrEqualTo(3));

    // Test hit testing on C L1 centroid
    const renderSize = Size(540.0, 480.0);
    final centroid = firstAnn.getCentroid(renderSize);
    final hit = Phase1CommercialAnnotationsData.hitTest(centroid, renderSize);

    expect(hit, isNotNull);
    expect(hit!.name, equals('C L1'));
  });

  test('Phase 1 Commercial lot numbers are correctly parsed', () {
    final lot1 = Phase1CommercialAnnotationsData.annotations.firstWhere((a) => a.name == 'C L1');
    final lot10 = Phase1CommercialAnnotationsData.annotations.firstWhere((a) => a.name == 'C L10');
    final lot21 = Phase1CommercialAnnotationsData.annotations.firstWhere((a) => a.name == 'C L21');

    expect(lot1.lotNumber, equals('1'));
    expect(lot10.lotNumber, equals('10'));
    expect(lot21.lotNumber, equals('21'));
  });

  test('LotModel.extractCommercialLotNo parses commercial formats into L<number>', () {
    expect(LotModel.extractCommercialLotNo('C L1'), equals('L1'));
    expect(LotModel.extractCommercialLotNo('C L10'), equals('L10'));
    expect(LotModel.extractCommercialLotNo('C L21'), equals('L21'));
    expect(LotModel.extractCommercialLotNo('CL1'), equals('L1'));
    expect(LotModel.extractCommercialLotNo('C 1'), equals('L1'));
    expect(LotModel.extractCommercialLotNo('Commercial Lot 5'), equals('L5'));
    expect(LotModel.extractCommercialLotNo('L1'), equals('L1'));
    expect(LotModel.extractCommercialLotNo('B1 L1'), isNull);
    expect(LotModel.extractCommercialLotNo('Block 27 Lot 1'), isNull);
  });

  test('Phase 1 Commercial inventory is fetched from table lots by querying L1 only', () async {
    // Query lot using annotation name 'C L1' which maps to 'L1' in lots table
    final lotC1 = await SupabaseService.fetchLotByAnnotation('C L1', phase: 1);
    expect(lotC1, isNotNull);
    expect(lotC1!.lotNo, anyOf(equals('L1'), equals('C L1')));
    expect(lotC1.phase, equals(1));
    expect(lotC1.sizeSqm, equals(2587.0));
    expect(lotC1.category, equals('regular'));
    expect(lotC1.isCommercial, isTrue);

    // Test C L10 -> queries L10 from table lots
    final lotC10 = await SupabaseService.fetchLotByAnnotation('C L10', phase: 1);
    expect(lotC10, isNotNull);
    expect(lotC10!.lotNo, anyOf(equals('L10'), equals('C L10')));
    expect(lotC10.phase, equals(1));
    expect(lotC10.sizeSqm, equals(179.0));

    // Test C L21 -> queries L21 from table lots
    final lotC21 = await SupabaseService.fetchLotByAnnotation('C L21', phase: 1);
    expect(lotC21, isNotNull);
    expect(lotC21!.lotNo, anyOf(equals('L21'), equals('C L21')));
    expect(lotC21.phase, equals(1));

    // Test MapLotModel construction with commercial specs
    final ann1 = Phase1CommercialAnnotationsData.annotations.firstWhere((a) => a.name == 'C L1');
    final mapLot = MapLotModel.fromLotModelAndAnnotation(
      lot: lotC1,
      phaseNumber: 1,
      annotation: ann1,
    );
    expect(mapLot.block, equals(0));
    expect(mapLot.lot, equals(1));
    expect(mapLot.reservationFee, equals(20000.0));
    expect(mapLot.phase, equals('Phase 1 Commercial'));
    expect(mapLot.sizeSqm, equals(2587.0));
  });

  test('fetchLots searchQuery finds commercial lots using C L1 alias', () async {
    final results = await SupabaseService.fetchLots(
      phase: 1,
      searchQuery: 'C L1',
      table: 'lots',
    );
    expect(results, isNotEmpty);
    expect(results.any((l) => l.lotNo == 'L1' || l.lotNo == 'C L1'), isTrue);
  });
}
