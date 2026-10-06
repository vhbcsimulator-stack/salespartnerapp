import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Floating bottom inventory count indicator with smooth scroll-to-top button.
class InventoryFloatingStatusPill extends StatelessWidget {
  final VoidCallback onScrollToTop;
  final int availableCount;
  final int totalCount;
  final String? customLabel;
  final IconData? icon;
  final Color? iconColor;

  const InventoryFloatingStatusPill({
    super.key,
    required this.onScrollToTop,
    this.availableCount = 142,
    this.totalCount = 342,
    this.customLabel,
    this.icon,
    this.iconColor,
    this.isUnit = false,
  });

  final bool isUnit;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryContainer.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon ?? (customLabel != null ? Icons.auto_awesome : Icons.domain_verification),
            size: 18,
            color: iconColor ?? AppColors.secondaryFixed,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: customLabel != null
                ? Text(
                    customLabel!,
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.secondaryFixed,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text.rich(
                    TextSpan(
                      text: 'Showing ',
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.5,
                      ),
                      children: [
                        TextSpan(
                          text: '$availableCount Available',
                          style: const TextStyle(
                            color: AppColors.secondaryFixed,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: isUnit
                              ? ' of $totalCount units'
                              : ' of $totalCount properties',
                        ),
                      ],
                    ),

                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onScrollToTop,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_upward,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
