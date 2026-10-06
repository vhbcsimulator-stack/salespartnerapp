import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/home/models/announcement_model.dart';
import 'package:vhbc_broker_app/features/home/models/featured_project_model.dart';
import 'package:vhbc_broker_app/features/home/models/home_portfolio_metrics.dart';
import 'package:vhbc_broker_app/features/home/presentation/home_screen.dart';
import 'package:vhbc_broker_app/features/home/presentation/widgets/featured_development_card.dart';
import 'package:vhbc_broker_app/features/inventory/models/project_model.dart';

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  group('Home Screen Real Data Integration Tests', () {
    test('AnnouncementModel correctly deserializes and formats relative time', () {
      final now = DateTime.now();
      final announcement = AnnouncementModel(
        id: 12,
        title: 'System Notice',
        content: 'Server maintenance tonight',
        createdAt: now.subtract(const Duration(minutes: 5)),
      );

      expect(announcement.id, 12);
      expect(announcement.title, 'System Notice');
      expect(announcement.relativeTime, '5m ago');
    });

    test('HomePortfolioMetrics calculates percentage sold and formatting correctly', () {
      const metrics = HomePortfolioMetrics(
        availableLots: 145,
        reservedLots: 289,
        soldLots: 566,
        totalLots: 1000,
        minPricePerSqm: 9800,
        minTcp: 1176000,
        activeProjectId: 'mvlc',
        activeProjectName: 'MVLC',
      );

      expect(metrics.availableLots, 145);
      expect(metrics.soldLots, 566);
      expect(metrics.totalLots, 1000);
      expect(metrics.soldPercentage, 56.6);
      expect(metrics.formattedMinPricePerSqm, '₱9,800');
      expect(metrics.formattedMinTcp, '₱1.18M');
    });

    test('FeaturedDevelopmentCard binds custom real metrics', () {
      const card = FeaturedDevelopmentCard(
        title: 'MVLC',
        location: 'Nasugbu, Batangas',
        categoryTag: 'Residential & Commercial',
        badgeText: '145 Units Available',
        pricePerSqm: '₱9,800',
        startingTcp: 'TCP ₱1.18M',
      );

      expect(card.title, 'MVLC');
      expect(card.badgeText, '145 Units Available');
      expect(card.pricePerSqm, '₱9,800');
      expect(card.startingTcp, 'TCP ₱1.18M');
      expect(FeaturedDevelopmentCard.imageUrl, 'asset/mvlc.jpg');
    });

    testWidgets('HomeScreen renders with portfolio pulse and featured development', (tester) async {
      SupabaseService.setMockData(
        announcements: [
          AnnouncementModel(
            id: 1,
            title: 'Sample Announcement',
            content: 'Notice details here',
            createdAt: DateTime.now().subtract(const Duration(hours: 1)),
          ),
        ],
        homeMetrics: {
          'all': const HomePortfolioMetrics(
            availableLots: 167,
            reservedLots: 293,
            soldLots: 634,
            totalLots: 1098,
            minPricePerSqm: 9800,
            minTcp: 1176000,
            activeProjectId: 'all',
            activeProjectName: 'All Projects',
          ),
          'mvlc': const HomePortfolioMetrics(
            availableLots: 145,
            reservedLots: 285,
            soldLots: 566,
            totalLots: 1000,
            minPricePerSqm: 9800,
            minTcp: 1176000,
            activeProjectId: 'mvlc',
            activeProjectName: 'MVLC',
          ),
        },
        recentLotUpdates: [
          {
            'id': 1,
            'lot_no': 'B1 L5',
            'phase': 'Phase 1',
            'status': 'reserved',
            'updated_at': DateTime.now().toIso8601String(),
            'project': 'MVLC',
          },
        ],
        projects: const [
          ProjectModel(
            id: '14',
            code: 'MVLC',
            name: 'MVLC',
          ),
          ProjectModel(
            id: '15',
            code: 'ERHD',
            name: 'ERHD',
          ),
        ],
        featuredProjects: const [
          FeaturedProjectModel(
            projectCode: 'MVLC',
            location: 'Nasugbu, Batangas',
            imageUrl: 'asset/mvlc.jpg',
          ),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('VHBC BROKER PORTAL'), findsOneWidget);
      expect(find.text('FEATURED DEVELOPMENT'), findsOneWidget);
      expect(find.text('BROKER TOOLING'), findsOneWidget);
      expect(find.text('LIVE BROKER UPDATES'), findsOneWidget);
    });
  });
}
