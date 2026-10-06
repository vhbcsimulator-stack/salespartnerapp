import 'dart:async';
import 'dart:developer' as developer;
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/change_password_screen.dart';
import '../../features/auth/services/auth_service.dart';
import 'supabase_service.dart';

/// Central service for capturing and handling incoming deep links
/// (custom schemes like vhbc://, io.supabase.vhbc://, and com.vhbc.broker://)
/// specifically tailored for password recovery / reset password redirection.
class DeepLinkService {
  DeepLinkService._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription<Uri>? _linkSubscription;
  static bool _initialized = false;

  /// Valid schemes recognized by the app
  static const List<String> supportedSchemes = [
    'vhbc',
    'io.supabase.vhbc',
    'com.vhbc.broker',
  ];

  /// Initialize deep link listening across cold start and foreground/background
  static Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    // 1. Handle initial URI on cold launch
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        developer.log('App launched with initial deep link: $initialUri', name: 'DeepLinkService');
        await handleUri(initialUri);
      }
    } catch (e) {
      developer.log('Error getting initial deep link: $e', name: 'DeepLinkService');
    }

    // 2. Listen to subsequent incoming deep links while app is running
    try {
      _linkSubscription = _appLinks.uriLinkStream.listen(
        (uri) async {
          developer.log('Incoming deep link received: $uri', name: 'DeepLinkService');
          await handleUri(uri);
        },
        onError: (err) {
          developer.log('Deep link stream error: $err', name: 'DeepLinkService');
        },
      );
    } catch (e) {
      developer.log('Error subscribing to deep links: $e', name: 'DeepLinkService');
    }
  }

  /// Determines whether a given URI is a password reset / change password deeplink
  static bool isPasswordResetUri(Uri uri) {
    final scheme = uri.scheme.toLowerCase();
    final host = uri.host.toLowerCase();
    final path = uri.path.toLowerCase();
    final fragment = uri.fragment.toLowerCase();

    // Check custom schemes
    final matchesScheme = supportedSchemes.contains(scheme);

    // Check host/path targets
    final matchesHostOrPath = host == 'change-password' ||
        host == 'reset-password' ||
        host == 'password-reset' ||
        path.contains('change-password') ||
        path.contains('reset-password') ||
        path.contains('callback') ||
        host == 'auth-callback';

    // Check recovery flags
    final hasRecoveryFragment = fragment.contains('type=recovery') ||
        uri.queryParameters['type'] == 'recovery' ||
        fragment.contains('access_token');

    return (matchesScheme && (matchesHostOrPath || hasRecoveryFragment)) ||
        (hasRecoveryFragment && matchesHostOrPath);
  }

  /// Processes incoming URI, recovers Supabase auth session, and redirects to ChangePasswordScreen
  static Future<void> handleUri(Uri uri) async {
    if (!isPasswordResetUri(uri)) {
      developer.log('Ignoring non-password-reset URI: $uri', name: 'DeepLinkService');
      return;
    }

    developer.log('Processing password reset deep link: $uri', name: 'DeepLinkService');

    try {
      // 1. Exchange or set Supabase recovery session if tokens are in fragment or code is in query
      if (uri.fragment.isNotEmpty) {
        // e.g. #access_token=...&refresh_token=...&type=recovery
        await SupabaseService.client.auth.getSessionFromUrl(uri);
      } else if (uri.queryParameters.containsKey('code')) {
        // PKCE flow code exchange
        await SupabaseService.client.auth.exchangeCodeForSession(uri.queryParameters['code']!);
      }
    } catch (e) {
      developer.log('Notice recovering session from deep link URL: $e', name: 'DeepLinkService');
    }

    // 2. Mark password reset flow as active
    AuthService.isPasswordResetFlowNotifier.value = true;

    // 3. Immediately route to ChangePasswordScreen
    navigateToChangePassword();
  }

  /// Programmatically pushes ChangePasswordScreen onto the navigation stack
  static void navigateToChangePassword() {
    final nav = navigatorKey.currentState;
    if (nav == null) {
      developer.log('Navigator state not ready yet; AuthGate will handle initial route', name: 'DeepLinkService');
      return;
    }

    nav.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const ChangePasswordScreen(
          isFirstLogin: false,
          isPasswordReset: true,
        ),
      ),
      (route) => false,
    );
  }

  static void dispose() {
    _linkSubscription?.cancel();
    _linkSubscription = null;
    _initialized = false;
  }
}
