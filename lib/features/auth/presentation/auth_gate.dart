import 'package:flutter/material.dart';
import '../../main_shell/main_shell_screen.dart';
import '../services/auth_service.dart';
import 'change_password_screen.dart';
import 'login_screen.dart';

/// Gatekeeper widget that dynamically routes to LoginScreen, ChangePasswordScreen,
/// or MainShellScreen based on active session and password change requirements.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: AuthService.isPasswordResetFlowNotifier,
      builder: (context, isPasswordReset, _) {
        if (isPasswordReset) {
          return const ChangePasswordScreen(
            isFirstLogin: false,
            isPasswordReset: true,
          );
        }

        return ValueListenableBuilder<BrokerUser?>(
          valueListenable: AuthService.currentUserNotifier,
          builder: (context, user, _) {
            if (user == null) {
              return const LoginScreen();
            }
            if (user.requiresPasswordChange) {
              return const ChangePasswordScreen(isFirstLogin: true);
            }
            return const MainShellScreen();
          },
        );
      },
    );
  }
}

