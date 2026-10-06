import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ToolingAction {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const ToolingAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });
}

/// 2-column quick action grid for high-frequency broker tasks.
class BrokerToolingGrid extends StatelessWidget {
  final Function(String actionTitle)? onActionTap;

  const BrokerToolingGrid({
    super.key,
    this.onActionTap,
  });

  List<ToolingAction> _getActions(BuildContext context) => [
        ToolingAction(
          title: 'Find Property',
          subtitle: 'Search inventory',
          icon: Icons.search,
          iconColor: AppColors.primaryContainer,
          onTap: () => onActionTap?.call('Find Property'),
        ),
        ToolingAction(
          title: 'Sales Map',
          subtitle: 'Live lot locator',
          icon: Icons.map_outlined,
          iconColor: AppColors.secondary,
          onTap: () => onActionTap?.call('Sales Map'),
        ),
        ToolingAction(
          title: 'Computation',
          subtitle: 'Sample schedules',
          icon: Icons.calculate_outlined,
          iconColor: AppColors.primaryContainer,
          onTap: () => onActionTap?.call('Computation'),
        ),
        ToolingAction(
          title: 'Add Client',
          subtitle: 'Quick lead entry',
          icon: Icons.person_add_alt_1_outlined,
          iconColor: AppColors.secondary,
          onTap: () => onActionTap?.call('Add Client'),
        ),
        ToolingAction(
          title: 'Reserve Unit',
          subtitle: 'Lock lot instantly',
          icon: Icons.bookmark_add_outlined,
          iconColor: AppColors.primaryContainer,
          onTap: () => onActionTap?.call('Reserve Unit'),
        ),
        ToolingAction(
          title: 'Sales Kit',
          subtitle: 'Brochures & decks',
          icon: Icons.folder_zip_outlined,
          iconColor: AppColors.secondary,
          onTap: () => onActionTap?.call('Sales Kit'),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final actions = _getActions(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'BROKER TOOLING',
            style: AppTextStyles.labelMd.copyWith(
              letterSpacing: 1.0,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.3,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: action.onTap,
                    borderRadius: BorderRadius.circular(14),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          // Icon Container
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              action.icon,
                              size: 20,
                              color: action.iconColor,
                            ),
                          ),
                          const SizedBox(width: 8),

                          // Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  action.title,
                                  style: AppTextStyles.titleMd.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  action.subtitle,
                                  style: AppTextStyles.bodySm.copyWith(
                                    fontSize: 10.5,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
