import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/client_model.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;
  final VoidCallback onTap;

  const ClientCard({
    super.key,
    required this.client,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color accentColor;
    switch (client.stage) {
      case ClientStage.hot:
        accentColor = AppColors.secondaryFixedDim;
        break;
      case ClientStage.reserved:
        accentColor = AppColors.secondary;
        break;
      case ClientStage.warm:
        accentColor = AppColors.tertiary;
        break;
      case ClientStage.cold:
        accentColor = AppColors.outlineVariant;
        break;
      case ClientStage.closed:
        accentColor = AppColors.surfaceTint;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Left Accent Highlight bar
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: 5,
            child: Container(color: accentColor),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 14,
              top: 14,
              bottom: 14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 12),
                _buildKeyDetailsBox(),
                const SizedBox(height: 10),
                _buildActivityRow(),
                const SizedBox(height: 12),
                _buildActionFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar with micro status icon
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.tertiaryContainer,
              ),
              clipBehavior: Clip.antiAlias,
              child: client.avatarUrl != null && client.avatarUrl!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: client.avatarUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildInitials(),
                      errorWidget: (context, url, error) => _buildInitials(),
                    )
                  : _buildInitials(),
            ),
            Positioned(
              right: -3,
              bottom: -3,
              child: _buildAvatarBadge(),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // Name and VIP / Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                client.name,
                style: AppTextStyles.headlineMd.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                  color: AppColors.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              if (client.vipTag != null && client.vipTag!.isNotEmpty)
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 13,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        client.vipTag!,
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              else if (client.subtitle != null)
                Text(
                  client.subtitle!,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.outline,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        const SizedBox(width: 6),
        // Stage Badge on the right
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildStageBadge(),
            if (client.holdSubtitle != null) ...[
              const SizedBox(height: 3),
              Text(
                client.holdSubtitle!,
                style: AppTextStyles.labelSm.copyWith(
                  color: AppColors.outline,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildInitials() {
    return Container(
      color: AppColors.tertiaryContainer,
      alignment: Alignment.center,
      child: Text(
        client.initials,
        style: AppTextStyles.titleMd.copyWith(
          color: AppColors.onTertiaryContainer,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildAvatarBadge() {
    IconData icon;
    Color bgColor;

    switch (client.stage) {
      case ClientStage.hot:
        icon = Icons.local_fire_department;
        bgColor = AppColors.secondary;
        break;
      case ClientStage.reserved:
        icon = Icons.check;
        bgColor = AppColors.primary;
        break;
      case ClientStage.warm:
        icon = Icons.trending_up;
        bgColor = AppColors.tertiary;
        break;
      case ClientStage.cold:
        icon = Icons.ac_unit;
        bgColor = AppColors.outline;
        break;
      case ClientStage.closed:
        icon = Icons.verified_user;
        bgColor = AppColors.surfaceTint;
        break;
    }

    return Container(
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Icon(
        icon,
        size: 10,
        color: Colors.white,
      ),
    );
  }

  Widget _buildStageBadge() {
    Color bg;
    Color fg;
    Widget? prefixDot;

    switch (client.stage) {
      case ClientStage.hot:
        bg = AppColors.secondaryContainer;
        fg = AppColors.onSecondaryContainer;
        prefixDot = Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 4),
          decoration: const BoxDecoration(
            color: AppColors.secondary,
            shape: BoxShape.circle,
          ),
        );
        break;
      case ClientStage.reserved:
        bg = AppColors.primaryFixed;
        fg = AppColors.primary;
        prefixDot = Container(
          width: 6,
          height: 6,
          margin: const EdgeInsets.only(right: 4),
          decoration: const BoxDecoration(
            color: AppColors.surfaceTint,
            shape: BoxShape.circle,
          ),
        );
        break;
      case ClientStage.warm:
        bg = AppColors.surfaceContainerHigh;
        fg = AppColors.tertiary;
        break;
      case ClientStage.cold:
        bg = AppColors.surfaceContainerLow;
        fg = AppColors.outline;
        break;
      case ClientStage.closed:
        bg = AppColors.primaryContainer;
        fg = AppColors.onPrimary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ?prefixDot,
          Text(
            client.stage.badgeText,
            style: AppTextStyles.labelSm.copyWith(
              color: fg,
              fontWeight: FontWeight.w800,
              fontSize: 9.5,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyDetailsBox() {
    IconData devIcon = Icons.holiday_village;
    if (client.projectCode == 'MSCC') {
      devIcon = Icons.domain;
    } else if (client.projectCode == 'EBLF') {
      devIcon = Icons.nature_people;
    } else if (client.projectCode == 'GLS' ||
        client.projectCode == 'LCN' ||
        client.projectCode == 'MCVC' ||
        client.projectCode == 'RHM' ||
        client.projectCode == 'RHN') {
      devIcon = Icons.auto_awesome;
    } else if (client.stage == ClientStage.closed) {
      devIcon = Icons.villa;
    }

    IconData noteIcon = Icons.payments;
    if (client.statusNote.toLowerCase().contains('tripping')) {
      noteIcon = Icons.directions_car;
    } else if (client.statusNote.toLowerCase().contains('computation')) {
      noteIcon = Icons.calculate;
    } else if (client.statusNote.toLowerCase().contains('commission')) {
      noteIcon = Icons.check_circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(devIcon, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  client.unitDescription,
                  style: AppTextStyles.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                client.tcpFormatted,
                style: AppTextStyles.titleMd.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Icon(noteIcon, size: 14, color: AppColors.secondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  client.statusNote,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  client.tagNote,
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.outline,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(
                Icons.schedule,
                size: 14,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  client.lastActivityText,
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.outline,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          client.phone,
          style: AppTextStyles.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionFooter(BuildContext context) {
    String folderButtonText = 'View Folder';
    IconData folderIcon = Icons.arrow_forward;
    Color folderBg = AppColors.primary;
    Color folderFg = AppColors.onPrimary;

    if (client.stage == ClientStage.warm || client.stage == ClientStage.cold) {
      folderButtonText = 'Client Details';
      folderBg = AppColors.surfaceContainerHigh;
      folderFg = AppColors.onSurface;
    } else if (client.stage == ClientStage.closed) {
      folderButtonText = 'Title & Ledger';
      folderIcon = Icons.receipt_long;
      folderBg = AppColors.surfaceContainerHigh;
      folderFg = AppColors.onSurface;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildIconButton(
              icon: Icons.call,
              color: AppColors.primary,
              tooltip: 'Call ${client.name}',
              onTap: () => _handleContactAction(context, 'Call', client.phone),
            ),
            const SizedBox(width: 6),
            _buildIconButton(
              icon: Icons.chat_bubble_outline,
              color: AppColors.secondary,
              tooltip: 'Message ${client.name}',
              onTap: () => _handleContactAction(context, 'SMS / Viber', client.phone),
            ),
            const SizedBox(width: 6),
            _buildIconButton(
              icon: Icons.ios_share,
              color: AppColors.onSurfaceVariant,
              tooltip: 'Share unit brochure',
              onTap: () => _handleShare(context),
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: folderBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  folderButtonText,
                  style: AppTextStyles.labelMd.copyWith(
                    color: folderFg,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(folderIcon, size: 16, color: folderFg),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 17, color: color),
      ),
    );
  }

  void _handleContactAction(BuildContext context, String action, String number) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action to $number (copied to clipboard)'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.primaryContainer,
      ),
    );
  }

  void _handleShare(BuildContext context) {
    Clipboard.setData(
      ClipboardData(
        text: 'VHBC Property Packet: ${client.unitDescription} (${client.tcpFormatted})',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Unit details copied to clipboard ready to share!'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.primaryContainer,
      ),
    );
  }
}
