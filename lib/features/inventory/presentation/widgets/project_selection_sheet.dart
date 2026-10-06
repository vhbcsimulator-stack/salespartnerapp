import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/project_model.dart';

/// Modal bottom sheet allowing brokers to select a development project fetched from Supabase.
class ProjectSelectionSheet extends StatefulWidget {
  final List<ProjectModel> projects;
  final String selectedProjectId;
  final ValueChanged<ProjectModel?> onProjectSelected;

  const ProjectSelectionSheet({
    super.key,
    required this.projects,
    required this.selectedProjectId,
    required this.onProjectSelected,
  });

  static Future<void> show({
    required BuildContext context,
    required List<ProjectModel> projects,
    required String selectedProjectId,
    required ValueChanged<ProjectModel?> onProjectSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ProjectSelectionSheet(
        projects: projects,
        selectedProjectId: selectedProjectId,
        onProjectSelected: onProjectSelected,
      ),
    );
  }

  @override
  State<ProjectSelectionSheet> createState() => _ProjectSelectionSheetState();
}

class _ProjectSelectionSheetState extends State<ProjectSelectionSheet> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _filter = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seen = <String>{};
    final filteredProjects = <ProjectModel>[];
    for (final p in widget.projects) {
      if (_filter.isNotEmpty) {
        final q = _filter.toLowerCase();
        final pCode = (p.code ?? '').toUpperCase();
        final pName = p.displayName.toUpperCase();
        final isGls = pCode == 'GLS' || pName.contains('GLS');
        final isLcn = pCode == 'LCN' || pName.contains('LCN') || pName.contains('LAKESHORE');
        final isMcvc = pCode == 'MCVC' || pName.contains('MCVC');
        final isRhm = pCode == 'RHM' || pName.contains('RHM');
        final isRhn = pCode == 'RHN' || pName.contains('RHN');
        final isSoonToRise = p.paused ||
            SupabaseService.isProjectPaused(p.code, p.displayName);
        final isEblf = pCode == 'EBLF' || pName.contains('EBLF');
        final isMvlc = pCode == 'MVLC' || pName.contains('MVLC');
        final isErhd = pCode == 'ERHD' || pName.contains('ERHD');
        final isMscc = pCode == 'MSCC' || pName.contains('MSCC');

        final matches = p.displayName.toLowerCase().contains(q) ||
            (p.code?.toLowerCase().contains(q) ?? false) ||
            (p.description?.toLowerCase().contains(q) ?? false) ||
            (isSoonToRise && 'soon to rise'.contains(q)) ||
            (isGls &&
                ('green landscape sanctuary'.contains(q) ||
                    'green ladscape sanctuary'.contains(q))) ||
            (isLcn && ('lakeshore community north'.contains(q) || 'lakeshore city north'.contains(q))) ||
            (isMcvc && ('mini complete vacation community'.contains(q) || 'monte cielo view community'.contains(q))) ||
            (isRhm && ('resort hub muños'.contains(q) || 'resort hub munos'.contains(q) || 'rancho hermosa mountain'.contains(q))) ||
            (isRhn && ('resort hub nasugbu'.contains(q) || 'rancho hermosa north'.contains(q))) ||
            (isEblf &&
                ('eastwest breeze leisure farm'.contains(q) ||
                    'sold out'.contains(q) ||
                    'eblf'.contains(q))) ||
            (isMvlc && 'mountain view leisure community'.contains(q)) ||
            (isErhd && 'eastwest resort hub and development'.contains(q)) ||
            (isMscc && 'mountain suites country club'.contains(q));
        if (!matches) continue;
      }
      if (seen.add(p.displayName.toLowerCase())) {
        filteredProjects.add(p);
      }
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 16, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.apartment,
                    color: AppColors.primaryContainer,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Project',
                        style: AppTextStyles.titleMd.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        'Fetch and filter inventory by community name',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: AppColors.onSurfaceVariant,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.surfaceContainerHigh),

          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: AppColors.outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (val) {
                        setState(() {
                          _filter = val.trim();
                        });
                      },
                      style: AppTextStyles.bodyMd.copyWith(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Search project name or code...',
                        hintStyle: AppTextStyles.bodySm.copyWith(
                          color: AppColors.outline,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  if (_filter.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        _searchCtrl.clear();
                        setState(() {
                          _filter = '';
                        });
                      },
                      child: const Icon(Icons.clear, size: 16, color: AppColors.outline),
                    ),
                ],
              ),
            ),
          ),

          // Project List
          Flexible(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: [
                // "All Projects" Option
                _buildProjectItem(
                  context,
                  isSelected: widget.selectedProjectId == 'all',
                  title: 'All Projects',
                  subtitle: 'Show inventory across all active developments',
                  badgeText: 'PORTFOLIO',
                  onTap: () {
                    widget.onProjectSelected(null);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),

                // Individual Projects from Supabase
                ...filteredProjects.map((project) {
                  final isSelected = widget.selectedProjectId.toLowerCase() ==
                          project.displayName.toLowerCase() ||
                      (project.code != null &&
                          widget.selectedProjectId.toLowerCase() ==
                              project.code!.toLowerCase());

                  final code = (project.code ?? '').toUpperCase();
                  final name = project.displayName.toUpperCase();
                  final isGls = code == 'GLS' || name.contains('GLS');
                  final isLcn = code == 'LCN' || name.contains('LCN') || name.contains('LAKESHORE');
                  final isMcvc = code == 'MCVC' || name.contains('MCVC');
                  final isRhm = code == 'RHM' || name.contains('RHM');
                  final isRhn = code == 'RHN' || name.contains('RHN');
                  final isSoonToRise = project.paused ||
                      SupabaseService.isProjectPaused(project.code, project.displayName);
                  final isEblf = code == 'EBLF' || name.contains('EBLF');
                  final isMvlc = code == 'MVLC' || name.contains('MVLC');
                  final isErhd = code == 'ERHD' || name.contains('ERHD');
                  final isMscc = code == 'MSCC' || name.contains('MSCC');

                  final badge = isSoonToRise
                      ? 'SOON TO RISE'
                      : (isEblf
                          ? 'SOLD OUT'
                          : (project.code?.toUpperCase() ?? 'PROJECT'));

                  String subtitle;
                  if (isGls) {
                    subtitle = 'Green Landscape Sanctuary • Soon to Rise';
                  } else if (isLcn) {
                    subtitle = 'Lakeshore Community North • Soon to Rise';
                  } else if (isMcvc) {
                    subtitle = 'Mini Complete Vacation Community • Soon to Rise';
                  } else if (isRhm) {
                    subtitle = 'Resort Hub Muños • Soon to Rise';
                  } else if (isRhn) {
                    subtitle = 'Resort Hub Nasugbu • Soon to Rise';
                  } else if (isSoonToRise) {
                    subtitle = '${project.displayName} • Soon to Rise';
                  } else if (isEblf) {
                    subtitle = 'Eastwest Breeze Leisure Farm • 100% Sold Out';
                  } else if (isMvlc) {
                    subtitle = 'Mountain View Leisure Community';
                  } else if (isErhd) {
                    subtitle = 'Eastwest Resort Hub and Development';
                  } else if (isMscc) {
                    subtitle = 'Mountain Suites Country Club';
                  } else {
                    subtitle = project.description ?? 'VHBC Development Community';
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: _buildProjectItem(
                      context,
                      isSelected: isSelected,
                      isSpecialBadge: isSoonToRise,
                      isSoldOutBadge: isEblf,
                      title: project.displayName,
                      subtitle: subtitle,
                      badgeText: badge,
                      onTap: () {
                        widget.onProjectSelected(project);
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),

                if (widget.projects.isEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.outlineVariant.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.info_outline,
                                size: 18, color: AppColors.secondary),
                            const SizedBox(width: 8),
                            Text(
                              'No projects found in Supabase',
                              style: AppTextStyles.labelMd
                                  .copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'The "public.projects" table currently returned 0 records. Once you insert project records into Supabase and ensure RLS allows SELECT for anon users, they will appear here and in the choice chips automatically.',
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (filteredProjects.isEmpty && _filter.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text(
                        'No projects matching "$_filter"',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
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

  Widget _buildProjectItem(
    BuildContext context, {
    required bool isSelected,
    required String title,
    required String subtitle,
    required String badgeText,
    bool isSpecialBadge = false,
    bool isSoldOutBadge = false,
    required VoidCallback onTap,
  }) {
    Color badgeColor;
    Color badgeTextColor;
    Border? badgeBorder;

    if (isSpecialBadge) {
      badgeColor = const Color(0xFFFEF3C7);
      badgeTextColor = const Color(0xFFB45309);
      badgeBorder = Border.all(color: const Color(0xFFF59E0B), width: 1);
    } else if (isSoldOutBadge) {
      badgeColor = const Color(0xFFFEE2E2);
      badgeTextColor = const Color(0xFFDC2626);
      badgeBorder = Border.all(color: const Color(0xFFEF4444), width: 1);
    } else if (isSelected) {
      badgeColor = AppColors.primaryContainer;
      badgeTextColor = AppColors.onPrimary;
      badgeBorder = null;
    } else {
      badgeColor = AppColors.surfaceContainerHighest;
      badgeTextColor = AppColors.onSurfaceVariant;
      badgeBorder = null;
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer.withValues(alpha: 0.08)
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(6),
                border: badgeBorder,
              ),
              child: Text(
                badgeText,
                style: AppTextStyles.labelSm.copyWith(
                  color: badgeTextColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMd.copyWith(
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primaryContainer,
                size: 20,
              )
            else
              const Icon(
                Icons.radio_button_unchecked,
                color: AppColors.outlineVariant,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
