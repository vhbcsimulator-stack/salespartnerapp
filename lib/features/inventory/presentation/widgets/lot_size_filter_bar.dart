import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LotSizePreset {
  final String id;
  final String label;
  final double? min;
  final double? max;

  const LotSizePreset({
    required this.id,
    required this.label,
    this.min,
    this.max,
  });
}

/// Horizontal chips bar for quick lot size filtering (presets + custom range trigger).
class LotSizeFilterBar extends StatelessWidget {
  final double? selectedMin;
  final double? selectedMax;
  final void Function(double? min, double? max, String label) onSelectPreset;
  final VoidCallback onOpenCustomFilter;

  const LotSizeFilterBar({
    super.key,
    required this.selectedMin,
    required this.selectedMax,
    required this.onSelectPreset,
    required this.onOpenCustomFilter,
  });

  static const List<LotSizePreset> presets = [
    LotSizePreset(id: 'all', label: 'All Sizes', min: null, max: null),
    LotSizePreset(id: 'under_200', label: '< 200 sqm', min: null, max: 200),
    LotSizePreset(id: '200_300', label: '200 - 300 sqm', min: 200, max: 300),
    LotSizePreset(id: '301_500', label: '301 - 500 sqm', min: 301, max: 500),
    LotSizePreset(id: 'above_500', label: '500+ sqm', min: 500, max: null),
  ];

  bool _isPresetSelected(LotSizePreset preset) {
    if (preset.id == 'all') {
      return selectedMin == null && selectedMax == null;
    }
    return selectedMin == preset.min && selectedMax == preset.max;
  }

  bool get _isCustomSelected {
    if (selectedMin == null && selectedMax == null) return false;
    for (final p in presets) {
      if (p.id != 'all' && selectedMin == p.min && selectedMax == p.max) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          // Icon indicator for Size/Area
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.outlineVariant.withValues(alpha: 0.4),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.straighten,
                  size: 14,
                  color: AppColors.primaryContainer,
                ),
                SizedBox(width: 4),
                Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Presets
          ...presets.map((preset) {
            final isSelected = _isPresetSelected(preset);
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelectPreset(preset.min, preset.max, preset.label),
                  borderRadius: BorderRadius.circular(999),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer
                          : AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryContainer
                            : AppColors.outlineVariant.withValues(alpha: 0.4),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryContainer.withValues(alpha: 0.25),
                                blurRadius: 4,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        preset.label,
                        style: AppTextStyles.labelSm.copyWith(
                          color: isSelected ? Colors.white : AppColors.onSurface,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),

          // Custom Range Button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onOpenCustomFilter,
              borderRadius: BorderRadius.circular(999),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _isCustomSelected
                      ? AppColors.primaryContainer
                      : AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: _isCustomSelected
                        ? AppColors.primaryContainer
                        : AppColors.outlineVariant.withValues(alpha: 0.4),
                  ),
                  boxShadow: _isCustomSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primaryContainer.withValues(alpha: 0.25),
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
                      Icons.tune,
                      size: 13,
                      color: _isCustomSelected ? Colors.white : AppColors.primaryContainer,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _isCustomSelected
                          ? '${selectedMin?.toInt() ?? 0} - ${selectedMax?.toInt() ?? "Max"} sqm'
                          : 'Custom...',
                      style: AppTextStyles.labelSm.copyWith(
                        color: _isCustomSelected ? Colors.white : AppColors.primaryContainer,
                        fontWeight: _isCustomSelected ? FontWeight.w700 : FontWeight.w600,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
