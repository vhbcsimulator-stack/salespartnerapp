import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../features/inventory/models/lot_model.dart';
import '../../features/inventory/models/mvlc_price_model.dart';
import '../../features/inventory/models/project_model.dart';
import '../../features/map/models/annotated_image_model.dart';
import '../../features/map/models/map_upload_model.dart';
import '../../features/home/models/announcement_model.dart';
import '../../features/home/models/featured_project_model.dart';
import '../../features/home/models/home_portfolio_metrics.dart';
import '../../features/sales_kit/models/youtube_link_model.dart';
import '../../features/sales_kit/models/development_photo_model.dart';
import '../../features/clients/models/client_model.dart';
import '../../features/computation/models/project_discount_model.dart';
import '../config/supabase_config.dart';

/// Central service for Supabase integration and real-time backend access.
class SupabaseService {
  SupabaseService._();

  static bool _isInitialized = false;

  /// Returns true if Supabase client has been initialized.
  static bool get isInitialized => _isInitialized;

  static SupabaseClient? _directClient;

  static set client(SupabaseClient c) => _directClient = c;

  /// In-memory caches for ultra-fast instant UI responsiveness
  static List<ProjectModel>? _cachedProjects;
  static final Map<String, Map<String, int>> _cachedSummaries = {};
  static final Map<String, List<LotModel>> _cachedLotsByTable = {};
  static List<AnnouncementModel>? _cachedAnnouncements;
  static final Map<String, HomePortfolioMetrics> _cachedHomeMetricsByProject = {};
  static List<Map<String, dynamic>>? _cachedRecentLotUpdates;
  static final Map<String, double> _cachedPricePerSqmByProject = {};
  static List<FeaturedProjectModel>? _cachedFeaturedProjects;
  static List<YoutubeLinkModel>? _cachedYoutubeLinks;
  static List<DevelopmentPhotoModel>? _cachedActualPhotos;
  static List<DevelopmentPhotoModel>? _cachedPerspectivePhotos;
  static List<ClientModel>? _cachedClients;
  static List<ProjectDiscountModel>? _cachedProjectDiscounts;

  /// Returns synchronous access to the currently cached project discounts, or empty list if none.
  static List<ProjectDiscountModel> get cachedProjectDiscounts => _cachedProjectDiscounts ?? const [];
  static bool get hasCachedDiscounts => _cachedProjectDiscounts != null;

  /// In-memory mock setter for fast, isolated unit and widget tests
  @visibleForTesting
  static void setMockData({
    List<AnnouncementModel>? announcements,
    Map<String, HomePortfolioMetrics>? homeMetrics,
    List<Map<String, dynamic>>? recentLotUpdates,
    List<ProjectModel>? projects,
    Map<String, double>? pricesByProject,
    List<FeaturedProjectModel>? featuredProjects,
    List<YoutubeLinkModel>? youtubeLinks,
    List<DevelopmentPhotoModel>? actualPhotos,
    List<DevelopmentPhotoModel>? perspectivePhotos,
    List<ProjectDiscountModel>? projectDiscounts,
  }) {
    if (announcements != null) _cachedAnnouncements = announcements;
    if (homeMetrics != null) _cachedHomeMetricsByProject.addAll(homeMetrics);
    if (recentLotUpdates != null) _cachedRecentLotUpdates = recentLotUpdates;
    if (projects != null) _cachedProjects = projects;
    if (pricesByProject != null) _cachedPricePerSqmByProject.addAll(pricesByProject);
    if (featuredProjects != null) _cachedFeaturedProjects = featuredProjects;
    if (youtubeLinks != null) _cachedYoutubeLinks = youtubeLinks;
    if (actualPhotos != null) _cachedActualPhotos = actualPhotos;
    if (perspectivePhotos != null) _cachedPerspectivePhotos = perspectivePhotos;
    if (projectDiscounts != null) _cachedProjectDiscounts = projectDiscounts;
  }

  /// Returns the Supabase client instance.
  /// Seamlessly falls back to a direct SupabaseClient if plugin storage fails on restart.
  static SupabaseClient get client {
    if (_directClient != null) return _directClient!;
    if (_isInitialized) {
      try {
        return Supabase.instance.client;
      } catch (_) {}
    }
    _directClient = SupabaseClient(
      SupabaseConfig.url,
      SupabaseConfig.anonKey,
      authOptions: const AuthClientOptions(autoRefreshToken: false),
    );
    return _directClient!;
  }

  /// Initialize Supabase client and pre-warm cache in background
  static Future<void> initialize({
    String? url,
    String? anonKey,
  }) async {
    if (_isInitialized) return;

    try {
      await Supabase.initialize(
        url: url ?? SupabaseConfig.url,
        // ignore: deprecated_member_use
        anonKey: anonKey ?? SupabaseConfig.anonKey,
        debug: kDebugMode,
      );
      _isInitialized = true;
      developer.log('Supabase initialized successfully', name: 'SupabaseService');
    } catch (e, stack) {
      developer.log(
        'Supabase initialization notice (using direct client fallback): $e',
        name: 'SupabaseService',
        error: e,
        stackTrace: stack,
      );
      _directClient = SupabaseClient(
        url ?? SupabaseConfig.url,
        anonKey ?? SupabaseConfig.anonKey,
      );
      _isInitialized = true;
    }

    // Pre-warm portfolio caches in the background so all tabs open instantly
    unawaited(prewarmCache());
  }

  /// Pre-warms projects, prices, and lots in memory asynchronously.
  static Future<void> prewarmCache() async {
    try {
      await Future.wait([
        fetchProjects(),
        fetchMvlcPrices(),
        fetchProjectDiscounts(),
        fetchLots(table: 'mvlc_lots'),
        fetchLots(table: 'erhd_lots'),
        fetchLots(table: 'mscc_lots'),
        fetchAnnouncements(),
        fetchHomePortfolioMetrics(),
        fetchFeaturedProjects(),
        fetchMapUploads(project: 'MVLC'),
        fetchAnnotatedImages(project: 'MVLC'),
        fetchYoutubeLinks(),
      ]);
      developer.log('Supabase cache pre-warmed successfully', name: 'SupabaseService');
    } catch (e) {
      developer.log('Notice during prewarming cache: $e', name: 'SupabaseService');
    }
  }

  /// Returns the appropriate Supabase lot table for a given project code or name.
  /// MSCC -> 'mscc_lots'
  /// ERHD -> 'erhd_lots'
  /// MVLC / other -> 'mvlc_lots'
  static String lotTableForProject(String? project) {
    final p = (project ?? '').trim().toUpperCase();
    if (p.contains('MSCC') || p.contains('MOUNTAIN SUITES')) return 'mscc_lots';
    if (p.contains('ERHD') || p.contains('EASTWEST RESORT')) return 'erhd_lots';
    return 'mvlc_lots';
  }


