import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Displays the broker level status pill, live sync pulse indicator,
/// broker name, and portfolio subtitle.
class GreetingStatusSection extends StatelessWidget {
  final String brokerName;
  final String brokerLevel;
  final String syncTime;

  const GreetingStatusSection({
    super.key,
    this.brokerName = 'Accredited Broker',
    this.brokerLevel = 'Accredited Broker',
    this.syncTime = 'Live Sync 2m ago',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Pills (Responsive Wrap)
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              // Accreditation Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryContainer,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified,
                      size: 14,
                      color: AppColors.onSecondaryContainer,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      brokerLevel.toUpperCase(),
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.onSecondaryContainer,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

              // Live Sync Pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
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
                    Text(
                      syncTime,
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Broker Name & Subtitle
          Text(
            brokerName,
            style: AppTextStyles.headlineSm.copyWith(
              color: AppColors.primaryContainer,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Here is your portfolio pace for today.',
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
