import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vhbc_broker_app/core/theme/app_theme.dart';
import 'package:vhbc_broker_app/features/auth/presentation/auth_gate.dart';
import 'package:vhbc_broker_app/features/auth/presentation/change_password_screen.dart';
import 'package:vhbc_broker_app/features/auth/presentation/login_screen.dart';
import 'package:vhbc_broker_app/features/auth/services/auth_service.dart';
import 'package:vhbc_broker_app/features/main_shell/main_shell_screen.dart';

void main() {
  setUp(() {
    AuthService.setMockUser(null);
  });

  tearDown(() {
    AuthService.setMockUser(null);
  });

  testWidgets('LoginScreen renders header, form inputs, and action buttons',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    // Verify Brand Header
    expect(find.text('Sales Partner Portal'), findsOneWidget);
    expect(find.text('BRIGHT HERMOSA REALTY INC.'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    expect(
        find.text('Accredited Agent Access • Live Lot Maps • Direct Holds'),
        findsOneWidget);

    // Verify Form Header
    expect(find.text('Sign In to Your Workspace'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Remember me'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);

    // Verify Action Buttons
    expect(find.text('Sign In as Accredited Broker'), findsOneWidget);
    expect(find.text('Apply Here'), findsOneWidget);
  });

  testWidgets('LoginScreen validates empty email and short password',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    // Tap submit button without filling fields
    await tester.tap(find.text('Sign In as Accredited Broker'));
    await tester.pumpAndSettle();

    // Verify error messages appear
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('LoginScreen password visibility toggle works',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    // Find password field
    final passwordFieldFinder = find.byWidgetPredicate((widget) {
      if (widget is EditableText) {
        return widget.obscureText == true;
      }
      return false;
    });
    expect(passwordFieldFinder, findsOneWidget);

    // Tap visibility toggle icon
    final toggleIcon = find.byIcon(Icons.visibility_outlined);
    expect(toggleIcon, findsOneWidget);
    await tester.tap(toggleIcon);
    await tester.pumpAndSettle();

    // Check that toggle changed icon to visibility_off
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('LoginScreen does not display instant demo access or hardcoded credentials',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Instant Demo Access'), findsNothing);
    expect(find.text('OR FAST EVALUATION'), findsNothing);
    expect(find.textContaining('Juan Dela Cruz'), findsNothing);
  });

  testWidgets('Forgot password opens dialog with email input',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();

    expect(find.text('Reset Password'), findsOneWidget);
    expect(find.text('Send Reset Link'), findsOneWidget);
  });

  testWidgets('Broker Accreditation contact sheet opens when Apply Here is tapped',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Apply Here'));
    await tester.pumpAndSettle();

    expect(find.text('Broker Accreditation Desk'), findsOneWidget);
    expect(find.text('0917 189 7112'), findsOneWidget);
    expect(find.text('Call 0917 189 7112 Now'), findsOneWidget);
  });

  testWidgets('AuthGate routes between LoginScreen and MainShellScreen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Initial state: logged out
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
    await tester.pump();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(MainShellScreen), findsNothing);

    // Set authenticated user
    AuthService.setMockUser(BrokerUser.demoBroker);
    await tester.pumpAndSettle();

    expect(find.byType(MainShellScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('AuthGate routes to ChangePasswordScreen upon first login',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Initial state: first-time authenticated broker requiring password change
    AuthService.setMockUser(
      BrokerUser.demoBroker.copyWith(requiresPasswordChange: true),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ChangePasswordScreen), findsOneWidget);
    expect(find.byType(MainShellScreen), findsNothing);
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.text('FIRST-TIME LOGIN REQUIRED'), findsOneWidget);
    expect(find.text('Set Your Permanent Password'), findsOneWidget);
  });

  testWidgets('ChangePasswordScreen validates password inputs and updates password',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    AuthService.setMockUser(
      BrokerUser.demoBroker.copyWith(requiresPasswordChange: true),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const AuthGate(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap submit with empty fields
    await tester.tap(find.text('Set Password & Enter Portal'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your new password'), findsOneWidget);

    // Enter short password
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Minimum 6 characters'),
      '123',
    );
    await tester.tap(find.text('Set Password & Enter Portal'));
    await tester.pumpAndSettle();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);

    // Enter mismatched confirm password
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Minimum 6 characters'),
      'SecurePass2026',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Re-enter your new password'),
      'DifferentPass2026',
    );
    await tester.tap(find.text('Set Password & Enter Portal'));
    await tester.pumpAndSettle();

    expect(find.text('Passwords do not match'), findsOneWidget);

    // Enter matching valid password and submit
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Re-enter your new password'),
      'SecurePass2026',
    );
    await tester.tap(find.text('Set Password & Enter Portal'));
    await tester.pumpAndSettle();

    // After successful update, user transitions to MainShellScreen
    expect(find.byType(MainShellScreen), findsOneWidget);
    expect(find.byType(ChangePasswordScreen), findsNothing);
    expect(AuthService.currentUser?.requiresPasswordChange, isFalse);
  });
}