  /// Invalidate cache when user pulls to refresh
  static void clearCache({String? table}) {
    if (table != null) {
      final actualTable = (table == 'lots') ? 'mvlc_lots' : table;
      _cachedLotsByTable.remove(actualTable);
      _cachedSummaries.remove(actualTable);
      _cachedHomeMetricsByProject.remove(actualTable);
      if (actualTable != table) {
        _cachedLotsByTable.remove(table);
        _cachedSummaries.remove(table);
        _cachedHomeMetricsByProject.remove(table);
      }
    } else {
      _cachedLotsByTable.clear();
      _cachedSummaries.clear();
      _cachedProjects = null;
      _cachedMvlcPrices = null;
      _cachedAnnouncements = null;
      _cachedHomeMetricsByProject.clear();
      _cachedRecentLotUpdates = null;
      _cachedPricePerSqmByProject.clear();
      _cachedFeaturedProjects = null;
      _cachedClients = null;
      _cachedProjectDiscounts = null;
      _annotatedImagesCache.clear();
    }
  }

  /// Update cached summary directly from in-memory lot list
  static void _updateSummaryFromLots(String table, List<LotModel> lots) {
    int available = 0;
    int reserved = 0;
    int hold = 0;
    int sold = 0;

    for (final item in lots) {
      final status = item.status.toLowerCase();
      if (status == 'available') {
        available++;
      } else if (status == 'reserved' || status == 'rsv-p') {
        reserved++;
      } else if (status == 'hold') {
        hold++;
      } else if (status == 'sold') {
        sold++;
      }
    }

    _cachedSummaries[table] = {
      'available': available,
      'reserved': reserved,
      'hold': hold,
      'sold': sold,
      'total': lots.length,
    };
  }

  /// Query summary metrics from the lots table with zero-latency memory cache
  static Future<Map<String, int>> fetchLotsSummary({
    String table = 'mvlc_lots',
    bool forceRefresh = false,
  }) async {
    final actualTable = (table == 'lots') ? 'mvlc_lots' : table;

    // 1. Instant check: derive from cached lots if present (< 0.1ms)
    if (!forceRefresh && _cachedLotsByTable.containsKey(actualTable) && _cachedLotsByTable[actualTable]!.isNotEmpty) {
      final cachedLots = _cachedLotsByTable[actualTable]!;
      _updateSummaryFromLots(actualTable, cachedLots);
      return _cachedSummaries[actualTable]!;
    }

    // 2. Return cached summary if present
    if (!forceRefresh && _cachedSummaries.containsKey(actualTable)) {
      return _cachedSummaries[actualTable]!;
    }

    const emptySummary = {
      'available': 0,
      'reserved': 0,
      'hold': 0,
      'sold': 0,
      'total': 0,
    };

    try {
      await fetchLots(table: actualTable, forceRefresh: forceRefresh);
      if (_cachedSummaries.containsKey(actualTable)) {
        return _cachedSummaries[actualTable]!;
      }
    } catch (e) {
      developer.log('Error fetching lots summary from $actualTable: $e', name: 'SupabaseService');
    }

    return _cachedSummaries[actualTable] ?? emptySummary;
  }

