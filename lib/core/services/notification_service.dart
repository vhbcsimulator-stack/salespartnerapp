import 'package:flutter/material.dart';
import '../../features/home/models/announcement_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'supabase_service.dart';

/// Centralized service managing broker announcements, notifications, and read/unread telemetry.
class NotificationService {
  NotificationService._();

  static final ValueNotifier<int> unreadCountNotifier = ValueNotifier<int>(0);
  static final Set<int> _readIds = <int>{};
  static List<AnnouncementModel> _announcements = <AnnouncementModel>[];

  static int get unreadCount => unreadCountNotifier.value;
  static List<AnnouncementModel> get announcements => List.unmodifiable(_announcements);

  /// Synchronize announcements list and recalculate unread badge count
  static void setAnnouncements(List<AnnouncementModel> items) {
    _announcements = List.from(items);
    _recalculateUnreadCount();
  }

  /// Whether a specific announcement has been read
  static bool isRead(int id) => _readIds.contains(id);

  /// Mark a single notification as read
  static void markAsRead(int id) {
    if (!_readIds.contains(id)) {
      _readIds.add(id);
      _recalculateUnreadCount();
    }
  }

  /// Mark all notifications as read (clears badge to 0)
  static void markAllAsRead() {
    for (final item in _announcements) {
      _readIds.add(item.id);
    }
    _recalculateUnreadCount();
  }

  static void _recalculateUnreadCount() {
    int unread = 0;
    for (final item in _announcements) {
      if (!_readIds.contains(item.id)) {
        unread++;
      }
    }
    unreadCountNotifier.value = unread;
  }

  /// Reset state (useful for tests or user session logout)
  @visibleForTesting
  static void reset() {
    _readIds.clear();
    _announcements.clear();
    unreadCountNotifier.value = 0;
  }

  /// Display modern, interactive announcements bottom sheet and automatically mark them as read
  static Future<void> showNotificationsModal(BuildContext context) async {
    // If announcements are empty, try loading from SupabaseService cache or live
    if (_announcements.isEmpty) {
      try {
        final items = await SupabaseService.fetchAnnouncements();
        if (items.isNotEmpty) {
          setAnnouncements(items);
        }
      } catch (_) {}
    }

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final items = _announcements;
            final hasUnread = items.any((a) => !isRead(a.id));

            return Container(
              decoration: const BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 28,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.campaign_outlined,
                            color: AppColors.primaryContainer,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Notifications',
                            style: AppTextStyles.headlineSm.copyWith(
                              color: AppColors.primaryContainer,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          if (hasUnread)
                            TextButton.icon(
                              onPressed: () {
                                markAllAsRead();
                                setModalState(() {});
                              },
                              icon: const Icon(Icons.done_all, size: 16, color: AppColors.secondary),
                              label: Text(
                                'Mark all as read',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.close, color: AppColors.outline),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (items.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 36.0),
                      child: Center(
                        child: Text(
                          'No unread notifications at this time.',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  else
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: items.length,
                        separatorBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: 1,
                          color: AppColors.surfaceContainer,
                        ),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final read = isRead(item.id);

                          return InkWell(
                            onTap: () {
                              markAsRead(item.id);
                              setModalState(() {});
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 6, right: 10),
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: read ? Colors.transparent : AppColors.error,
                                    ),
                                  ),
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
                                                  fontWeight: read ? FontWeight.w600 : FontWeight.w800,
                                                  color: read ? AppColors.onSurfaceVariant : AppColors.onSurface,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              item.relativeTime,
                                              style: AppTextStyles.labelSm.copyWith(
                                                color: AppColors.secondary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item.content,
                                          style: AppTextStyles.bodyMd.copyWith(
                                            color: AppColors.onSurfaceVariant,
                                            height: 1.4,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );

    // When modal closes, mark all remaining as read so the badge is completely dismissed
    markAllAsRead();
  }
}
