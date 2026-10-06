import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/contact_service.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../auth/presentation/change_password_screen.dart';
import '../../auth/services/auth_service.dart';
import '../../clients/models/client_model.dart';
import '../../sales_kit/presentation/sales_kit_videos_screen.dart';
import '../../chat/presentation/widgets/chat_sheet.dart';

/// State-of-the-art Broker Profile screen with accreditation management,
/// digital business card, sales performance telemetry, and customizable broker preferences.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Real Supabase Telemetry State
  List<ClientModel> _brokerClients = [];
  bool _isLoadingTelemetry = false;

  @override
  void initState() {
    super.initState();
    _loadTelemetry();
  }

  Future<void> _loadTelemetry({bool forceRefresh = false}) async {
    final user = AuthService.currentUser ?? BrokerUser.demoBroker;
    if (mounted) setState(() => _isLoadingTelemetry = true);
    try {
      final clients = await SupabaseService.fetchClients(
        brokerName: user.displayName,
        forceRefresh: forceRefresh,
      );
      if (mounted) {
        setState(() {
          _brokerClients = clients;
          _isLoadingTelemetry = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoadingTelemetry = false);
      }
    }
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.errorContainer,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.logout_rounded,
                color: AppColors.error,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Sign Out?',
              style: AppTextStyles.titleMd.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to sign out of the BHRI Sales Partner App? You will need your credentials to log back in.',
          style: AppTextStyles.bodySm.copyWith(
            color: AppColors.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(
              'Cancel',
              style: AppTextStyles.labelLg.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(dialogCtx).pop();
              await AuthService.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileSheet(BuildContext context, BrokerUser user) {
    final nameController = TextEditingController(text: user.displayName);
    final phoneController = TextEditingController(text: user.phone);
    final agencyController = TextEditingController(text: user.agency);
    final prcController = TextEditingController(text: user.prcNumber);
    final dhsudController = TextEditingController(text: user.dhsudNumber);
    final tierController = TextEditingController(
      text: user.commissionTier.isNotEmpty
          ? user.commissionTier
          : 'Tier 1 Executive',
    );
    final validUntilController = TextEditingController(
      text: user.validUntil.isNotEmpty ? user.validUntil : 'Dec 2026',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 24,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Edit Broker Credentials',
                      style: AppTextStyles.titleMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.of(sheetCtx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildEditField(
                  'Full Name / Display Name',
                  nameController,
                  Icons.person_outline,
                ),
                const SizedBox(height: 12),
                _buildEditField(
                  'Mobile Number',
                  phoneController,
                  Icons.phone_outlined,
                ),
                const SizedBox(height: 12),
                _buildEditField(
                  'Realty / Brokerage Agency',
                  agencyController,
                  Icons.business_outlined,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildEditField(
                        'PRC License',
                        prcController,
                        Icons.badge_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEditField(
                        'DHSUD Reg.',
                        dhsudController,
                        Icons.verified_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildEditField(
                        'Commission Tier',
                        tierController,
                        Icons.military_tech_outlined,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildEditField(
                        'Accreditation Expiry',
                        validUntilController,
                        Icons.event_available_outlined,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      await AuthService.updateProfile(
                        displayName: nameController.text.trim(),
                        phone: phoneController.text.trim(),
                        agency: agencyController.text.trim(),
                        prcNumber: prcController.text.trim(),
                        dhsudNumber: dhsudController.text.trim(),
                        licenseNumber:
                            '${prcController.text.trim()} • ${dhsudController.text.trim()}',
                        commissionTier: tierController.text.trim(),
                        validUntil: validUntilController.text.trim(),
                      );
                      if (!sheetCtx.mounted) return;
                      Navigator.of(sheetCtx).pop();
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Broker profile updated and saved to Supabase!',
                          ),
                          duration: Duration(milliseconds: 1500),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      await _loadTelemetry(forceRefresh: true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Save Changes',
                      style: AppTextStyles.labelLg.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEditField(
    String label,
    TextEditingController controller,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18, color: AppColors.outline),
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryContainer,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDigitalCard(BuildContext context, BrokerUser user) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF00271B), Color(0xFF0F3E2E), Color(0xFF071C14)],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColors.secondaryContainer.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.apartment_rounded,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VHBC BROKER PASS',
                            style: AppTextStyles.labelSm.copyWith(
                              color: AppColors.secondaryContainer,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Official Digital Credential',
                            style: AppTextStyles.labelSm.copyWith(
                              color: Colors.white70,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer.withValues(
                        alpha: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColors.secondaryContainer.withValues(
                          alpha: 0.6,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'VERIFIED',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.secondaryContainer,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondaryContainer,
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: user.avatarUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: AppColors.primaryContainer),
                          errorWidget: (context, url, error) =>
                              _buildInitialsAvatar(user, size: 76),
                        )
                      : _buildInitialsAvatar(user, size: 76),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                user.displayName,
                style: AppTextStyles.titleMd.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user.agency.isNotEmpty ? user.agency : 'Independent Broker',
                style: AppTextStyles.bodySm.copyWith(
                  color: AppColors.secondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _buildDigitalCardRow(
                      'PRC License',
                      user.prcNumber.isNotEmpty
                          ? user.prcNumber
                          : 'Not Specified',
                    ),
                    const Divider(height: 14, color: Colors.white12),
                    _buildDigitalCardRow(
                      'DHSUD Reg.',
                      user.dhsudNumber.isNotEmpty
                          ? user.dhsudNumber
                          : 'Not Specified',
                    ),
                    const Divider(height: 14, color: Colors.white12),
                    _buildDigitalCardRow(
                      'Accreditation Tier',
                      user.commissionTier.isNotEmpty
                          ? user.commissionTier
                          : user.role,
                    ),
                    const Divider(height: 14, color: Colors.white12),
                    _buildDigitalCardRow(
                      'Valid Until',
                      user.validUntil.isNotEmpty
                          ? user.validUntil
                          : 'Active Accreditation',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text:
                                'VHBC Accredited Broker: ${user.displayName}\n${user.prcNumber} • ${user.dhsudNumber}\n${user.agency}',
                          ),
                        );
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Credentials copied to clipboard!'),
                            duration: Duration(milliseconds: 1400),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.copy_rounded,
                        size: 16,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Copy Info',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.check, size: 16),
                      label: const Text('Done'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryContainer,
                        foregroundColor: AppColors.onSecondaryFixed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(BrokerUser user, {double size = 48}) {
    final initials = user.displayName.trim().isNotEmpty
        ? user.displayName
              .trim()
              .split(RegExp(r'\s+'))
              .map((s) => s.isNotEmpty ? s[0].toUpperCase() : '')
              .take(2)
              .join()
        : 'B';

    return Container(
      width: size,
      height: size,
      color: AppColors.primaryContainer,
      alignment: Alignment.center,
      child: Text(
        initials.isNotEmpty ? initials : 'B',
        style: TextStyle(
          color: AppColors.secondaryContainer,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.4,
        ),
      ),
    );
  }

  Widget _buildDigitalCardRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSm.copyWith(color: Colors.white60),
        ),
        Text(
          value,
          style: AppTextStyles.labelSm.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BrokerUser?>(
      valueListenable: AuthService.currentUserNotifier,
      builder: (context, rawUser, _) {
        final user = rawUser ?? BrokerUser.demoBroker;

        return Scaffold(
          backgroundColor: AppColors.surface,
          body: RefreshIndicator(
            color: AppColors.primaryContainer,
            onRefresh: () => _loadTelemetry(forceRefresh: true),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                // Premium Emerald & Gold Hero AppBar
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColors.primaryContainer,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Gradient Background
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary,
                                AppColors.primaryContainer,
                                Color(0xFF144D3A),
                              ],
                            ),
                          ),
                        ),
                        // Subtle decorative gold glow
                        Positioned(
                          right: -30,
                          top: -20,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryContainer.withValues(
                                alpha: 0.12,
                              ),
                            ),
                          ),
                        ),
                        // Hero Content
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Avatar with verified badge
                                    Stack(
                                      children: [
                                        Container(
                                          width: 72,
                                          height: 72,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  AppColors.secondaryContainer,
                                              width: 2.5,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(
                                                  alpha: 0.25,
                                                ),
                                                blurRadius: 10,
                                              ),
                                            ],
                                          ),
                                          child: ClipOval(
                                            child:
                                                (user.avatarUrl != null &&
                                                    user.avatarUrl!.isNotEmpty)
                                                ? CachedNetworkImage(
                                                    imageUrl: user.avatarUrl!,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => Container(
                                                          color: AppColors
                                                              .secondaryContainer,
                                                          child: const Icon(
                                                            Icons.person,
                                                            color: AppColors
                                                                .onSecondaryContainer,
                                                          ),
                                                        ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            _buildInitialsAvatar(
                                                              user,
                                                              size: 54,
                                                            ),
                                                  )
                                                : _buildInitialsAvatar(
                                                    user,
                                                    size: 54,
                                                  ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.secondaryContainer,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color:
                                                    AppColors.primaryContainer,
                                                width: 1.5,
                                              ),
                                            ),
                                            child: const Icon(
                                              Icons.verified,
                                              size: 14,
                                              color: AppColors.onSecondaryFixed,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16),
                                    // Name and Accreditation
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  user.displayName,
                                                  style: AppTextStyles.titleMd
                                                      .copyWith(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 18,
                                                      ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .secondaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (user
                                                              .commissionTier
                                                              .isNotEmpty
                                                          ? user.commissionTier
                                                          : (user
                                                                    .role
                                                                    .isNotEmpty
                                                                ? user.role
                                                                : 'Accredited'))
                                                      .toUpperCase(),
                                                  style: AppTextStyles.labelSm
                                                      .copyWith(
                                                        color: AppColors
                                                            .onSecondaryFixed,
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 3),
                                          Text(
                                            user.agency.isNotEmpty
                                                ? user.agency
                                                : 'Independent Broker',
                                            style: AppTextStyles.bodySm
                                                .copyWith(
                                                  color: AppColors
                                                      .secondaryContainer,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            user.email,
                                            style: AppTextStyles.bodySm
                                                .copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 11,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                // Fast Action Buttons in Header
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () =>
                                            _showDigitalCard(context, user),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.12,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: Colors.white.withValues(
                                                alpha: 0.2,
                                              ),
                                              width: 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.qr_code_rounded,
                                                size: 16,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Digital ID Pass',
                                                style: AppTextStyles.labelSm
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () => _showEditProfileSheet(
                                          context,
                                          user,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryContainer,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.edit_note_rounded,
                                                size: 18,
                                                color:
                                                    AppColors.onSecondaryFixed,
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                'Edit Profile',
                                                style: AppTextStyles.labelSm
                                                    .copyWith(
                                                      color: AppColors
                                                          .onSecondaryFixed,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      tooltip: 'Digital Pass',
                      icon: const Icon(
                        Icons.badge_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => _showDigitalCard(context, user),
                    ),
                    IconButton(
                      tooltip: 'Sign Out',
                      icon: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white70,
                      ),
                      onPressed: () => _confirmSignOut(context),
                    ),
                  ],
                ),

                // Profile Content Body
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 20,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      // Sales & Commission Performance Overview
                      _buildPerformanceSection(),
                      const SizedBox(height: 20),

                      // Government Accreditation & Licensing Card
                      _buildAccreditationCard(user),
                      const SizedBox(height: 20),

                      // Broker Tools & Sales Resources
                      _buildBrokerToolsSection(context, user),
                      const SizedBox(height: 24),

                      // Sign Out Button
                      SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: () => _confirmSignOut(context),
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: AppColors.error,
                            size: 18,
                          ),
                          label: Text(
                            'Sign Out of Broker Portal',
                            style: AppTextStyles.labelLg.copyWith(
                              color: AppColors.error,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.error,
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'BHRI Sales Partner App',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.outline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Version 1.2.0',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.outlineVariant,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Broker Production & Pipeline Telemetry using dynamic Supabase broker data
  Widget _buildPerformanceSection() {
    final closedClients = _brokerClients
        .where((c) => c.stage == ClientStage.closed)
        .toList();
    final reservedClients = _brokerClients
        .where((c) => c.stage == ClientStage.reserved)
        .toList();
    final hotClients = _brokerClients
        .where((c) => c.stage == ClientStage.hot)
        .toList();
    final warmClients = _brokerClients
        .where((c) => c.stage == ClientStage.warm)
        .toList();

    final closedCount = closedClients.length;
    final reservedCount = reservedClients.length;
    final activeCount = hotClients.length + warmClients.length;

    // Dynamic Tier Milestones:
    // Tier 1: 0 - 3 units (Silver Associate)
    // Tier 2: 4 - 9 units (Gold Premier)
    // Tier 3: 10+ units (President's Elite Club)
    final String nextTierName;
    final double progressRatio;
    final String progressPercentText;
    final String milestoneRequirementText;

    if (closedCount < 3) {
      nextTierName = 'Next Level: Silver Associate';
      progressRatio = (closedCount / 3).clamp(0.0, 1.0);
      progressPercentText = '${(progressRatio * 100).toInt()}% Achieved';
      final rem = 3 - closedCount;
      milestoneRequirementText =
          'Close $rem more unit${rem == 1 ? '' : 's'} to unlock Silver Associate recognition & higher tiers.';
    } else if (closedCount < 10) {
      nextTierName = 'Next Level: Gold Premier Club';
      progressRatio = ((closedCount - 3) / 7).clamp(0.0, 1.0);
      progressPercentText = '${(progressRatio * 100).toInt()}% Achieved';
      final rem = 10 - closedCount;
      milestoneRequirementText =
          'Close $rem more unit${rem == 1 ? '' : 's'} to unlock Gold Premier override bonuses.';
    } else {
      nextTierName = "Top Tier: President's Elite Club";
      progressRatio = 1.0;
      progressPercentText = '100% Achieved';
      milestoneRequirementText =
          'President\'s Elite unlocked! Highest override bonuses and developer incentives active.';
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up_rounded,
                      color: AppColors.primaryContainer,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Broker Production Summary',
                        style: AppTextStyles.labelLg.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryContainer,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (_isLoadingTelemetry) ...[
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 13,
                        height: 13,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'LIVE TELEMETRY',
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.primaryContainer,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 3 Dynamic Unit & Pipeline Metric Cards (no commissions or sales volume)
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  title: 'Units Closed',
                  value: '$closedCount Lot${closedCount == 1 ? '' : 's'}',
                  subtitle: closedCount > 0
                      ? 'Closed transactions'
                      : 'No closed deals',
                  color: AppColors.primaryContainer,
                  bgColor: AppColors.primaryFixed.withValues(alpha: 0.25),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  title: 'Reserved Units',
                  value: '$reservedCount Lot${reservedCount == 1 ? '' : 's'}',
                  subtitle: reservedCount > 0
                      ? 'Awaiting settlement'
                      : '0 on hold',
                  color: AppColors.secondary,
                  bgColor: AppColors.secondaryContainer.withValues(alpha: 0.25),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  title: 'Active Pipeline',
                  value: '$activeCount Client${activeCount == 1 ? '' : 's'}',
                  subtitle:
                      '${hotClients.length} hot • ${warmClients.length} warm',
                  color: const Color(0xFF1E6F5C),
                  bgColor: const Color(0xFFE8F6F1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Active Pipeline Breakdown Chips
          Row(
            children: [
              _buildPipelinePill(
                '🔥 ${hotClients.length} Hot',
                const Color(0xFFC05621),
                const Color(0xFFFEEBC8),
              ),
              const SizedBox(width: 6),
              _buildPipelinePill(
                '⏳ ${reservedClients.length} Reserved',
                AppColors.primaryContainer,
                AppColors.primaryFixed.withValues(alpha: 0.35),
              ),
              const SizedBox(width: 6),
              _buildPipelinePill(
                '🤝 ${closedClients.length} Closed',
                const Color(0xFF1E6F5C),
                const Color(0xFFE8F6F1),
              ),
              const SizedBox(width: 6),
              _buildPipelinePill(
                '🌤️ ${warmClients.length} Warm',
                AppColors.onSurfaceVariant,
                AppColors.surfaceContainerLow,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Tier Progression Bar
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        nextTierName,
                        style: AppTextStyles.labelSm.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      progressPercentText,
                      style: AppTextStyles.labelSm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressRatio,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceContainerHighest,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.secondary,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  milestoneRequirementText,
                  style: AppTextStyles.bodySm.copyWith(
                    fontSize: 10,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelinePill(String text, Color textColor, Color bgColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: AppTextStyles.labelSm.copyWith(
            color: textColor,
            fontSize: 9.5,
            fontWeight: FontWeight.w700,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppTextStyles.titleMd.copyWith(
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.labelSm.copyWith(
              color: color.withValues(alpha: 0.8),
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Government Licensing & Accreditation
  Widget _buildAccreditationCard(BrokerUser user) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.verified_user_rounded,
                    color: AppColors.primaryContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Licensing & Accreditation',
                    style: AppTextStyles.labelLg.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryContainer,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: AppColors.outline,
                ),
                tooltip: 'Copy Licensing Info',
                onPressed: () {
                  final details = [
                    user.displayName,
                    if (user.prcNumber.isNotEmpty) 'PRC: ${user.prcNumber}',
                    if (user.dhsudNumber.isNotEmpty)
                      'DHSUD: ${user.dhsudNumber}',
                    if (user.agency.isNotEmpty) user.agency,
                  ].join(' • ');

                  Clipboard.setData(ClipboardData(text: details));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Accreditation info copied!'),
                      duration: Duration(milliseconds: 1200),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
          const Divider(height: 16, color: AppColors.outlineVariant),
          _buildInfoRow(
            'Accreditation Status',
            'Active & Fully Verified',
            isHighlight: true,
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'PRC Real Estate License',
            user.prcNumber.isNotEmpty ? user.prcNumber : 'Not Specified',
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'DHSUD Registration',
            user.dhsudNumber.isNotEmpty ? user.dhsudNumber : 'Not Specified',
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'Realty / Brokerage',
            user.agency.isNotEmpty ? user.agency : 'Independent Broker',
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'Commission Bracket',
            user.commissionTier.isNotEmpty
                ? user.commissionTier
                : 'Standard Bracket',
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
            'Accreditation Expiry',
            user.validUntil.isNotEmpty ? user.validUntil : 'Ongoing',
          ),
        ],
      ),
    );
  }

  /// Broker Tools & Marketing Resources
  Widget _buildBrokerToolsSection(BuildContext context, BrokerUser user) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
            child: Row(
              children: [
                const Icon(
                  Icons.business_center_rounded,
                  color: AppColors.primaryContainer,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Broker Desk Tools',
                  style: AppTextStyles.labelLg.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.qr_code_rounded,
                color: AppColors.secondary,
                size: 20,
              ),
            ),
            title: Text(
              'Digital Business Card',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Instant client verification pass',
              style: AppTextStyles.bodySm.copyWith(fontSize: 11),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.outline,
            ),
            onTap: () => _showDigitalCard(context, user),
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryFixed.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: AppColors.primaryContainer,
                size: 20,
              ),
            ),
            title: Text(
              'Sales Kits & Masterplans',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Video walkthroughs, presentations, and assets',
              style: AppTextStyles.bodySm.copyWith(fontSize: 11),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.outline,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SalesKitVideosScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F6F1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.headset_mic_rounded,
                color: Color(0xFF1E6F5C),
                size: 20,
              ),
            ),
            title: Text(
              'Developer Liaison Desk',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Direct hotline: Mon-Sat 8AM - 6PM',
              style: AppTextStyles.bodySm.copyWith(fontSize: 11),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F6F1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ONLINE',
                style: AppTextStyles.labelSm.copyWith(
                  color: const Color(0xFF1E6F5C),
                  fontWeight: FontWeight.w800,
                  fontSize: 8,
                ),
              ),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('VHBC Broker Support'),
                  content: const Text(
                    'For questions regarding project developments (MVLC, ERHD, MSCC), lot calculations, and broker sales guidelines, consult the Hermosa AI assistant or coordinate with your authorized broker liaison.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        ContactService.callSalesDesk(context: context);
                      },
                      child: const Text(
                        'Call Support Desk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        HermosaChatSheet.show(context);
                      },
                      child: const Text(
                        'Chat with Hermosa AI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          const Divider(height: 1, color: AppColors.outlineVariant),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.lock_reset_rounded,
                color: AppColors.primaryContainer,
                size: 20,
              ),
            ),
            title: Text(
              'Change Account Password',
              style: AppTextStyles.bodyMd.copyWith(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              'Update your permanent broker portal password',
              style: AppTextStyles.bodySm.copyWith(fontSize: 11),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.outline,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      const ChangePasswordScreen(isFirstLogin: false),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySm.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodySm.copyWith(
              fontWeight: FontWeight.w600,
              color: isHighlight
                  ? AppColors.primaryContainer
                  : AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
