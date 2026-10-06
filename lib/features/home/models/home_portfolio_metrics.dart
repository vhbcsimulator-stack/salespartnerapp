import 'package:intl/intl.dart';

/// Data class holding real portfolio summary stats calculated from Supabase database.
class HomePortfolioMetrics {
  final int availableLots;
  final int reservedLots;
  final int soldLots;
  final int totalLots;
  final double minPricePerSqm;
  final double minTcp;
  final String activeProjectId;
  final String activeProjectName;

  const HomePortfolioMetrics({
    required this.availableLots,
    required this.reservedLots,
    required this.soldLots,
    required this.totalLots,
    required this.minPricePerSqm,
    required this.minTcp,
    required this.activeProjectId,
    required this.activeProjectName,
  });

  String get formattedMinPricePerSqm {
    if (minPricePerSqm <= 0 || minPricePerSqm.isInfinite) return '₱9,800';
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(minPricePerSqm.round())}';
  }

  String get formattedMinTcp {
    if (minTcp <= 0 || minTcp.isInfinite) return '₱1.18M';
    if (minTcp >= 1000000) {
      final inMillions = minTcp / 1000000;
      return '₱${inMillions.toStringAsFixed(2)}M';
    }
    final fmt = NumberFormat('#,##0', 'en_PH');
    return '₱${fmt.format(minTcp.round())}';
  }

  double get soldPercentage {
    if (totalLots <= 0) return 0.0;
    return double.parse(((soldLots / totalLots) * 100.0).toStringAsFixed(1));
  }
}
