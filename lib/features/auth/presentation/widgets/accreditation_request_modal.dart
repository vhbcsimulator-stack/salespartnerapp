import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Modal bottom sheet allowing prospective brokers to apply for VHBC Accreditation.
class AccreditationRequestModal extends StatefulWidget {
  const AccreditationRequestModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AccreditationRequestModal(),
    );
  }

  @override
  State<AccreditationRequestModal> createState() =>
      _AccreditationRequestModalState();
}

class _AccreditationRequestModalState extends State<AccreditationRequestModal> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _realtyController = TextEditingController();
  final _prcController = TextEditingController();
  final _dhsudController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isSubmitted = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _realtyController.dispose();
    _prcController.dispose();
    _dhsudController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    // Simulate submission processing
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;
    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.fromLTRB(24, 16, 24, 24 + bottomInset),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              if (_isSubmitted) _buildSuccessState(context) else _buildForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryFixed.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.primaryContainer,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Apply for Accreditation',
                      style: AppTextStyles.titleMd.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.primaryContainer,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'VHermosa Bright Corp. Partner Network',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Join our elite network of property brokers and gain direct access to live lot maps, real-time inventory holds, and instant amortization schedules.',
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),

          // Full Name
          _buildTextField(
            controller: _nameController,
            label: 'Full Name',
            hint: 'e.g. Maria Santos',
            icon: Icons.person_outline,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter your full name' : null,
          ),
          const SizedBox(height: 14),

          // Realty / Brokerage
          _buildTextField(
            controller: _realtyController,
            label: 'Realty Firm / Brokerage',
            hint: 'e.g. Prime Horizons Realty',
            icon: Icons.business_outlined,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter your brokerage' : null,
          ),
          const SizedBox(height: 14),

          // License row
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _prcController,
                  label: 'PRC License #',
                  hint: 'e.g. 0012345',
                  icon: Icons.badge_outlined,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'PRC is required'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  controller: _dhsudController,
                  label: 'DHSUD Reg #',
                  hint: 'e.g. NCR-B-12/23',
                  icon: Icons.card_membership_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Email & Mobile
          _buildTextField(
            controller: _emailController,
            label: 'Corporate / Broker Email',
            hint: 'broker@realty.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Enter email address';
              if (!v.contains('@') || !v.contains('.')) return 'Invalid email';
              return null;
            },
          ),
          const SizedBox(height: 14),

          _buildTextField(
            controller: _phoneController,
            label: 'Mobile Contact',
            hint: '+63 917 123 4567',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter mobile number' : null,
          ),
          const SizedBox(height: 24),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _isSubmitting ? null : _handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryContainer,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Submit Accreditation Request',
                      style: AppTextStyles.labelLg.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primaryFixedDim.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              size: 44,
              color: AppColors.primaryContainer,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Application Submitted!',
            style: AppTextStyles.headlineSm.copyWith(
              color: AppColors.primaryContainer,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Thank you for applying to the VHermosa Bright Corp. Broker Network. Our Broker Relations team will verify your PRC credentials and send portal activation credentials to ${_emailController.text}.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.outlineVariant),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Return to Sign In',
                style: AppTextStyles.labelLg.copyWith(
                  color: AppColors.primaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMd.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.bodySm.copyWith(
              color: AppColors.outline,
            ),
            prefixIcon: Icon(icon, size: 20, color: AppColors.outline),
            filled: true,
            fillColor: AppColors.surfaceContainerLow,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error),
            ),
          ),
        ),
      ],
    );
  }
}
