// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/core/config/supabase_config.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';

void main() {
  setUpAll(() async {
    SupabaseService.client =
        SupabaseClient(SupabaseConfig.url, SupabaseConfig.anonKey);
    SupabaseService.clearCache();
  });

  test('Inspect Phase and map_section distribution in mvlc_lots', () async {
    final allLots = await SupabaseService.fetchLots(table: 'mvlc_lots', limit: 2000, forceRefresh: true);
    final distribution = <String, int>{};
    for (final l in allLots) {
      final key = 'Phase ${l.phase} [section: ${l.mapSection}]';
      distribution[key] = (distribution[key] ?? 0) + 1;
    }
    for (final entry in distribution.entries) {
      print('${entry.key}: ${entry.value} lots');
    }
  });

  test('lotTableForProject returns mvlc_lots for MVLC and erhd_lots for ERHD', () {
    expect(SupabaseService.lotTableForProject('MVLC'), equals('mvlc_lots'));
    expect(SupabaseService.lotTableForProject('mvlc'), equals('mvlc_lots'));
    expect(SupabaseService.lotTableForProject('Mountain View Leisure Community'), equals('mvlc_lots'));
    expect(SupabaseService.lotTableForProject(null), equals('mvlc_lots'));
    expect(SupabaseService.lotTableForProject('ERHD'), equals('erhd_lots'));
    expect(SupabaseService.lotTableForProject('erhd'), equals('erhd_lots'));
  });

  test('fetchLots from mvlc_lots table directly and via default parameter', () async {
    SupabaseService.clearCache();

    // 1. Direct fetch with explicit table: 'mvlc_lots'
    final lotsExplicit = await SupabaseService.fetchLots(
      table: 'mvlc_lots',
      limit: 10,
      forceRefresh: true,
    );
    expect(lotsExplicit, isNotEmpty);
    expect(lotsExplicit.first.project, equals('MVLC'));

    // 2. Fetch using default table parameter (now mvlc_lots)
    final lotsDefault = await SupabaseService.fetchLots(
      limit: 10,
      forceRefresh: true,
    );
    expect(lotsDefault, isNotEmpty);
    expect(lotsDefault.first.project, equals('MVLC'));

    // 3. Fetch passing legacy 'lots' redirects cleanly to mvlc_lots
    final lotsLegacy = await SupabaseService.fetchLots(
      table: 'lots',
      limit: 10,
      forceRefresh: true,
    );
    expect(lotsLegacy, isNotEmpty);
    expect(lotsLegacy.first.project, equals('MVLC'));
  });

  test('fetchLotsSummary uses mvlc_lots', () async {
    SupabaseService.clearCache();
    final summary = await SupabaseService.fetchLotsSummary(table: 'mvlc_lots', forceRefresh: true);
    expect(summary['total'], greaterThan(0));
    expect(summary['available'], isNotNull);
    expect(summary['reserved'], isNotNull);
    expect(summary['sold'], isNotNull);
  });

  test('fetchLotByAnnotation queries mvlc_lots table', () async {
    SupabaseService.clearCache();
    final lot = await SupabaseService.fetchLotByAnnotation('B27 L1', phase: 2, table: 'mvlc_lots');
    expect(lot, isNotNull);
    expect(lot!.lotNo, equals('B27 L1'));
    expect(lot.phase, equals(2));
    expect(lot.project, equals('MVLC'));
  });

  test('fetchRecentLotUpdates fetches MVLC updates from mvlc_lots', () async {
    SupabaseService.clearCache();
    final updates = await SupabaseService.fetchRecentLotUpdates(limit: 6, forceRefresh: true);
    expect(updates, isNotEmpty);
    final mvlcUpdates = updates.where((u) => u['project'] == 'MVLC').toList();
    expect(mvlcUpdates, isNotEmpty);
  });

  test('fetchHomePortfolioMetrics queries mvlc_lots for MVLC', () async {
    SupabaseService.clearCache();
    final metrics = await SupabaseService.fetchHomePortfolioMetrics(project: 'mvlc', forceRefresh: true);
    expect(metrics.totalLots, greaterThan(0));
    expect(metrics.activeProjectName, equals('MVLC'));
  });

  test('Phase 2E fetches lots with phase 2 and map_section East', () async {
    final countRes = await SupabaseService.client
        .from('mvlc_lots')
        .select('*')
        .count(CountOption.exact);
    print('Exact count in mvlc_lots: ${countRes.count}');
    final allMvlcLots = await SupabaseService.fetchLots(forceRefresh: true, limit: 2000);
    print('allMvlcLots length: ${allMvlcLots.length}');
    final phase2Lots = allMvlcLots.where((l) => l.phase == 2).toList();
    print('phase2Lots length: ${phase2Lots.length}');
    final mapSectionsInPhase2 = phase2Lots.map((l) => l.mapSection).toSet();
    print('mapSections in Phase 2: $mapSectionsInPhase2');

    final p2eLots = await SupabaseService.fetchLots(
      phase: 2,
      mapSection: 'East',
    );
    print('p2eLots length: ${p2eLots.length}');
    expect(p2eLots, isNotEmpty);
    expect(p2eLots.length, equals(614));
    for (final l in p2eLots) {
      expect(l.phase, equals(2));
      expect(l.mapSection?.toLowerCase(), anyOf(equals('east'), equals('e')));
    }

    // B1 L1 on Phase 2 East specifically returns the prime corner parcel (406 sqm)
    final b1l1East = await SupabaseService.fetchLotByAnnotation(
      'B1 L1',
      phase: 2,
      mapSection: 'East',
    );
    expect(b1l1East, isNotNull);
    expect(b1l1East!.phase, equals(2));
    expect(b1l1East.mapSection?.toLowerCase(), equals('east'));
    expect(b1l1East.sizeSqm, equals(406.0));
    expect(b1l1East.category, equals('prime_corner'));
  });

  test('MVLC always refers to map_section when present, and only phase number when map_section is null', () async {
    // 1. When map_section is present for Phase 2:
    final p2EastLots = await SupabaseService.fetchLots(phase: 2, mapSection: 'East');
    expect(p2EastLots.length, equals(614));
    for (final l in p2EastLots) {
      expect(l.phase, equals(2));
      expect(l.mapSection?.toLowerCase(), anyOf(equals('east'), equals('e')));
    }

    final p2ALots = await SupabaseService.fetchLots(phase: 2, mapSection: 'A');
    expect(p2ALots.length, equals(138));
    for (final l in p2ALots) {
      expect(l.phase, equals(2));
      expect(l.mapSection?.toUpperCase(), equals('A'));
    }

    final p2BLots = await SupabaseService.fetchLots(phase: 2, mapSection: 'B');
    expect(p2BLots.length, equals(147));
    for (final l in p2BLots) {
      expect(l.phase, equals(2));
      expect(l.mapSection?.toUpperCase(), equals('B'));
    }

    // 2. When map_section is present for Phase 1:
    final p1EastLots = await SupabaseService.fetchLots(phase: 1, mapSection: 'East');
    expect(p1EastLots.length, equals(453));
    for (final l in p1EastLots) {
      expect(l.phase, equals(1));
      expect(l.mapSection?.toLowerCase(), anyOf(equals('east'), equals('e')));
    }

    final p1ALots = await SupabaseService.fetchLots(phase: 1, mapSection: 'A');
    expect(p1ALots.length, equals(62));
    for (final l in p1ALots) {
      expect(l.phase, equals(1));
      expect(l.mapSection?.toUpperCase(), equals('A'));
    }

    final p1BLots = await SupabaseService.fetchLots(phase: 1, mapSection: 'B');
    expect(p1BLots.length, equals(28));
    for (final l in p1BLots) {
      expect(l.phase, equals(1));
      expect(l.mapSection?.toUpperCase(), equals('B'));
    }

    final p1CLots = await SupabaseService.fetchLots(phase: 1, mapSection: 'C');
    expect(p1CLots.length, equals(7));
    for (final l in p1CLots) {
      expect(l.phase, equals(1));
      expect(l.mapSection?.toUpperCase(), equals('C'));
    }

    // 3. When map_section is null (Phase 3):
    // "If map_section is null it should only use the phase number"
    final p3Lots = await SupabaseService.fetchLots(phase: 3, mapSection: null);
    expect(p3Lots.length, equals(302));
    for (final l in p3Lots) {
      expect(l.phase, equals(3));
    }
  });
}
