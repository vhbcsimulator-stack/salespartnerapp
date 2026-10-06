import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/contact_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// State-of-the-art Broker Contact Sheet for dialing and contacting the sales desk.
class BrokerContactSheet extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? lotInfo;

  const BrokerContactSheet({
    super.key,
    this.title = 'Broker Support & Reservations',
    this.subtitle,
    this.lotInfo,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Broker Support & Reservations',
    String? subtitle,
    String? lotInfo,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => BrokerContactSheet(
        title: title,
        subtitle: subtitle,
        lotInfo: lotInfo,
      ),
    );
  }

  Future<void> _makeCall(BuildContext context) async {
    final Uri telUri = Uri.parse('tel:${ContactService.salesDeskNumber}');
    try {
      final launched = await launchUrl(
        telUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        final fallback = await launchUrl(telUri);
        if (!fallback && context.mounted) {
          _showSimulatorNotice(context);
        }
      }
    } catch (_) {
      if (context.mounted) {
        _showSimulatorNotice(context);
      }
    }
  }

  Future<void> _sendSms(BuildContext context) async {
    final message = lotInfo != null
        ? 'Hi BHRI Sales Desk, I would like to inquire/reserve lot: $lotInfo'
        : 'Hi BHRI Sales Desk, I need sales partner assistance.';
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: ContactService.salesDeskNumber,
      queryParameters: {'body': message},
    );
    try {
      if (!await launchUrl(smsUri)) {
        await launchUrl(Uri.parse('sms:${ContactService.salesDeskNumber}'));
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to open SMS messaging on this device.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _copyNumber(BuildContext context) {
    Clipboard.setData(
      const ClipboardData(text: ContactService.salesDeskNumber),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Hotline 09171897112 copied to clipboard!'),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSimulatorNotice(BuildContext context) {
    Clipboard.setData(
      const ClipboardData(text: ContactService.salesDeskNumber),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Dialing 09171897112 (Phone dialer launches on physical devices; copied to clipboard).',
        ),
        duration: Duration(seconds: 3),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 38,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E6F5C).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.support_agent_rounded,
                  color: Color(0xFF1E6F5C),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleMd.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryContainer,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subtitle ?? 'Official BHRI Sales & Reservations Desk',
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.outline,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Lot Details context card if provided
          if (lotInfo != null && lotInfo!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.6),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Target Reservation: $lotInfo',
                      style: AppTextStyles.labelMd.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryContainer,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Contact Details Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F3E2E), Color(0xFF165B43)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F3E2E).withValues(alpha: 0.18),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4ADE80),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'HOTLINE ACTIVE',
                          style: AppTextStyles.labelSm.copyWith(
                            color: const Color(0xFF86EFAC),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '0917 189 7112',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Direct Line • Sales Coordination',
                      style: AppTextStyles.bodySm.copyWith(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                IconButton.filledTonal(
                  onPressed: () => _copyNumber(context),
                  tooltip: 'Copy Number',
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.15),
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.copy_rounded, size: 18),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Primary Call CTA
          ElevatedButton.icon(
            onPressed: () => _makeCall(context),
            icon: const Icon(Icons.phone_in_talk_rounded, size: 20),
            label: const Text(
              'Call 0917 189 7112 Now',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E6F5C),
              foregroundColor: Colors.white,
              elevation: 2,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Secondary SMS CTA
          OutlinedButton.icon(
            onPressed: () => _sendSms(context),
            icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18),
            label: const Text(
              'Send SMS / Message',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryContainer,
              side: const BorderSide(color: AppColors.outlineVariant),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
