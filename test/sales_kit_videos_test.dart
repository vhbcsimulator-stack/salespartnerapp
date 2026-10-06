import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/sales_kit/models/youtube_link_model.dart';
import 'package:vhbc_broker_app/features/sales_kit/models/development_photo_model.dart';
import 'package:vhbc_broker_app/features/sales_kit/presentation/in_app_video_player_screen.dart';
import 'package:vhbc_broker_app/features/sales_kit/presentation/sales_kit_videos_screen.dart';
import 'package:vhbc_broker_app/features/sales_kit/presentation/sales_kit_photo_viewer_dialog.dart';
import 'package:vhbc_broker_app/features/sales_kit/services/video_stream_service.dart';

void main() {
  group('YoutubeLinkModel tests', () {
    test('Correctly parses model from json', () {
      final json = {
        'id': 1,
        'created_at': '2025-01-15T08:30:00Z',
        'link': 'https://youtu.be/-4qqgbHjYck',
        'title': 'MVLC Actual Video',
        'project_name': 'MVLC',
      };
      final model = YoutubeLinkModel.fromJson(json);

      expect(model.id, equals(1));
      expect(model.title, equals('MVLC Actual Video'));
      expect(model.projectName, equals('MVLC'));
      expect(model.videoId, equals('-4qqgbHjYck'));
      expect(
        model.thumbnailUrl,
        equals('https://img.youtube.com/vi/-4qqgbHjYck/hqdefault.jpg'),
      );
    });

    test('Extracts video IDs from various YouTube URL variants', () {
      final v1 = YoutubeLinkModel(
        id: 1,
        link: 'https://youtu.be/7VaGzdTTYo0',
        title: 'Overview',
        projectName: 'MVLC',
      );
      expect(v1.videoId, equals('7VaGzdTTYo0'));

      final v2 = YoutubeLinkModel(
        id: 2,
        link: 'https://www.youtube.com/watch?v=AQk0p_XysDM',
        title: 'Walkthrough',
        projectName: 'ERHD',
      );
      expect(v2.videoId, equals('AQk0p_XysDM'));

      final v3 = YoutubeLinkModel(
        id: 3,
        link: 'https://www.youtube.com/embed/xZ3gue0AtyQ',
        title: 'Embed',
        projectName: 'MSCC',
      );
      expect(v3.videoId, equals('xZ3gue0AtyQ'));
    });
  });

  group('SalesKitVideosScreen Widget tests', () {
    final mockActualPhotos = [
      const DevelopmentPhotoModel(
        id: 1,
        imageLink: 'https://example.com/actual_mvlc_1.png',
        projectName: 'MVLC',
        type: DevelopmentPhotoType.actual,
      ),
      const DevelopmentPhotoModel(
        id: 2,
        imageLink: 'https://example.com/actual_erhd_1.png',
        projectName: 'ERHD',
        type: DevelopmentPhotoType.actual,
      ),
    ];

    final mockPerspectives = [
      const DevelopmentPhotoModel(
        id: 10,
        imageLink: 'https://example.com/persp_mvlc_1.png',
        projectName: 'MVLC',
        type: DevelopmentPhotoType.perspective,
      ),
      const DevelopmentPhotoModel(
        id: 11,
        imageLink: 'https://example.com/persp_mscc_1.png',
        projectName: 'MSCC - paused',
        type: DevelopmentPhotoType.perspective,
      ),
    ];

    final mockVideos = [
      const YoutubeLinkModel(
        id: 1,
        link: 'https://youtu.be/-4qqgbHjYck',
        title: 'MVLC Actual Video',
        projectName: 'MVLC',
      ),
      const YoutubeLinkModel(
        id: 2,
        link: 'https://youtu.be/7VaGzdTTYo0',
        title: 'MVLC Project Overview',
        projectName: 'MVLC',
      ),
      const YoutubeLinkModel(
        id: 5,
        link: 'https://youtu.be/i51d0F8M7wI',
        title: 'ERHD Project Overview',
        projectName: 'ERHD',
      ),
      const YoutubeLinkModel(
        id: 7,
        link: 'https://youtu.be/xZ3gue0AtyQ',
        title: 'MSCC Walkthrough',
        projectName: 'MSCC - paused',
      ),
    ];

    setUp(() {
      SupabaseService.setMockData(
        youtubeLinks: mockVideos,
        actualPhotos: mockActualPhotos,
        perspectivePhotos: mockPerspectives,
      );
      VideoStreamService.setMockStream(
        'https://youtu.be/-4qqgbHjYck',
        'https://example.com/mock_stream.mp4',
      );
    });

    testWidgets('Renders screen with tabs and ChoiceChips for project selection',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Check header
      expect(find.text('Sales Kit & Walkthroughs'), findsOneWidget);

      // Check Tabs
      expect(find.text('Actual Photos'), findsOneWidget);
      expect(find.text('Perspectives'), findsOneWidget);
      expect(find.text('Videos'), findsOneWidget);

      // Check ChoiceChips
      expect(find.widgetWithText(ChoiceChip, 'All'), findsOneWidget);
      expect(find.widgetWithText(ChoiceChip, 'MVLC'), findsOneWidget);
      expect(find.widgetWithText(ChoiceChip, 'ERHD'), findsOneWidget);
    });

    testWidgets('Displays actual photos on Actual Photos tab and filters by project',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 0),
        ),
      );
      await tester.pumpAndSettle();

      // Should show project badges for actual photos
      expect(find.text('MVLC'), findsWidgets);
      expect(find.text('ERHD'), findsWidgets);

      // Filter by ERHD
      final erhdChip = find.widgetWithText(ChoiceChip, 'ERHD');
      await tester.tap(erhdChip);
      await tester.pumpAndSettle();

      // ERHD should remain
      expect(find.text('ERHD'), findsWidgets);
    });

    testWidgets('Displays future perspectives on Perspectives tab',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 1),
        ),
      );
      await tester.pumpAndSettle();

      // MSCC normalized project badge should be rendered
      expect(find.text('MSCC'), findsWidgets);
    });

    testWidgets('Tapping choice chip filters video according to project on Videos tab',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 2),
        ),
      );
      await tester.pumpAndSettle();

      // Tap 'ERHD' choice chip
      final erhdChip = find.widgetWithText(ChoiceChip, 'ERHD');
      expect(erhdChip, findsOneWidget);
      await tester.tap(erhdChip);
      await tester.pumpAndSettle();

      // Only ERHD videos should be visible
      expect(find.text('ERHD Project Overview'), findsOneWidget);
      expect(find.text('MVLC Actual Video'), findsNothing);
      expect(find.text('MVLC Project Overview'), findsNothing);
      expect(find.text('MSCC Walkthrough'), findsNothing);
    });

    testWidgets('Tapping "All" choice chip restores all project videos on Videos tab',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 2),
        ),
      );
      await tester.pumpAndSettle();

      // Select MVLC first
      await tester.tap(find.widgetWithText(ChoiceChip, 'MVLC'));
      await tester.pumpAndSettle();

      expect(find.text('MVLC Actual Video'), findsOneWidget);
      expect(find.text('ERHD Project Overview'), findsNothing);

      // Tap All
      await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
      await tester.pumpAndSettle();

      expect(find.text('MVLC Actual Video'), findsOneWidget);
    });

    testWidgets('Has zero YouTube branding and displays Play Walkthrough on Videos tab',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 2),
        ),
      );
      await tester.pumpAndSettle();

      // Check for Play Walkthrough button
      expect(find.text('Play Walkthrough'), findsOneWidget);

      // Verify that no text contains "YouTube" or "youtu.be"
      expect(find.textContaining('YouTube', findRichText: true), findsNothing);
      expect(find.textContaining('youtu.be', findRichText: true), findsNothing);
      expect(find.text('HD Tour'), findsOneWidget);
    });

    testWidgets('Tapping Play Walkthrough navigates to InAppVideoPlayerScreen',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SalesKitVideosScreen(initialTabIndex: 2),
        ),
      );
      await tester.pumpAndSettle();

      final playButtons = find.text('Play Walkthrough');
      expect(playButtons, findsWidgets);
      await tester.ensureVisible(playButtons.first);
      await tester.pumpAndSettle();

      await tester.tap(playButtons.first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // Should have pushed InAppVideoPlayerScreen
      expect(find.byType(InAppVideoPlayerScreen), findsOneWidget);
    });

    testWidgets('InAppVideoPlayerScreen renders fullscreen toggle icon',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: InAppVideoPlayerScreen(
            video: mockVideos.first,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(InAppVideoPlayerScreen), findsOneWidget);
      expect(find.byIcon(Icons.fullscreen_rounded), findsOneWidget);
    });
  });

  group('SalesKitPhotoViewerDialog tests', () {
    const testPhoto = DevelopmentPhotoModel(
      id: 99,
      imageLink: 'https://example.com/test_actual.jpg',
      projectName: 'MVLC',
      type: DevelopmentPhotoType.actual,
    );

    testWidgets('Renders Download button and does not contain Copy Link button',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SalesKitPhotoViewerDialog(photo: testPhoto),
          ),
        ),
      );
      await tester.pump();

      // Ensure 'Copy Link' is completely removed
      expect(find.text('Copy Link'), findsNothing);

      // Ensure 'Download' button is rendered with download icon
      expect(find.text('Download'), findsOneWidget);
      expect(find.byIcon(Icons.download_rounded), findsOneWidget);
      expect(find.text('MVLC'), findsOneWidget);
      expect(find.text('Actual Site Photo'), findsOneWidget);
    });
  });
}
