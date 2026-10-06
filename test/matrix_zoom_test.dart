import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('InteractiveViewer child center position with Matrix4', (tester) async {
    final controller = TransformationController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: InteractiveViewer(
                transformationController: controller,
                boundaryMargin: const EdgeInsets.all(1000),
                child: Center(
                  child: Container(
                    key: const ValueKey('target'),
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final targetCenterBefore = tester.getCenter(find.byKey(const ValueKey('target')));

    const targetScale = 2.0;
    const vpW = 400.0;
    const vpH = 400.0;
    final tx = (vpW / 2) * (1.0 - targetScale);
    final ty = (vpH / 2) * (1.0 - targetScale);

    controller.value = Matrix4.identity()
      ..setTranslationRaw(tx, ty, 0.0)
      ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

    await tester.pumpAndSettle();

    final targetCenterAfter = tester.getCenter(find.byKey(const ValueKey('target')));

    expect(targetCenterAfter.dx, closeTo(targetCenterBefore.dx, 0.01));
    expect(targetCenterAfter.dy, closeTo(targetCenterBefore.dy, 0.01));
  });

  testWidgets('InteractiveViewer arbitrary point centering on canvas', (tester) async {
    final controller = TransformationController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: InteractiveViewer(
                transformationController: controller,
                boundaryMargin: const EdgeInsets.all(1000),
                child: Center(
                  child: Container(
                    key: const ValueKey('canvas'),
                    width: 200,
                    height: 200,
                    color: Colors.blue,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 50,
                          top: 50,
                          child: Container(
                            key: const ValueKey('point'),
                            width: 10,
                            height: 10,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Target point is at (55, 55) in canvas coordinates (center of the 10x10 red box)
    const targetScale = 2.5;
    const vpW = 400.0;
    const vpH = 400.0;
    const canvasW = 200.0;
    const canvasH = 200.0;
    const ptX = 55.0;
    const ptY = 55.0;

    final childX = (vpW - canvasW) / 2 + ptX;
    final childY = (vpH - canvasH) / 2 + ptY;

    final tx = (vpW / 2) - childX * targetScale;
    final ty = (vpH / 2) - childY * targetScale;

    controller.value = Matrix4.identity()
      ..setTranslationRaw(tx, ty, 0.0)
      ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

    await tester.pumpAndSettle();

    final pointCenterAfter = tester.getCenter(find.byKey(const ValueKey('point')));
    final viewportCenter = tester.getCenter(find.byType(InteractiveViewer));

    expect(pointCenterAfter.dx, closeTo(viewportCenter.dx, 0.01));
    expect(pointCenterAfter.dy, closeTo(viewportCenter.dy, 0.01));
  });
}
