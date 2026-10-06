import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class BrokerUpdateItem {
  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;

  const BrokerUpdateItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
  });
}

/// Real-time activity feed showing live lot reservations, inventory drops, and price changes.
class LiveBrokerUpdates extends StatelessWidget {
  final List<BrokerUpdateItem>? updates;

  const LiveBrokerUpdates({
    super.key,
    this.updates,
  });

  static List<BrokerUpdateItem> get defaultUpdates => const [
        BrokerUpdateItem(
          title: 'Lot Reservation Approved',
          subtitle: 'Block 5 Lot 12 • Buyer Mr. Carlos Mendoza',
          time: '15m ago',
          icon: Icons.check_circle,
          iconColor: AppColors.surfaceTint,
          iconBgColor: AppColors.surfaceContainer,
        ),
        BrokerUpdateItem(
          title: 'New Inventory Released',
          subtitle: 'Phase 3 Sunset Ridge (18 Scenic Corner Lots)',
          time: '1h ago',
          icon: Icons.new_releases,
          iconColor: AppColors.onSecondaryContainer,
          iconBgColor: AppColors.secondaryContainer,
        ),
        BrokerUpdateItem(
          title: 'Price Adjustment',
          subtitle: 'Commercial Block 2 adjusted +5% effective today',
          time: 'Today',
          icon: Icons.trending_up,
          iconColor: AppColors.primaryContainer,
          iconBgColor: AppColors.surfaceContainerHigh,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final list = updates ?? defaultUpdates;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'LIVE BROKER UPDATES',
                  style: AppTextStyles.labelMd.copyWith(
                    letterSpacing: 1.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.sensors,
                size: 18,
                color: AppColors.secondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // List Container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
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
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              separatorBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                height: 1,
                color: AppColors.surfaceContainer,
              ),
              itemBuilder: (context, index) {
                final item = list[index];

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon Circle
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: item.iconBgColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        size: 17,
                        color: item.iconColor,
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.title,
                                  style: AppTextStyles.titleMd.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.time,
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.subtitle,
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 11.5,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
