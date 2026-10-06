import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/core/config/supabase_config.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/map/models/map_lot_model.dart';
import 'package:vhbc_broker_app/features/map/models/phase3_annotations_data.dart';

void main() {
  setUpAll(() async {
    SupabaseService.client = SupabaseClient(SupabaseConfig.url, SupabaseConfig.anonKey);
  });

  test('Phase 3 annotations data is correctly populated and hit-testable', () {
    expect(Phase3AnnotationsData.annotations.length, equals(302));

    final firstAnn = Phase3AnnotationsData.annotations.first;
    expect(firstAnn.name, equals('B1 L1'));
    expect(firstAnn.originalImageWidth, equals(6869.0));
    expect(firstAnn.originalImageHeight, equals(5724.0));
    expect(firstAnn.points.length, equals(4));

    // Test hit testing on B1 L1 centroid
    const renderSize = Size(540.0, 480.0);
    final centroid = firstAnn.getCentroid(renderSize);
    final hit = Phase3AnnotationsData.hitTest(centroid, renderSize);

    expect(hit, isNotNull);
    expect(hit!.name, equals('B1 L1'));
  });

  test('Phase 3 lot details fetch and binding to MapLotModel', () async {
    final priceModel = await SupabaseService.fetchMvlcPriceForPhase(3);
    expect(priceModel, isNotNull);
    expect(priceModel!.phase, equals(3));

    // Test B1 L3 in Phase 3 (Commercial, 361 sqm, status sold)
    final lotB1L3 = await SupabaseService.fetchLotByAnnotation('B1 L3', phase: 3);
    expect(lotB1L3, isNotNull);
    expect(lotB1L3!.phase, equals(3));
    expect(lotB1L3.lotNo, equals('B1 L3'));
    expect(lotB1L3.sizeSqm, equals(361.0));

    final annB1L3 = Phase3AnnotationsData.annotations.firstWhere((a) => a.name == 'B1 L3');
    final mapLotB1L3 = MapLotModel.fromLotModelAndAnnotation(
      lot: lotB1L3,
      priceModel: priceModel,
      phaseNumber: 3,
      annotation: annB1L3,
    );

    expect(mapLotB1L3.lot, equals(3));
    expect(mapLotB1L3.block, equals(1));
    expect(mapLotB1L3.sizeSqm, equals(361.0));
    expect(mapLotB1L3.status, equals(MapLotStatus.sold));
    expect(mapLotB1L3.pricePerSqm, greaterThan(0));
    expect(mapLotB1L3.totalPrice, greaterThan(0));
  });
}
