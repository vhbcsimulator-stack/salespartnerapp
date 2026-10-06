import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/supabase_service.dart';
import 'package:vhbc_broker_app/features/auth/services/auth_service.dart';
import 'package:vhbc_broker_app/features/profile/presentation/profile_screen.dart';

class _MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    HttpOverrides.global = _MockHttpOverrides();
  });

  tearDownAll(() {
    HttpOverrides.global = null;
  });

  setUp(() {
    SupabaseService.clearClientsCache();
    AuthService.currentUserNotifier.value = const BrokerUser(
      id: 'test-broker-123',
      email: 'alex.villar@vhbc.com',
      displayName: 'Alex Villar',
      role: 'Senior Real Estate Broker',
      phone: '+63 917 555 8899',
      agency: 'Apex Realty Group',
      prcNumber: 'PRC-0098765',
      dhsudNumber: 'DHSUD-NCR-B-2026/0432',
      licenseNumber: 'PRC-0098765 • DHSUD-NCR-B-2026/0432',
      validUntil: 'Nov 2027',
      commissionTier: 'Tier 1 Diamond',
      isDemo: false,
    );
  });

  group('ProfileScreen Real Data & Dynamic Telemetry Tests', () {
    testWidgets('Renders real broker credentials from AuthService', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Check broker name and agency in hero
      expect(find.text('Alex Villar'), findsWidgets);
      expect(find.text('Apex Realty Group'), findsWidgets);
      expect(find.text('alex.villar@vhbc.com'), findsWidgets);

      // Check accreditation details
      expect(find.text('PRC-0098765'), findsWidgets);
      expect(find.text('DHSUD-NCR-B-2026/0432'), findsWidgets);
      expect(find.text('Tier 1 Diamond'), findsWidgets);
      expect(find.text('Nov 2027'), findsWidgets);
    });

    testWidgets('Renders live production telemetry and dynamic tier progress', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Live Telemetry header is present
      expect(find.text('Broker Production Summary'), findsOneWidget);
      expect(find.text('LIVE TELEMETRY'), findsOneWidget);

      // Production Metric tiles without monetary commissions or sales volume
      expect(find.text('Units Closed'), findsOneWidget);
      expect(find.text('Reserved Units'), findsOneWidget);
      expect(find.text('Active Pipeline'), findsOneWidget);
      expect(find.text('Sales Volume'), findsNothing);
      expect(find.text('Commissions'), findsNothing);

      // Dynamic milestone progression bar
      expect(find.textContaining('Next Level:'), findsOneWidget);
    });

    testWidgets('Tapping Digital ID Pass opens verification modal with real user data', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final digitalIdBtn = find.text('Digital ID Pass');
      expect(digitalIdBtn, findsOneWidget);
      await tester.tap(digitalIdBtn);
      await tester.pumpAndSettle();

      expect(find.text('VHBC BROKER PASS'), findsOneWidget);
      expect(find.text('VERIFIED'), findsOneWidget);
      expect(find.text('Alex Villar'), findsWidgets);
      expect(find.text('Apex Realty Group'), findsWidgets);

      // Close modal
      final doneBtn = find.text('Done');
      expect(doneBtn, findsOneWidget);
      await tester.tap(doneBtn);
      await tester.pumpAndSettle();
      expect(find.text('VHBC BROKER PASS'), findsNothing);
    });

    testWidgets('Tapping Edit Profile opens edit modal with credentials fields', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        const MaterialApp(
          home: ProfileScreen(),
        ),
      );
      await tester.pumpAndSettle();

      final editBtn = find.text('Edit Profile');
      expect(editBtn, findsOneWidget);
      await tester.tap(editBtn);
      await tester.pumpAndSettle();

      expect(find.text('Edit Broker Credentials'), findsOneWidget);
      expect(find.text('Full Name / Display Name'), findsOneWidget);
      expect(find.text('Commission Tier'), findsOneWidget);
      expect(find.text('Accreditation Expiry'), findsWidgets);
      expect(find.text('Save Changes'), findsOneWidget);
    });
  });
}
