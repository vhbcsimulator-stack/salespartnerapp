import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/map/models/phase1_annotations_data.dart';

void main() {
  test('Phase 1 annotations data is correctly populated and hit-testable', () {
    expect(Phase1AnnotationsData.annotations.length, equals(433));

    final firstAnn = Phase1AnnotationsData.annotations.first;
    expect(firstAnn.name, equals('B1 L1'));
    expect(firstAnn.originalImageWidth, equals(7073.0));
    expect(firstAnn.originalImageHeight, equals(8851.0));
    expect(firstAnn.points.length, greaterThanOrEqualTo(3));

    // Test hit testing on B1 L1 centroid
    const renderSize = Size(540.0, 480.0);
    final centroid = firstAnn.getCentroid(renderSize);
    final hit = Phase1AnnotationsData.hitTest(centroid, renderSize);

    expect(hit, isNotNull);
    expect(hit!.name, equals('B1 L1'));
  });

  test('Phase 1 contains annotations across various blocks', () {
    final block1Lot1 = Phase1AnnotationsData.annotations.firstWhere((a) => a.name == 'B1 L1');
    final block19Lot1 = Phase1AnnotationsData.annotations.firstWhere((a) => a.name == 'B19 L1');

    expect(block1Lot1.blockNumber, equals('1'));
    expect(block1Lot1.lotNumber, equals('1'));

    expect(block19Lot1.blockNumber, equals('19'));
    expect(block19Lot1.lotNumber, equals('1'));
  });
}
