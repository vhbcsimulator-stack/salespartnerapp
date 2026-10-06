import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Featured development highlight card with hero image, pricing stats, and quick actions.
class FeaturedDevelopmentCard extends StatelessWidget {
  final VoidCallback? onViewInventory;
  final VoidCallback? onExploreMap;
  final String title;
  final String location;
  final String categoryTag;
  final String badgeText;
  final String pricePerSqm;
  final String startingTcp;
  final String? customImageUrl;
  final String inventoryButtonLabel;
  final String mapButtonLabel;

  const FeaturedDevelopmentCard({
    super.key,
    this.onViewInventory,
    this.onExploreMap,
    this.title = 'MVLC',
    this.location = 'Nasugbu, Batangas',
    this.categoryTag = 'Residential & Commercial',
    this.badgeText = 'Available Lots',
    this.pricePerSqm = '₱9,800',
    this.startingTcp = 'TCP ₱1.18M',
    this.customImageUrl,
    this.inventoryButtonLabel = 'View Inventory',
    this.mapButtonLabel = 'Explore Map',
  });

  static const String imageUrl = 'asset/mvlc.jpg';

  @override
  Widget build(BuildContext context) {
    final displayImage = customImageUrl ?? imageUrl;
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
                  'FEATURED DEVELOPMENT',
                  style: AppTextStyles.labelMd.copyWith(
                    letterSpacing: 1.0,
                    color: AppColors.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Priority Allocation',
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Showcase Card
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Media Banner with Badges & Overlays
                Stack(
                  children: [
                    SizedBox(
                      height: 176,
                      width: double.infinity,
                      child: displayImage.startsWith('asset')
                          ? Image.asset(
                              displayImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: AppColors.primaryContainer,
                                child: const Center(
                                  child: Icon(
                                    Icons.landscape,
                                    size: 48,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: displayImage,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: AppColors.surfaceContainerHigh,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 36,
                                    color: AppColors.outlineVariant,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.primaryContainer,
                                child: const Center(
                                  child: Icon(
                                    Icons.landscape,
                                    size: 48,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                    ),

                    // Gradient Overlay
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.35),
                              Colors.transparent,
                              AppColors.primary.withValues(alpha: 0.85),
                            ],
                            stops: const [0.0, 0.45, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Top Badges
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest
                              .withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          categoryTag,
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.primaryContainer,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 4,
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
                            const SizedBox(width: 5),
                            Text(
                              badgeText,
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.onSurface,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Overlay Info
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppColors.primaryFixed,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                location,
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.primaryFixed,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            title,
                            style: AppTextStyles.headlineMd.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Card Details & Pricing
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      // Pricing Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PRICE PER SQM',
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    letterSpacing: 0.6,
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text.rich(
                                  TextSpan(
                                    text: pricePerSqm,
                                    style:
                                        AppTextStyles.priceDisplay.copyWith(
                                      fontSize: 20,
                                      color: AppColors.primaryContainer,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: ' /sqm',
                                        style: AppTextStyles.bodySm.copyWith(
                                          color: AppColors.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'INVESTMENT STARTS',
                                  style: AppTextStyles.labelSm.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    letterSpacing: 0.6,
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  startingTcp,
                                  style: AppTextStyles.titleMd.copyWith(
                                    color: AppColors.secondary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Action Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: ElevatedButton.icon(
                                onPressed: onViewInventory ?? () {},
                                icon: const Icon(Icons.list_alt, size: 18),
                                label: Text(inventoryButtonLabel),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryContainer,
                                  foregroundColor: AppColors.onPrimary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: AppTextStyles.labelLg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 44,
                              child: ElevatedButton.icon(
                                onPressed: onExploreMap ?? () {},
                                icon: const Icon(Icons.explore, size: 18),
                                label: Text(mapButtonLabel),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.surfaceContainer,
                                  foregroundColor: AppColors.primaryContainer,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  textStyle: AppTextStyles.labelLg.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
