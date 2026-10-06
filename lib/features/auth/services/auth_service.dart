import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/deep_link_service.dart';
import '../../../core/services/supabase_service.dart';

/// Representation of an authenticated broker in the VHBC Portal
class BrokerUser {
  final String id;
  final String email;
  final String displayName;
  final String role;
  final String? licenseNumber;
  final String phone;
  final String agency;
  final String? avatarUrl;
  final String prcNumber;
  final String dhsudNumber;
  final String validUntil;
  final String commissionTier;
  final bool isDemo;
  final bool requiresPasswordChange;

  const BrokerUser({
    required this.id,
    required this.email,
    required this.displayName,
    this.role = 'Accredited Broker',
    this.licenseNumber,
    this.phone = '',
    this.agency = '',
    this.avatarUrl,
    this.prcNumber = '',
    this.dhsudNumber = '',
    this.validUntil = '',
    this.commissionTier = '',
    this.isDemo = false,
    this.requiresPasswordChange = false,
  });

  BrokerUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? role,
    String? licenseNumber,
    String? phone,
    String? agency,
    String? avatarUrl,
    String? prcNumber,
    String? dhsudNumber,
    String? validUntil,
    String? commissionTier,
    bool? isDemo,
    bool? requiresPasswordChange,
  }) {
    return BrokerUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      phone: phone ?? this.phone,
      agency: agency ?? this.agency,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      prcNumber: prcNumber ?? this.prcNumber,
      dhsudNumber: dhsudNumber ?? this.dhsudNumber,
      validUntil: validUntil ?? this.validUntil,
      commissionTier: commissionTier ?? this.commissionTier,
      isDemo: isDemo ?? this.isDemo,
      requiresPasswordChange:
          requiresPasswordChange ?? this.requiresPasswordChange,
    );
  }

  static const BrokerUser demoBroker = BrokerUser(
    id: 'demo-broker-juan',
    email: 'juan.delacruz@vhbcbroker.com',
    displayName: 'Juan Dela Cruz',
    role: 'Senior Accredited Broker (Level 3)',
    licenseNumber: 'PRC #0028491 • DHSUD NCR-B-08/21-8842',
    phone: '+63 917 888 2345',
    agency: 'VHermosa Premier Realty Group',
    avatarUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuD1a7_We32irwkDdGxkE8-blVC0bY9vbh-QhZ26ILNmDXuhO-JhlIJLicEuqhqt58lHYs2zVSvkA6Zrv8pI4YSPiipNWv57XPhr4cfpe9w4Jh9arEV6fC-mLeIyZ-9CdebTeNZh-v65iDC6Mn5tvHeO1-kzOwFksHDFYY1PwQJDP3mssQ2vmSmH32ihHr6BlenHiRXbd-3cqFWibjDSwPI3-FZh_DZC-pH-YEFen3IsDLKt38Si5Dks_A',
    prcNumber: 'PRC #0028491',
    dhsudNumber: 'DHSUD NCR-B-08/21-8842',
    validUntil: 'Dec 31, 2026',
    commissionTier: 'Tier 1 Prime Partner (5.0% + 1.5%)',
    isDemo: true,
  );
}

/// Central service managing authentication, session state, and demo credentials.
class AuthService {
  AuthService._();

  static final ValueNotifier<BrokerUser?> currentUserNotifier =
      ValueNotifier<BrokerUser?>(null);

  /// Notifier flagging an active password recovery flow via deep link
  static final ValueNotifier<bool> isPasswordResetFlowNotifier =
      ValueNotifier<bool>(false);

  static StreamSubscription<AuthState>? _authSubscription;
  static bool _initialized = false;

  /// Current authenticated broker or null if guest/logged out
  static BrokerUser? get currentUser => currentUserNotifier.value;

  /// Whether any user (real or demo) is currently logged in
  static bool get isAuthenticated => currentUserNotifier.value != null;

  /// Initialize auth state listeners
  static void initialize() {
    if (_initialized) return;
    _initialized = true;

    try {
      final currentSession = SupabaseService.client.auth.currentSession;
      if (currentSession != null) {
        _setSupabaseUser(currentSession.user);
        unawaited(fetchExtendedProfile(currentSession.user));
      }

      _authSubscription =
          SupabaseService.client.auth.onAuthStateChange.listen((data) {
        final AuthChangeEvent event = data.event;
        final Session? session = data.session;

        developer.log('Auth state changed: $event', name: 'AuthService');

        if (event == AuthChangeEvent.passwordRecovery) {
          if (session?.user != null) {
            final authUser = session!.user;
            _setSupabaseUser(authUser);
            if (currentUserNotifier.value != null) {
              currentUserNotifier.value = currentUserNotifier.value!.copyWith(
                requiresPasswordChange: true,
              );
            }
          }
          isPasswordResetFlowNotifier.value = true;
          DeepLinkService.navigateToChangePassword();
        } else if (event == AuthChangeEvent.signedIn ||
            event == AuthChangeEvent.tokenRefreshed ||
            event == AuthChangeEvent.userUpdated) {
          if (session?.user != null) {
            final authUser = session!.user;
            _setSupabaseUser(authUser);
            unawaited(fetchExtendedProfile(authUser));
          }
        } else if (event == AuthChangeEvent.signedOut) {
          // Only clear if not in manual demo session
          if (currentUserNotifier.value?.isDemo != true) {
            currentUserNotifier.value = null;
          }
          isPasswordResetFlowNotifier.value = false;
        }
      });
    } catch (e) {
      developer.log('Supabase auth listener initialization notice: $e',
          name: 'AuthService');
    }
  }

