import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/map/models/erhd_annotations_data.dart';

void main() {
  test('ERHD annotations data is correctly populated and hit-testable', () {
    expect(ErhdAnnotationsData.annotations.length, equals(94));

    final firstAnn = ErhdAnnotationsData.annotations.first;
    expect(firstAnn.name, equals('B1 L1'));
    expect(firstAnn.originalImageWidth, equals(4961.0));
    expect(firstAnn.originalImageHeight, equals(3508.0));
    expect(firstAnn.points.length, greaterThanOrEqualTo(3));

    // Test hit testing on B1 L1 centroid
    const renderSize = Size(540.0, 480.0);
    final centroid = firstAnn.getCentroid(renderSize);
    final hit = ErhdAnnotationsData.hitTest(centroid, renderSize);

    expect(hit, isNotNull);
    expect(hit!.name, equals('B1 L1'));
  });

  test('ERHD contains annotations across various blocks', () {
    final block1Lot1 = ErhdAnnotationsData.annotations.firstWhere((a) => a.name == 'B1 L1');
    final block10Lot1 = ErhdAnnotationsData.annotations.firstWhere((a) => a.name == 'B10 L1');
    final block11Lot1 = ErhdAnnotationsData.annotations.firstWhere((a) => a.name == 'B11 L1');

    expect(block1Lot1.blockNumber, equals('1'));
    expect(block1Lot1.lotNumber, equals('1'));

    expect(block10Lot1.blockNumber, equals('10'));
    expect(block10Lot1.lotNumber, equals('1'));

    expect(block11Lot1.blockNumber, equals('11'));
    expect(block11Lot1.lotNumber, equals('1'));
  });
}
