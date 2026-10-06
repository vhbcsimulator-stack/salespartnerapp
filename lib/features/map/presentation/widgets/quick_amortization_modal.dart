import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../computation/models/computation_result_model.dart';
import '../../../computation/models/payment_scheme_model.dart';
import '../../../computation/presentation/computation_page.dart';
import '../../../computation/services/computation_service.dart';
import '../../models/map_lot_model.dart';

/// Interactive Quick Amortization Bottom Sheet Modal
/// Dynamically calculates price computations matching project discount schemes from Supabase:
/// - Cash: Discount on Total TCP (dynamic, e.g. 50%)
/// - 50% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (dynamic, e.g. 30%)
/// - 30% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (dynamic, e.g. 20%)
/// - 20% Spot DP: Discount on DP • Balance 60 mos @ 0% Interest (dynamic, e.g. 10%)
/// - 0% Spot DP: ₱20,000 Reservation Fee • Balance 60 mos @ 0% Interest
class QuickAmortizationModal extends StatefulWidget {
  final MapLotModel lot;
  final PaymentSchemeModel? initialScheme;
  final String? initialSchemeCode;

  const QuickAmortizationModal({
    super.key,
    required this.lot,
    this.initialScheme,
    this.initialSchemeCode,
  });

  static Future<void> show(
    BuildContext context, {
    required MapLotModel lot,
    PaymentSchemeModel? initialScheme,
    String? initialSchemeCode,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => QuickAmortizationModal(
        lot: lot,
        initialScheme: initialScheme,
        initialSchemeCode: initialSchemeCode,
      ),
    );
  }

  @override
  State<QuickAmortizationModal> createState() => _QuickAmortizationModalState();
}

class _QuickAmortizationModalState extends State<QuickAmortizationModal> {
  final _currencyFmt = NumberFormat.currency(
    symbol: '₱',
    decimalDigits: 0,
    locale: 'en_PH',
  );

  late List<PaymentSchemeModel> _schemes;
  late PaymentSchemeModel _selectedScheme;

  @override
  void initState() {
    super.initState();
    final projectCode = ComputationService.normalizeProjectCode(
      null,
      widget.lot.phase,
    );
    _schemes = ComputationService.getPaymentSchemesForProject(
      projectCode,
      discounts: SupabaseService.cachedProjectDiscounts,
    );
    if (widget.initialScheme != null) {
      _selectedScheme = _schemes.firstWhere(
        (s) =>
            s.schemeCode == widget.initialScheme!.schemeCode ||
            s.id == widget.initialScheme!.id,
        orElse: () => widget.initialScheme!,
      );
    } else if (widget.initialSchemeCode != null) {
      _selectedScheme = _schemes.firstWhere(
        (s) => s.schemeCode == widget.initialSchemeCode,
        orElse: () => _schemes.first,
      );
    } else {
      _selectedScheme = _schemes.firstWhere(
        (s) => s.schemeCode == 'CASH_100',
        orElse: () => _schemes.first,
      );
    }

    if (SupabaseService.cachedProjectDiscounts.isEmpty) {
      SupabaseService.fetchProjectDiscounts().then((discounts) {
        if (mounted && discounts.isNotEmpty) {
          setState(() {
            _schemes = ComputationService.getPaymentSchemesForProject(
              projectCode,
              discounts: discounts,
            );
            _selectedScheme = _schemes.firstWhere(
              (s) => s.schemeCode == _selectedScheme.schemeCode,
              orElse: () => _schemes.first,
            );
          });
        }
      });
    }
  }

  ComputationResultModel get _result {
    final projectCode = ComputationService.normalizeProjectCode(
      null,
      widget.lot.phase,
    );
    final phaseNum =
        int.tryParse(
          RegExp(r'\d+').firstMatch(widget.lot.phase)?.group(0) ?? '2',
        ) ??
        2;

    return ComputationService.calculate(
      projectName: projectCode,
      projectCode: projectCode,
      phase: phaseNum,
      blockNumber: widget.lot.block.toString(),
      lotNumber: widget.lot.lot.toString(),
      lotSize: widget.lot.sizeSqm,
      lotType: widget.lot.lotType,
      pricePerSqm: widget.lot.pricePerSqm,
      scheme: _selectedScheme,
    );
  }

