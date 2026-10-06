import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/notification_service.dart';
import 'package:vhbc_broker_app/features/home/models/announcement_model.dart';
import 'package:vhbc_broker_app/features/home/presentation/widgets/home_header.dart';

void main() {
  setUp(() {
    NotificationService.reset();
  });

  group('NotificationService - Unit Tests', () {
    final mockAnnouncements = [
      AnnouncementModel(
        id: 1,
        title: 'New Price Matrix Released',
        content: 'Check the updated pricing for Phase 2',
        createdAt: DateTime.now(),
      ),
      AnnouncementModel(
        id: 2,
        title: 'Broker Incentive Announced',
        content: 'Earn extra commission on spot cash deals',
        createdAt: DateTime.now(),
      ),
      AnnouncementModel(
        id: 3,
        title: 'System Maintenance',
        content: 'Scheduled for this Sunday',
        createdAt: DateTime.now(),
      ),
    ];

    test('Initial announcements set unread count correctly', () {
      NotificationService.setAnnouncements(mockAnnouncements);
      expect(NotificationService.unreadCount, 3);
      expect(NotificationService.unreadCountNotifier.value, 3);
      expect(NotificationService.isRead(1), isFalse);
    });

    test('Marking single announcement as read decrements unread count', () {
      NotificationService.setAnnouncements(mockAnnouncements);
      expect(NotificationService.unreadCount, 3);

      NotificationService.markAsRead(1);
      expect(NotificationService.unreadCount, 2);
      expect(NotificationService.isRead(1), isTrue);
      expect(NotificationService.isRead(2), isFalse);
    });

    test('Marking all as read resets unread count to 0', () {
      NotificationService.setAnnouncements(mockAnnouncements);
      expect(NotificationService.unreadCount, 3);

      NotificationService.markAllAsRead();
      expect(NotificationService.unreadCount, 0);
      expect(NotificationService.unreadCountNotifier.value, 0);
      expect(NotificationService.isRead(1), isTrue);
      expect(NotificationService.isRead(2), isTrue);
      expect(NotificationService.isRead(3), isTrue);
    });
  });

  group('HomeHeader Notification Badge - Widget Tests', () {
    testWidgets('Badge displays number when unreadCount > 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: HomeHeader(
              unreadCount: 3,
              greetingText: 'Good day, Broker',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('Badge number disappears completely when unreadCount is 0', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: HomeHeader(
              unreadCount: 0,
              greetingText: 'Good day, Broker',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Number badge should not exist
      expect(find.text('0'), findsNothing);
      expect(find.text('3'), findsNothing);
    });

    testWidgets('Badge updates reactively via NotificationService.unreadCountNotifier', (tester) async {
      final mockAnnouncements = [
        AnnouncementModel(
          id: 1,
          title: 'Test Promo',
          content: 'Test content',
          createdAt: DateTime.now(),
        ),
      ];
      NotificationService.setAnnouncements(mockAnnouncements);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: HomeHeader(
              onNotificationTap: () {
                NotificationService.markAllAsRead();
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Initially badge shows 1
      expect(find.text('1'), findsOneWidget);

      // Tap notification bell to read
      await tester.tap(find.byIcon(Icons.notifications_outlined));
      await tester.pumpAndSettle();

      // Once read, badge number disappears
      expect(find.text('1'), findsNothing);
    });
  });
}
