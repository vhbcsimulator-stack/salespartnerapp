import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/contact_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/lot_model.dart';

/// Dynamic card rendering a real lot record fetched from Supabase.
class DynamicLotCard extends StatelessWidget {
  final LotModel lot;
  final Function(LotModel lot)? onDetailsTap;
  final Function(LotModel lot)? onComputeTap;
  final Function(LotModel lot)? onReserveTap;
  final Function(LotModel lot)? onViewLotTap;
  final Function(LotModel lot)? onJoinWaitlistTap;
  final Function(LotModel lot)? onBookmarkTap;

  const DynamicLotCard({
    super.key,
    required this.lot,
    this.onDetailsTap,
    this.onComputeTap,
    this.onReserveTap,
    this.onViewLotTap,
    this.onJoinWaitlistTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    if (lot.isSold) {
      return _buildSoldCard(context);
    } else if (lot.isReserved || lot.isHold) {
      return _buildReservedCard(context);
    } else {
      return _buildAvailableCard(context);
    }
  }

  // --- AVAILABLE LOT CARD ---
  Widget _buildAvailableCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image with Overlays
          Stack(
            children: [
              SizedBox(
                height: 176,
                width: double.infinity,
                child: lot.imageUrl.startsWith('asset')
                    ? Image.asset(
                        lot.imageUrl,
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
                        imageUrl: lot.imageUrl,
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
                        AppColors.primaryContainer.withValues(alpha: 0.90),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Live Status Badge
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
                        .withValues(alpha: 0.95),
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
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.surfaceTint,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'AVAILABLE',
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bookmark Action Button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => onBookmarkTap?.call(lot),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest
                          .withValues(alpha: 0.90),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.bookmark_border,
                      size: 20,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ),
              ),

              // Bottom Overlaid Unit Identity
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lot.project ?? (lot.phase != null ? 'Phase ${lot.phase}' : 'VHBC Inventory'),
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.secondaryFixed,
                              letterSpacing: 0.8,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lot.formattedLotNo,
                            style: AppTextStyles.headlineSm.copyWith(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 1),
                          Text(
                            lot.phaseLocationText,
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.surfaceContainerHigh,
                              fontSize: 11,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        lot.categoryDisplay,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.secondaryFixed,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Card Core Details
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Specs Tag Badges
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _buildSpecBadge(
                      icon: Icons.square_foot,
                      text: lot.formattedSize,
                    ),
                    _buildSpecBadge(
                      icon: lot.isMscc ? Icons.apartment_outlined : Icons.terrain_outlined,
                      text: lot.categoryDisplay,
                    ),
                    _buildSpecBadge(
                      icon: Icons.layers_outlined,
                      text: lot.isMscc
                          ? (lot.floorLevel ?? 'Floor ${lot.phase ?? 2}')
                          : 'Phase ${lot.phase ?? 1}',
                    ),

                  ],
                ),
                const SizedBox(height: 12),

                // Pricing Highlight Matrix
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UNIT PRICE',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 0.6,
                                fontSize: 9.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                text: lot.formattedPricePerSqm,
                                style: AppTextStyles.bodyMd.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurface,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' / sqm',
                                    style: AppTextStyles.labelSm.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 32,
                        width: 1,
                        color: AppColors.surfaceContainerHighest,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'TOTAL CONTRACT PRICE (TCP)',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 9,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 1),
                            Text(
                              lot.formattedTotal,
                              style: AppTextStyles.priceDisplay.copyWith(
                                fontSize: 20,
                                color: AppColors.primaryContainer,
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
                const SizedBox(height: 10),

                // Hold / Reservation Meta Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.verified,
                            size: 15,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              lot.reservationFeeText,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.secondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '60-Mo Amortization',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.outline,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Action Bar: Compute + Reserve Now
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: () => onComputeTap?.call(lot),
                          icon: const Icon(Icons.calculate_outlined, size: 17),
                          label: const Text('Compute'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryContainer,
                            foregroundColor: AppColors.onSecondaryContainer,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: AppTextStyles.labelMd.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: onReserveTap != null
                              ? () => onReserveTap!.call(lot)
                              : () => ContactService.callSalesDesk(
                                    context: context,
                                    title: 'Lot Reservation Desk',
                                    subtitle:
                                        'Direct line to hold lot with sales coordinator',
                                    lotInfo:
                                        '${lot.formattedLotNo} • ${lot.formattedTotal}',
                                  ),
                          icon: const Icon(Icons.lock_open, size: 17),
                          label: const Text('Reserve Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryContainer,
                            foregroundColor: AppColors.onPrimary,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: AppTextStyles.labelMd.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 12.5,
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
    );
  }

  // --- RESERVED OR HOLD LOT CARD ---
  Widget _buildReservedCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 144,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.grey.withValues(alpha: 0.25),
                    BlendMode.saturation,
                  ),
                  child: lot.imageUrl.startsWith('asset')
                      ? Image.asset(
                          lot.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: AppColors.primaryContainer,
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: lot.imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: AppColors.surfaceContainerHigh,
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.primaryContainer,
                          ),
                        ),
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.75),
                      ],
                      stops: const [0.2, 1.0],
                    ),
                  ),
                ),
              ),

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
                        .withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        lot.isHold ? Icons.timer_outlined : Icons.lock,
                        size: 14,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        lot.statusBadgeText,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSecondaryContainer,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 10,
                left: 12,
                right: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lot.project ?? (lot.phase != null ? 'Phase ${lot.phase}' : 'VHBC Inventory'),
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.secondaryFixed,
                        letterSpacing: 0.8,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      lot.formattedLotNo,
                      style: AppTextStyles.headlineSm.copyWith(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryContainer.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lot.isHold ? 'Active Hold by Broker' : 'Unit Pending Reservation',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.onSecondaryContainer,
                                fontWeight: FontWeight.w800,
                                fontSize: 10.5,
                              ),
                            ),
                            Text(
                              'Amortization verification & documentation pending',
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
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            lot.formattedSize,
                            style: AppTextStyles.labelMd.copyWith(
                              color: AppColors.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6.0),
                            child: Text('•'),
                          ),
                          Flexible(
                            child: Text(
                              lot.categoryDisplay,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.labelMd.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'TCP',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.outline,
                            fontSize: 9,
                          ),
                        ),
                        Text(
                          lot.formattedTotal,
                          style: AppTextStyles.titleMd.copyWith(
                            color: AppColors.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: () => onViewLotTap?.call(lot),
                          icon: const Icon(Icons.visibility_outlined, size: 17),
                          label: Text(lot.isMscc ? 'View Unit' : 'View Lot'),
                          style: ElevatedButton.styleFrom(

                            backgroundColor: AppColors.surfaceContainer,
                            foregroundColor: AppColors.primaryContainer,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: AppTextStyles.labelMd.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                          onPressed: () => onJoinWaitlistTap?.call(lot),
                          icon: const Icon(
                            Icons.notification_add_outlined,
                            size: 17,
                            color: AppColors.secondary,
                          ),
                          label: const Text('Join Waitlist'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            foregroundColor: AppColors.onSurface,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: AppTextStyles.labelMd.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
    );
  }

  // --- SOLD OUT CARD ---
  Widget _buildSoldCard(BuildContext context) {
    return Opacity(
      opacity: 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2.5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.errorContainer,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            'SOLD OUT',
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.onErrorContainer,
                              fontWeight: FontWeight.w800,
                              fontSize: 9,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ),
                        Text(
                          'Closed Contract',
                          style: AppTextStyles.labelSm.copyWith(
                            color: AppColors.outline,
                            fontSize: 9.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      lot.formattedLotNo,
                      style: AppTextStyles.titleMd.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${lot.project ?? "VHBC"} • ${lot.phaseLocationText} • ${lot.formattedSize}',
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
              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Contract Closed',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.outline,
                      fontSize: 9.5,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    lot.formattedTotal,
                    style: AppTextStyles.titleMd.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '100% Commission Paid',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecBadge({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.secondary,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTextStyles.labelMd.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
