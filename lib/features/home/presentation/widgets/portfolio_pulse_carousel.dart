import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Data class representing a portfolio pulse metric card.
class MetricItem {
  final String label;
  final String value;
  final String subtitle;
  final Color? subtitleColor;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final double width;

  const MetricItem({
    required this.label,
    required this.value,
    required this.subtitle,
    this.subtitleColor,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.width = 164,
  });
}

/// Horizontal scrolling carousel for key portfolio metrics.
class PortfolioPulseCarousel extends StatelessWidget {
  final List<MetricItem>? metrics;

  const PortfolioPulseCarousel({
    super.key,
    this.metrics,
  });

  static List<MetricItem> get defaultMetrics => const [
        MetricItem(
          label: 'AVAILABLE',
          value: '342',
          subtitle: 'Across 5 projects',
          icon: Icons.apartment,
          iconBgColor: AppColors.surfaceContainer,
          iconColor: AppColors.surfaceTint,
          width: 164,
        ),
        MetricItem(
          label: 'RESERVATIONS',
          value: '4',
          subtitle: '1 expiring in 24h',
          subtitleColor: AppColors.error,
          icon: Icons.hourglass_top,
          iconBgColor: AppColors.errorContainer,
          iconColor: AppColors.onErrorContainer,
          width: 164,
        ),
        MetricItem(
          label: 'TOTAL CLIENTS',
          value: '18',
          subtitle: '3 warm leads',
          subtitleColor: AppColors.secondary,
          icon: Icons.contacts,
          iconBgColor: AppColors.surfaceContainer,
          iconColor: AppColors.secondary,
          width: 164,
        ),
        MetricItem(
          label: 'COMMISSION',
          value: '₱485,000',
          subtitle: '₱120k pending release',
          icon: Icons.payments,
          iconBgColor: AppColors.secondaryContainer,
          iconColor: AppColors.onSecondaryContainer,
          width: 184,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = metrics ?? defaultMetrics;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'PORTFOLIO PULSE',
                style: AppTextStyles.labelMd.copyWith(
                  letterSpacing: 1.0,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              Text(
                'Real-time stats',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Carousel
        SizedBox(
          height: 118,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const BouncingScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                width: item.width,
                padding: const EdgeInsets.all(13.0),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Card Top Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.label,
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              letterSpacing: 0.6,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: item.iconBgColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(
                            item.icon,
                            size: 15,
                            color: item.iconColor,
                          ),
                        ),
                      ],
                    ),

                    // Card Bottom Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.value,
                          style: item.value.startsWith('₱')
                              ? AppTextStyles.titleMd.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: AppColors.primaryContainer,
                                )
                              : AppTextStyles.priceDisplay.copyWith(
                                  fontSize: 24,
                                ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle,
                          style: AppTextStyles.bodySm.copyWith(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: item.subtitleColor ??
                                AppColors.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
