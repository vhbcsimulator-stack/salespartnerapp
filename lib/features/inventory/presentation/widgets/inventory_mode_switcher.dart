import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/inventory_item.dart';

/// Row with Live Inventory pulse badge and segmented List/Map view switcher.
class InventoryModeSwitcher extends StatelessWidget {
  final InventoryViewMode viewMode;
  final ValueChanged<InventoryViewMode> onViewModeChanged;
  final String syncText;

  const InventoryModeSwitcher({
    super.key,
    required this.viewMode,
    required this.onViewModeChanged,
    this.syncText = 'Live Inventory • 2m ago',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Live Status Badge
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainer,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceTint,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    syncText.toUpperCase(),
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0.6,
                      fontSize: 9.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),

        // Segmented List / Map View Switcher
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSegmentButton(
                title: 'List',
                icon: Icons.format_list_bulleted,
                isSelected: viewMode == InventoryViewMode.list,
                onTap: () => onViewModeChanged(InventoryViewMode.list),
              ),
              _buildSegmentButton(
                title: 'Map',
                icon: Icons.map_outlined,
                isSelected: viewMode == InventoryViewMode.map,
                onTap: () => onViewModeChanged(InventoryViewMode.map),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSegmentButton({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surfaceContainerLowest
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? AppColors.primaryContainer
                  : AppColors.outline,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: AppTextStyles.labelMd.copyWith(
                color: isSelected
                    ? AppColors.primaryContainer
                    : AppColors.outline,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
