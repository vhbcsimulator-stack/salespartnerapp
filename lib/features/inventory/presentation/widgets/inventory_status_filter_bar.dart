import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Interactive filter row allowing brokers to toggle between:
/// - Available
/// - Reserved
/// - Sold
/// - All
class InventoryStatusFilterBar extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String> onStatusSelected;
  final int availableCount;
  final int reservedCount;
  final int soldCount;
  final int totalCount;
  final bool isUnit;

  const InventoryStatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
    this.availableCount = 0,
    this.reservedCount = 0,
    this.soldCount = 0,
    this.totalCount = 0,
    this.isUnit = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _StatusOption(
        id: 'available',
        label: 'Available',
        count: availableCount,
        dotColor: const Color(0xFF1B5E20), // deep emerald green
        activeBgColor: AppColors.primaryContainer,
      ),
      _StatusOption(
        id: 'reserved',
        label: 'Reserved',
        count: reservedCount,
        dotColor: const Color(0xFFE65100), // vibrant amber-orange
        activeBgColor: const Color(0xFFC05621),
      ),
      _StatusOption(
        id: 'sold',
        label: 'Sold',
        count: soldCount,
        dotColor: const Color(0xFFC62828), // deep crimson
        activeBgColor: const Color(0xFF8E1B1B),
      ),
      _StatusOption(
        id: 'all',
        label: isUnit ? 'All Units' : 'All Lots',
        count: totalCount,
        dotColor: AppColors.outline,
        activeBgColor: AppColors.onSurface,
      ),
    ];


    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedStatus.toLowerCase() == item.id.toLowerCase();

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onStatusSelected(item.id),
              borderRadius: BorderRadius.circular(999),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? item.activeBgColor
                      : AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : AppColors.outlineVariant.withValues(alpha: 0.6),
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: item.activeBgColor.withValues(alpha: 0.3),
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
                    // Status Indicator Dot
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : item.dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Label
                    Text(
                      item.label,
                      style: AppTextStyles.labelMd.copyWith(
                        color: isSelected ? Colors.white : AppColors.onSurface,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),

                    // Count Badge (if count > 0)
                    if (item.count > 0) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1.5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.25)
                              : AppColors.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${item.count}',
                          style: AppTextStyles.labelSm.copyWith(
                            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
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
    );
  }
}

class _StatusOption {
  final String id;
  final String label;
  final int count;
  final Color dotColor;
  final Color activeBgColor;

  const _StatusOption({
    required this.id,
    required this.label,
    required this.count,
    required this.dotColor,
    required this.activeBgColor,
  });
}
