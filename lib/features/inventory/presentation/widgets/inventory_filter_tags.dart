import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/inventory_item.dart';

/// Removable active filter tags row with a "Reset All" trigger.
class InventoryFilterTags extends StatelessWidget {
  final List<AppliedFilterTag> tags;
  final ValueChanged<String> onRemoveTag;
  final VoidCallback onResetAll;

  const InventoryFilterTags({
    super.key,
    required this.tags,
    required this.onRemoveTag,
    required this.onResetAll,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 30,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          ...tags.map((tag) => Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (tag.hasStatusDot) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.surfaceTint,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        tag.label,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () => onRemoveTag(tag.id),
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: AppColors.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          TextButton(
            onPressed: onResetAll,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Reset All',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
