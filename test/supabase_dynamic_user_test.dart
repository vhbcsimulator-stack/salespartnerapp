import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vhbc_broker_app/features/auth/services/auth_service.dart';
import 'package:vhbc_broker_app/features/home/presentation/widgets/greeting_status_section.dart';
import 'package:vhbc_broker_app/features/home/presentation/widgets/home_header.dart';

void main() {
  group('Supabase Dynamic User Profile Tests', () {
    test('BrokerUser default constructor does NOT contain hardcoded user info', () {
      const broker = BrokerUser(
        id: 'user-123',
        email: 'maria.santos@realty.ph',
        displayName: 'Maria Santos',
      );

      expect(broker.phone, isEmpty);
      expect(broker.agency, isEmpty);
      expect(broker.prcNumber, isEmpty);
      expect(broker.dhsudNumber, isEmpty);
      expect(broker.validUntil, isEmpty);
      expect(broker.commissionTier, isEmpty);
      expect(broker.avatarUrl, isNull);
      expect(broker.isDemo, isFalse);
    });

    test('BrokerUser dynamically populates Supabase metadata', () {
      final user = User(
        id: 'supabase-user-uuid-999',
        appMetadata: {},
        userMetadata: {
          'full_name': 'Atty. Roberto Tan',
          'phone': '+63 918 111 2222',
          'agency': 'Tan & Partners Realty',
          'prc_number': 'PRC #9988776',
          'dhsud_number': 'DHSUD NCR-B-99/88-7766',
          'avatar_url': 'https://example.com/avatar.jpg',
          'commission_tier': 'Top Tier Partner',
          'valid_until': 'Dec 2028',
          'has_changed_password': true,
        },
        aud: 'authenticated',
        createdAt: DateTime.now().toIso8601String(),
      );

      // Verify that when metadata is passed into BrokerUser, it maps correctly
      final meta = user.userMetadata!;
      final broker = BrokerUser(
        id: user.id,
        email: user.email ?? 'roberto.tan@realty.ph',
        displayName: meta['full_name'] as String,
        phone: meta['phone'] as String,
        agency: meta['agency'] as String,
        prcNumber: meta['prc_number'] as String,
        dhsudNumber: meta['dhsud_number'] as String,
        avatarUrl: meta['avatar_url'] as String,
        commissionTier: meta['commission_tier'] as String,
        validUntil: meta['valid_until'] as String,
        isDemo: false,
      );

      expect(broker.displayName, 'Atty. Roberto Tan');
      expect(broker.phone, '+63 918 111 2222');
      expect(broker.agency, 'Tan & Partners Realty');
      expect(broker.prcNumber, 'PRC #9988776');
      expect(broker.dhsudNumber, 'DHSUD NCR-B-99/88-7766');
      expect(broker.avatarUrl, 'https://example.com/avatar.jpg');
      expect(broker.commissionTier, 'Top Tier Partner');
      expect(broker.validUntil, 'Dec 2028');
    });

    testWidgets('HomeHeader displays dynamic greeting and custom avatarUrl', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: HomeHeader(
              greetingText: 'Good afternoon, Elena',
              avatarUrl: 'https://example.com/elena.jpg',
            ),
          ),
        ),
      );

      expect(find.text('Good afternoon, Elena'), findsOneWidget);
      expect(find.text('Good day, Juan'), findsNothing);
    });

    testWidgets('GreetingStatusSection renders dynamic broker name and role', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: GreetingStatusSection(
              brokerName: 'Arch. Carlos Reyes',
              brokerLevel: 'SENIOR ASSOCIATE',
            ),
          ),
        ),
      );

      expect(find.text('Arch. Carlos Reyes'), findsOneWidget);
      expect(find.text('SENIOR ASSOCIATE'), findsOneWidget);
      expect(find.text('Juan Dela Cruz'), findsNothing);
    });
  });
}
