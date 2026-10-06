import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/services/contact_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../home/presentation/widgets/home_header.dart';
import '../models/inventory_item.dart';
import '../models/lot_model.dart';
import '../models/mvlc_price_model.dart';
import '../models/project_model.dart';
import '../../map/presentation/interactive_sales_map_screen.dart';
import 'widgets/dynamic_lot_card.dart';
import 'widgets/inventory_filter_tags.dart';
import 'widgets/inventory_floating_status_pill.dart';
import 'widgets/inventory_mode_switcher.dart';
import 'widgets/inventory_project_chips.dart';
import 'widgets/inventory_search_bar.dart';
import 'widgets/inventory_status_filter_bar.dart';
import 'widgets/lot_size_filter_bar.dart';
import 'widgets/lot_size_filter_sheet.dart';
import 'widgets/project_selection_sheet.dart';
import '../../computation/presentation/computation_page.dart';
import '../../clients/presentation/widgets/add_client_modal.dart';

/// Modular Inventory Screen for VHBC Broker Portal connected to Supabase backend.
class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounceTimer;

  String _selectedProjectId = 'all';
  String _selectedStatus = 'available';
  double? _minLotSize;
  double? _maxLotSize;
  InventoryViewMode _viewMode = InventoryViewMode.list;

  List<ProjectModel> _projects = [];
  List<MvlcPriceModel> _mvlcPrices = [];
  List<LotModel> _lots = [];
  bool _isLoading = true;
  bool _isLoadingProjects = true;
  int _availableCount = 0;
  int _reservedCount = 0;
  int _soldCount = 0;
  int _totalCount = 0;

  List<AppliedFilterTag> _activeTags = [
    const AppliedFilterTag(
      id: 'status_available',
      label: 'Status: Available',
      hasStatusDot: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([
      _loadLiveCounts(),
      _loadProjects(),
      _fetchLots(),
    ]);
  }

  Future<void> _loadMvlcPrices({bool forceRefresh = false}) async {
    final prices = await SupabaseService.fetchMvlcPrices(forceRefresh: forceRefresh);
    if (mounted) {
      setState(() {
        _mvlcPrices = prices;
      });
    }
  }

  Future<void> _loadProjects() async {
    setState(() {
      _isLoadingProjects = true;
    });
    final projects = await SupabaseService.fetchProjects();
    if (mounted) {
      setState(() {
        _projects = projects;
        _isLoadingProjects = false;
      });
    }
  }

  List<InventoryProjectOption> get _projectChipsOptions {
    if (_projects.isEmpty) {
      return InventoryProjectChips.defaultOptions;
    }
    final options = <InventoryProjectOption>[
      const InventoryProjectOption(
        id: 'all',
        label: 'All Projects',
        name: 'All Projects',
      ),
    ];
    final seen = <String>{'all'};
    for (final p in _projects) {
      final name = p.displayName;
      if (seen.contains(name.toLowerCase())) continue;
      seen.add(name.toLowerCase());
      options.add(
        InventoryProjectOption(
          id: name,
          label: name,
          code: p.code,
          name: name,
          paused: p.paused,
        ),
      );
    }
    return options;
  }

  bool get _isErhdSelected {
    final lower = _selectedProjectId.trim().toLowerCase();
    return lower == 'erhd' ||
        lower.contains('erhd') ||
        lower.contains('resort hub') ||
        lower.contains('eastwest resort');
  }

  bool get _isMsccSelected {
    final lower = _selectedProjectId.trim().toLowerCase();
    return lower == 'mscc' ||
        lower.contains('mscc') ||
        lower.contains('mountain suites');
  }

  bool get _isSoonToRiseSelected {
    final lower = _selectedProjectId.trim().toLowerCase();
    if (lower == 'all') return false;

    // Check against fetched projects list
    for (final p in _projects) {
      if (p.id.toLowerCase() == lower ||
          (p.code != null && p.code!.toLowerCase() == lower) ||
          p.displayName.toLowerCase() == lower) {
        return p.paused;
      }
    }

    // Check dynamic state from SupabaseService cache / fallback
    return SupabaseService.isProjectPaused(_selectedProjectId, _selectedProjectId);
  }

  String get _soonToRiseProjectCode {
    final lower = _selectedProjectId.trim().toLowerCase();
    for (final p in _projects) {
      if (p.id.toLowerCase() == lower ||
          (p.code != null && p.code!.toLowerCase() == lower) ||
          p.displayName.toLowerCase() == lower) {
        if (p.code != null && p.code!.trim().isNotEmpty) {
          return p.code!.trim().toUpperCase();
        }
        return p.displayName;
      }
    }
    if (lower.contains('lcn') || lower.contains('lakeshore')) return 'LCN';
    if (lower.contains('mcvc')) return 'MCVC';
    if (lower.contains('rhm')) return 'RHM';
    if (lower.contains('rhn')) return 'RHN';
    if (lower.contains('gls') || lower.contains('landscape')) return 'GLS';
    return _selectedProjectId.toUpperCase();
  }

  String get _soonToRiseProjectTitle {
    final lower = _selectedProjectId.trim().toLowerCase();
    for (final p in _projects) {
      if (p.id.toLowerCase() == lower ||
          (p.code != null && p.code!.toLowerCase() == lower) ||
          p.displayName.toLowerCase() == lower) {
        final code = p.code?.trim().toUpperCase();
        if (code != null && code.isNotEmpty && !p.displayName.contains(code)) {
          return '${p.displayName} ($code)';
        }
        return p.displayName;
      }
    }
    final code = _soonToRiseProjectCode;
    switch (code) {
      case 'LCN':
        return 'Lakeshore Community North (LCN)';
      case 'MCVC':
        return 'Mini Complete Vacation Community (MCVC)';
      case 'RHM':
        return 'Resort Hub Muños (RHM)';
      case 'RHN':
        return 'Resort Hub Nasugbu (RHN)';
      case 'GLS':
      default:
        return 'Green Landscape Sanctuary (GLS)';
    }
  }

  String get _soonToRiseProjectSubtitle {
    final code = _soonToRiseProjectCode;
    switch (code) {
      case 'LCN':
        return 'Upcoming Masterplanned Lakeside Community';
      case 'MCVC':
        return 'Upcoming Vacation & Leisure Community';
      case 'RHM':
        return 'Upcoming Resort Hub in Muños';
      case 'RHN':
        return 'Upcoming Resort Hub in Nasugbu';
      case 'GLS':
      default:
        return 'Upcoming Masterplanned Sanctuary Community';
    }
  }

  bool get _isEblfSelected {
    final lower = _selectedProjectId.trim().toLowerCase();
    return lower == 'eblf' ||
        lower.contains('eblf') ||
        lower.contains('eastwest breeze') ||
        lower.contains('breeze');
  }

  bool get _isMvlcSelected {
    final lower = _selectedProjectId.trim().toLowerCase();
    return lower == 'all' ||
        lower == 'mvlc' ||
        lower.contains('mountain view') ||
        lower.contains('mvlc');
  }

  void _openProjectSelector() {
    ProjectSelectionSheet.show(
      context: context,
      projects: _projects,
      selectedProjectId: _selectedProjectId,
      onProjectSelected: (project) {
        setState(() {
          if (project == null) {
            _selectedProjectId = 'all';
          } else {
            final c = (project.code ?? '').trim().toUpperCase();
            final d = project.displayName.trim().toUpperCase();
            if (c == 'ERHD' || d == 'ERHD') {
              _selectedProjectId = 'ERHD';
            } else if (c == 'MSCC' || d == 'MSCC') {
              _selectedProjectId = 'MSCC';
            } else if (c == 'GLS' || d == 'GLS') {
              _selectedProjectId = 'GLS';
            } else if (c == 'LCN' || d == 'LCN') {
              _selectedProjectId = 'LCN';
            } else if (c == 'MCVC' || d == 'MCVC') {
              _selectedProjectId = 'MCVC';
            } else if (c == 'RHM' || d == 'RHM') {
              _selectedProjectId = 'RHM';
            } else if (c == 'RHN' || d == 'RHN') {
              _selectedProjectId = 'RHN';
            } else if (c == 'EBLF' || d == 'EBLF') {
              _selectedProjectId = 'EBLF';
            } else {
              _selectedProjectId = project.displayName;
            }
          }
        });
        _loadLiveCounts();
        _fetchLots();
      },
    );
  }

  Future<void> _loadLiveCounts() async {
    if (_isSoonToRiseSelected || _isEblfSelected) {
      if (mounted) {
        setState(() {
          _availableCount = 0;
          _reservedCount = 0;
          _soldCount = 0;
          _totalCount = 0;
        });
      }
      return;
    }
    final isErhd = _isErhdSelected;
    final isMscc = _isMsccSelected;
    final table = isMscc ? 'mscc_lots' : (isErhd ? 'erhd_lots' : 'mvlc_lots');
    final summary = await SupabaseService.fetchLotsSummary(table: table);
    if (mounted) {
      setState(() {
        _availableCount = summary['available'] ?? 0;
        _reservedCount = (summary['reserved'] ?? 0) + (summary['hold'] ?? 0);
        _soldCount = summary['sold'] ?? 0;
        _totalCount = summary['total'] ?? 0;
      });
    }
  }


  void _onStatusChanged(String status) {
    setState(() {
      _selectedStatus = status;
      _updateActiveStatusTag(status);
    });
    _fetchLots();
  }

  void _updateActiveStatusTag(String status) {
    _activeTags.removeWhere((t) => t.id.startsWith('status_'));
    if (status == 'available') {
      _activeTags.insert(
        0,
        const AppliedFilterTag(
          id: 'status_available',
          label: 'Status: Available',
          hasStatusDot: true,
        ),
      );
    } else if (status == 'reserved') {
      _activeTags.insert(
        0,
        const AppliedFilterTag(
          id: 'status_reserved',
          label: 'Status: Reserved',
          hasStatusDot: true,
        ),
      );
    } else if (status == 'sold') {
      _activeTags.insert(
        0,
        const AppliedFilterTag(
          id: 'status_sold',
          label: 'Status: Sold',
          hasStatusDot: true,
        ),
      );
    }
  }

  void _onLotSizePresetSelected(double? min, double? max, String label) {
    setState(() {
      _minLotSize = min;
      _maxLotSize = max;
      _updateActiveLotSizeTag(min, max, label);
    });
    _fetchLots();
  }

  void _updateActiveLotSizeTag(double? min, double? max, String? label) {
    _activeTags.removeWhere((t) => t.id == 'lot_size');
    if (min != null || max != null) {
      final tagLabel = label ??
          (min != null && max != null
              ? 'Size: ${min.toInt()} - ${max.toInt()} sqm'
              : (min != null ? 'Size: >= ${min.toInt()} sqm' : 'Size: <= ${max!.toInt()} sqm'));
      _activeTags.add(
        AppliedFilterTag(
          id: 'lot_size',
          label: tagLabel,
        ),
      );
    }
  }

  void _openLotSizeFilterSheet() {
    LotSizeFilterSheet.show(
      context: context,
      currentMin: _minLotSize,
      currentMax: _maxLotSize,
      isUnit: _isMsccSelected,
      onApply: (min, max, label) {

        setState(() {
          _minLotSize = min;
          _maxLotSize = max;
          _updateActiveLotSizeTag(min, max, label);
        });
        _fetchLots();
      },
    );
  }

  Future<void> _fetchLots() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
    });

    String? status;
    if (_selectedStatus != 'all') {
      status = _selectedStatus;
    }

    int? phase;
    String? mapSection;
    if (_activeTags.any((t) => t.id == 'phase_2_east')) {
      phase = 2;
      mapSection = 'East';
    } else if (_activeTags.any((t) => t.id == 'phase_2')) {
      phase = 2;
    } else if (_selectedProjectId.toLowerCase().contains('phase 2 east') ||
        _selectedProjectId.toLowerCase().contains('phase 2e') ||
        _selectedProjectId.toLowerCase().contains('phase-2-east')) {
      phase = 2;
      mapSection = 'East';
    } else if (_selectedProjectId.toLowerCase().contains('phase 1') ||
        _selectedProjectId == 'phase1') {
      phase = 1;
    } else if (_selectedProjectId.toLowerCase().contains('phase 2') ||
        _selectedProjectId == 'phase2') {
      phase = 2;
    } else if (_selectedProjectId.toLowerCase().contains('phase 3') ||
        _selectedProjectId == 'phase3') {
      phase = 3;
    }

    final isErhd = _isErhdSelected;
    final isMscc = _isMsccSelected;
    final isMvlcSelected = _isMvlcSelected;

    if (!isMvlcSelected && !isErhd && !isMscc) {
      if (mounted) {
        setState(() {
          _lots = [];
          _isLoading = false;
        });
      }
      return;
    }

    final table = isMscc ? 'mscc_lots' : (isErhd ? 'erhd_lots' : 'mvlc_lots');
    final query = _searchController.text.trim();
    final fetched = await SupabaseService.fetchLots(
      status: status,
      phase: (isErhd || isMscc) ? null : phase,
      mapSection: (isErhd || isMscc) ? null : mapSection,
      minSize: _minLotSize,
      maxSize: _maxLotSize,
      searchQuery: query.isNotEmpty ? query : null,
      table: table,
      defaultProject: isMscc ? 'MSCC' : (isErhd ? 'ERHD' : 'MVLC'),
      limit: 100,
    );

    if (mounted) {
      if (!isErhd && !isMscc && _mvlcPrices.isEmpty) {
        _mvlcPrices = await SupabaseService.fetchMvlcPrices();
      }

      final processedLots = fetched.map((l) {
        if (isMscc) {
          return l.copyWith(project: 'MSCC');
        }
        if (isErhd) {
          return l.copyWith(project: 'ERHD');
        }
        var lot = l.copyWith(project: 'MVLC');


        // Dynamically resolve price from mvlc_price table by Phase number and category
        if (_mvlcPrices.isNotEmpty && lot.phase != null) {
          final phasePrice = _mvlcPrices
              .where((p) => p.phase == lot.phase)
              .firstOrNull;
          if (phasePrice != null) {
            final pricePerSqm = phasePrice.getPriceForCategory(lot.category);
            if (pricePerSqm != null && pricePerSqm > 0) {
              final total = lot.sizeSqm > 0
                  ? (lot.sizeSqm * pricePerSqm)
                  : lot.total;
              lot = lot.copyWith(
                pricePerSqm: pricePerSqm,
                total: total,
                project: 'MVLC',
              );
            }
          }
        }
        return lot;
      }).toList();

      setState(() {
        _lots = processedLots;
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _fetchLots();
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _handleRefresh() async {
    await Future.wait([
      _loadLiveCounts(),
      _loadMvlcPrices(forceRefresh: true),
      _loadProjects(),
      _fetchLots(),
    ]);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Inventory synchronized with Supabase ($_availableCount available lots).',
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showActionFeedback(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: HomeHeader(
        greetingText: _isMsccSelected ? 'MSCC Unit Inventory' : 'VHBC Lot Inventory',
        avatarUrl: AuthService.currentUser?.avatarUrl,
        onNotificationTap: () => NotificationService.showNotificationsModal(context),
        onProfileTap: () {
          final name = AuthService.currentUser?.displayName ?? 'Broker';
          _showActionFeedback('Broker Profile: $name');
        },
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primaryContainer,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Search & Controls Surface
                  Container(
                    color: AppColors.surface,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Search Bar & Filter Button
                        InventorySearchBar(
                          controller: _searchController,
                          activeFilterCount: _activeTags.length,
                          onChanged: _onSearchChanged,
                          onClear: () {
                            _fetchLots();
                          },
                          onScanTap: () {
                            _showActionFeedback('Document & QR scanner opened');
                          },
                          onFilterTap: _openLotSizeFilterSheet,
                        ),
                        const SizedBox(height: 10),

                        // Mode Switcher (List vs Map) & Live Sync
                        InventoryModeSwitcher(
                          viewMode: _viewMode,
                          onViewModeChanged: (mode) {
                            setState(() {
                              _viewMode = mode;
                            });
                          },
                        ),
                        const SizedBox(height: 10),

                        // Status Filter Bar (Available, Reserved, Sold, All Lots)
                        InventoryStatusFilterBar(
                          selectedStatus: _selectedStatus,
                          availableCount: _availableCount,
                          reservedCount: _reservedCount,
                          soldCount: _soldCount,
                          totalCount: _totalCount,
                          isUnit: _isMsccSelected,
                          onStatusSelected: _onStatusChanged,
                        ),

                        const SizedBox(height: 10),

                        // Project Carousel Chips (Dynamic from Supabase)
                        InventoryProjectChips(
                          selectedProjectId: _selectedProjectId,
                          options: _projectChipsOptions,
                          isLoading: _isLoadingProjects,
                          onOpenSelector: _openProjectSelector,
                          onSelectProject: (id) {
                            setState(() {
                              _selectedProjectId = id;
                            });
                            _loadLiveCounts();
                            _fetchLots();
                          },
                        ),
                        const SizedBox(height: 10),

                        // Lot Size Range Filter Bar (< 200, 200-300, 301-500, 500+, Custom)
                        LotSizeFilterBar(
                          selectedMin: _minLotSize,
                          selectedMax: _maxLotSize,
                          onSelectPreset: _onLotSizePresetSelected,
                          onOpenCustomFilter: _openLotSizeFilterSheet,
                        ),
                        const SizedBox(height: 10),

                        // Applied Quick Filter Tags
                        InventoryFilterTags(
                          tags: _activeTags,
                          onRemoveTag: (tagId) {
                            setState(() {
                              _activeTags = _activeTags
                                  .where((t) => t.id != tagId)
                                  .toList();
                              if (tagId.startsWith('status_')) {
                                _selectedStatus = 'all';
                              } else if (tagId == 'lot_size') {
                                _minLotSize = null;
                                _maxLotSize = null;
                              }
                            });
                            _fetchLots();
                          },
                          onResetAll: () {
                            setState(() {
                              _activeTags = [];
                              _selectedStatus = 'all';
                              _selectedProjectId = 'all';
                              _minLotSize = null;
                              _maxLotSize = null;
                              _searchController.clear();
                            });
                            _fetchLots();
                          },
                        ),
                      ],
                    ),
                  ),

                  // Feed View: List vs Map
                  if (_viewMode == InventoryViewMode.list) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 8),

                          if (_isLoading && _lots.isEmpty) ...[
                            _buildLoadingShimmer(),
                          ] else if (_lots.isEmpty) ...[
                            _buildEmptyState(),
                          ] else ...[
                            ..._lots.map((lot) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: DynamicLotCard(
                                    lot: lot,
                                    onComputeTap: (l) =>
                                         Navigator.of(context).push(
                                           MaterialPageRoute(
                                             builder: (context) =>
                                                 ComputationPage(lotModel: l),
                                           ),
                                         ),
                                    onReserveTap: (l) => ContactService.callSalesDesk(
                                      context: context,
                                      title: 'Lot Reservation Desk',
                                      subtitle: 'Direct line to hold lot with sales coordinator',
                                      lotInfo: '${l.formattedLotNo} • ${l.formattedTotal}',
                                    ),
                                    onViewLotTap: (l) => _showActionFeedback(
                                        'Viewing ${l.formattedLotNo} Map Position'),
                                    onJoinWaitlistTap: (l) => _showActionFeedback(
                                        'Joined Waitlist for ${l.formattedLotNo}'),
                                    onBookmarkTap: (l) => _showActionFeedback(
                                        'Bookmarked ${l.formattedLotNo}'),
                                  ),
                                )),
                          ],

                          // Extra padding for bottom floating pill and navigation
                          const SizedBox(height: 72),
                        ],
                      ),
                    ),
                  ] else ...[
                    // Map View Container
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 380,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: AppColors.outlineVariant.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceContainer,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Icon(
                                  Icons.map,
                                  size: 28,
                                  color: AppColors.primaryContainer,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Interactive Sales Lot Map',
                                style: AppTextStyles.titleMd.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tap lots directly on the subdivision map to view real-time status.',
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodySm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const InteractiveSalesMapScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.explore, size: 16),
                                    label: const Text('Open Interactive Map'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryContainer,
                                      foregroundColor: AppColors.onPrimary,
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  OutlinedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        _viewMode = InventoryViewMode.list;
                                      });
                                    },
                                    icon: const Icon(Icons.format_list_bulleted, size: 16),
                                    label: const Text('List View'),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: AppColors.onSurface,
                                      side: const BorderSide(
                                        color: AppColors.outlineVariant,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 72),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Floating Inventory Status Pill
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Center(
              child: InventoryFloatingStatusPill(
                onScrollToTop: _scrollToTop,
                availableCount: _availableCount,
                totalCount: _totalCount,
                isUnit: _isMsccSelected,
                icon: _isEblfSelected
                    ? Icons.verified
                    : (_isSoonToRiseSelected ? Icons.auto_awesome : null),
                iconColor: _isEblfSelected ? const Color(0xFFF87171) : null,
                customLabel: _isEblfSelected
                    ? 'EBLF • Sold Out'
                    : (_isSoonToRiseSelected ? '$_soonToRiseProjectCode • Soon to Rise' : null),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 220,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryContainer,
              strokeWidth: 2.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    if (_isSoonToRiseSelected) {
      return _buildGlsSoonToRiseInventoryState();
    }

    if (_isEblfSelected) {
      return _buildEblfSoldOutInventoryState();
    }

    final isNonSupportedProject = !_isMvlcSelected && !_isErhdSelected && !_isMsccSelected && !_isSoonToRiseSelected && !_isEblfSelected;

    if (isNonSupportedProject) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.apartment,
                size: 30,
                color: AppColors.primaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No lots listed for $_selectedProjectId',
              style: AppTextStyles.titleMd.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Inventory records for $_selectedProjectId are currently not available.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedProjectId = 'MVLC';
                });
                _loadLiveCounts();
                _fetchLots();
              },
              icon: const Icon(Icons.apartment, size: 16),
              label: const Text('View MVLC Inventory'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.search_off,
              size: 28,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            _isMsccSelected
                ? 'No MSCC units found'
                : (_isErhdSelected ? 'No ERHD lots found' : 'No properties found'),
            style: AppTextStyles.titleMd.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _isMsccSelected
                ? 'Try adjusting your search query or reset filter tags to view available units.'
                : 'Try adjusting your search query or reset filter tags to view available lots.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              _searchController.clear();
              setState(() {
                _activeTags = [];
                _selectedStatus = 'all';
                _minLotSize = null;
                _maxLotSize = null;
              });
              _fetchLots();
            },
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildGlsSoonToRiseInventoryState() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF59E0B)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 15, color: Color(0xFFB45309)),
                SizedBox(width: 6),
                Text(
                  'SOON TO RISE',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: Color(0xFFB45309),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.villa_outlined,
              size: 32,
              color: Color(0xFFD97706),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _soonToRiseProjectTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineSm.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _soonToRiseProjectSubtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Lot inventory, subdivision blueprints, and official TCP computation tables for $_soonToRiseProjectTitle are currently in pre-launch preparation. Register prospective buyer leads now to secure early priority hold privileges.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureBadge('Pre-Launch Stage'),
              _buildFeatureBadge(_soonToRiseProjectTitle),
              _buildFeatureBadge('Priority Lead Lock'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedProjectId = 'MVLC';
                    });
                    _loadLiveCounts();
                    _fetchLots();
                  },
                  icon: const Icon(Icons.explore, size: 16),
                  label: const Text('View MVLC Lots'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedProjectId = 'ERHD';
                    });
                    _loadLiveCounts();
                    _fetchLots();
                  },
                  icon: const Icon(Icons.apartment, size: 16),
                  label: const Text('View ERHD Lots'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryContainer,
                    side: const BorderSide(color: AppColors.outlineVariant),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEblfSoldOutInventoryState() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEF4444).withValues(alpha: 0.35),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEF4444)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock, size: 14, color: Color(0xFFDC2626)),
                SizedBox(width: 6),
                Text(
                  '100% SOLD OUT',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: Color(0xFFDC2626),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.verified,
              size: 32,
              color: Color(0xFFDC2626),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'EBLF is Fully Sold Out',
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineSm.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Eastwest Breeze Leisure Farm',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(
              color: const Color(0xFFDC2626),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'All residential and farm lot inventory for EBLF has been completely sold out and officially turned over. Active units are currently available in Mountain View Leisure Community (MVLC) and Eastwest Resort Hub and Development (ERHD).',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _buildFeatureBadge('100% Sold Out'),
              _buildFeatureBadge('Turned Over to Owners'),
              _buildFeatureBadge('Waitlist / Secondary Market'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedProjectId = 'MVLC';
                    });
                    _loadLiveCounts();
                    _fetchLots();
                  },
                  icon: const Icon(Icons.explore, size: 16),
                  label: const Text('View MVLC Lots'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedProjectId = 'ERHD';
                    });
                    _loadLiveCounts();
                    _fetchLots();
                  },
                  icon: const Icon(Icons.apartment, size: 16),
                  label: const Text('View ERHD Lots'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryContainer,
                    side: const BorderSide(color: AppColors.outlineVariant),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                AddClientModal.show(
                  context,
                  availableProjects: const ['MVLC', 'ERHD', 'MSCC'],
                  onClientAdded: (_) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Client lead registered successfully!'),
                          backgroundColor: AppColors.primaryContainer,
                        ),
                      );
                    }
                  },
                );
              },
              icon: const Icon(Icons.person_add_alt_1, size: 16, color: AppColors.secondary),
              label: const Text(
                'Register Client Lead',
                style: TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: AppTextStyles.labelSm.copyWith(
          color: AppColors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }
}
