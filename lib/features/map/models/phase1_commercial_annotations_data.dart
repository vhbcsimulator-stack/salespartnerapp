import 'package:flutter/material.dart';
import 'phase_lot_annotation.dart';
export 'phase_lot_annotation.dart';

/// Static dataset containing all lot annotations for Phase 1 Commercial (4961x3508)
class Phase1CommercialAnnotationsData {
  Phase1CommercialAnnotationsData._();

  /// Find the annotation at [localPos] within [renderSize].
  static Phase1CommercialLotAnnotation? hitTest(Offset localPos, Size renderSize) {
    return PhaseLotAnnotation.hitTestList(annotations, localPos, renderSize);
  }

  static const List<Phase1CommercialLotAnnotation> annotations = [
    // id 1: C L1
    Phase1CommercialLotAnnotation(
      id: 1,
      categoryId: 1,
      name: 'C L1',
      bbox: Rect.fromLTWH(3069.27, 2561.16, 752.24, 386.33),
      points: [
        Offset(3253.516, 2935.021),
        Offset(3253.866, 2890.600),
        Offset(3324.561, 2890.462),
        Offset(3323.429, 2947.488),
        Offset(3479.506, 2945.039),
        Offset(3478.435, 2900.696),
        Offset(3678.177, 2894.000),
        Offset(3672.578, 2798.639),
        Offset(3821.510, 2798.172),
        Offset(3813.211, 2561.163),
        Offset(3069.274, 2641.154),
        Offset(3104.373, 2946.076),
        Offset(3184.204, 2935.427),
      ],
    ),
    // id 2: C L2
    Phase1CommercialLotAnnotation(
      id: 2,
      categoryId: 11,
      name: 'C L2',
      bbox: Rect.fromLTWH(3030.13, 2218.82, 357.17, 282.90),
      points: [
        Offset(3030.127, 2253.796),
        Offset(3054.479, 2501.721),
        Offset(3387.294, 2466.104),
        Offset(3361.193, 2218.822),
      ],
    ),
    // id 3: C L3
    Phase1CommercialLotAnnotation(
      id: 3,
      categoryId: 14,
      name: 'C L3',
      bbox: Rect.fromLTWH(3010.22, 2045.83, 350.37, 209.16),
      points: [
        Offset(3010.221, 2081.277),
        Offset(3029.380, 2254.988),
        Offset(3360.593, 2217.958),
        Offset(3341.724, 2045.828),
      ],
    ),
    // id 4: C L4
    Phase1CommercialLotAnnotation(
      id: 4,
      categoryId: 15,
      name: 'C L4',
      bbox: Rect.fromLTWH(2991.42, 1873.50, 350.56, 211.34),
      points: [
        Offset(2991.421, 1907.653),
        Offset(3010.092, 2084.833),
        Offset(3341.979, 2045.271),
        Offset(3322.738, 1873.496),
      ],
    ),
    // id 5: C L5
    Phase1CommercialLotAnnotation(
      id: 5,
      categoryId: 16,
      name: 'C L5',
      bbox: Rect.fromLTWH(2973.73, 1700.57, 347.26, 210.17),
      points: [
        Offset(2973.727, 1736.241),
        Offset(2992.203, 1910.738),
        Offset(3320.988, 1874.200),
        Offset(3304.806, 1700.572),
      ],
    ),
    // id 6: C L6
    Phase1CommercialLotAnnotation(
      id: 6,
      categoryId: 17,
      name: 'C L6',
      bbox: Rect.fromLTWH(2953.82, 1527.69, 350.91, 208.74),
      points: [
        Offset(2953.821, 1563.723),
        Offset(2973.360, 1736.427),
        Offset(3304.733, 1699.012),
        Offset(3286.581, 1527.686),
      ],
    ),
    // id 7: C L7
    Phase1CommercialLotAnnotation(
      id: 7,
      categoryId: 18,
      name: 'C L7',
      bbox: Rect.fromLTWH(2927.28, 1279.18, 358.85, 284.22),
      points: [
        Offset(2927.280, 1316.004),
        Offset(2954.076, 1563.394),
        Offset(3286.131, 1527.881),
        Offset(3259.128, 1279.177),
      ],
    ),
    // id 8: C L8
    Phase1CommercialLotAnnotation(
      id: 8,
      categoryId: 19,
      name: 'C L8',
      bbox: Rect.fromLTWH(2862.02, 670.77, 896.17, 507.61),
      points: [
        Offset(2862.019, 702.411),
        Offset(2912.316, 1178.382),
        Offset(3758.187, 1086.555),
        Offset(3742.019, 670.768),
      ],
    ),
    // id 9: C L9
    Phase1CommercialLotAnnotation(
      id: 9,
      categoryId: 20,
      name: 'C L9',
      bbox: Rect.fromLTWH(2648.73, 2628.58, 234.16, 383.45),
      points: [
        Offset(2648.728, 2649.714),
        Offset(2844.025, 2628.576),
        Offset(2882.889, 2988.133),
        Offset(2689.943, 3012.023),
      ],
    ),
    // id 10: C L10
    Phase1CommercialLotAnnotation(
      id: 10,
      categoryId: 2,
      name: 'C L10',
      bbox: Rect.fromLTWH(2626.63, 2456.10, 219.78, 194.13),
      points: [
        Offset(2626.632, 2476.316),
        Offset(2648.178, 2650.233),
        Offset(2846.414, 2628.214),
        Offset(2827.358, 2456.100),
      ],
    ),
    // id 11: C L11
    Phase1CommercialLotAnnotation(
      id: 11,
      categoryId: 3,
      name: 'C L11',
      bbox: Rect.fromLTWH(2605.49, 2281.31, 221.07, 195.71),
      points: [
        Offset(2605.486, 2304.179),
        Offset(2626.331, 2477.013),
        Offset(2826.561, 2453.999),
        Offset(2808.019, 2281.305),
      ],
    ),
    // id 12: C L12
    Phase1CommercialLotAnnotation(
      id: 12,
      categoryId: 4,
      name: 'C L12',
      bbox: Rect.fromLTWH(2584.66, 2108.73, 222.93, 197.21),
      points: [
        Offset(2584.661, 2131.759),
        Offset(2605.315, 2305.940),
        Offset(2807.592, 2282.201),
        Offset(2789.942, 2108.726),
      ],
    ),
    // id 13: C L14
    Phase1CommercialLotAnnotation(
      id: 13,
      categoryId: 5,
      name: 'C L14',
      bbox: Rect.fromLTWH(2564.84, 1935.49, 224.69, 197.60),
      points: [
        Offset(2564.842, 1959.588),
        Offset(2586.125, 2133.094),
        Offset(2789.534, 2109.904),
        Offset(2772.472, 1935.495),
      ],
    ),
    // id 14: C L15
    Phase1CommercialLotAnnotation(
      id: 14,
      categoryId: 6,
      name: 'C L15',
      bbox: Rect.fromLTWH(2541.71, 1762.77, 226.87, 196.07),
      points: [
        Offset(2541.713, 1786.227),
        Offset(2563.309, 1958.848),
        Offset(2768.587, 1936.776),
        Offset(2750.892, 1762.774),
      ],
    ),
    // id 15: C L16
    Phase1CommercialLotAnnotation(
      id: 15,
      categoryId: 7,
      name: 'C L16',
      bbox: Rect.fromLTWH(2520.24, 1590.57, 231.96, 197.48),
      points: [
        Offset(2520.239, 1613.461),
        Offset(2542.857, 1788.049),
        Offset(2752.203, 1763.171),
        Offset(2732.110, 1590.569),
      ],
    ),
    // id 16: C L17
    Phase1CommercialLotAnnotation(
      id: 16,
      categoryId: 8,
      name: 'C L17',
      bbox: Rect.fromLTWH(2499.74, 1416.44, 233.57, 197.98),
      points: [
        Offset(2499.742, 1439.718),
        Offset(2521.833, 1614.421),
        Offset(2733.314, 1589.223),
        Offset(2714.247, 1416.445),
      ],
    ),
    // id 17: C L18
    Phase1CommercialLotAnnotation(
      id: 17,
      categoryId: 9,
      name: 'C L18',
      bbox: Rect.fromLTWH(2479.24, 1244.27, 234.38, 197.86),
      points: [
        Offset(2479.244, 1267.928),
        Offset(2501.389, 1442.132),
        Offset(2713.621, 1416.624),
        Offset(2692.765, 1244.270),
      ],
    ),
    // id 18: C L19
    Phase1CommercialLotAnnotation(
      id: 18,
      categoryId: 10,
      name: 'C L19',
      bbox: Rect.fromLTWH(2460.05, 1072.41, 234.36, 197.09),
      points: [
        Offset(2460.050, 1096.321),
        Offset(2480.906, 1269.507),
        Offset(2694.409, 1243.862),
        Offset(2676.831, 1072.415),
      ],
    ),
    // id 19: C L20
    Phase1CommercialLotAnnotation(
      id: 19,
      categoryId: 12,
      name: 'C L20',
      bbox: Rect.fromLTWH(2437.27, 899.68, 239.02, 194.37),
      points: [
        Offset(2437.272, 922.396),
        Offset(2458.727, 1094.049),
        Offset(2676.294, 1070.508),
        Offset(2657.432, 899.679),
      ],
    ),
    // id 20: C L21
    Phase1CommercialLotAnnotation(
      id: 20,
      categoryId: 13,
      name: 'C L21',
      bbox: Rect.fromLTWH(2418.73, 726.17, 239.46, 198.17),
      points: [
        Offset(2418.727, 750.606),
        Offset(2438.207, 924.344),
        Offset(2658.191, 899.122),
        Offset(2640.171, 726.169),
      ],
    ),
  ];
}