  static void _setSupabaseUser(User user, [Map<String, dynamic>? extraData]) {
    final metadata = Map<String, dynamic>.from(user.userMetadata ?? {});
    if (extraData != null) {
      metadata.addAll(extraData);
    }

    final displayName = metadata['full_name'] as String? ??
        metadata['name'] as String? ??
        metadata['display_name'] as String? ??
        metadata['fullName'] as String? ??
        (user.email != null && user.email!.contains('@')
            ? user.email!.split('@').first
            : 'Accredited Broker');

    final role = metadata['role'] as String? ??
        metadata['broker_role'] as String? ??
        metadata['title'] as String? ??
        metadata['accreditation_level'] as String? ??
        'Accredited Broker';

    final phone = metadata['phone'] as String? ??
        metadata['phone_number'] as String? ??
        metadata['mobile'] as String? ??
        metadata['contact_number'] as String? ??
        user.phone ??
        '';

    final agency = metadata['agency'] as String? ??
        metadata['brokerage'] as String? ??
        metadata['realty'] as String? ??
        metadata['company'] as String? ??
        '';

    final prcNumber = metadata['prc_number'] as String? ??
        metadata['prc_license'] as String? ??
        metadata['prc'] as String? ??
        metadata['prcNumber'] as String? ??
        '';

    final dhsudNumber = metadata['dhsud_number'] as String? ??
        metadata['dhsud_reg'] as String? ??
        metadata['dhsud'] as String? ??
        metadata['dhsudNumber'] as String? ??
        '';

    final licenseNumber = metadata['license_number'] as String? ??
        metadata['licenseNumber'] as String? ??
        (prcNumber.isNotEmpty && dhsudNumber.isNotEmpty
            ? '$prcNumber • $dhsudNumber'
            : (prcNumber.isNotEmpty
                ? prcNumber
                : (dhsudNumber.isNotEmpty ? dhsudNumber : null)));

    final avatarUrl = metadata['avatar_url'] as String? ??
        metadata['photo_url'] as String? ??
        metadata['picture'] as String? ??
        metadata['avatarUrl'] as String?;

    final validUntil = metadata['valid_until'] as String? ??
        metadata['validity'] as String? ??
        metadata['expiration'] as String? ??
        metadata['validUntil'] as String? ??
        '';

    final commissionTier = metadata['commission_tier'] as String? ??
        metadata['tier'] as String? ??
        metadata['commissionTier'] as String? ??
        '';

    // Check if user has completed initial password change
    final hasChangedPassword = metadata['has_changed_password'] == true ||
        metadata['password_changed'] == true;
    final explicitRequire = metadata['requires_password_change'] == true;
    final isFirstLogin = metadata['first_login'] == true;

    // Upon first login (where has_changed_password has not been set), or if explicitly flagged
    final bool requiresChange =
        explicitRequire || isFirstLogin || !hasChangedPassword;

    currentUserNotifier.value = BrokerUser(
      id: user.id,
      email: user.email ?? '',
      displayName: displayName,
      role: role,
      licenseNumber: licenseNumber,
      phone: phone,
      agency: agency,
      avatarUrl: avatarUrl,
      prcNumber: prcNumber,
      dhsudNumber: dhsudNumber,
      validUntil: validUntil,
      commissionTier: commissionTier,
      isDemo: false,
      requiresPasswordChange: requiresChange,
    );
  }

  /// Queries extended user profile data from Supabase DB tables if available
  static Future<void> fetchExtendedProfile(User user) async {
    try {
      final dbProfile = await SupabaseService.client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (dbProfile != null) {
        _setSupabaseUser(user, dbProfile);
        return;
      }
    } catch (_) {}

    try {
      final dbBroker = await SupabaseService.client
          .from('brokers')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (dbBroker != null) {
        _setSupabaseUser(user, dbBroker);
      }
    } catch (_) {}
  }

