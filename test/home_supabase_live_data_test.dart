import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/core/config/supabase_config.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';

// ignore_for_file: avoid_print
void main() {
  setUpAll(() {
    SupabaseService.client = SupabaseClient(SupabaseConfig.url, SupabaseConfig.anonKey);
    SupabaseService.clearCache();
  });

  test('Live fetch: home portfolio metrics strictly from price tables & projects table', () async {
    SupabaseService.clearCache();
    final mvlcAllLots = await SupabaseService.fetchLots(table: 'mvlc_lots', limit: 3000, forceRefresh: true);
    final erhdAllLots = await SupabaseService.fetchLots(table: 'erhd_lots', limit: 3000, forceRefresh: true);
    expect(mvlcAllLots.length, 1751);
    expect(erhdAllLots.length, 99);

    final allProjects = await SupabaseService.fetchProjects();
    expect(allProjects, isNotEmpty);

    final allMetrics = await SupabaseService.fetchHomePortfolioMetrics(project: 'all', forceRefresh: true);
    expect(allMetrics.totalLots, 1850);
    expect(allMetrics.availableLots, 287);
    expect(allMetrics.reservedLots, 518);
    expect(allMetrics.soldLots, 1045);
    expect(allMetrics.minPricePerSqm, 9800.0); // strictly lowest across price tables

    final mvlcMetrics = await SupabaseService.fetchHomePortfolioMetrics(project: 'mvlc', forceRefresh: true);
    expect(mvlcMetrics.totalLots, 1751);
    expect(mvlcMetrics.availableLots, 265);
    expect(mvlcMetrics.reservedLots, 509);
    expect(mvlcMetrics.soldLots, 977);
    expect(mvlcMetrics.activeProjectName, 'MVLC'); // strictly from projects table, not invented
    expect(mvlcMetrics.minPricePerSqm, 9800.0); // strictly from mvlc_price table, not table lots

    final erhdMetrics = await SupabaseService.fetchHomePortfolioMetrics(project: 'erhd', forceRefresh: true);
    expect(erhdMetrics.activeProjectName, 'ERHD'); // strictly from projects table, not invented
    expect(erhdMetrics.minPricePerSqm, 12000.0); // strictly from erhd_price table, not erhd_lots
  });

  test('Live fetch: map lot updates strictly for sold or reserved status', () async {
    SupabaseService.clearCache();
    final updates = await SupabaseService.fetchRecentLotUpdates(limit: 6, forceRefresh: true);
    expect(updates, isNotEmpty);
    for (final u in updates) {
      final status = (u['status'] as String? ?? '').toLowerCase();
      expect(
        ['sold', 'reserved', 'rsv-p', 'hold'].contains(status),
        isTrue,
        reason: 'Status should be sold, reserved, or hold from map',
      );
    }
  });

  test('Live fetch: featured project from featured_projects table', () async {
    SupabaseService.clearCache();
    final featured = await SupabaseService.fetchFeaturedProject(forceRefresh: true);
    expect(featured, isNotNull);
    expect(featured!.projectCode, 'MVLC');
    expect(featured.location, contains('Nasugbu'));
    expect(featured.imageUrl, isNotNull);
  });
}
