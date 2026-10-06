import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/development_photo_model.dart';
import '../models/youtube_link_model.dart';
import 'in_app_video_player_screen.dart';
import 'sales_kit_photo_viewer_dialog.dart';

typedef SalesKitScreen = SalesKitVideosScreen;

class SalesKitVideosScreen extends StatefulWidget {
  final String? initialProject;
  final int initialTabIndex;

  const SalesKitVideosScreen({
    super.key,
    this.initialProject,
    this.initialTabIndex = 0,
  });

  @override
  State<SalesKitVideosScreen> createState() => _SalesKitVideosScreenState();
}

class _SalesKitVideosScreenState extends State<SalesKitVideosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  String? _errorMessage;

  List<DevelopmentPhotoModel> _allActualPhotos = [];
  List<DevelopmentPhotoModel> _allPerspectivePhotos = [];
  List<YoutubeLinkModel> _allVideos = [];

  String _selectedProject = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialTabIndex.clamp(0, 2),
    );
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });

    if (widget.initialProject != null && widget.initialProject!.isNotEmpty) {
      _selectedProject = widget.initialProject!;
    }
    _loadAllMedia();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAllMedia({bool forceRefresh = false}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await Future.wait([
        SupabaseService.fetchActualPhotos(forceRefresh: forceRefresh),
        SupabaseService.fetchPerspectivePhotos(forceRefresh: forceRefresh),
        SupabaseService.fetchYoutubeLinks(forceRefresh: forceRefresh),
      ]);

      if (mounted) {
        setState(() {
          _allActualPhotos = results[0] as List<DevelopmentPhotoModel>;
          _allPerspectivePhotos = results[1] as List<DevelopmentPhotoModel>;
          _allVideos = results[2] as List<YoutubeLinkModel>;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage =
              'Unable to load sales kit media. Please check your connection.';
          _isLoading = false;
        });
      }
    }
  }

  /// Extracts unique projects from all media sources
  List<String> get _availableProjects {
    final projects = <String>{'All'};

    // Core projects
    const core = ['MVLC', 'ERHD', 'MSCC', 'GLS', 'EBLF'];
    projects.addAll(core);

    for (final p in _allActualPhotos) {
      projects.add(p.normalizedProjectName);
    }
    for (final p in _allPerspectivePhotos) {
      projects.add(p.normalizedProjectName);
    }
    for (final v in _allVideos) {
      if (v.projectName.isNotEmpty) {
        final norm = v.projectName.toUpperCase().contains('MSCC')
            ? 'MSCC'
            : v.projectName.trim();
        projects.add(norm);
      }
    }

    return projects.toList();
  }

  List<DevelopmentPhotoModel> get _filteredActualPhotos {
    return _allActualPhotos.where((photo) {
      if (_selectedProject != 'All' &&
          !photo.matchesProject(_selectedProject)) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchProject =
            photo.projectName.toLowerCase().contains(q) ||
            photo.normalizedProjectName.toLowerCase().contains(q);
        if (!matchProject) return false;
      }
      return true;
    }).toList();
  }

  List<DevelopmentPhotoModel> get _filteredPerspectivePhotos {
    return _allPerspectivePhotos.where((photo) {
      if (_selectedProject != 'All' &&
          !photo.matchesProject(_selectedProject)) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchProject =
            photo.projectName.toLowerCase().contains(q) ||
            photo.normalizedProjectName.toLowerCase().contains(q);
        if (!matchProject) return false;
      }
      return true;
    }).toList();
  }

  List<YoutubeLinkModel> get _filteredVideos {
    return _allVideos.where((video) {
      if (_selectedProject != 'All') {
        final target = _selectedProject.toLowerCase();
        final p = video.projectName.toLowerCase();
        final matchesProject = p == target ||
            p.contains(target) ||
            (target == 'mscc' && p.contains('mscc'));
        if (!matchesProject) return false;
      }
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesTitle = video.title.toLowerCase().contains(query);
        final matchesProject = video.projectName.toLowerCase().contains(query);
        if (!matchesTitle && !matchesProject) return false;
      }
      return true;
    }).toList();
  }

  int _countForProject(String project) {
    final activeIndex = _tabController.index;
    if (project == 'All') {
      if (activeIndex == 0) return _allActualPhotos.length;
      if (activeIndex == 1) return _allPerspectivePhotos.length;
      return _allVideos.length;
    }

    if (activeIndex == 0) {
      return _allActualPhotos.where((p) => p.matchesProject(project)).length;
    }
    if (activeIndex == 1) {
      return _allPerspectivePhotos
          .where((p) => p.matchesProject(project))
          .length;
    }
    return _allVideos.where((v) {
      final target = project.toLowerCase();
      final p = v.projectName.toLowerCase();
      return p == target || p.contains(target) || (target == 'mscc' && p.contains('mscc'));
    }).length;
  }

  void _openInAppPlayer(YoutubeLinkModel video) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InAppVideoPlayerScreen(video: video),
      ),
    );
  }

  void _copyLink(String link, String label) {
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$label copied to clipboard',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  Color _getProjectBadgeColor(String project) {
    final p = project.toUpperCase();
    if (p.contains('MVLC')) return const Color(0xFF0F3E2E);
    if (p.contains('ERHD')) return const Color(0xFF77591C);
    if (p.contains('MSCC')) return const Color(0xFF1E3A8A);
    if (p.contains('GLS') ||
        p.contains('LCN') ||
        p.contains('MCVC') ||
        p.contains('RHM') ||
        p.contains('RHN')) {
      return const Color(0xFFB45309);
    }
    if (p.contains('EBLF')) return const Color(0xFF991B1B);
    return const Color(0xFF414944);
  }

  @override
  Widget build(BuildContext context) {
    final projects = _availableProjects;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sales Kit & Walkthroughs',
              style: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Actual photos, perspectives & video presentations',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.primaryFixedDim,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, size: 22),
            tooltip: 'Refresh media',
            onPressed: () => _loadAllMedia(forceRefresh: true),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: AppColors.primary,
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppColors.secondary,
              indicatorWeight: 3.5,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.65),
              labelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.photo_camera_rounded, size: 16),
                      const SizedBox(width: 6),
                      const Text('Actual Photos'),
                    ],
                  ),
                ),
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.architecture_rounded, size: 16),
                      const SizedBox(width: 6),
                      const Text('Perspectives'),
                    ],
                  ),
                ),
                Tab(
                  iconMargin: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.play_circle_outline_rounded, size: 16),
                      const SizedBox(width: 6),
                      const Text('Videos'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadAllMedia(forceRefresh: true),
        color: AppColors.primaryContainer,
        child: Column(
          children: [
            // Top Section: Search & Project Choice Chips Filter
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val.trim();
                        });
                      },
                      style: AppTextStyles.bodyMd,
                      decoration: InputDecoration(
                        hintText: _tabController.index == 0
                            ? 'Search actual photos...'
                            : _tabController.index == 1
                                ? 'Search future perspectives...'
                                : 'Search video walkthroughs...',
                        hintStyle: AppTextStyles.bodySm.copyWith(
                          color: AppColors.outline,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: AppColors.outline,
                          size: 20,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                color: AppColors.outline,
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceContainerLow,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  // Project Choice Chips Header Row
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.filter_list_rounded,
                          size: 14,
                          color: AppColors.outline,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'FILTER BY PROJECT',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.outline,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const Spacer(),
                        if (_selectedProject != 'All')
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedProject = 'All';
                                });
                              },
                              child: Text(
                                'Clear Filter',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryContainer,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Choice Chips Horizontal List
                  SizedBox(
                    height: 48,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      scrollDirection: Axis.horizontal,
                      itemCount: projects.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final proj = projects[index];
                        final isSelected =
                            _selectedProject.toLowerCase() == proj.toLowerCase();
                        final count = _countForProject(proj);

                        return ChoiceChip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(proj),
                              if (count > 0) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Colors.white.withValues(alpha: 0.25)
                                        : AppColors.surfaceContainerHigh,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '$count',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          selected: isSelected,
                          selectedColor: AppColors.primaryContainer,
                          backgroundColor: AppColors.surfaceContainerLow,
                          labelStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.onSurface,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primaryContainer
                                  : AppColors.outlineVariant
                                      .withValues(alpha: 0.5),
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          showCheckmark: false,
                          onSelected: (selected) {
                            if (selected) {
                              setState(() {
                                _selectedProject = proj;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),

            // Tab Views: Actual Photos, Perspectives, Videos
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _errorMessage != null
                      ? _buildErrorState()
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            // 1. Actual Photos Tab (from project_dev)
                            _buildPhotoGrid(
                              _filteredActualPhotos,
                              title: 'Actual Site Photos',
                              emptyDescription:
                                  'No actual development photos found for "$_selectedProject".',
                              isActual: true,
                            ),

                            // 2. Perspectives Tab (from future_dev)
                            _buildPhotoGrid(
                              _filteredPerspectivePhotos,
                              title: 'Future Perspectives',
                              emptyDescription:
                                  'No architectural perspectives found for "$_selectedProject".',
                              isActual: false,
                            ),

                            // 3. Videos Tab (from youtube_links)
                            _buildVideoContent(_filteredVideos),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2.5,
            color: AppColors.primaryContainer,
          ),
          const SizedBox(height: 16),
          Text(
            'Fetching sales kit media...',
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              size: 48,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd
                  .copyWith(color: AppColors.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _loadAllMedia(forceRefresh: true),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotoGrid(
    List<DevelopmentPhotoModel> photos, {
    required String title,
    required String emptyDescription,
    required bool isActual,
  }) {
    if (photos.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isActual
                      ? Icons.photo_library_outlined
                      : Icons.architecture_rounded,
                  size: 44,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No Photos Found',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _searchQuery.isNotEmpty
                    ? 'No photos match "$_searchQuery" in project "$_selectedProject".'
                    : emptyDescription,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedProject = 'All';
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
                icon: const Icon(Icons.restore_rounded, size: 18),
                label: const Text('Reset Filter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryContainer,
                  side: const BorderSide(color: AppColors.primaryContainer),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return _buildPhotoCard(photo);
      },
    );
  }

  Widget _buildPhotoCard(DevelopmentPhotoModel photo) {
    final badgeColor = _getProjectBadgeColor(photo.projectName);
    final isActual = photo.isActual;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => SalesKitPhotoViewerDialog.show(context, photo),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Photo Image
              CachedNetworkImage(
                imageUrl: photo.imageLink,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.surfaceContainerLow,
                  child: Center(
                    child: Icon(
                      isActual
                          ? Icons.photo_camera_outlined
                          : Icons.architecture_outlined,
                      color: AppColors.outlineVariant,
                      size: 28,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.surfaceContainerLow,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: AppColors.outlineVariant,
                      size: 32,
                    ),
                  ),
                ),
              ),

              // Bottom subtle dark gradient
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 48,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Top Badges
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    photo.normalizedProjectName,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Top Right: Type Icon Indicator
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isActual
                        ? Icons.photo_camera_rounded
                        : Icons.architecture_rounded,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),

              // Bottom Tap to Expand Indicator
              Positioned(
                bottom: 8,
                right: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.fullscreen_rounded,
                      size: 18,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ],
                ),
              ),

              // Bottom Date tag if available
              if (photo.createdAt != null)
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Text(
                    '${photo.createdAt!.year}-${photo.createdAt!.month.toString().padLeft(2, '0')}',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContent(List<YoutubeLinkModel> filtered) {
    if (filtered.isEmpty) {
      return Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.video_library_outlined,
                  size: 44,
                  color: AppColors.outline,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No Videos Found',
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _searchQuery.isNotEmpty
                    ? 'No videos match "$_searchQuery" in project "$_selectedProject".'
                    : 'No walkthroughs available for "$_selectedProject" at this time.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMd.copyWith(color: AppColors.outline),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedProject = 'All';
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
                icon: const Icon(Icons.restore_rounded, size: 18),
                label: const Text('Reset Filter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryContainer,
                  side: const BorderSide(color: AppColors.primaryContainer),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final video = filtered[index];
        return _buildVideoCard(video);
      },
    );
  }

  Widget _buildVideoCard(YoutubeLinkModel video) {
    final badgeColor = _getProjectBadgeColor(video.projectName);
    final thumbnailUrl = video.thumbnailUrl;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail with Play Button Overlay
          InkWell(
            onTap: () => _openInAppPlayer(video),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Thumbnail Image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: thumbnailUrl != null
                      ? CachedNetworkImage(
                          imageUrl: thumbnailUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.surfaceContainerLow,
                            child: const Center(
                              child: Icon(
                                Icons.video_collection_outlined,
                                color: AppColors.outlineVariant,
                                size: 36,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.surfaceContainerLow,
                            child: const Icon(
                              Icons.play_circle_fill_rounded,
                              size: 48,
                              color: AppColors.outline,
                            ),
                          ),
                        )
                      : Container(
                          color: AppColors.primaryContainer,
                          child: const Icon(
                            Icons.play_circle_fill_rounded,
                            size: 48,
                            color: Colors.white,
                          ),
                        ),
                ),

                // Dark Translucent Scrim for Video
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.2),
                          Colors.black.withValues(alpha: 0.55),
                        ],
                      ),
                    ),
                  ),
                ),

                // Project Badge (Top-Left)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: badgeColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      video.projectName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),

                // HD Badge (Top-Right)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.hd_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'HD Tour',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Pulsing Center Play Button
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withValues(alpha: 0.4),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.primary,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Video Card Footer / Metadata
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Title
                Text(
                  video.title,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                    height: 1.25,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Action Bar
                Row(
                  children: [
                    // Copy Link Button
                    InkWell(
                      onTap: () => _copyLink(video.link, 'Walkthrough link'),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.link_rounded,
                              size: 16,
                              color: AppColors.outline,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Copy Link',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Watch Now / Play Walkthrough Button
                    FilledButton.icon(
                      onPressed: () => _openInAppPlayer(video),
                      icon: const Icon(Icons.play_arrow_rounded, size: 18),
                      label: const Text('Play Walkthrough'),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: Colors.white,
                        textStyle: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
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
        ],
      ),
    );
  }
}
