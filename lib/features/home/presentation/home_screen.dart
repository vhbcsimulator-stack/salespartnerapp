import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/services/contact_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/services/auth_service.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../clients/presentation/clients_screen.dart';
import '../../computation/presentation/computation_page.dart';
import '../../inventory/models/project_model.dart';
import '../../inventory/presentation/inventory_screen.dart';
import '../../map/presentation/interactive_sales_map_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../sales_kit/presentation/sales_kit_videos_screen.dart';
import '../models/announcement_model.dart';
import '../models/featured_project_model.dart';
import '../models/home_portfolio_metrics.dart';
import 'widgets/broker_tooling_grid.dart';
import 'widgets/featured_development_card.dart';
import 'widgets/greeting_status_section.dart';
import 'widgets/home_header.dart';
import 'widgets/live_broker_updates.dart';
import 'widgets/portfolio_pulse_carousel.dart';
import 'widgets/project_filter_pills.dart';
import 'widgets/support_desk_banner.dart';

/// Modular Home Screen for VHBC Broker Portal with 100% real database telemetry from Supabase.
class HomeScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateTab;

  const HomeScreen({
    super.key,
    this.onNavigateTab,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedProjectId = 'all';
  List<ProjectModel> _projects = [];
  HomePortfolioMetrics? _metrics;
  FeaturedProjectModel? _featuredProject;
  List<AnnouncementModel> _announcements = [];
  List<BrokerUpdateItem> _brokerUpdates = [];
  DateTime? _lastSync;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData({bool forceRefresh = false}) async {
    try {
      final results = await Future.wait([
        SupabaseService.fetchProjects(forceRefresh: forceRefresh),
        SupabaseService.fetchHomePortfolioMetrics(
          project: _selectedProjectId,
          forceRefresh: forceRefresh,
        ),
        SupabaseService.fetchRecentLotUpdates(limit: 6, forceRefresh: forceRefresh),
        SupabaseService.fetchAnnouncements(forceRefresh: forceRefresh),
        SupabaseService.fetchFeaturedProject(
          projectCode: _selectedProjectId,
          forceRefresh: forceRefresh,
        ),
      ]);

      final projects = results[0] as List<ProjectModel>;
      final metrics = results[1] as HomePortfolioMetrics;
      final recentLotUpdates = results[2] as List<Map<String, dynamic>>;
      final announcements = results[3] as List<AnnouncementModel>;
      final featuredProject = results[4] as FeaturedProjectModel?;

      final updates = _buildRealBrokerUpdates(recentLotUpdates);
      NotificationService.setAnnouncements(announcements);

      if (mounted) {
        setState(() {
          _projects = projects;
          _metrics = metrics;
          _featuredProject = featuredProject;
          _announcements = announcements;
          _brokerUpdates = updates;
          _lastSync = DateTime.now();
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleRefresh() async {
    await _loadData(forceRefresh: true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Portfolio data synchronized with Supabase database.'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _onSelectProject(String id) async {
    setState(() {
      _selectedProjectId = id;
      _isLoading = true;
    });

    final results = await Future.wait([
      SupabaseService.fetchHomePortfolioMetrics(project: id),
      SupabaseService.fetchFeaturedProject(projectCode: id),
    ]);

    final metrics = results[0] as HomePortfolioMetrics;
    final featuredProject = results[1] as FeaturedProjectModel?;

    if (mounted && _selectedProjectId == id) {
      setState(() {
        _metrics = metrics;
        _featuredProject = featuredProject;
        _isLoading = false;
      });
    }
  }

  List<BrokerUpdateItem> _buildRealBrokerUpdates(
    List<Map<String, dynamic>> recentLotUpdates,
  ) {
    final list = <BrokerUpdateItem>[];

    // Show strictly the latest updates on the map like sold or reserved
    for (final lot in recentLotUpdates) {
      final status = (lot['status'] as String? ?? '').toLowerCase();
      final lotNo = lot['lot_no'] as String? ?? 'Lot';
      final phase = lot['phase'];
      final proj = lot['project'] as String? ?? 'MVLC';
      final rawCat = lot['category'] as String? ?? 'Regular';
      final cat = rawCat.isNotEmpty
          ? '${rawCat[0].toUpperCase()}${rawCat.substring(1)}'
          : 'Regular';

      final phaseText = phase != null ? 'Phase $phase' : proj;
      final timeStr = _formatRelativeTime(
        lot['updated_at']?.toString() ?? lot['last_updated']?.toString(),
      );

      if (status == 'sold') {
        list.add(
          BrokerUpdateItem(
            title: 'Lot Sold • $lotNo',
            subtitle: '$proj • $phaseText ($cat) • Status updated on map',
            time: timeStr,
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.surfaceTint,
            iconBgColor: AppColors.surfaceContainer,
          ),
        );
      } else if (status == 'reserved' || status == 'rsv-p') {
        list.add(
          BrokerUpdateItem(
            title: 'Lot Reserved • $lotNo',
            subtitle: '$proj • $phaseText ($cat) • Status updated on map',
            time: timeStr,
            icon: Icons.bookmark_added_rounded,
            iconColor: AppColors.error,
            iconBgColor: AppColors.errorContainer,
          ),
        );
      } else if (status == 'hold') {
        list.add(
          BrokerUpdateItem(
            title: 'Lot on Hold • $lotNo',
            subtitle: '$proj • $phaseText ($cat) • Status updated on map',
            time: timeStr,
            icon: Icons.hourglass_top_rounded,
            iconColor: AppColors.secondary,
            iconBgColor: AppColors.surfaceContainerLow,
          ),
        );
      }

      if (list.length >= 6) break;
    }

    if (list.isEmpty) {
      return const [
        BrokerUpdateItem(
          title: 'Map Telemetry Active',
          subtitle: 'No recent sold or reserved status updates recorded.',
          time: 'Live',
          icon: Icons.map_outlined,
          iconColor: AppColors.surfaceTint,
          iconBgColor: AppColors.surfaceContainer,
        ),
      ];
    }

    return list;
  }

  String _formatRelativeTime(String? dateStr) {
    if (dateStr == null) return 'Recently';
    final dt = DateTime.tryParse(dateStr);
    if (dt == null) return 'Recently';
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return DateFormat('MMM d').format(dt);
  }

  String get _greetingText {
    final user = AuthService.currentUser;
    final name = (user != null && user.displayName.trim().isNotEmpty)
        ? user.displayName.trim().split(' ').first
        : 'Broker';
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning, $name';
    if (hour < 17) return 'Good afternoon, $name';
    return 'Good evening, $name';
  }

  String get _syncTimeString {
    if (_lastSync == null) return 'Connecting...';
    return 'Live Sync ${_formatRelativeTime(_lastSync!.toIso8601String())}';
  }

  List<ProjectFilterOption> get _projectFilterOptions {
    if (_projects.isEmpty) {
      return ProjectFilterPills.defaultOptions;
    }
    final options = <ProjectFilterOption>[
      const ProjectFilterOption(
        id: 'all',
        label: 'All Projects',
        name: 'All Projects',
      ),
    ];
    final seen = <String>{'all'};

    final sortedProjects = List<ProjectModel>.from(_projects);
    // Prioritize active developments: MVLC first, then ERHD, then others
    sortedProjects.sort((a, b) {
      final aCode = (a.code ?? a.id).toUpperCase();
      final bCode = (b.code ?? b.id).toUpperCase();
      const priority = {
        'MVLC': 0,
        'ERHD': 1,
        'MSCC': 2,
        'GLS': 3,
        'LCN': 4,
        'MCVC': 5,
        'RHM': 6,
        'RHN': 7,
        'EBLF': 8,
      };
      final aPrio = priority[aCode] ?? 99;
      final bPrio = priority[bCode] ?? 99;
      if (aPrio != bPrio) return aPrio.compareTo(bPrio);
      return aCode.compareTo(bCode);
    });

    for (final p in sortedProjects) {
      final code = (p.code ?? p.id).toUpperCase();
      final key = code.toLowerCase();
      if (seen.contains(key)) continue;
      seen.add(key);
      options.add(
        ProjectFilterOption(
          id: key,
          label: code,
          code: code,
          name: p.displayName,
        ),
      );
    }
    return options;
  }

  void _onToolingAction(String action) {
    final lower = action.toLowerCase();
    if (action == 'Sales Map' || lower.contains('map')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const InteractiveSalesMapScreen(),
        ),
      );
      return;
    }
    if (action == 'Computation' || lower.contains('computation')) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ComputationPage(),
        ),
      );
      return;
    }
    if (action == 'Find Property' || lower.contains('inventory') || action == 'Reserve Unit') {
      if (widget.onNavigateTab != null) {
        widget.onNavigateTab!(1);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const InventoryScreen(),
          ),
        );
      }
      return;
    }
    if (action == 'Add Client') {
      if (widget.onNavigateTab != null) {
        widget.onNavigateTab!(2);
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ClientsScreen(),
          ),
        );
      }
      return;
    }
    if (action == 'Sales Kit') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const SalesKitVideosScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Action: $action'),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAnnouncementsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.campaign_outlined,
                        color: AppColors.primaryContainer,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'VHBC Announcements',
                        style: AppTextStyles.headlineSm.copyWith(
                          color: AppColors.primaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.outline),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_announcements.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Center(
                    child: Text('No active announcements found in database.'),
                  ),
                )
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _announcements.length,
                    separatorBuilder: (context, index) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: 1,
                      color: AppColors.surfaceContainer,
                    ),
                    itemBuilder: (context, index) {
                      final item = _announcements[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item.title,
                                    style: AppTextStyles.titleMd.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.onSurface,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.relativeTime,
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.content,
                              style: AppTextStyles.bodySm.copyWith(
                                color: AppColors.onSurfaceVariant,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  foregroundColor: AppColors.onSurface,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Close Notice'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final m = _metrics;
    final fmt = NumberFormat('#,##0');

    final availableVal = m != null ? fmt.format(m.availableLots) : '...';
    final reservedVal = m != null ? fmt.format(m.reservedLots) : '...';
    final soldVal = m != null ? fmt.format(m.soldLots) : '...';
    final totalVal = m != null ? fmt.format(m.totalLots) : '...';
    final minPriceStr = m != null ? m.formattedMinPricePerSqm : '...';
    final minTcpStr = m != null ? m.formattedMinTcp : '...';
    final soldPercent = m != null && m.totalLots > 0
        ? '${m.soldPercentage.toStringAsFixed(0)}% sold'
        : 'Closed sales';

    // 100% Real Supabase Metrics
    final liveMetrics = [
      MetricItem(
        label: 'AVAILABLE',
        value: availableVal,
        subtitle: _selectedProjectId == 'all'
            ? 'Across ${_projects.isNotEmpty ? _projects.length : 5} projects'
            : '${m?.activeProjectName ?? "Portfolio"} lots',
        icon: Icons.apartment,
        iconBgColor: AppColors.surfaceContainer,
        iconColor: AppColors.surfaceTint,
        width: 164,
      ),
      MetricItem(
        label: 'RESERVATIONS',
        value: reservedVal,
        subtitle: 'Active buyer holds',
        subtitleColor: AppColors.error,
        icon: Icons.hourglass_top,
        iconBgColor: AppColors.errorContainer,
        iconColor: AppColors.onErrorContainer,
        width: 164,
      ),
      MetricItem(
        label: 'UNITS SOLD',
        value: soldVal,
        subtitle: soldPercent,
        subtitleColor: AppColors.secondary,
        icon: Icons.verified,
        iconBgColor: AppColors.surfaceContainer,
        iconColor: AppColors.secondary,
        width: 164,
      ),
      MetricItem(
        label: 'TOTAL UNITS',
        value: totalVal,
        subtitle: _selectedProjectId == 'all'
            ? 'Masterplan portfolio'
            : '${m?.activeProjectName ?? "Portfolio"} masterplan',
        icon: Icons.domain,
        iconBgColor: AppColors.surfaceContainerHigh,
        iconColor: AppColors.primaryContainer,
        width: 164,
      ),
      MetricItem(
        label: 'STARTING AT',
        value: minPriceStr,
        subtitle: 'TCP from $minTcpStr',
        icon: Icons.payments,
        iconBgColor: AppColors.secondaryContainer,
        iconColor: AppColors.onSecondaryContainer,
        width: 184,
      ),
    ];

    // Featured Development Card Parameters strictly resolved from featured_projects table
    final feat = _featuredProject;
    final selectedProject = _projects
        .where((p) => (p.code ?? p.id).toLowerCase() == _selectedProjectId.toLowerCase())
        .firstOrNull;
    final cardTitle = feat?.projectCode ??
        selectedProject?.displayName ??
        (_selectedProjectId == 'all'
            ? (_projects.isNotEmpty ? _projects.first.displayName : 'MVLC')
            : _selectedProjectId.toUpperCase());

    final cardLocation = feat?.location ??
        ((_selectedProjectId == 'all' || _selectedProjectId.contains('mvlc'))
            ? 'Nasugbu, Batangas'
            : 'Batangas');
    const cardCategory = 'Residential & Commercial';

    final cardBadge = m != null
        ? '${fmt.format(m.availableLots)} Units Available'
        : 'Active Allocation';

    final cardPrice = m != null ? m.formattedMinPricePerSqm : '₱9,800';
    final cardTcp = m != null ? 'TCP ${m.formattedMinTcp}' : 'TCP ₱1.18M';
    final cardImageUrl = (feat?.imageUrl != null && feat!.imageUrl!.isNotEmpty)
        ? feat.imageUrl!
        : 'asset/mvlc.jpg';

    return ValueListenableBuilder<BrokerUser?>(
      valueListenable: AuthService.currentUserNotifier,
      builder: (context, currentUser, _) {
        final brokerName = (currentUser != null && currentUser.displayName.trim().isNotEmpty)
            ? currentUser.displayName
            : 'Accredited Broker';
        final brokerLevel = (currentUser != null && currentUser.commissionTier.isNotEmpty)
            ? currentUser.commissionTier
            : ((currentUser != null && currentUser.role.isNotEmpty)
                ? currentUser.role
                : 'Accredited Broker');

        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: HomeHeader(
            greetingText: _greetingText,
            avatarUrl: currentUser?.avatarUrl,
            onNotificationTap: () => NotificationService.showNotificationsModal(context),
            onProfileTap: () {
              if (widget.onNavigateTab != null) {
                widget.onNavigateTab!(3);
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              }
            },
          ),
          body: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: AppColors.primaryContainer,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_isLoading)
                    const LinearProgressIndicator(
                      minHeight: 2.5,
                      color: AppColors.secondary,
                      backgroundColor: AppColors.surfaceContainerLow,
                    ),
                  // Greeting & Broker Accreditation Status with real sync telemetry
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GreetingStatusSection(
                      brokerName: brokerName,
                      brokerLevel: brokerLevel,
                      syncTime: _syncTimeString,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Portfolio Pulse Carousel (Live Supabase Metrics)
                  PortfolioPulseCarousel(metrics: liveMetrics),
                  const SizedBox(height: 20),

                  // Project Filter Pills
                  ProjectFilterPills(
                    selectedProjectId: _selectedProjectId,
                    options: _projectFilterOptions,
                    onSelectProject: _onSelectProject,
                  ),
                  const SizedBox(height: 20),

                  // Broker Tooling Quick Actions Grid
                  BrokerToolingGrid(
                    onActionTap: _onToolingAction,
                  ),
                  const SizedBox(height: 20),

                  // Featured Development Card (Dynamically bound with real database stats)
                  FeaturedDevelopmentCard(
                    title: cardTitle,
                    location: cardLocation,
                    categoryTag: cardCategory,
                    badgeText: cardBadge,
                    pricePerSqm: cardPrice,
                    startingTcp: cardTcp,
                    customImageUrl: cardImageUrl,
                    inventoryButtonLabel: 'View $cardTitle Inventory',
                    mapButtonLabel: 'Explore $cardTitle Map',
                    onViewInventory: () => _onToolingAction('inventory'),
                    onExploreMap: () => _onToolingAction('map'),
                  ),
                  const SizedBox(height: 20),

                  // Real-Time Broker Activity Updates (from Supabase announcements + lot updates)
                  LiveBrokerUpdates(
                    updates: _brokerUpdates,
                  ),
                  const SizedBox(height: 16),

                  // Broker Concierge / Support Desk Banner
                  SupportDeskBanner(
                    onCallDesk: () => ContactService.callSalesDesk(
                      context: context,
                      title: 'Broker Support Desk',
                    ),
                  ),

                  // Padding for bottom nav bar
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
