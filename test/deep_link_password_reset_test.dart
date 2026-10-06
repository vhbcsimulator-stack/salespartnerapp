import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/services/deep_link_service.dart';
import 'package:vhbc_broker_app/core/theme/app_theme.dart';
import 'package:vhbc_broker_app/features/auth/presentation/auth_gate.dart';
import 'package:vhbc_broker_app/features/auth/presentation/change_password_screen.dart';
import 'package:vhbc_broker_app/features/auth/presentation/login_screen.dart';
import 'package:vhbc_broker_app/features/auth/services/auth_service.dart';

void main() {
  group('DeepLinkService URI recognition', () {
    test('identifies valid custom scheme password reset and change-password URIs', () {
      final uri1 = Uri.parse('vhbc://change-password');
      expect(DeepLinkService.isPasswordResetUri(uri1), isTrue);

      final uri2 = Uri.parse('vhbc://reset-password#access_token=test&refresh_token=test&type=recovery');
      expect(DeepLinkService.isPasswordResetUri(uri2), isTrue);

      final uri3 = Uri.parse('io.supabase.vhbc://change-password');
      expect(DeepLinkService.isPasswordResetUri(uri3), isTrue);

      final uri4 = Uri.parse('com.vhbc.broker://change-password');
      expect(DeepLinkService.isPasswordResetUri(uri4), isTrue);

      final uri5 = Uri.parse('vhbc://auth-callback#type=recovery&access_token=abc');
      expect(DeepLinkService.isPasswordResetUri(uri5), isTrue);
    });

    test('rejects unrelated URIs', () {
      final uri1 = Uri.parse('vhbc://inventory');
      expect(DeepLinkService.isPasswordResetUri(uri1), isFalse);

      final uri2 = Uri.parse('https://example.com/home');
      expect(DeepLinkService.isPasswordResetUri(uri2), isFalse);

      final uri3 = Uri.parse('randomscheme://change-password');
      expect(DeepLinkService.isPasswordResetUri(uri3), isFalse);
    });
  });

  group('Password Reset Deeplink Navigation & AuthGate routing', () {
    setUp(() {
      AuthService.setMockUser(null);
      AuthService.isPasswordResetFlowNotifier.value = false;
    });

    testWidgets('AuthGate routes to LoginScreen when unauthenticated and no reset flow', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const AuthGate(),
        ),
      );
      await tester.pump();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(ChangePasswordScreen), findsNothing);
    });

    testWidgets('AuthGate immediately routes to ChangePasswordScreen in recovery mode when reset flow is active', (tester) async {
      AuthService.isPasswordResetFlowNotifier.value = true;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const AuthGate(),
        ),
      );
      await tester.pump();

      expect(find.byType(ChangePasswordScreen), findsOneWidget);
      expect(find.text('PASSWORD RECOVERY MODE'), findsOneWidget);
      expect(find.text('Reset Your Password'), findsOneWidget);
    });
  });
}
