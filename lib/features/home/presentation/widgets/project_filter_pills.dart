import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProjectFilterOption {
  final String id;
  final String label;
  final String? subtitle;
  final String? code;
  final String? name;

  const ProjectFilterOption({
    required this.id,
    required this.label,
    this.subtitle,
    this.code,
    this.name,
  });
}

/// Horizontal list of community filter pills with active state selection.
class ProjectFilterPills extends StatelessWidget {
  final String selectedProjectId;
  final ValueChanged<String> onSelectProject;
  final List<ProjectFilterOption>? options;

  const ProjectFilterPills({
    super.key,
    required this.selectedProjectId,
    required this.onSelectProject,
    this.options,
  });

  static List<ProjectFilterOption> get defaultOptions => const [
        ProjectFilterOption(
          id: 'all',
          label: 'All Projects',
          name: 'All Projects',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final list = options ?? defaultOptions;
    final projectCount = list.where((o) => o.id != 'all').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'FILTER COMMUNITIES',
                  style: AppTextStyles.labelMd.copyWith(
                    letterSpacing: 1.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$projectCount Projects',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Horizontal Pills List
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final option = list[index];
              final isSelected = option.id == selectedProjectId;

              return GestureDetector(
                onTap: () => onSelectProject(option.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        option.label,
                        style: AppTextStyles.labelMd.copyWith(
                          color: isSelected
                              ? AppColors.onPrimary
                              : AppColors.onSurfaceVariant,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                        ),
                      ),
                      if (option.subtitle != null &&
                          option.subtitle!.trim().isNotEmpty &&
                          option.subtitle!.trim().toUpperCase() !=
                              option.label.trim().toUpperCase()) ...[
                        const SizedBox(width: 4),
                        Text(
                          option.subtitle!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? AppColors.primaryFixedDim
                                : AppColors.onSurfaceVariant
                                    .withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
