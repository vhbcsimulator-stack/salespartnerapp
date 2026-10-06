import 'package:flutter/material.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/inventory_item.dart';

/// Horizontal carousel chips for filtering properties by development project.
class InventoryProjectChips extends StatelessWidget {
  final String selectedProjectId;
  final ValueChanged<String> onSelectProject;
  final List<InventoryProjectOption>? options;
  final VoidCallback? onOpenSelector;
  final bool isLoading;

  const InventoryProjectChips({
    super.key,
    required this.selectedProjectId,
    required this.onSelectProject,
    this.options,
    this.onOpenSelector,
    this.isLoading = false,
  });

  static List<InventoryProjectOption> get defaultOptions => const [
        InventoryProjectOption(
          id: 'all',
          label: 'All Projects',
          name: 'All Projects',
          paused: false,
        ),
        InventoryProjectOption(
          id: 'EBLF',
          label: 'EBLF',
          name: 'Eastwest Breeze Leisure Farm',
          paused: false,
        ),
        InventoryProjectOption(
          id: 'ERHD',
          label: 'ERHD',
          name: 'Eastwest Resort Hub and Development',
          paused: false,
        ),
        InventoryProjectOption(
          id: 'GLS',
          label: 'GLS',
          name: 'Green Landscape Sanctuary',
          paused: true,
        ),
        InventoryProjectOption(
          id: 'LCN',
          label: 'LCN',
          name: 'Lakeshore Community North',
          paused: true,
        ),
        InventoryProjectOption(
          id: 'MCVC',
          label: 'MCVC',
          name: 'Mini Complete Vacation Community',
          paused: true,
        ),
        InventoryProjectOption(
          id: 'MSCC',
          label: 'MSCC',
          name: 'Mountain Suites Country Club',
          paused: true,
        ),
        InventoryProjectOption(
          id: 'MVLC',
          label: 'MVLC',
          name: 'Mountain View Leisure Community',
          paused: false,
        ),
        InventoryProjectOption(
          id: 'RHM',
          label: 'RHM',
          name: 'Resort Hub Muños',
          paused: true,
        ),
        InventoryProjectOption(
          id: 'RHN',
          label: 'RHN',
          name: 'Resort Hub Nasugbu',
          paused: true,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final rawList = (options != null && options!.isNotEmpty)
        ? options!
        : defaultOptions;
    final list = rawList;

    return SizedBox(
      height: 38,
      child: Row(
        children: [
          if (onOpenSelector != null) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onOpenSelector,
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.primaryContainer.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.apartment,
                        size: 16,
                        color: AppColors.primaryContainer,
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 18,
                        color: AppColors.primaryContainer,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final option = list[index];
                final isSelected = option.id.toLowerCase() ==
                        selectedProjectId.toLowerCase() ||
                    (option.name != null &&
                        option.name!.toLowerCase() ==
                            selectedProjectId.toLowerCase()) ||
                    (option.code != null &&
                        option.code!.toLowerCase() ==
                            selectedProjectId.toLowerCase());

                final projectName = option.name ?? option.label;
                final isSoonToRise = option.paused ||
                    SupabaseService.isProjectPaused(option.code, option.name ?? option.label);

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (option.id == '_loading') return;
                      onSelectProject(option.id);
                    },
                    borderRadius: BorderRadius.circular(999),
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
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryContainer
                              : AppColors.outlineVariant.withValues(alpha: 0.5),
                          width: 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primaryContainer
                                      .withValues(alpha: 0.25),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.02),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (option.id == '_loading') ...[
                            const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primaryContainer,
                              ),
                            ),
                            const SizedBox(width: 6),
                          ] else if (option.id == 'all') ...[
                            Icon(
                              Icons.apps,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                          ] else ...[
                            Icon(
                              Icons.apartment,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.primaryContainer,
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            projectName,
                            style: AppTextStyles.labelMd.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.onSurface,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                          if (isSoonToRise) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.25)
                                    : const Color(0xFFFEF3C7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Soon to Rise',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : const Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ],
                          if (option.id.toUpperCase() == 'EBLF' ||
                              option.code?.toUpperCase() == 'EBLF' ||
                              (option.name?.toUpperCase().contains('EBLF') ?? false)) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.25)
                                    : const Color(0xFFFEE2E2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'Sold Out',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w800,
                                  color: isSelected ? Colors.white : const Color(0xFFDC2626),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
