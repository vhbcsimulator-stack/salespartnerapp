import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/widgets/app_image.dart';

void main() {
  group('AppImage SVG detection', () {
    test('isSvg correctly identifies SVG URLs and file paths', () {
      expect(AppImage.isSvg('https://example.com/map_blueprint.svg'), isTrue);
      expect(AppImage.isSvg('https://example.com/map_blueprint.SVG'), isTrue);
      expect(AppImage.isSvg('https://example.com/plan.svg?token=12345'), isTrue);
      expect(AppImage.isSvg('assets/images/logo.svg'), isTrue);
      expect(AppImage.isSvg('<svg viewBox="0 0 100 100"></svg>'), isTrue);
      expect(AppImage.isSvg('data:image/svg+xml;base64,PHN2Z...'), isTrue);

      expect(AppImage.isSvg('https://example.com/photo.png'), isFalse);
      expect(AppImage.isSvg('https://example.com/photo.jpg'), isFalse);
      expect(AppImage.isSvg('https://example.com/photo.webp'), isFalse);
      expect(AppImage.isSvg(''), isFalse);
      expect(AppImage.isSvg(null), isFalse);
    });

    testWidgets('AppImage renders SvgPicture for SVG string content', (tester) async {
      const svgCode = '<svg viewBox="0 0 100 100"><circle cx="50" cy="50" r="40"/></svg>';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppImage(
              imageUrl: svgCode,
              width: 100,
              height: 100,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('AppImage handles null/empty with fallback gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppImage(
              imageUrl: null,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.image_not_supported_outlined), findsOneWidget);
    });

    testWidgets('AppImage supports disableCache parameter without crashing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppImage(
              imageUrl: '<svg viewBox="0 0 100 100"><rect width="100" height="100"/></svg>',
              disableCache: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SvgPicture), findsOneWidget);
    });

    test('AppImage.clearSvgCache removes items without error', () {
      expect(() => AppImage.clearSvgCache('https://example.com/map.svg'), returnsNormally);
      expect(() => AppImage.clearSvgCache(), returnsNormally);
    });
  });
}
