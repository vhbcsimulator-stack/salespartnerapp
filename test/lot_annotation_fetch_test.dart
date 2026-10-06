import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/core/config/supabase_config.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/inventory/models/lot_model.dart';
import 'package:vhbc_broker_app/features/map/models/map_lot_model.dart';
import 'package:vhbc_broker_app/features/map/models/phase2_annotations_data.dart';

void main() {
  setUpAll(() async {
    SupabaseService.client = SupabaseClient(SupabaseConfig.url, SupabaseConfig.anonKey);
  });

  test('Fetch lot details by annotation name from lots table with phase and lot type price resolution', () async {
    // 1. Fetch phase 2 pricing from mvlc_price table
    final priceModel = await SupabaseService.fetchMvlcPriceForPhase(2);
    expect(priceModel, isNotNull);
    expect(priceModel!.phase, equals(2));
    expect(priceModel.regular, equals(9800.0));
    expect(priceModel.regularCorner, equals(11460.0));
    expect(priceModel.prime, equals(11460.0));
    expect(priceModel.primeCorner, equals(13120.0));

    // 2. Test B27 L1 (Regular Lot in mvlc_lots, 241 sqm in Phase 2)
    final lotB27L1 = await SupabaseService.fetchLotByAnnotation('B27 L1', phase: 2);
    expect(lotB27L1, isNotNull);
    expect(lotB27L1!.lotNo, equals('B27 L1'));
    expect(lotB27L1.phase, equals(2));
    expect(lotB27L1.sizeSqm, equals(241.0));
    expect(lotB27L1.category, equals('regular'));
    expect(lotB27L1.status, equals('reserved'));

    final annB27L1 = Phase2AnnotationsData.annotations.firstWhere((a) => a.name == 'B27 L1');
    final mapLotB27L1 = MapLotModel.fromLotModelAndAnnotation(
      lot: lotB27L1,
      priceModel: priceModel,
      phaseNumber: 2,
      annotation: annB27L1,
    );

    // Price should be resolved from mvlc_price using phase 2 + regular = 9,800
    expect(mapLotB27L1.pricePerSqm, equals(9800.0));
    // Total should be 241 * 9,800 = 2,361,800
    expect(mapLotB27L1.totalPrice, equals(2361800.0));
    expect(mapLotB27L1.sizeSqm, equals(241.0));
    expect(mapLotB27L1.lotType, equals('Regular Lot'));
    expect(mapLotB27L1.status, equals(MapLotStatus.reserved));

    // 3. Test B27 L10 (Regular Lot, 155 sqm in Phase 2)
    final lotB27L10 = await SupabaseService.fetchLotByAnnotation('B27 L10', phase: 2);
    expect(lotB27L10, isNotNull);
    expect(lotB27L10!.sizeSqm, equals(155.0));
    expect(lotB27L10.category, equals('regular'));

    final annB27L10 = Phase2AnnotationsData.annotations.firstWhere((a) => a.name == 'B27 L10');
    final mapLotB27L10 = MapLotModel.fromLotModelAndAnnotation(
      lot: lotB27L10,
      priceModel: priceModel,
      phaseNumber: 2,
      annotation: annB27L10,
    );

    // Price for regular = 9,800
    expect(mapLotB27L10.pricePerSqm, equals(9800.0));
    // Total should be 155 * 9,800 = 1,519,000
    expect(mapLotB27L10.totalPrice, equals(1519000.0));
    expect(mapLotB27L10.sizeSqm, equals(155.0));
    expect(mapLotB27L10.lotType, equals('Regular Lot'));

    // 4. Test B31 L3 (Prime Lot, 143 sqm in Phase 2)
    final lotB31L3 = await SupabaseService.fetchLotByAnnotation('B31 L3', phase: 2);
    expect(lotB31L3, isNotNull);
    expect(lotB31L3!.category, equals('prime'));

    final annB31L3 = Phase2AnnotationsData.annotations.firstWhere((a) => a.name == 'B31 L3');
    final mapLotB31L3 = MapLotModel.fromLotModelAndAnnotation(
      lot: lotB31L3,
      priceModel: priceModel,
      phaseNumber: 2,
      annotation: annB31L3,
    );

    // Price for prime = 11,460
    expect(mapLotB31L3.pricePerSqm, equals(11460.0));
    // Total should be 143 * 11,460 = 1,638,780
    expect(mapLotB31L3.totalPrice, equals(1638780.0));
    expect(mapLotB31L3.sizeSqm, equals(143.0));
    expect(mapLotB31L3.lotType, equals('Prime Residential Lot'));
    expect(mapLotB31L3.status, equals(MapLotStatus.available));

    // 5. Test B1 L1 (Commercial Lot, 300 sqm in Phase 2 in mvlc_lots)
    final lotB1L1 = await SupabaseService.fetchLotByAnnotation('B1 L1', phase: 2);
    expect(lotB1L1, isNotNull);
    expect(lotB1L1!.category, equals('commercial'));

    final annB1L1 = Phase2AnnotationsData.annotations.firstWhere((a) => a.name == 'B1 L1');
    final mapLotB1L1 = MapLotModel.fromLotModelAndAnnotation(
      lot: lotB1L1,
      priceModel: priceModel,
      phaseNumber: 2,
      annotation: annB1L1,
    );

    // Price for commercial falls back to regular (9,800) in Phase 2
    expect(mapLotB1L1.pricePerSqm, equals(9800.0));
    // Total should be 300 * 9,800 = 2,940,000
    expect(mapLotB1L1.totalPrice, equals(2940000.0));
    expect(mapLotB1L1.lotType, equals('Commercial Lot'));

    // 6. Test missing 'L' quirk in Roboflow ("B24 10" -> "B24 L10")
    final lotB2410 = await SupabaseService.fetchLotByAnnotation('B24 10', phase: 2);
    expect(lotB2410, isNotNull);
    expect(lotB2410!.lotNo, equals('B24 L10'));
  });

  test('Hold lot status displays as HOLD and does not use model villa', () {
    const holdLot = LotModel(
      id: 9999,
      lotNo: 'B99 L99',
      sizeSqm: 200.0,
      pricePerSqm: 10000.0,
      total: 2000000.0,
      category: 'regular',
      phase: 2,
      status: 'hold',
    );
    expect(holdLot.isHold, isTrue);
    expect(holdLot.statusBadgeText, equals('HOLD'));

    final mapHoldLot = MapLotModel.fromLotModelAndAnnotation(
      lot: holdLot,
      phaseNumber: 2,
    );
    expect(mapHoldLot.status, equals(MapLotStatus.hold));
    expect(mapHoldLot.badgeText, equals('HOLD'));
  });
}
