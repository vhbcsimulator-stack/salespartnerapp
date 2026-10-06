import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/services/notification_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_image.dart';

/// Top App Bar / Header for the VHBC Broker Portal Home Page
class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final VoidCallback? onProfileTap;
  final int? unreadCount;
  final String greetingText;
  final String? avatarUrl;

  const HomeHeader({
    super.key,
    this.onNotificationTap,
    this.onProfileTap,
    this.unreadCount,
    this.greetingText = 'Good day, Broker',
    this.avatarUrl,
  });

  static const String logoUrl = 'asset/bhrilogo.jpg';

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              // Logo
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: AppImage(
                    imageUrl: logoUrl,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                    placeholder: (context) => Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.apartment,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    errorWidget: (context, error) => Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.apartment,
                        size: 16,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Title and Subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BHRI SALES PARTNER APP',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.secondary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      greetingText,
                      style: AppTextStyles.titleMd.copyWith(
                        color: AppColors.primaryContainer,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Notification Button with Badge
              ValueListenableBuilder<int>(
                valueListenable: NotificationService.unreadCountNotifier,
                builder: (context, dynamicCount, _) {
                  final effectiveCount = unreadCount ?? dynamicCount;

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        onPressed: onNotificationTap ?? () => NotificationService.showNotificationsModal(context),
                        icon: const Icon(
                          Icons.notifications_outlined,
                          color: AppColors.onSurfaceVariant,
                          size: 24,
                        ),
                        style: IconButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                        ),
                      ),
                      if (effectiveCount > 0)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.surfaceContainerLowest,
                                width: 1.5,
                              ),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              '$effectiveCount',
                              style: const TextStyle(
                                color: AppColors.onError,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 4),

              // Profile Avatar
              GestureDetector(
                onTap: onProfileTap ?? () {},
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondaryContainer,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: (avatarUrl != null && avatarUrl!.isNotEmpty)
                        ? CachedNetworkImage(
                            imageUrl: avatarUrl!,
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 30,
                              height: 30,
                              color: AppColors.surfaceContainer,
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 30,
                              height: 30,
                              color: AppColors.secondaryContainer,
                              child: const Icon(
                                Icons.person,
                                size: 18,
                                color: AppColors.secondary,
                              ),
                            ),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            color: AppColors.secondaryContainer,
                            child: const Icon(
                              Icons.person,
                              size: 18,
                              color: AppColors.secondary,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
