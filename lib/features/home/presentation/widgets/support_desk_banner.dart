import 'package:flutter/material.dart';
import '../../../../core/services/contact_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Concierge and Broker Desk quick assistance banner.
class SupportDeskBanner extends StatelessWidget {
  final VoidCallback? onCallDesk;

  const SupportDeskBanner({
    super.key,
    this.onCallDesk,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.support_agent,
                size: 19,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 10),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Broker Support Desk',
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    'Instant document verification & holds',
                    style: AppTextStyles.bodySm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Call Desk Button
            ElevatedButton(
              onPressed: onCallDesk ?? () => ContactService.callSalesDesk(context: context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerLowest,
                foregroundColor: AppColors.primaryContainer,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: AppTextStyles.labelSm.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
              child: const Text('Call Desk'),
            ),
          ],
        ),
      ),
    );
  }
}
