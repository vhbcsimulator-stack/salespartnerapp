import 'package:flutter/material.dart';
import '../../../core/services/ghl_service.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/services/auth_service.dart';
import '../../home/presentation/widgets/home_header.dart';
import '../data/initial_clients.dart';
import '../models/client_model.dart';
import 'widgets/add_client_modal.dart';
import 'widgets/client_card.dart';
import 'widgets/client_detail_sheet.dart';

/// Full-featured, interactive Clients screen conforming to the VHBC Broker CRM design spec.
class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  late List<ClientModel> _allClients;
  final TextEditingController _searchController = TextEditingController();

  ClientStage? _selectedStageFilter; // null = All
  String? _selectedProjectFilter; // null = All Projects
  List<String> _availableProjects = [
    'MVLC',
    'MSCC',
    'ERHD',
    'GLS',
    'LCN',
    'MCVC',
    'RHM',
    'RHN',
    'EBLF',
  ];
  bool _isRefreshing = false;
  bool _isLoadingClients = false;

  @override
  void initState() {
    super.initState();
    _allClients = getInitialClients();
    _searchController.addListener(_onSearchChanged);
    _loadProjects();
    _loadClients();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {});
  }

  Future<void> _loadClients({bool forceRefresh = false}) async {
    final brokerName = AuthService.currentUser?.displayName ?? 'Juan Dela Cruz';
    setState(() => _isLoadingClients = true);
    try {
      final clients = await SupabaseService.fetchClients(
        brokerName: brokerName,
        forceRefresh: forceRefresh,
      );
      if (mounted) {
        setState(() {
          _allClients = clients;
          _isLoadingClients = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingClients = false);
      }
    }
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await SupabaseService.fetchProjects();
      if (projects.isNotEmpty && mounted) {
        final codes = <String>{};
        for (final p in projects) {
          final code = (p.code ?? p.name ?? '').trim().toUpperCase();
          if (code.isNotEmpty) codes.add(code);
        }
        if (codes.isNotEmpty) {
          setState(() {
            _availableProjects = codes.toList()..sort();
          });
        }
      }
    } catch (_) {}
  }

  List<ClientModel> get _filteredClients {
    final query = _searchController.text.trim().toLowerCase();

    return _allClients.where((client) {
      // Stage filter
      if (_selectedStageFilter != null &&
          client.stage != _selectedStageFilter) {
        return false;
      }

      // Project filter
      if (_selectedProjectFilter != null &&
          client.projectCode.toUpperCase() !=
              _selectedProjectFilter!.toUpperCase()) {
        return false;
      }

      // Search query
      if (query.isNotEmpty) {
        final matchesName = client.name.toLowerCase().contains(query);
        final matchesPhone = client.phone.toLowerCase().contains(query);
        final matchesEmail =
            client.email?.toLowerCase().contains(query) ?? false;
        final matchesProject = client.projectCode.toLowerCase().contains(query);
        final matchesUnit = client.unitDescription.toLowerCase().contains(
          query,
        );
        if (!matchesName &&
            !matchesPhone &&
            !matchesEmail &&
            !matchesProject &&
            !matchesUnit) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  // Real-time metric computations
  int get _totalActiveCount => _allClients
      .where(
        (c) => c.stage != ClientStage.closed && c.stage != ClientStage.cold,
      )
      .length;

  int get _hotCount =>
      _allClients.where((c) => c.stage == ClientStage.hot).length;

  int get _reservedCount =>
      _allClients.where((c) => c.stage == ClientStage.reserved).length;

  int get _warmCount =>
      _allClients.where((c) => c.stage == ClientStage.warm).length;

  int get _coldCount =>
      _allClients.where((c) => c.stage == ClientStage.cold).length;

  int get _closedCount =>
      _allClients.where((c) => c.stage == ClientStage.closed).length;

  void _openAddClientModal() {
    final eligible = _availableProjects
        .where(AddClientModal.isProjectEligibleForClient)
        .toList();

    AddClientModal.show(
      context,
      availableProjects: eligible.isNotEmpty
          ? eligible
          : const ['MVLC', 'ERHD', 'MSCC'],
      onClientAdded: (newClient) {
        setState(() {
          _allClients.removeWhere((c) => c.id == newClient.id);
          _allClients.insert(0, newClient);
        });
        _showConfirmationBanner('Client lead stored & verified on Supabase!');
        GhlService.syncClientLead(newClient);
      },
    );
  }

  void _openClientDetail(ClientModel client) {
    ClientDetailSheet.show(
      context,
      client: client,
      onStageChanged: (newStage) {
        setState(() {
          final index = _allClients.indexWhere((c) => c.id == client.id);
          if (index != -1) {
            _allClients[index] = _allClients[index].copyWith(stage: newStage);
          }
        });
        if (client.id.isNotEmpty && !client.id.startsWith('client-')) {
          SupabaseService.updateClientStage(
            client.id,
            newStage,
          ).catchError((_) {});
        }
        _showConfirmationBanner('Lead status updated to ${newStage.label}');
      },
    );
  }

  void _showConfirmationBanner(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        backgroundColor: AppColors.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.secondaryFixed,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    await Future.wait([_loadProjects(), _loadClients(forceRefresh: true)]);
    if (mounted) {
      setState(() => _isRefreshing = false);
      _showConfirmationBanner('Broker leads refreshed & synced');
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredClients;

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: HomeHeader(
        greetingText: 'Clients',
        avatarUrl: AuthService.currentUser?.avatarUrl,
        onNotificationTap: () => NotificationService.showNotificationsModal(context),
        onProfileTap: () {
          final name = AuthService.currentUser?.displayName ?? 'Broker';
          _showConfirmationBanner('Broker Profile: $name');
        },
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            RefreshIndicator(
              color: AppColors.primary,
              onRefresh: _handleRefresh,
              child: CustomScrollView(
                slivers: [
                  // Search & Quick Action Bar
                  SliverToBoxAdapter(child: _buildSearchBarAndBanner()),

                  // Real-time Pipeline Metrics Scroll
                  SliverToBoxAdapter(child: _buildPipelineMetricsScroll()),

                  // Stage Tabs / Filter Chips
                  SliverToBoxAdapter(child: _buildStageChips()),

                  // Project Pills and Filter Counter
                  SliverToBoxAdapter(
                    child: _buildProjectFilterPills(filtered.length),
                  ),

                  // Directory Cards List
                  if (filtered.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final client = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ClientCard(
                              client: client,
                              onTap: () => _openClientDetail(client),
                            ),
                          );
                        }, childCount: filtered.length),
                      ),
                    )
                  else
                    SliverToBoxAdapter(child: _buildEmptyState()),

                  // End State Cloud Sync Micro-Card
                  SliverToBoxAdapter(child: _buildCloudSyncCard()),

                  // Bottom padding to avoid navigation bar clipping
                  const SliverToBoxAdapter(child: SizedBox(height: 96)),
                ],
              ),
            ),

            // Persistent Floating Add Client Button
            Positioned(right: 16, bottom: 24, child: _buildFloatingAddButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBarAndBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Column(
        children: [
          // Search & Filter Row
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.outline,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search client name, mobile, email...',
                            hintStyle: AppTextStyles.bodyMd.copyWith(
                              color: AppColors.outline,
                              fontSize: 13.5,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: AppTextStyles.bodyMd,
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        IconButton(
                          icon: const Icon(
                            Icons.clear,
                            size: 18,
                            color: AppColors.outline,
                          ),
                          onPressed: () => _searchController.clear(),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        )
                      else
                        IconButton(
                          icon: const Icon(
                            Icons.qr_code_scanner,
                            size: 20,
                            color: AppColors.outline,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Client QR Code Scanner ready'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Filter tune button with gold indicator dot
              InkWell(
                onTap: () {
                  // Toggle active filter reset or stage cycle
                  if (_selectedStageFilter != null ||
                      _selectedProjectFilter != null) {
                    setState(() {
                      _selectedStageFilter = null;
                      _selectedProjectFilter = null;
                    });
                    _showConfirmationBanner('Filters cleared');
                  } else {
                    _showFilterBottomSheet();
                  }
                },
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 6,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        Icons.tune,
                        size: 22,
                        color: AppColors.primaryContainer,
                      ),
                      if (_selectedStageFilter != null ||
                          _selectedProjectFilter != null)
                        Positioned(
                          top: 11,
                          right: 11,
                          child: Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Quick Action Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.primaryContainer,
                  AppColors.primary,
                  AppColors.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    size: 20,
                    color: AppColors.secondaryFixed,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Client Management',
                        style: AppTextStyles.headlineSm.copyWith(
                          fontSize: 16,
                          color: AppColors.surfaceBright,
                        ),
                      ),
                      Text(
                        '${_allClients.length} total records under your team',
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.secondaryFixed.withValues(
                            alpha: 0.95,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryContainer,
                    foregroundColor: AppColors.onSecondaryContainer,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _openAddClientModal,
                  icon: const Icon(Icons.add, size: 16),
                  label: Text(
                    'Add Client',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSecondaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineMetricsScroll() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          _buildMetricCard(
            label: 'TOTAL ACTIVE',
            icon: Icons.groups_outlined,
            iconColor: AppColors.primary,
            value: '$_totalActiveCount',
            unit: 'buyers',
            subtitle: 'Active pipeline',
            subtitleColor: AppColors.secondary,
            onTap: () {
              setState(() {
                _selectedStageFilter = null;
              });
            },
          ),
          const SizedBox(width: 10),
          _buildMetricCard(
            label: 'HOT LEADS',
            icon: Icons.local_fire_department,
            iconColor: AppColors.secondary,
            value: '$_hotCount',
            unit: 'ready',
            subtitle: 'Site trippings set',
            subtitleColor: AppColors.onSurfaceVariant,
            onTap: () {
              setState(() {
                _selectedStageFilter = ClientStage.hot;
              });
            },
          ),
          const SizedBox(width: 10),
          _buildMetricCard(
            label: 'ACTIVE HOLDS',
            icon: Icons.lock_clock_outlined,
            iconColor: AppColors.primaryContainer,
            value: '$_reservedCount',
            unit: 'units',
            subtitle: '₱100k held escrow',
            subtitleColor: AppColors.onPrimaryContainer,
            onTap: () {
              setState(() {
                _selectedStageFilter = ClientStage.reserved;
              });
            },
          ),
          const SizedBox(width: 10),
          _buildMetricCard(
            label: 'TURNOVER',
            icon: Icons.verified_outlined,
            iconColor: AppColors.surfaceTint,
            value: '$_closedCount',
            unit: 'closed',
            subtitle: '100% Commissioned',
            subtitleColor: AppColors.outline,
            onTap: () {
              setState(() {
                _selectedStageFilter = ClientStage.closed;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String label,
    required IconData icon,
    required Color iconColor,
    required String value,
    required String unit,
    required String subtitle,
    required Color subtitleColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 136,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.outline,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                      fontSize: 9.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(icon, size: 18, color: iconColor),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: AppTextStyles.headlineMd.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              subtitle,
              style: AppTextStyles.bodySm.copyWith(
                fontSize: 11,
                color: subtitleColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // All chip
          _buildStageChip(
            title: 'All',
            count: _allClients.length,
            isSelected: _selectedStageFilter == null,
            onTap: () => setState(() => _selectedStageFilter = null),
          ),
          const SizedBox(width: 8),
          // Hot Leads
          _buildStageChip(
            title: 'Hot Leads',
            count: _hotCount,
            icon: Icons.local_fire_department,
            iconColor: AppColors.secondary,
            isSelected: _selectedStageFilter == ClientStage.hot,
            onTap: () => setState(() => _selectedStageFilter = ClientStage.hot),
          ),
          const SizedBox(width: 8),
          // Reserved
          _buildStageChip(
            title: 'Reserved',
            count: _reservedCount,
            icon: Icons.lock,
            iconColor: AppColors.secondary,
            isSelected: _selectedStageFilter == ClientStage.reserved,
            onTap: () =>
                setState(() => _selectedStageFilter = ClientStage.reserved),
          ),
          const SizedBox(width: 8),
          // Warm
          _buildStageChip(
            title: 'Warm',
            count: _warmCount,
            isSelected: _selectedStageFilter == ClientStage.warm,
            onTap: () =>
                setState(() => _selectedStageFilter = ClientStage.warm),
          ),
          const SizedBox(width: 8),
          // Cold
          _buildStageChip(
            title: 'Cold',
            count: _coldCount,
            isSelected: _selectedStageFilter == ClientStage.cold,
            onTap: () =>
                setState(() => _selectedStageFilter = ClientStage.cold),
          ),
          const SizedBox(width: 8),
          // Closed Buyers
          _buildStageChip(
            title: 'Closed Buyers',
            count: _closedCount,
            icon: Icons.check_circle,
            iconColor: AppColors.surfaceTint,
            isSelected: _selectedStageFilter == ClientStage.closed,
            onTap: () =>
                setState(() => _selectedStageFilter = ClientStage.closed),
          ),
        ],
      ),
    );
  }

  Widget _buildStageChip({
    required String title,
    required int count,
    IconData? icon,
    Color? iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 15,
                color: isSelected
                    ? AppColors.secondaryFixed
                    : (iconColor ?? AppColors.secondary),
              ),
              const SizedBox(width: 4),
            ],
            Text(
              title,
              style: AppTextStyles.labelMd.copyWith(
                color: isSelected
                    ? AppColors.onPrimary
                    : AppColors.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryFixed.withValues(alpha: 0.25)
                    : AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                '$count',
                style: AppTextStyles.labelSm.copyWith(
                  color: isSelected
                      ? AppColors.primaryFixed
                      : AppColors.onSurface,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectFilterPills(int showingCount) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    'PROJECT:',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.outline,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildProjectPill(
                    title: 'All Projects',
                    isSelected: _selectedProjectFilter == null,
                    onTap: () => setState(() => _selectedProjectFilter = null),
                  ),
                  ..._availableProjects.map((proj) {
                    final isSelected =
                        _selectedProjectFilter?.toUpperCase() ==
                        proj.toUpperCase();
                    return Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: _buildProjectPill(
                        title: proj,
                        isSelected: isSelected,
                        onTap: () => setState(() {
                          _selectedProjectFilter = isSelected ? null : proj;
                        }),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Showing $showingCount of ${_allClients.length}',
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.outline,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectPill({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.secondaryFixed.withValues(alpha: 0.55)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          title,
          style: AppTextStyles.labelSm.copyWith(
            color: isSelected
                ? AppColors.onSecondaryFixed
                : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    if (_isLoadingClients && _allClients.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        padding: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: const Column(
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Loading broker clients from Supabase...',
              style: TextStyle(color: AppColors.outline, fontSize: 13),
            ),
          ],
        ),
      );
    }

    final hasNoClientsAtAll = _allClients.isEmpty;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerLow,
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasNoClientsAtAll
                  ? Icons.people_outline_rounded
                  : Icons.person_search_outlined,
              size: 28,
              color: AppColors.outline,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            hasNoClientsAtAll ? 'No clients yet' : 'No matching clients found',
            style: AppTextStyles.titleMd.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            hasNoClientsAtAll
                ? 'Start building your pipeline by adding your first buyer lead.'
                : 'Try clearing your search terms or adjusting your pipeline stage filter.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(color: AppColors.outline),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: hasNoClientsAtAll
                ? _openAddClientModal
                : () {
                    setState(() {
                      _searchController.clear();
                      _selectedStageFilter = null;
                      _selectedProjectFilter = null;
                    });
                  },
            child: Text(
              hasNoClientsAtAll ? '+ Add First Client' : 'Reset All Filters',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudSyncCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.secondaryFixed.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.sync,
                size: 20,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VHBC Cloud Sync: Up to date',
                    style: AppTextStyles.labelMd.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurface,
                    ),
                  ),
                  Text(
                    'All buyer leads encrypted & MLS aligned',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.outline,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Refresh contacts',
              icon: _isRefreshing
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      Icons.refresh,
                      size: 20,
                      color: AppColors.primary,
                    ),
              onPressed: _isRefreshing ? null : _handleRefresh,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingAddButton() {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(100),
      color: AppColors.primary,
      child: InkWell(
        onTap: _openAddClientModal,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.person_add,
                size: 22,
                color: AppColors.secondaryFixed,
              ),
              const SizedBox(width: 8),
              Text(
                '+ Add Client',
                style: AppTextStyles.headlineSm.copyWith(
                  fontSize: 15,
                  color: AppColors.surfaceBright,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter Clients & Leads',
                    style: AppTextStyles.titleMd.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStageFilter = null;
                        _selectedProjectFilter = null;
                      });
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Reset All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'PIPELINE STAGE',
                style: AppTextStyles.labelSm.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All Stages'),
                    selected: _selectedStageFilter == null,
                    onSelected: (val) {
                      setState(() => _selectedStageFilter = null);
                      Navigator.of(ctx).pop();
                    },
                  ),
                  ...ClientStage.values.map(
                    (stg) => ChoiceChip(
                      label: Text(stg.label),
                      selected: _selectedStageFilter == stg,
                      onSelected: (val) {
                        setState(() => _selectedStageFilter = val ? stg : null);
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'PROJECT DEVELOPMENT',
                style: AppTextStyles.labelSm.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All Developments'),
                    selected: _selectedProjectFilter == null,
                    onSelected: (val) {
                      setState(() => _selectedProjectFilter = null);
                      Navigator.of(ctx).pop();
                    },
                  ),
                  ..._availableProjects.map(
                    (p) => ChoiceChip(
                      label: Text(p),
                      selected: _selectedProjectFilter == p,
                      onSelected: (val) {
                        setState(() => _selectedProjectFilter = val ? p : null);
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
