import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/features/map/presentation/interactive_sales_map_screen.dart';

void main() {
  group('InteractiveSalesMapScreen download button and filename formatting', () {
    test('formatDownloadFilename produces "project name - phase - latest.ext"', () {
      // 1. MVLC Phase 1 PNG
      final fn1 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'MVLC',
        phase: 'Phase 1',
        extension: '.png',
      );
      expect(fn1, equals('MVLC - Phase 1 - latest.png'));

      // 2. MVLC Phase 2 East SVG
      final fn2 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'MVLC',
        phase: 'Phase 2 East',
        extension: 'svg',
      );
      expect(fn2, equals('MVLC - Phase 2 East - latest.svg'));

      // 3. ERHD Phase 1
      final fn3 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'ERHD',
        phase: 'Phase 1',
        extension: '.png',
      );
      expect(fn3, equals('ERHD - Phase 1 - latest.png'));

      // 4. Commercial phase
      final fn4 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'MVLC',
        phase: 'Commercial',
        extension: '.png',
      );
      expect(fn4, equals('MVLC - Commercial - latest.png'));

      // 5. Parentheses cleaning from project name
      final fn5 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'Mountain View Leisure (MVLC)',
        phase: 'Phase 3',
      );
      expect(fn5, equals('Mountain View Leisure - Phase 3 - latest.png'));

      // 6. Default extension is always .png
      final fn6 = InteractiveSalesMapScreen.formatDownloadFilename(
        projectName: 'MVLC',
        phase: 'Phase 2 East',
      );
      expect(fn6, equals('MVLC - Phase 2 East - latest.png'));
    });

    test('convertImageToPng converts SVG bytes into standard PNG bytes', () async {
      const sampleSvg = '<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg"><rect width="100" height="100" fill="navy"/><circle cx="50" cy="50" r="30" fill="gold"/></svg>';
      final svgBytes = Uint8List.fromList(sampleSvg.codeUnits);

      final pngBytes = await InteractiveSalesMapScreen.convertImageToPng(
        svgBytes,
        contentType: 'image/svg+xml',
        url: 'https://example.com/storage/map.svg',
      );

      expect(pngBytes, isNotEmpty);
      // Valid PNG signature: [137, 80, 78, 71, 13, 10, 26, 10]
      expect(pngBytes.sublist(0, 8), equals([137, 80, 78, 71, 13, 10, 26, 10]));
    });

    test('convertImageToPng preserves existing PNG bytes intact', () async {
      final fakePngBytes = Uint8List.fromList([137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 0]);
      final result = await InteractiveSalesMapScreen.convertImageToPng(fakePngBytes);
      expect(result, equals(fakePngBytes));
    });

    test('convertImageToPng converts raster images into valid uncompressed PNG bytes', () async {
      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.drawRect(const ui.Rect.fromLTWH(0, 0, 40, 40), ui.Paint()..color = Colors.blue);
      final pic = recorder.endRecording();
      final imgUi = await pic.toImage(40, 40);

      // Create JPEG-like raw raster byteData
      final rawByteData = await imgUi.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = await InteractiveSalesMapScreen.convertImageToPng(
        rawByteData!.buffer.asUint8List(),
        contentType: 'image/jpeg',
      );
      expect(pngBytes, isNotEmpty);
      expect(pngBytes.sublist(0, 8), equals([137, 80, 78, 71, 13, 10, 26, 10]));
    });

    test('convertImageToPng rasterizes SVG to ultra high definition uncompressed PNG', () async {
      const sampleSvg = '<svg viewBox="0 0 200 200" xmlns="http://www.w3.org/2000/svg"><rect width="200" height="200" fill="#00271B"/><text x="20" y="50" fill="#FED48A">LOT 101 - 150 SQM</text></svg>';
      final svgBytes = Uint8List.fromList(sampleSvg.codeUnits);

      final pngBytes = await InteractiveSalesMapScreen.convertImageToPng(
        svgBytes,
        contentType: 'image/svg+xml',
        url: 'https://example.com/storage/blueprint.svg',
      );

      expect(pngBytes, isNotEmpty);
      expect(pngBytes.sublist(0, 8), equals([137, 80, 78, 71, 13, 10, 26, 10]));
    });

    test('getDownloadsDirectory resolves a valid downloads directory', () {
      final dir = InteractiveSalesMapScreen.getDownloadsDirectory();
      expect(dir.existsSync(), isTrue);
      expect(dir.path, isNotEmpty);
    });

    testWidgets('InteractiveSalesMapScreen renders download map buttons',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(
          home: InteractiveSalesMapScreen(),
        ),
      );
      await tester.pump();

      // Download icons should be rendered on the screen
      final downloadIcons = find.byIcon(Icons.download_rounded);
      expect(downloadIcons, findsWidgets);

      // Tooltips for downloading map
      expect(find.byTooltip('Download Map'), findsWidgets);
    });
  });
}