  void _shareQuote() {
    final r = _result;
    final text = StringBuffer();
    text.writeln('*BHRI Sales Partner App - ${r.projectName}*');
    text.writeln(
      'Lot: ${widget.lot.blockLotText} (${r.lotSize.toStringAsFixed(0)} sqm • ${r.lotType})',
    );
    text.writeln('Price / sqm: ${_currencyFmt.format(r.pricePerSqm)}/sqm');
    text.writeln('Payment Scheme: ${r.paymentSchemeName}');
    text.writeln('------------------------------------');
    text.writeln('Original TCP: ${_currencyFmt.format(r.originalTCP)}');
    if (r.discountAmount > 0) {
      text.writeln(
        'Discount (${r.discountPercentage.toStringAsFixed(0)}%): -${_currencyFmt.format(r.discountAmount)}',
      );
    }
    text.writeln(
      'TCP AFTER DISCOUNT: ${_currencyFmt.format(r.tcpAfterDiscount)} (VAT Inclusive)',
    );
    text.writeln('------------------------------------');
    text.writeln(
      'Reservation Fee: ${_currencyFmt.format(r.reservationFee)} (Credited against DP/Balance)',
    );

    if (r.grossDownPayment > 0 && r.balance > 0) {
      text.writeln(
        'Spot DP (${r.downPaymentPercentage.toStringAsFixed(0)}%): ${_currencyFmt.format(r.grossDownPayment)}',
      );
      if (r.discountAmount > 0) {
        text.writeln(
          'Discount on Spot DP: -${_currencyFmt.format(r.discountAmount)}',
        );
        text.writeln(
          'Discounted DP: ${_currencyFmt.format(r.discountedDownPayment)}',
        );
      }
      text.writeln(
        'Remaining Spot DP Due: ${_currencyFmt.format(r.remainingDownPayment)}',
      );
    }

    if (r.balance > 0) {
      text.writeln('Balance: ${_currencyFmt.format(r.balance)}');
      text.writeln('Term: ${r.balanceMonths} Months @ 0% Interest');
      text.writeln(
        'Monthly Amortization: ${_currencyFmt.format(r.monthlyAmortization)} / mo',
      );
    } else if (r.grossDownPayment >= r.tcpAfterDiscount) {
      text.writeln(
        'Net Spot Cash Due (30 Days): ${_currencyFmt.format(r.remainingDownPayment)}',
      );
    }

    text.writeln(
      'Estimated Misc Fee (8%): ${_currencyFmt.format(r.miscellaneousFee)}',
    );
    text.writeln('Status: ${widget.lot.status.name.toUpperCase()}');
    text.writeln('------------------------------------');
    text.writeln('Generated via BHRI Sales Partner App');

    Clipboard.setData(ClipboardData(text: text.toString()));
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard! Ready to send via WhatsApp.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryContainer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = _result;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header & Drag Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.calculate_rounded,
                          color: AppColors.secondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Amortization',
                            style: AppTextStyles.headlineSm.copyWith(
                              color: AppColors.primaryContainer,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            r.projectName,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.outline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 18,
                        color: AppColors.outline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Lot Overview Card
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F3E2E), Color(0xFF1E5B45)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F3E2E).withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.lot.blockLotText,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.lot.phase} • ${widget.lot.lotType}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFFBDEDD6),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${widget.lot.sizeSqm.toStringAsFixed(0)} sqm',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'TOTAL CONTRACT PRICE (AFTER DISC.)',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 0.5,
                                color: Color(0xFFBDEDD6),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _currencyFmt.format(r.tcpAfterDiscount),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'RESERVATION FEE',
                              style: TextStyle(
                                fontSize: 10,
                                letterSpacing: 0.5,
                                color: Color(0xFFBDEDD6),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _currencyFmt.format(r.reservationFee),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Payment Scheme Selector Chips
              const Text(
                'Select Payment Option:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _schemes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, idx) {
                    final s = _schemes[idx];
                    final isSel = _selectedScheme.id == s.id;
                    return ChoiceChip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            s.schemeName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSel
                                  ? FontWeight.w800
                                  : FontWeight.w600,
                              color: isSel ? Colors.white : AppColors.onSurface,
                            ),
                          ),
                          if (s.badgeText != null &&
                              s.badgeText!.isNotEmpty) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isSel
                                    ? Colors.white.withValues(alpha: 0.25)
                                    : AppColors.secondary.withValues(
                                        alpha: 0.12,
                                      ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                s.badgeText!,
                                style: TextStyle(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w800,
                                  color: isSel
                                      ? Colors.white
                                      : AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      selected: isSel,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.surfaceContainerLow,
                      side: BorderSide(
                        color: isSel
                            ? AppColors.primary
                            : AppColors.outlineVariant.withValues(alpha: 0.6),
                      ),
                      onSelected: (sel) {
                        if (sel) setState(() => _selectedScheme = s);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              // Original TCP Metric
              _buildRow(
                label: 'Original TCP',
                valueWidget: Text(
                  _currencyFmt.format(r.originalTCP),
                  style: AppTextStyles.labelLg.copyWith(
                    color: AppColors.primaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Spot DP Breakdown (for 50%, 30%, 20%)
              if (r.grossDownPayment > 0 && r.balance > 0) ...[
                _buildRow(
                  label:
                      '${r.downPaymentPercentage.toStringAsFixed(0)}% Spot Down Payment',
                  valueWidget: Text(
                    _currencyFmt.format(r.grossDownPayment),
                    style: AppTextStyles.labelLg.copyWith(
                      color: AppColors.primaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                if (r.discountAmount > 0) ...[
                  _buildRow(
                    label:
                        'Discount on DP (${r.discountPercentage.toStringAsFixed(0)}%)',
                    valueWidget: Text(
                      '-${_currencyFmt.format(r.discountAmount)}',
                      style: AppTextStyles.labelLg.copyWith(
                        color: const Color(0xFF16A34A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  _buildRow(
                    label: 'Discounted Down Payment',
                    valueWidget: Text(
                      _currencyFmt.format(r.discountedDownPayment),
                      style: AppTextStyles.labelLg.copyWith(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                _buildRow(
                  label: 'Less: Reservation Fee (Paid)',
                  valueWidget: Text(
                    '-${_currencyFmt.format(r.reservationFee)}',
                    style: AppTextStyles.labelLg.copyWith(
                      color: const Color(0xFFD4AF37),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                _buildRow(
                  label: 'Remaining Spot DP Due (30 Days)',
                  valueWidget: Text(
                    _currencyFmt.format(r.remainingDownPayment),
                    style: AppTextStyles.labelLg.copyWith(
                      color: AppColors.primaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Balance Amortization (60 Months @ 0% Interest)
              if (r.balance > 0) ...[
                if (r.downPaymentPercentage == 0) ...[
                  _buildRow(
                    label: 'Down Payment',
                    valueWidget: Text(
                      '0% Spot DP',
                      style: AppTextStyles.labelLg.copyWith(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  _buildRow(
                    label: 'Less: Reservation Fee (Credited)',
                    valueWidget: Text(
                      '-${_currencyFmt.format(r.reservationFee)}',
                      style: AppTextStyles.labelLg.copyWith(
                        color: const Color(0xFFD4AF37),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],

                _buildRow(
                  label:
                      '${((r.balance / r.originalTCP) * 100).round()}% Balance',
                  valueWidget: Text(
                    _currencyFmt.format(r.balance),
                    style: AppTextStyles.labelLg.copyWith(
                      color: AppColors.primaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Monthly Balance Amortization Highlight (60 mos @ 0%)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF81C784)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monthly Amortization',
                            style: AppTextStyles.bodySm.copyWith(
                              color: const Color(0xFF1B5E20),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            '${r.balanceMonths} Months @ 0% interest',
                            style: const TextStyle(
                              fontSize: 10.5,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${_currencyFmt.format(r.monthlyAmortization)} / mo',
                        style: AppTextStyles.titleMd.copyWith(
                          color: const Color(0xFF1B5E20),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ] else if (r.grossDownPayment >= r.tcpAfterDiscount) ...[
                // Spot Cash Details (40% OFF TCP)
                if (r.discountAmount > 0) ...[
                  _buildRow(
                    label:
                        '${r.discountPercentage.toStringAsFixed(0)}% Spot Cash Discount',
                    valueWidget: Text(
                      '-${_currencyFmt.format(r.discountAmount)}',
                      style: AppTextStyles.labelLg.copyWith(
                        color: const Color(0xFF16A34A),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                _buildRow(
                  label: 'Less: Reservation Fee',
                  valueWidget: Text(
                    '-${_currencyFmt.format(r.reservationFee)}',
                    style: AppTextStyles.labelLg.copyWith(
                      color: const Color(0xFFD4AF37),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF81C784)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Net Spot Cash Due (30 Days)',
                        style: TextStyle(
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        _currencyFmt.format(r.remainingDownPayment),
                        style: const TextStyle(
                          color: Color(0xFF1B5E20),
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // Estimated Misc Fee (8%)
              _buildRow(
                label: 'Estimated Misc Fee (8% Title/Transfer)',
                valueWidget: Text(
                  _currencyFmt.format(r.miscellaneousFee),
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.outline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Full Computation Page CTA
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ComputationPage(
                        lot: widget.lot,
                        initialScheme: _selectedScheme,
                        initialSchemeCode: _selectedScheme.schemeCode,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.tune_rounded, size: 18),
                label: const Text(
                  'Open Full Computation Page',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryContainer,
                  side: const BorderSide(
                    color: AppColors.primaryContainer,
                    width: 1.5,
                  ),
                  minimumSize: const Size(double.infinity, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // CTA Share via WhatsApp
              ElevatedButton.icon(
                onPressed: _shareQuote,
                icon: const Icon(Icons.share_rounded, size: 18),
                label: const Text(
                  'Send Quote to Buyer via WhatsApp',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryContainer,
                  foregroundColor: AppColors.onPrimary,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow({required String label, required Widget valueWidget}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 12.5,
            ),
          ),
          valueWidget,
        ],
      ),
    );
  }
}
