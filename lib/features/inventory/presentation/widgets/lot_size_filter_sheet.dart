import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Modal bottom sheet allowing brokers to dial in an exact lot area range (sqm).
class LotSizeFilterSheet extends StatefulWidget {
  final double? initialMin;
  final double? initialMax;
  final void Function(double? min, double? max, String? label) onApply;
  final bool isUnit;

  const LotSizeFilterSheet({
    super.key,
    this.initialMin,
    this.initialMax,
    required this.onApply,
    this.isUnit = false,
  });

  static Future<void> show({
    required BuildContext context,
    double? currentMin,
    double? currentMax,
    required void Function(double? min, double? max, String? label) onApply,
    bool isUnit = false,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => LotSizeFilterSheet(
        initialMin: currentMin,
        initialMax: currentMax,
        onApply: onApply,
        isUnit: isUnit,
      ),
    );
  }


  @override
  State<LotSizeFilterSheet> createState() => _LotSizeFilterSheetState();
}

class _LotSizeFilterSheetState extends State<LotSizeFilterSheet> {
  static const double sliderMinBound = 100;
  static const double sliderMaxBound = 1200;

  late double _currentMin;
  late double _currentMax;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _currentMin = (widget.initialMin ?? sliderMinBound).clamp(sliderMinBound, sliderMaxBound);
    _currentMax = (widget.initialMax ?? sliderMaxBound).clamp(sliderMinBound, sliderMaxBound);
    if (_currentMin > _currentMax) {
      _currentMin = _currentMax;
    }

    _minController = TextEditingController(
      text: widget.initialMin != null ? widget.initialMin!.toInt().toString() : '',
    );
    _maxController = TextEditingController(
      text: widget.initialMax != null ? widget.initialMax!.toInt().toString() : '',
    );
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  void _applyPreset(double? min, double? max) {
    setState(() {
      _currentMin = (min ?? sliderMinBound).clamp(sliderMinBound, sliderMaxBound);
      _currentMax = (max ?? sliderMaxBound).clamp(sliderMinBound, sliderMaxBound);
      _minController.text = min != null ? min.toInt().toString() : '';
      _maxController.text = max != null ? max.toInt().toString() : '';
    });
  }

  void _submit() {
    final parsedMin = double.tryParse(_minController.text.trim());
    final parsedMax = double.tryParse(_maxController.text.trim());

    String? label;
    if (parsedMin != null && parsedMax != null) {
      label = '${parsedMin.toInt()} - ${parsedMax.toInt()} sqm';
    } else if (parsedMin != null) {
      label = '>= ${parsedMin.toInt()} sqm';
    } else if (parsedMax != null) {
      label = '<= ${parsedMax.toInt()} sqm';
    }

    widget.onApply(parsedMin, parsedMax, label);
    Navigator.pop(context);
  }

  void _reset() {
    setState(() {
      _currentMin = sliderMinBound;
      _currentMax = sliderMaxBound;
      _minController.clear();
      _maxController.clear();
    });
    widget.onApply(null, null, null);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.straighten,
                    size: 20,
                    color: AppColors.primaryContainer,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isUnit ? 'Filter Unit Size Range' : 'Filter Lot Size Range',
                        style: AppTextStyles.titleMd.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.isUnit
                            ? 'Specify unit area requirements in square meters'
                            : 'Specify lot area requirements in square meters',
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),

                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  color: AppColors.onSurfaceVariant,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: AppColors.surfaceContainerHigh),
            const SizedBox(height: 16),

            // Quick Preset Chips
            Text(
              'QUICK PRESETS',
              style: AppTextStyles.labelSm.copyWith(
                color: AppColors.onSurfaceVariant,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildPresetChip('< 200 sqm', null, 200),
                _buildPresetChip('200 - 300 sqm', 200, 300),
                _buildPresetChip('301 - 500 sqm', 301, 500),
                _buildPresetChip('500+ sqm', 500, null),
                _buildPresetChip('Any Size', null, null),
              ],
            ),
            const SizedBox(height: 20),

            // Range Slider Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'SLIDER RANGE',
                  style: AppTextStyles.labelSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${_currentMin.toInt()} - ${_currentMax >= sliderMaxBound ? '1,200+ sqm' : '${_currentMax.toInt()} sqm'}',
                  style: AppTextStyles.labelMd.copyWith(
                    color: AppColors.primaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(_currentMin, _currentMax),
              min: sliderMinBound,
              max: sliderMaxBound,
              divisions: 22,
              activeColor: AppColors.primaryContainer,
              inactiveColor: AppColors.surfaceContainerHighest,
              labels: RangeLabels(
                '${_currentMin.toInt()} sqm',
                '${_currentMax.toInt()} sqm',
              ),
              onChanged: (values) {
                setState(() {
                  _currentMin = values.start;
                  _currentMax = values.end;
                  _minController.text = _currentMin.toInt().toString();
                  _maxController.text =
                      _currentMax >= sliderMaxBound ? '' : _currentMax.toInt().toString();
                });
              },
            ),
            const SizedBox(height: 12),

            // Manual Min/Max Text Inputs
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Min Area (sqm)',
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.outlineVariant.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _minController,
                                keyboardType: TextInputType.number,
                                style: AppTextStyles.bodyMd.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'e.g. 150',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (val) {
                                  final num = double.tryParse(val);
                                  if (num != null) {
                                    setState(() {
                                      _currentMin = num.clamp(sliderMinBound, _currentMax);
                                    });
                                  }
                                },
                              ),
                            ),
                            const Text(
                              'sqm',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.outline,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Max Area (sqm)',
                        style: AppTextStyles.labelSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLowest,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.outlineVariant.withValues(alpha: 0.6),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _maxController,
                                keyboardType: TextInputType.number,
                                style: AppTextStyles.bodyMd.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'e.g. 500',
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (val) {
                                  final num = double.tryParse(val);
                                  if (num != null) {
                                    setState(() {
                                      _currentMax = num.clamp(_currentMin, sliderMaxBound);
                                    });
                                  }
                                },
                              ),
                            ),
                            const Text(
                              'sqm',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.outline,
                                fontWeight: FontWeight.w600,
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
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(
                        color: AppColors.outlineVariant.withValues(alpha: 0.6),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Clear Filter',
                      style: AppTextStyles.labelMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    icon: const Icon(Icons.check, size: 18),
                    label: const Text('Apply Size Filter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
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
    );
  }

  Widget _buildPresetChip(String label, double? min, double? max) {
    final parsedMin = double.tryParse(_minController.text.trim());
    final parsedMax = double.tryParse(_maxController.text.trim());
    final isSelected = (min == null && max == null && parsedMin == null && parsedMax == null) ||
        (parsedMin == min && parsedMax == max);

    return InkWell(
      onTap: () => _applyPreset(min, max),
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer
              : AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.labelSm.copyWith(
            color: isSelected ? Colors.white : AppColors.onSurface,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
