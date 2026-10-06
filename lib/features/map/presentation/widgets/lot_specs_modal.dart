import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/map_lot_model.dart';

/// Full Lot Specifications Sheet
class LotSpecsModal extends StatelessWidget {
  final MapLotModel lot;

  const LotSpecsModal({
    super.key,
    required this.lot,
  });

  static Future<void> show(BuildContext context, {required MapLotModel lot}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => LotSpecsModal(lot: lot),
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
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 28,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: AppColors.primaryContainer,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${lot.blockLotText} Specifications',
                      style: AppTextStyles.headlineSm.copyWith(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
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
            const SizedBox(height: 16),
            _specTile('Development', 'Mountain View Leisure (MVLC)'),
            _specTile('Phase & Cluster', '${lot.phase} • ${lot.cluster}'),
            _specTile('Lot Classification', lot.lotType),
            _specTile('Total Area', '${lot.sizeSqm.toInt()} sqm (Square Cut)'),
            _specTile('Frontage Width', '12.0 meters along 14m R.O.W.'),
            _specTile('Depth', '18.3 meters regular boundary'),
            _specTile('Topography & Elevation', 'EL. 412m above sea level (Ridge Vista)'),
            _specTile('Orientation', lot.viewOrientation),
            _specTile('Zoning / Usage', 'Low-Density Eco-Resort Residential (R-1)'),
            _specTile('Building Height Limit', '9.0 meters (2-Storey with View Deck)'),
            _specTile('Deed Restrictions', 'Modern Tropical / Mountain Modern Architecture'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerHigh,
                foregroundColor: AppColors.onSurface,
                elevation: 0,
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Close Specifications'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _specTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.outline,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMd.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