  /// Query real lot models from Supabase with flexible filters and instant in-memory caching
  static Future<List<LotModel>> fetchLots({
    String? status,
    int? phase,
    String? mapSection,
    String? category,
    double? minSize,
    double? maxSize,
    String? searchQuery,
    int limit = 5000,
    int offset = 0,
    String table = 'mvlc_lots',
    String? defaultProject,
    bool forceRefresh = false,
  }) async {
    final actualTable = (table == 'lots') ? 'mvlc_lots' : table;
    final supabase = client;
    final proj = defaultProject ??
        (actualTable == 'mscc_lots'
            ? 'MSCC'
            : (actualTable == 'erhd_lots' ? 'ERHD' : 'MVLC'));

    List<LotModel> allLots;

    // Check if we already have this table cached in memory
    if (!forceRefresh &&
        _cachedLotsByTable.containsKey(actualTable) &&
        _cachedLotsByTable[actualTable]!.isNotEmpty) {
      allLots = _cachedLotsByTable[actualTable]!;
    } else {
      try {
        final List<LotModel> loadedLots = [];
        const pageSize = 1000;
        int pageOffset = 0;
        bool hasMore = true;

        while (hasMore) {
          final response = await supabase
              .from(actualTable)
              .select('*')
              .order('id', ascending: true)
              .range(pageOffset, pageOffset + pageSize - 1)
              .timeout(const Duration(seconds: 12));

          final List list = response as List;
          for (final item in list) {
            final json = Map<String, dynamic>.from(item as Map);
            json['project'] ??= proj;
            loadedLots.add(LotModel.fromJson(json));
          }

          if (list.length < pageSize) {
            hasMore = false;
          } else {
            pageOffset += pageSize;
          }
        }

        allLots = loadedLots;
        _cachedLotsByTable[actualTable] = allLots;
        _updateSummaryFromLots(actualTable, allLots);
      } catch (e, stack) {
        developer.log('Error fetching lots from $actualTable: $e',
            name: 'SupabaseService', error: e, stackTrace: stack);
        allLots = _cachedLotsByTable[actualTable] ?? [];
      }
    }

    // Filter in-memory with sub-millisecond latency
    var result = allLots;

    if (status != null && status != 'all') {
      if (status == 'available') {
        result = result.where((l) => l.isAvailable).toList();
      } else if (status == 'reserved') {
        result = result.where((l) => l.isReserved || l.isHold).toList();
      } else if (status == 'sold') {
        result = result.where((l) => l.isSold).toList();
      } else {
        final s = status.toLowerCase();
        result = result.where((l) => l.status.toLowerCase() == s).toList();
      }
    }

    if (phase != null && actualTable != 'erhd_lots') {
      result = result.where((l) => l.phase == phase).toList();
    }

    if (mapSection != null && mapSection.trim().isNotEmpty && actualTable != 'erhd_lots') {
      final s = mapSection.trim().toLowerCase();
      result = result.where((l) {
        if (l.mapSection == null) return false;
        final ms = l.mapSection!.trim().toLowerCase();
        if (ms == s) return true;
        if ((s == 'east' || s == 'e') && (ms == 'east' || ms == 'e')) return true;
        if ((s == 'west' || s == 'w') && (ms == 'west' || ms == 'w')) return true;
        if ((s == 'north' || s == 'n') && (ms == 'north' || ms == 'n')) return true;
        if ((s == 'south' || s == 's') && (ms == 'south' || ms == 's')) return true;
        return false;
      }).toList();
    }

    if (category != null && category != 'all') {
      final cat = category.toLowerCase();
      result = result.where((l) => l.category.toLowerCase() == cat).toList();
    }

    if (minSize != null && minSize > 0) {
      result = result.where((l) => l.sizeSqm >= minSize).toList();
    }

    if (maxSize != null && maxSize > 0) {
      result = result.where((l) => l.sizeSqm <= maxSize).toList();
    }

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final cleaned = searchQuery.trim().toLowerCase();
      final commLot = LotModel.extractCommercialLotNo(cleaned);
      if (commLot != null) {
        final clLower = commLot.toLowerCase();
        result = result.where((l) {
          final lotNo = l.lotNo.toLowerCase();
          return lotNo == clLower || lotNo.contains(cleaned);
        }).toList();
      } else {
        final blockLotRegex =
            RegExp(r'block\s*(\d+)\s*lot\s*(\d+)', caseSensitive: false);
        final match = blockLotRegex.firstMatch(cleaned);
        if (match != null) {
          final b = match.group(1);
          final l = match.group(2);
          final pattern = 'b$b l$l';
          result = result.where((lot) {
            final ln = lot.lotNo.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
            return ln.contains(pattern) || ln.contains(cleaned);
          }).toList();
        } else {
          final blockOnlyRegex =
              RegExp(r'block\s*(\d+)', caseSensitive: false);
          final blockMatch = blockOnlyRegex.firstMatch(cleaned);
          if (blockMatch != null) {
            final b = blockMatch.group(1);
            final pattern = 'b$b ';
            result = result.where((lot) {
              final ln = lot.lotNo.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
              return ln.contains(pattern) || ln.contains(cleaned);
            }).toList();
          } else {
            result = result.where((lot) {
              final ln = lot.lotNo.toLowerCase();
              final fln = lot.formattedLotNo.toLowerCase();
              final ut = (lot.unitType ?? '').toLowerCase();
              final fl = (lot.floorLevel ?? '').toLowerCase();
              final cat = lot.category.toLowerCase();
              return ln.contains(cleaned) ||
                  fln.contains(cleaned) ||
                  ut.contains(cleaned) ||
                  fl.contains(cleaned) ||
                  cat.contains(cleaned);
            }).toList();
          }

        }
      }

      // If in-memory search returned 0 items, query Supabase directly for lots beyond cache batch
      if (result.isEmpty) {
        try {
          var sqQuery = supabase.from(actualTable).select();
          if (status != null && status != 'all') {
            if (status == 'available') {
              sqQuery = sqQuery.eq('status', 'available');
            } else if (status == 'reserved') {
              sqQuery = sqQuery.inFilter('status', ['reserved', 'rsv-p', 'hold']);
            } else if (status == 'sold') {
              sqQuery = sqQuery.eq('status', 'sold');
            } else {
              sqQuery = sqQuery.eq('status', status);
            }
          }
          if (phase != null && actualTable != 'erhd_lots') {
            sqQuery = sqQuery.eq('phase', phase);
          }
          if (mapSection != null && mapSection.trim().isNotEmpty && actualTable != 'erhd_lots') {
            final ms = mapSection.trim();
            sqQuery = sqQuery.or('map_section.eq.$ms,map_section.ilike.$ms');
          }
          if (commLot != null) {
            sqQuery = sqQuery.or('lot_no.eq.$commLot,lot_no.ilike.$commLot,lot_no.ilike.%$cleaned%');
          } else {
            sqQuery = sqQuery.ilike('lot_no', '%$cleaned%');
          }
          final sqRes = await sqQuery.limit(limit).timeout(const Duration(seconds: 8));
          final sqList = sqRes as List;
          final fallbackLots = sqList.map((item) {
            final json = Map<String, dynamic>.from(item as Map);
            json['project'] ??= proj;
            return LotModel.fromJson(json);
          }).toList();
          if (fallbackLots.isNotEmpty) {
            return fallbackLots;
          }
        } catch (_) {}
      }
    }

    if (offset > 0) {
      if (offset >= result.length) return [];
      result = result.sublist(offset);
    }
    if (result.length > limit) {
      result = result.sublist(0, limit);
    }