  /// Updates local and Supabase broker profile attributes
  static Future<void> updateProfile({
    String? displayName,
    String? phone,
    String? agency,
    String? licenseNumber,
    String? prcNumber,
    String? dhsudNumber,
    String? email,
    String? avatarUrl,
    String? role,
    String? validUntil,
    String? commissionTier,
  }) async {
    final current = currentUserNotifier.value ?? BrokerUser.demoBroker;
    currentUserNotifier.value = current.copyWith(
      displayName: displayName,
      phone: phone,
      agency: agency,
      licenseNumber: licenseNumber,
      prcNumber: prcNumber,
      dhsudNumber: dhsudNumber,
      email: email,
      avatarUrl: avatarUrl,
      role: role,
      validUntil: validUntil,
      commissionTier: commissionTier,
    );

    if (!current.isDemo) {
      final dataToSave = <String, dynamic>{};
      if (displayName != null) {
        dataToSave['full_name'] = displayName;
        dataToSave['name'] = displayName;
      }
      if (phone != null) dataToSave['phone'] = phone;
      if (agency != null) dataToSave['agency'] = agency;
      if (prcNumber != null) dataToSave['prc_number'] = prcNumber;
      if (dhsudNumber != null) dataToSave['dhsud_number'] = dhsudNumber;
      if (licenseNumber != null) dataToSave['license_number'] = licenseNumber;
      if (avatarUrl != null) dataToSave['avatar_url'] = avatarUrl;
      if (role != null) dataToSave['role'] = role;
      if (validUntil != null) dataToSave['valid_until'] = validUntil;
      if (commissionTier != null) dataToSave['commission_tier'] = commissionTier;

      try {
        await SupabaseService.client.auth.updateUser(
          UserAttributes(data: dataToSave),
        );
      } catch (e) {
        developer.log('Notice saving profile metadata to Supabase Auth: $e',
            name: 'AuthService');
      }

      try {
        await SupabaseService.client.from('profiles').upsert({
          'id': current.id,
          'email': current.email,
          ...dataToSave,
          'updated_at': DateTime.now().toIso8601String(),
        });
      } catch (_) {
        try {
          await SupabaseService.client.from('brokers').upsert({
            'id': current.id,
            'email': current.email,
            ...dataToSave,
            'updated_at': DateTime.now().toIso8601String(),
          });
        } catch (_) {}
      }
    }
  }

  /// Sign in with Supabase Email and Password
  static Future<BrokerUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await SupabaseService.client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Unable to authenticate broker account.');
      }

      _setSupabaseUser(user);
      unawaited(fetchExtendedProfile(user));
      return currentUserNotifier.value!;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Instant 1-tap demo login for testing & previewing the full broker portal
  static Future<BrokerUser> signInDemoBroker() async {
    // Artificial brief delay for realistic smooth transition
    await Future.delayed(const Duration(milliseconds: 300));
    currentUserNotifier.value = BrokerUser.demoBroker;
    return BrokerUser.demoBroker;
  }

  /// Register new broker user in Supabase
  static Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? licenseNumber,
  }) async {
    try {
      await SupabaseService.client.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          if (licenseNumber != null && licenseNumber.isNotEmpty)
            'license_number': licenseNumber.trim(),
          'role': 'Accredited Broker',
        },
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Request password reset link with deep link redirect to change password
  static Future<void> resetPassword(String email, {String? redirectTo}) async {
    try {
      await SupabaseService.client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: redirectTo ?? 'vhbc://change-password',
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Update password in Supabase Auth and mark initial password change complete
  static Future<void> updatePassword({
    required String newPassword,
  }) async {
    try {
      final current = currentUserNotifier.value;
      if (current?.isDemo == true) {
        // For demo session, simulate instant password update
        currentUserNotifier.value = current!.copyWith(requiresPasswordChange: false);
        isPasswordResetFlowNotifier.value = false;
        return;
      }

      final response = await SupabaseService.client.auth.updateUser(
        UserAttributes(
          password: newPassword,
          data: {
            'has_changed_password': true,
            'requires_password_change': false,
            'first_login': false,
            'password_changed_at': DateTime.now().toIso8601String(),
          },
        ),
      );

      isPasswordResetFlowNotifier.value = false;

      final updatedUser = response.user;
      if (updatedUser != null) {
        _setSupabaseUser(updatedUser);
      } else if (currentUserNotifier.value != null) {
        currentUserNotifier.value = currentUserNotifier.value!.copyWith(
          requiresPasswordChange: false,
        );
      }
    } on AuthException {
      rethrow;
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  /// Sign out current broker session
  static Future<void> signOut() async {
    try {
      if (currentUserNotifier.value?.isDemo != true) {
        await SupabaseService.client.auth.signOut();
      }
    } catch (e) {
      developer.log('SignOut notice: $e', name: 'AuthService');
    } finally {
      currentUserNotifier.value = null;
    }
  }

  @visibleForTesting
  static void setMockUser(BrokerUser? user) {
    currentUserNotifier.value = user;
  }

  static void dispose() {
    _authSubscription?.cancel();
    _authSubscription = null;
    _initialized = false;
  }
}
