import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/client_model.dart';

class ClientDetailSheet extends StatelessWidget {
  final ClientModel client;
  final ValueChanged<ClientStage>? onStageChanged;

  const ClientDetailSheet({
    super.key,
    required this.client,
    this.onStageChanged,
  });

  static void show(
    BuildContext context, {
    required ClientModel client,
    ValueChanged<ClientStage>? onStageChanged,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => ClientDetailSheet(
        client: client,
        onStageChanged: onStageChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  client.initials,
                  style: AppTextStyles.titleMd.copyWith(
                    color: AppColors.onPrimaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      client.name,
                      style: AppTextStyles.headlineMd.copyWith(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      client.subtitle ?? client.phone,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.outline),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          const SizedBox(height: 18),
          const Divider(height: 1, color: AppColors.surfaceContainer),
          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unit & Reservation Card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'INTERESTED PROPERTY',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.outline,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryFixed,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                client.stage.badgeText,
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          client.unitDescription,
                          style: AppTextStyles.titleMd.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryContainer,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          client.tcpFormatted,
                          style: AppTextStyles.headlineSm.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              size: 15,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                client.statusNote,
                                style: AppTextStyles.bodySm.copyWith(
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Contact Quick Bar
                  Text(
                    'DIRECT CONTACT ACTIONS',
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.outline,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => _copyToClipboard(
                            context,
                            client.phone,
                            'Mobile number copied',
                          ),
                          icon: const Icon(Icons.call, size: 16, color: AppColors.primary),
                          label: Text(
                            'Call Lead',
                            style: AppTextStyles.labelMd.copyWith(color: AppColors.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => _copyToClipboard(
                            context,
                            client.phone,
                            'Viber/WhatsApp number copied',
                          ),
                          icon: const Icon(Icons.chat, size: 16, color: AppColors.secondary),
                          label: Text(
                            'Message',
                            style: AppTextStyles.labelMd.copyWith(color: AppColors.secondary),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Stage Transition Selector
                  if (onStageChanged != null) ...[
                    Text(
                      'UPDATE PIPELINE STAGE',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.outline,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ClientStage.values.map((stage) {
                        final isSelected = client.stage == stage;
                        return ChoiceChip(
                          selected: isSelected,
                          label: Text(stage.label),
                          selectedColor: AppColors.primary,
                          labelStyle: AppTextStyles.labelSm.copyWith(
                            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                          onSelected: (val) {
                            if (val) {
                              onStageChanged!(stage);
                              Navigator.of(context).pop();
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ],

                  const SizedBox(height: 20),

                  // Audit & MLS sync card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.verified_user_outlined,
                          size: 20,
                          color: AppColors.surfaceTint,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'VHBC Cloud Verification',
                                style: AppTextStyles.labelMd.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Encrypted & synced with broker MLS registry.',
                                style: AppTextStyles.bodySm.copyWith(
                                  color: AppColors.outline,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text, String message) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$message ($text)'),
        backgroundColor: AppColors.primaryContainer,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