    return result;
  }

  /// Query a single lot directly using annotation name with in-memory fast path
  static Future<LotModel?> fetchLotByAnnotation(
    String annotationName, {
    int? phase,
    String? mapSection,
    String table = 'mvlc_lots',
    String? defaultProject,
  }) async {
    final actualTable = (table == 'lots') ? 'mvlc_lots' : table;

    // 0. Instant in-memory cache lookup (< 0.1ms)
    if (_cachedLotsByTable.containsKey(actualTable) &&
        _cachedLotsByTable[actualTable]!.isNotEmpty) {
      final cachedLot =
          _findLotInCache(actualTable, annotationName, phase: phase, mapSection: mapSection);
      if (cachedLot != null) {
        return cachedLot;
      }
    }

    final proj = defaultProject ??
        (actualTable == 'mscc_lots'
            ? 'MSCC'
            : (actualTable == 'erhd_lots' ? 'ERHD' : 'MVLC'));

    final ms = (mapSection != null && mapSection.trim().isNotEmpty && actualTable != 'erhd_lots')
        ? mapSection.trim()
        : null;

    try {
      final normalized = LotModel.normalizeLotNo(annotationName);
      final commLotNo = LotModel.extractCommercialLotNo(annotationName);

      // 0. Phase 1 Commercial extraction: "C L1" -> queries "L1" or "C L1" in lots table
      if (commLotNo != null) {
        var commQuery = client
            .from(actualTable)
            .select('*')
            .or('lot_no.eq.$commLotNo,lot_no.eq.$annotationName,lot_no.eq.C $commLotNo');
        if (phase != null && actualTable != 'erhd_lots') {
          commQuery = commQuery.eq('phase', phase);
        }
        if (ms != null) {
          commQuery = commQuery.or('map_section.eq.$ms,map_section.ilike.$ms');
        }
        final resComm = await commQuery.limit(1);
        if (resComm.isNotEmpty) {
          final json = Map<String, dynamic>.from(resComm.first as Map);
          json['project'] ??= proj;
          return LotModel.fromJson(json);
        }

        var resCommIlike = client
            .from(actualTable)
            .select('*')
            .or('lot_no.ilike.$commLotNo,lot_no.ilike.%$annotationName%');
        if (ms != null) {
          resCommIlike = resCommIlike.or('map_section.eq.$ms,map_section.ilike.$ms');
        }
        final resCommIlikeList = await resCommIlike.limit(1);
        if (resCommIlikeList.isNotEmpty) {
          final json = Map<String, dynamic>.from(resCommIlikeList.first as Map);
          json['project'] ??= proj;
          return LotModel.fromJson(json);
        }
      }

      // 1. Exact match with phase filter if provided (only for tables with phase column)
      if (phase != null && actualTable != 'erhd_lots') {
        var resPhase = client
            .from(actualTable)
            .select('*')
            .eq('lot_no', normalized)
            .eq('phase', phase);
        if (ms != null) {
          resPhase = resPhase.or('map_section.eq.$ms,map_section.ilike.$ms');
        }
        final resPhaseList = await resPhase.limit(1);
        if (resPhaseList.isNotEmpty) {
          final json = Map<String, dynamic>.from(resPhaseList.first as Map);
          json['project'] ??= proj;
          return LotModel.fromJson(json);
        }
      }

      // 2. Exact match on normalized lot_no
      var resExact = client
          .from(actualTable)
          .select('*')
          .eq('lot_no', normalized);
      if (phase != null && actualTable != 'erhd_lots') {
        resExact = resExact.eq('phase', phase);
      }
      if (ms != null) {
        resExact = resExact.or('map_section.eq.$ms,map_section.ilike.$ms');
      }
      final resExactList = await resExact.limit(1);
      if (resExactList.isNotEmpty) {
        final json = Map<String, dynamic>.from(resExactList.first as Map);
        json['project'] ??= proj;
        return LotModel.fromJson(json);
      }

      // 3. Case-insensitive ilike match
      var resIlike = client
          .from(actualTable)
          .select('*')
          .ilike('lot_no', normalized);
      if (phase != null && actualTable != 'erhd_lots') {
        resIlike = resIlike.eq('phase', phase);
      }
      if (ms != null) {
        resIlike = resIlike.or('map_section.eq.$ms,map_section.ilike.$ms');
      }
      final resIlikeList = await resIlike.limit(1);
      if (resIlikeList.isNotEmpty) {
        final json = Map<String, dynamic>.from(resIlikeList.first as Map);
        json['project'] ??= proj;
        return LotModel.fromJson(json);
      }

      // 4. Regex extraction for Block & Lot numbers (e.g. "B27 L1" or "Block 27 Lot 1")
      final match = RegExp(
        r'B(?:lock)?\s*(\d+)\s*(?:L(?:ot)?)?\s*(\d+(?:-[0-9a-zA-Z]+)?)',
        caseSensitive: false,
      ).firstMatch(annotationName.trim());

      if (match != null) {
        final b = match.group(1);
        final l = match.group(2);
        var query = client
            .from(actualTable)
            .select('*')
            .or('lot_no.ilike.%B$b L$l%,lot_no.ilike.%B$b  L$l%,lot_no.ilike.%B$b L $l%');
        if (phase != null && actualTable != 'erhd_lots') {
          query = query.eq('phase', phase);
        }
        if (ms != null) {
          query = query.or('map_section.eq.$ms,map_section.ilike.$ms');
        }
        final resFuzzy = await query.limit(1);
        if (resFuzzy.isNotEmpty) {
          final json = Map<String, dynamic>.from(resFuzzy.first as Map);
          json['project'] ??= proj;
          return LotModel.fromJson(json);
        }
      }

      return null;
    } catch (e, stack) {
      developer.log(
        'Error fetching lot by annotation "$annotationName" from $actualTable: $e',
        name: 'SupabaseService',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  /// Fast memory lookup for an annotation
  static LotModel? _findLotInCache(
    String table,
    String annotationName, {
    int? phase,
    String? mapSection,
  }) {
    final actualTable = (table == 'lots') ? 'mvlc_lots' : table;
    final lots = _cachedLotsByTable[actualTable];
    if (lots == null || lots.isEmpty) return null;

    final hasMapSection = mapSection != null &&
        mapSection.trim().isNotEmpty &&
        mapSection.trim().toLowerCase() != 'null' &&
        mapSection.trim().toLowerCase() != 'all';

    bool matchesSection(LotModel lot) {
      if (!hasMapSection) {
        // If map_section is null, only use the phase number
        return true;
      }
      if (lot.mapSection == null) return false;
      final s = mapSection.trim().toLowerCase();
      final ms = lot.mapSection!.trim().toLowerCase();
      if (ms == s) return true;
      if ((s == 'east' || s == 'e') && (ms == 'east' || ms == 'e')) return true;
      if ((s == 'west' || s == 'w') && (ms == 'west' || ms == 'w')) return true;
      if ((s == 'north' || s == 'n') && (ms == 'north' || ms == 'n')) return true;
      if ((s == 'south' || s == 's') && (ms == 'south' || ms == 's')) return true;
      return false;
    }

    final normalized =
        LotModel.normalizeLotNo(annotationName).trim().toLowerCase();
    final commLotNo =
        LotModel.extractCommercialLotNo(annotationName)?.trim().toLowerCase();

    if (commLotNo != null) {
      for (final l in lots) {
        final ln = l.lotNo.trim().toLowerCase();
        if (ln == commLotNo ||
            ln == annotationName.trim().toLowerCase() ||
            ln == 'c $commLotNo') {
          if ((phase == null || actualTable == 'erhd_lots' || l.phase == phase) &&
              matchesSection(l)) {
            return l;
          }
        }
      }
    }

    if (phase != null && actualTable != 'erhd_lots') {
      for (final l in lots) {
        if (l.phase == phase &&
            l.lotNo.trim().toLowerCase() == normalized &&
            matchesSection(l)) {
          return l;
        }
      }
    } else {
      for (final l in lots) {
        if (l.lotNo.trim().toLowerCase() == normalized && matchesSection(l)) {
          return l;
        }
      }
    }

    final match = RegExp(
      r'B(?:lock)?\s*(\d+)\s*(?:L(?:ot)?)?\s*(\d+(?:-[0-9a-zA-Z]+)?)',
      caseSensitive: false,
    ).firstMatch(annotationName.trim());

    if (match != null) {
      final b = match.group(1);
      final l = match.group(2);
      final target = 'b$b l$l';
      for (final lot in lots) {
        if (phase != null && actualTable != 'erhd_lots' && lot.phase != phase) {
          continue;
        }
        if (!matchesSection(lot)) {
          continue;
        }
        final norm = lot.lotNo.toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
        if (norm.contains(target)) {
          return lot;
        }
      }
    }

    return null;
  }

  /// Query project records from public.projects table in Supabase with in-memory caching
  static Future<List<ProjectModel>> fetchProjects({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedProjects != null && _cachedProjects!.isNotEmpty) {
      return _cachedProjects!;
    }

    final supabase = client;

    try {
      final response = await supabase
          .from('projects')
          .select('*')
          .timeout(const Duration(seconds: 8));

      final List list = response as List;
      final rawProjects = list
          .map((item) =>
              ProjectModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      // Deduplicate projects by code or displayName
      final seen = <String>{};
      final projects = <ProjectModel>[];
      for (final p in rawProjects) {
        final key = (p.code ?? p.name ?? p.displayName).trim().toUpperCase();
        if (key.isNotEmpty && seen.add(key)) {
          projects.add(p);
        }
      }

      // Sort alphabetically by displayName
      projects.sort((a, b) =>
          a.displayName.toLowerCase().compareTo(b.displayName.toLowerCase()));

      _cachedProjects = projects;
      return projects;
    } catch (e, stack) {
      developer.log('Error fetching projects from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return _cachedProjects ?? [];
    }
  }

  /// Returns whether a project is paused / soon-to-rise according to the projects table.
  /// If cached projects exist, evaluates based strictly on project.paused.
  /// Otherwise, falls back to default known paused projects (GLS, LCN, MCVC, MSCC, RHM, RHN).
  static bool isProjectPaused(String? code, [String? name]) {
    final c = (code ?? '').trim().toUpperCase();
    final n = (name ?? '').trim().toUpperCase();

    if (_cachedProjects != null && _cachedProjects!.isNotEmpty) {
      for (final p in _cachedProjects!) {
        final pCode = (p.code ?? '').trim().toUpperCase();
        final pName = (p.name ?? p.displayName).trim().toUpperCase();
        final pDesc = (p.description ?? '').trim().toUpperCase();
        if ((c.isNotEmpty && (pCode == c || pName == c || pDesc == c)) ||
            (n.isNotEmpty && (pCode == n || pName == n || pDesc == n))) {
          return p.paused;
        }
      }
    }

    // Fallback when projects haven't loaded yet or offline
    const defaultPausedKeywords = {
      'GLS', 'GREEN LANDSCAPE', 'SANCTUARY',
      'LCN', 'LAKESHORE', 'LAKESHORE COMMUNITY NORTH',
      'MCVC', 'MINI COMPLETE', 'VACATION COMMUNITY', 'MONTE CIELO',
      'MSCC', 'MOUNTAIN SUITES',
      'RHM', 'RESORT HUB MUÑOS', 'RESORT HUB MUNOS', 'RESORT HUB MUNOZ', 'RANCHO HERMOSA MOUNTAIN',
      'RHN', 'RESORT HUB NASUGBU', 'RANCHO HERMOSA NORTH',
    };
    for (final kw in defaultPausedKeywords) {
      if ((c.isNotEmpty && (c == kw || c.contains(kw))) ||
          (n.isNotEmpty && (n == kw || n.contains(kw)))) {
        return true;
      }
    }
    final combined = '$c $n';
    return combined.contains('SOON TO RISE');
  }

  static List<MvlcPriceModel>? _cachedMvlcPrices;

  /// Query phase and category price matrix from public.mvlc_price table
  static Future<List<MvlcPriceModel>> fetchMvlcPrices({bool forceRefresh = false}) async {
    if (!forceRefresh && _cachedMvlcPrices != null && _cachedMvlcPrices!.isNotEmpty) {
      return _cachedMvlcPrices!;
    }

    final supabase = client;

    try {
      final response = await supabase
          .from('mvlc_price')
          .select('*')
          .order('phase', ascending: true)
          .timeout(const Duration(seconds: 8));

      final List list = response as List;
      final prices = list
          .map((item) =>
              MvlcPriceModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      _cachedMvlcPrices = prices;
      developer.log(
        'Fetched ${prices.length} phase pricing records from mvlc_price',
        name: 'SupabaseService',
      );
      return prices;
    } catch (e, stack) {
      developer.log('Error fetching mvlc_price from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return [];
    }
  }

  /// Query project discount rules from public.project_discounts table.
  /// Supports dynamic discount percentages and interest rates per project.
  static Future<List<ProjectDiscountModel>> fetchProjectDiscounts({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh &&
        _cachedProjectDiscounts != null &&
        _cachedProjectDiscounts!.isNotEmpty) {
      return _cachedProjectDiscounts!;
    }

    final supabase = client;

    try {
      final response = await supabase
          .from('project_discounts')
          .select('*')
          .timeout(const Duration(seconds: 8));

      final List list = response as List;
      final discounts = list
          .map((item) => ProjectDiscountModel.fromJson(
              Map<String, dynamic>.from(item as Map)))
          .toList();

      _cachedProjectDiscounts = discounts;
      developer.log(
        'Fetched ${discounts.length} discount rules from project_discounts',
        name: 'SupabaseService',
      );
      return discounts;
    } catch (e, stack) {
      developer.log(
        'Error fetching project_discounts from Supabase: $e',
        name: 'SupabaseService',
        error: e,
        stackTrace: stack,
      );
      return _cachedProjectDiscounts ?? [];
    }
  }

  /// Get pricing record for a specific phase from mvlc_price table.
  static Future<MvlcPriceModel?> fetchMvlcPriceForPhase(int phase) async {
    final prices = await fetchMvlcPrices();
    return prices.where((p) => p.phase == phase).firstOrNull;
  }

  /// Resolve price per sqm for a given phase number and lot type (category)
  /// using the mvlc_price table.
  static Future<double?> resolvePricePerSqm({
    required int phase,
    required String lotType,
  }) async {
    final priceModel = await fetchMvlcPriceForPhase(phase);
    return priceModel?.getPriceForCategory(lotType);
  }

  /// Query map image uploads directly from public.uploads table.
  /// Never caches results to ensure the latest map image is always fetched.
  static Future<List<MapUploadModel>> fetchMapUploads({
    String? project,
    int? projectId,
    bool forceRefresh = true,
  }) async {
    final supabase = client;

    try {
      var query = supabase.from('uploads').select('*');

      if (projectId != null && project != null && project.isNotEmpty && project != 'all') {
        final p = project.trim();
        query = query.or('project_id.eq.$projectId,project.ilike.%$p%,name.ilike.%$p%');
      } else if (projectId != null) {
        query = query.eq('project_id', projectId);
      } else if (project != null && project.isNotEmpty && project != 'all') {
        final p = project.trim();
        query = query.or('project.ilike.%$p%,name.ilike.%$p%');
      }

      final response = await query
          .order('id', ascending: false)
          .timeout(const Duration(seconds: 15));

      final List list = response as List;
      final uploads = list
          .map((item) =>
              MapUploadModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .where((u) => u.image_URL.isNotEmpty)
          .toList();

      return uploads;
    } catch (e, stack) {
      developer.log('Error fetching map uploads from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return [];
    }
  }

  // In-memory cache for annotated images by project
  static final Map<String, List<AnnotatedImageModel>> _annotatedImagesCache = {};

  /// Fetch annotations and COCO datasets from `annotated_images` table.
  /// Caches results in memory to keep map navigation instant.
  static Future<List<AnnotatedImageModel>> fetchAnnotatedImages({
    String? project,
    bool forceRefresh = false,
  }) async {
    final cacheKey = (project ?? 'all').toUpperCase().trim();
    if (!forceRefresh && _annotatedImagesCache.containsKey(cacheKey)) {
      return _annotatedImagesCache[cacheKey]!;
    }

    final supabase = client;

    try {
      var query = supabase.from('annotated_images').select('*');

      if (project != null && project.isNotEmpty && project != 'all') {
        final p = project.trim();
        query = query.ilike('project', '%$p%');
      }

      final response = await query
          .order('id', ascending: true)
          .timeout(const Duration(seconds: 12));

      final List list = response as List;
      final parsed = list
          .map((item) =>
              AnnotatedImageModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      _annotatedImagesCache[cacheKey] = parsed;
      return parsed;
    } catch (e, stack) {
      developer.log('Error fetching annotated images from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return _annotatedImagesCache[cacheKey] ?? [];
    }
  }

  /// Clear the annotated images cache.
  static void clearAnnotatedImagesCache() {
    _annotatedImagesCache.clear();
  }

  /// Fetch announcements from public.announcements table
  static Future<List<AnnouncementModel>> fetchAnnouncements({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedAnnouncements != null) {
      return _cachedAnnouncements!;
    }

    final supabase = client;
    try {
      final response = await supabase
          .from('announcements')
          .select('*')
          .order('created_at', ascending: false)
          .limit(10)
          .timeout(const Duration(seconds: 8));

      final List list = response as List;
      final parsed = list
          .map((item) =>
              AnnouncementModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      _cachedAnnouncements = parsed;
      return parsed;
    } catch (e, stack) {
      developer.log('Error fetching announcements from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return _cachedAnnouncements ?? [];
    }
  }

  /// Fetch featured project records from public.featured_projects table
  static Future<List<FeaturedProjectModel>> fetchFeaturedProjects({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedFeaturedProjects != null && _cachedFeaturedProjects!.isNotEmpty) {
      return _cachedFeaturedProjects!;
    }

    final supabase = client;
    try {
      final response = await supabase
          .from('featured_projects')
          .select('*')
          .order('updated_at', ascending: false)
          .timeout(const Duration(seconds: 8));

      final list = (response as List)
          .map((item) =>
              FeaturedProjectModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      _cachedFeaturedProjects = list;
      return list;
    } catch (e, stack) {
      developer.log('Error fetching featured_projects from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      return _cachedFeaturedProjects ?? [];
    }
  }


  /// Fetch video walkthroughs and sales kit links from `youtube_links` table.
  static Future<List<YoutubeLinkModel>> fetchYoutubeLinks({
    String? projectName,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedYoutubeLinks != null && (projectName == null || projectName.toLowerCase() == 'all')) {
      return _cachedYoutubeLinks!;
    }

    final supabase = client;
    try {
      var query = supabase.from('youtube_links').select('*');
      if (projectName != null && projectName.isNotEmpty && projectName.toLowerCase() != 'all') {
        query = query.ilike('project_name', '%${projectName.trim()}%');
      }

      final response = await query
          .order('id', ascending: true)
          .timeout(const Duration(seconds: 10));

      final list = (response as List)
          .map((item) => YoutubeLinkModel.fromJson(Map<String, dynamic>.from(item as Map)))
          .toList();

      if (projectName == null || projectName.toLowerCase() == 'all') {
        _cachedYoutubeLinks = list;
      }
      return list;
    } catch (e, stack) {
      developer.log('Error fetching youtube_links from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      if (_cachedYoutubeLinks != null) {
        if (projectName == null || projectName.toLowerCase() == 'all') {
          return _cachedYoutubeLinks!;
        }
        return _cachedYoutubeLinks!
            .where((item) => item.projectName.toLowerCase().contains(projectName.toLowerCase()))
            .toList();
      }
      return [];
    }
  }

  /// Clear the youtube links cache
  static void clearYoutubeLinksCache() {
    _cachedYoutubeLinks = null;
  }

  /// Fetches actual development photos from Supabase table `project_dev`.
  static Future<List<DevelopmentPhotoModel>> fetchActualPhotos({
    String? projectName,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh &&
        _cachedActualPhotos != null &&
        (projectName == null || projectName.toLowerCase() == 'all')) {
      return _cachedActualPhotos!;
    }

    final supabase = client;
    try {
      var query = supabase.from('project_dev').select('*');
      if (projectName != null &&
          projectName.isNotEmpty &&
          projectName.toLowerCase() != 'all') {
        final norm = projectName.trim().toLowerCase();
        query = query.ilike('project_name', '%$norm%');
      }

      final response = await query
          .order('id', ascending: false)
          .timeout(const Duration(seconds: 12));

      final list = (response as List)
          .map((item) => DevelopmentPhotoModel.fromProjectDev(
              Map<String, dynamic>.from(item as Map)))
          .toList();

      if (projectName == null || projectName.toLowerCase() == 'all') {
        _cachedActualPhotos = list;
      }
      return list;
    } catch (e, stack) {
      developer.log('Error fetching project_dev from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      if (_cachedActualPhotos != null) {
        if (projectName == null || projectName.toLowerCase() == 'all') {
          return _cachedActualPhotos!;
        }
        return _cachedActualPhotos!
            .where((item) => item.matchesProject(projectName))
            .toList();
      }
      return [];
    }
  }

  /// Fetches future architectural perspectives from Supabase table `future_dev`.
  static Future<List<DevelopmentPhotoModel>> fetchPerspectivePhotos({
    String? projectName,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh &&
        _cachedPerspectivePhotos != null &&
        (projectName == null || projectName.toLowerCase() == 'all')) {
      return _cachedPerspectivePhotos!;
    }

    final supabase = client;
    try {
      var query = supabase.from('future_dev').select('*');
      if (projectName != null &&
          projectName.isNotEmpty &&
          projectName.toLowerCase() != 'all') {
        final norm = projectName.trim().toLowerCase();
        query = query.ilike('project_name', '%$norm%');
      }

      final response = await query
          .order('id', ascending: false)
          .timeout(const Duration(seconds: 12));

      final list = (response as List)
          .map((item) => DevelopmentPhotoModel.fromFutureDev(
              Map<String, dynamic>.from(item as Map)))
          .toList();

      if (projectName == null || projectName.toLowerCase() == 'all') {
        _cachedPerspectivePhotos = list;
      }
      return list;
    } catch (e, stack) {
      developer.log('Error fetching future_dev from Supabase: $e',
          name: 'SupabaseService', error: e, stackTrace: stack);
      if (_cachedPerspectivePhotos != null) {
        if (projectName == null || projectName.toLowerCase() == 'all') {
          return _cachedPerspectivePhotos!;
        }
        return _cachedPerspectivePhotos!
            .where((item) => item.matchesProject(projectName))
            .toList();
      }
      return [];
    }
  }

  /// Clears the development photos caches
  static void clearDevelopmentPhotosCache() {
    _cachedActualPhotos = null;
    _cachedPerspectivePhotos = null;
  }

  static Future<FeaturedProjectModel?> fetchFeaturedProject({
    String? projectCode,
    bool forceRefresh = false,
  }) async {
    final list = await fetchFeaturedProjects(forceRefresh: forceRefresh);
    if (list.isEmpty) return null;

    if (projectCode != null &&
        projectCode.isNotEmpty &&
        projectCode.toLowerCase() != 'all') {
      final norm = projectCode.trim().toLowerCase();
      final match = list.where((p) => p.projectCode.toLowerCase() == norm).firstOrNull;
      if (match != null) return match;
    }

    return list.first;
  }

  /// Query starting price per sqm strictly from project price tables (`mvlc_price`, `erhd_price`, `mscc_price`, `eblf_price`).
  /// Strictly does NOT query price columns from the table of lots (`lots`, `erhd_lots`).
  static Future<double> fetchProjectPricePerSqm({
    required String project,
    bool forceRefresh = false,
  }) async {
    final key = project.trim().toLowerCase();
    if (!forceRefresh && _cachedPricePerSqmByProject.containsKey(key)) {
      return _cachedPricePerSqmByProject[key]!;
    }

    final supabase = client;

    try {
      if (key == 'all') {
        final prices = await Future.wait([
          fetchProjectPricePerSqm(project: 'mvlc', forceRefresh: forceRefresh),
          fetchProjectPricePerSqm(project: 'erhd', forceRefresh: forceRefresh),
          fetchProjectPricePerSqm(project: 'mscc', forceRefresh: forceRefresh),
          fetchProjectPricePerSqm(project: 'eblf', forceRefresh: forceRefresh),
        ]);
        final validPrices = prices.where((p) => p > 0).toList();
        if (validPrices.isNotEmpty) {
          validPrices.sort();
          _cachedPricePerSqmByProject[key] = validPrices.first;
          return validPrices.first;
        }
        return 9800.0;
      }

      if (key == 'mvlc') {
        final res = await supabase
            .from('mvlc_price')
            .select('regular, regular_corner, commercial')
            .timeout(const Duration(seconds: 8));
        double minPrice = double.infinity;
        for (final row in res as List) {
          for (final col in ['regular', 'regular_corner', 'commercial']) {
            final val = (row[col] as num?)?.toDouble();
            if (val != null && val > 0 && val < minPrice) minPrice = val;
          }
        }
        final finalVal = minPrice.isInfinite ? 9800.0 : minPrice;
        _cachedPricePerSqmByProject[key] = finalVal;
        return finalVal;
      }

      if (key == 'erhd') {
        final res = await supabase
            .from('erhd_price')
            .select('regular, regular_corner, prime')
            .timeout(const Duration(seconds: 8));
        double minPrice = double.infinity;
        for (final row in res as List) {
          for (final col in ['regular', 'regular_corner', 'prime']) {
            final val = (row[col] as num?)?.toDouble();
            if (val != null && val > 0 && val < minPrice) minPrice = val;
          }
        }
        final finalVal = minPrice.isInfinite ? 12000.0 : minPrice;
        _cachedPricePerSqmByProject[key] = finalVal;
        return finalVal;
      }

      if (key == 'mscc') {
        final res = await supabase
            .from('mscc_price')
            .select('price_per_sqm')
            .limit(1)
            .timeout(const Duration(seconds: 8));
        if ((res as List).isNotEmpty) {
          final val = (res.first['price_per_sqm'] as num?)?.toDouble();
          if (val != null && val > 0) {
            _cachedPricePerSqmByProject[key] = val;
            return val;
          }
        }
        return 9800.0;
      }

      if (key == 'eblf') {
        final res = await supabase
            .from('eblf_price')
            .select('regular')
            .timeout(const Duration(seconds: 8));
        double minPrice = double.infinity;
        for (final row in res as List) {
          final val = (row['regular'] as num?)?.toDouble();
          if (val != null && val > 0 && val < minPrice) minPrice = val;
        }
        final finalVal = minPrice.isInfinite ? 12000.0 : minPrice;
        _cachedPricePerSqmByProject[key] = finalVal;
        return finalVal;
      }
    } catch (e) {
      developer.log('Notice fetching price for project $project from price table: $e', name: 'SupabaseService');
    }

    final fallback = (key == 'erhd' || key == 'eblf') ? 12000.0 : 9800.0;
    _cachedPricePerSqmByProject[key] = fallback;
    return fallback;
  }

  /// Calculates real-time portfolio metrics dynamically.
  /// Unit availability is derived from lot records.
  /// Price per sqm is STRICTLY retrieved from project pricing tables (`mvlc_price`, `erhd_price`, etc.),
  /// and project names are STRICTLY resolved from the `projects` table without inventing names.
  static Future<HomePortfolioMetrics> fetchHomePortfolioMetrics({
    String project = 'all',
    bool forceRefresh = false,
  }) async {
    final key = project.trim().toLowerCase();
    if (!forceRefresh && _cachedHomeMetricsByProject.containsKey(key)) {
      return _cachedHomeMetricsByProject[key]!;
    }

    List<LotModel> lots = [];
    if (key == 'all') {
      final results = await Future.wait([
        fetchLots(table: 'mvlc_lots', forceRefresh: forceRefresh, limit: 5000),
        fetchLots(table: 'erhd_lots', forceRefresh: forceRefresh, limit: 5000),
      ]);
      lots = [...results[0], ...results[1]];
    } else if (key == 'erhd' || key.contains('erhd')) {
      lots = await fetchLots(table: 'erhd_lots', forceRefresh: forceRefresh, limit: 5000);
    } else if (key == 'mvlc' || key.contains('mvlc')) {
      lots = await fetchLots(table: 'mvlc_lots', forceRefresh: forceRefresh, limit: 5000);
    } else {
      final minPrice = await fetchProjectPricePerSqm(project: key, forceRefresh: forceRefresh);
      final projects = await fetchProjects(forceRefresh: forceRefresh);
      final matched = projects.where((p) =>
        (p.code ?? p.id).toLowerCase() == key ||
        (p.name ?? '').toLowerCase() == key
      ).firstOrNull;

      final metrics = HomePortfolioMetrics(
        availableLots: 0,
        reservedLots: 0,
        soldLots: 0,
        totalLots: 0,
        minPricePerSqm: minPrice,
        minTcp: minPrice * 120.0,
        activeProjectId: key,
        activeProjectName: matched?.displayName ?? key.toUpperCase(),
      );
      _cachedHomeMetricsByProject[key] = metrics;
      return metrics;
    }

    int available = 0;
    int reserved = 0;
    int sold = 0;
    double minLotSize = double.infinity;

    for (final l in lots) {
      final s = l.status.toLowerCase();
      if (s == 'available') {
        available++;
        if (l.sizeSqm > 0 && l.sizeSqm < minLotSize) {
          minLotSize = l.sizeSqm;
        }
      } else if (s == 'reserved' || s == 'rsv-p' || s == 'hold') {
        reserved++;
      } else if (s == 'sold') {
        sold++;
      }
    }

    // STRICT REQUIREMENT: Retrieve price per sqm from dedicated price tables, NOT table mvlc_lots / erhd_lots
    final minPrice = await fetchProjectPricePerSqm(project: key, forceRefresh: forceRefresh);

    // Compute starting TCP from price table rate and smallest lot dimension cut
    final defaultCut = (key == 'erhd' || key.contains('erhd')) ? 240.0 : 120.0;
    final lotCut = minLotSize.isInfinite || minLotSize <= 0 ? defaultCut : minLotSize;
    final minTcp = minPrice * lotCut;

    // STRICT REQUIREMENT: Do not invent name of the project; use project name from database
    String projectName = 'All Projects';
    if (key != 'all') {
      final projects = await fetchProjects(forceRefresh: forceRefresh);
      final matched = projects.where((p) =>
        (p.code ?? p.id).toLowerCase() == key ||
        (p.name ?? '').toLowerCase() == key
      ).firstOrNull;
      projectName = matched?.displayName ?? key.toUpperCase();
    }

    final metrics = HomePortfolioMetrics(
      availableLots: available,
      reservedLots: reserved,
      soldLots: sold,
      totalLots: lots.length,
      minPricePerSqm: minPrice,
      minTcp: minTcp,
      activeProjectId: key,
      activeProjectName: projectName,
    );

    _cachedHomeMetricsByProject[key] = metrics;
    return metrics;
  }

  /// Fetches recent lot status activities and announcements from Supabase
  static Future<List<Map<String, dynamic>>> fetchRecentLotUpdates({
    int limit = 6,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedRecentLotUpdates != null) {
      return _cachedRecentLotUpdates!;
    }

    final supabase = client;
    final results = <Map<String, dynamic>>[];

    try {
      final mvlcRecent = await supabase
          .from('mvlc_lots')
          .select('id, lot_no, phase, status, updated_at, last_updated, category')
          .inFilter('status', ['sold', 'reserved', 'rsv-p', 'hold'])
          .order('updated_at', ascending: false)
          .limit(limit)
          .timeout(const Duration(seconds: 8));

      for (final r in mvlcRecent as List) {
        final map = Map<String, dynamic>.from(r as Map);
        map['project'] = 'MVLC';
        results.add(map);
      }
    } catch (e) {
      developer.log('Notice fetching recent MVLC lot updates: $e', name: 'SupabaseService');
    }

    try {
      final erhdRecent = await supabase
          .from('erhd_lots')
          .select('id, lot_no, phase, status, updated_at, last_updated, category')
          .inFilter('status', ['sold', 'reserved', 'rsv-p', 'hold'])
          .order('updated_at', ascending: false)
          .limit(limit)
          .timeout(const Duration(seconds: 8));

      for (final r in erhdRecent as List) {
        final map = Map<String, dynamic>.from(r as Map);
        map['project'] = 'ERHD';
        results.add(map);
      }
    } catch (e) {
      developer.log('Notice fetching recent ERHD lot updates: $e', name: 'SupabaseService');
    }

    results.sort((a, b) {
      final tA = DateTime.tryParse(a['updated_at']?.toString() ?? '') ?? DateTime(2000);
      final tB = DateTime.tryParse(b['updated_at']?.toString() ?? '') ?? DateTime(2000);
      return tB.compareTo(tA);
    });

    final finalResults = results.take(limit).toList();
    _cachedRecentLotUpdates = finalResults;
    return finalResults;
  }

  /// Fetches clients for a specific broker (or all if not filtered) from Supabase.
  static Future<List<ClientModel>> fetchClients({
    String? brokerName,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh && _cachedClients != null) {
      if (brokerName != null && brokerName.isNotEmpty) {
        return _cachedClients!
            .where((c) =>
                c.brokerName == null ||
                c.brokerName!.toLowerCase() == brokerName.toLowerCase())
            .toList();
      }
      return _cachedClients!;
    }

    final supabase = client;
    try {
      var query = supabase.from('clients').select('*');
      if (brokerName != null && brokerName.isNotEmpty) {
        query = query.eq('broker_name', brokerName);
      }

      final response = await query
          .order('created_at', ascending: false)
          .timeout(const Duration(seconds: 10));

      final clientList = <ClientModel>[];
      for (final item in response as List) {
        final map = Map<String, dynamic>.from(item as Map);
        clientList.add(ClientModel.fromSupabase(map));
      }

      _cachedClients = clientList;
      return clientList;
    } catch (e) {
      developer.log('Error fetching clients from Supabase: $e', name: 'SupabaseService');
      return _cachedClients ?? [];
    }
  }

  /// Adds a new client to Supabase and inserts it into local cache
  static Future<ClientModel> addClient(
    ClientModel clientData, {
    String? brokerName,
    String? brokerId,
  }) async {
    final supabase = client;
    final payload = clientData.toSupabaseMap(
      brokerName: brokerName,
      brokerId: brokerId,
    );

    try {
      final response = await supabase
          .from('clients')
          .insert(payload)
          .select()
          .single()
          .timeout(const Duration(seconds: 10));

      final newClient = ClientModel.fromSupabase(Map<String, dynamic>.from(response));
      _cachedClients = [newClient, ...(_cachedClients ?? [])];
      return newClient;
    } catch (e) {
      developer.log('Error adding client to Supabase: $e', name: 'SupabaseService');
      _cachedClients = [clientData, ...(_cachedClients ?? [])];
      rethrow;
    }
  }

  /// Updates an existing client's stage in Supabase
  static Future<void> updateClientStage(String clientId, ClientStage stage) async {
    final supabase = client;
    try {
      await supabase.from('clients').update({
        'stage': stage.name,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      }).eq('id', clientId);

      if (_cachedClients != null) {
        final index = _cachedClients!.indexWhere((c) => c.id == clientId);
        if (index != -1) {
          _cachedClients![index] = _cachedClients![index].copyWith(stage: stage);
        }
      }
    } catch (e) {
      developer.log('Error updating client stage in Supabase: $e', name: 'SupabaseService');
      rethrow;
    }
  }

  /// Deletes a client lead from Supabase
  static Future<void> deleteClient(String clientId) async {
    final supabase = client;
    try {
      await supabase.from('clients').delete().eq('id', clientId);
      _cachedClients?.removeWhere((c) => c.id == clientId);
    } catch (e) {
      developer.log('Error deleting client from Supabase: $e', name: 'SupabaseService');
      rethrow;
    }
  }

  /// Clears in-memory client cache (useful for testing and session reset)
  static void clearClientsCache() {
    _cachedClients = null;
  }
}
