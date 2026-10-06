import 'package:flutter/material.dart';
import 'phase_lot_annotation.dart';
export 'phase_lot_annotation.dart';

/// Static dataset containing all lot annotations for Phase 3 (Carnation)
class Phase3AnnotationsData {
  Phase3AnnotationsData._();

  /// Find the annotation at [localPos] within [renderSize].
  static Phase3LotAnnotation? hitTest(Offset localPos, Size renderSize) {
    return PhaseLotAnnotation.hitTestList(annotations, localPos, renderSize);
  }

  static const List<Phase3LotAnnotation> annotations = [
    // id 1: B1 L1
    Phase3LotAnnotation(
      id: 1,
      categoryId: 1,
      name: 'B1 L1',
      bbox: Rect.fromLTWH(2834.09, 4109.95, 225.22, 173.71),
      points: [
        Offset(2834.093, 4159.826),
        Offset(2886.319, 4283.664),
        Offset(3059.315, 4195.411),
        Offset(3017.891, 4109.955),
      ],
    ),
    // id 2: B1 L2
    Phase3LotAnnotation(
      id: 2,
      categoryId: 2,
      name: 'B1 L2',
      bbox: Rect.fromLTWH(3021.23, 4057.75, 226.80, 138.29),
      points: [
        Offset(3021.228, 4094.441),
        Offset(3066.907, 4196.032),
        Offset(3248.028, 4136.178),
        Offset(3222.610, 4084.586),
        Offset(3204.850, 4069.807),
        Offset(3184.572, 4061.467),
        Offset(3162.263, 4057.746),
      ],
    ),
    // id 3: B1 L3
    Phase3LotAnnotation(
      id: 3,
      categoryId: 3,
      name: 'B1 L3',
      bbox: Rect.fromLTWH(2889.19, 4198.53, 223.05, 181.72),
      points: [
        Offset(2889.186, 4282.391),
        Offset(2941.514, 4380.248),
        Offset(3112.233, 4295.519),
        Offset(3057.149, 4198.529),
      ],
    ),
    // id 4: B1 L4
    Phase3LotAnnotation(
      id: 4,
      categoryId: 4,
      name: 'B1 L4',
      bbox: Rect.fromLTWH(3067.45, 4136.80, 230.26, 165.12),
      points: [
        Offset(3067.449, 4195.900),
        Offset(3127.690, 4301.917),
        Offset(3297.713, 4215.421),
        Offset(3250.516, 4136.799),
      ],
    ),
    // id 5: B1 L5
    Phase3LotAnnotation(
      id: 5,
      categoryId: 5,
      name: 'B1 L5',
      bbox: Rect.fromLTWH(2942.64, 4296.23, 247.01, 187.36),
      points: [
        Offset(3112.542, 4296.232),
        Offset(2942.642, 4382.860),
        Offset(3014.980, 4483.597),
        Offset(3189.653, 4404.640),
      ],
    ),
    // id 6: B1 L6
    Phase3LotAnnotation(
      id: 6,
      categoryId: 6,
      name: 'B1 L6',
      bbox: Rect.fromLTWH(3128.32, 4214.55, 251.71, 184.79),
      points: [
        Offset(3128.324, 4301.869),
        Offset(3196.703, 4399.342),
        Offset(3380.030, 4316.053),
        Offset(3349.531, 4285.412),
        Offset(3298.880, 4214.554),
      ],
    ),
    // id 7: B2 L1
    Phase3LotAnnotation(
      id: 7,
      categoryId: 139,
      name: 'B2 L1',
      bbox: Rect.fromLTWH(2761.83, 3862.58, 204.02, 133.93),
      points: [
        Offset(2950.509, 3862.576),
        Offset(2761.834, 3895.820),
        Offset(2782.271, 3996.504),
        Offset(2965.851, 3948.162),
      ],
    ),
    // id 8: B2 L2
    Phase3LotAnnotation(
      id: 8,
      categoryId: 150,
      name: 'B2 L2',
      bbox: Rect.fromLTWH(2948.90, 3778.26, 202.14, 187.95),
      points: [
        Offset(2948.900, 3812.224),
        Offset(2977.879, 3966.212),
        Offset(3109.401, 3927.404),
        Offset(3129.023, 3913.099),
        Offset(3145.062, 3892.614),
        Offset(3151.043, 3860.673),
        Offset(3135.642, 3778.264),
      ],
    ),
    // id 9: B2 L3
    Phase3LotAnnotation(
      id: 9,
      categoryId: 161,
      name: 'B2 L3',
      bbox: Rect.fromLTWH(2747.39, 3766.88, 201.63, 128.20),
      points: [
        Offset(2931.898, 3766.885),
        Offset(2747.393, 3800.697),
        Offset(2764.277, 3895.090),
        Offset(2949.018, 3861.971),
      ],
    ),
    // id 10: B2 L4
    Phase3LotAnnotation(
      id: 10,
      categoryId: 172,
      name: 'B2 L4',
      bbox: Rect.fromLTWH(2932.84, 3684.65, 203.09, 127.66),
      points: [
        Offset(2932.843, 3720.602),
        Offset(2949.756, 3812.308),
        Offset(3135.930, 3778.533),
        Offset(3121.234, 3684.646),
      ],
    ),
    // id 11: B2 L5
    Phase3LotAnnotation(
      id: 11,
      categoryId: 173,
      name: 'B2 L5',
      bbox: Rect.fromLTWH(2728.52, 3672.25, 203.10, 129.06),
      points: [
        Offset(2931.618, 3766.627),
        Offset(2915.099, 3672.245),
        Offset(2728.517, 3707.810),
        Offset(2747.891, 3801.310),
      ],
    ),
    // id 12: B2 L6
    Phase3LotAnnotation(
      id: 12,
      categoryId: 174,
      name: 'B2 L6',
      bbox: Rect.fromLTWH(2915.75, 3593.34, 205.08, 127.96),
      points: [
        Offset(2915.752, 3629.471),
        Offset(2933.112, 3721.295),
        Offset(3120.828, 3684.779),
        Offset(3102.889, 3593.338),
      ],
    ),
    // id 13: B2 L7
    Phase3LotAnnotation(
      id: 13,
      categoryId: 175,
      name: 'B2 L7',
      bbox: Rect.fromLTWH(2708.42, 3577.03, 206.46, 130.20),
      points: [
        Offset(2896.950, 3577.029),
        Offset(2708.423, 3612.528),
        Offset(2727.959, 3707.227),
        Offset(2914.885, 3671.869),
      ],
    ),
    // id 14: B2 L8
    Phase3LotAnnotation(
      id: 14,
      categoryId: 176,
      name: 'B2 L8',
      bbox: Rect.fromLTWH(2896.95, 3501.68, 209.00, 130.83),
      points: [
        Offset(2896.950, 3538.303),
        Offset(2912.424, 3632.507),
        Offset(3105.951, 3590.681),
        Offset(3085.359, 3501.675),
      ],
    ),
    // id 15: B2 L9
    Phase3LotAnnotation(
      id: 15,
      categoryId: 177,
      name: 'B2 L9',
      bbox: Rect.fromLTWH(2692.05, 3480.68, 204.76, 131.47),
      points: [
        Offset(2880.892, 3480.685),
        Offset(2692.052, 3504.391),
        Offset(2697.748, 3550.803),
        Offset(2711.740, 3612.155),
        Offset(2896.813, 3577.199),
      ],
    ),
    // id 16: B2 L10
    Phase3LotAnnotation(
      id: 16,
      categoryId: 140,
      name: 'B2 L10',
      bbox: Rect.fromLTWH(2884.22, 3412.63, 200.23, 125.66),
      points: [
        Offset(2884.224, 3438.416),
        Offset(2894.061, 3538.292),
        Offset(3084.451, 3501.509),
        Offset(3072.740, 3412.633),
      ],
    ),
    // id 17: B2 L11
    Phase3LotAnnotation(
      id: 17,
      categoryId: 141,
      name: 'B2 L11',
      bbox: Rect.fromLTWH(2680.23, 3386.23, 199.81, 119.11),
      points: [
        Offset(2867.669, 3386.229),
        Offset(2680.234, 3408.980),
        Offset(2691.199, 3505.335),
        Offset(2880.048, 3481.755),
      ],
    ),
    // id 18: B2 L12
    Phase3LotAnnotation(
      id: 18,
      categoryId: 142,
      name: 'B2 L12',
      bbox: Rect.fromLTWH(2871.45, 3322.05, 199.32, 116.72),
      points: [
        Offset(2871.447, 3344.669),
        Offset(2882.457, 3438.770),
        Offset(3070.770, 3412.282),
        Offset(3059.037, 3322.051),
      ],
    ),
    // id 19: B2 L13
    Phase3LotAnnotation(
      id: 19,
      categoryId: 143,
      name: 'B2 L13',
      bbox: Rect.fromLTWH(2667.60, 3288.94, 200.26, 121.54),
      points: [
        Offset(2854.445, 3288.940),
        Offset(2667.596, 3314.325),
        Offset(2679.130, 3410.478),
        Offset(2867.861, 3385.532),
      ],
    ),
    // id 20: B2 L14
    Phase3LotAnnotation(
      id: 20,
      categoryId: 144,
      name: 'B2 L14',
      bbox: Rect.fromLTWH(2858.22, 3228.92, 204.05, 116.12),
      points: [
        Offset(2858.223, 3253.047),
        Offset(2870.938, 3345.042),
        Offset(3062.273, 3319.505),
        Offset(3046.732, 3228.920),
      ],
    ),
    // id 21: B2 L15
    Phase3LotAnnotation(
      id: 21,
      categoryId: 145,
      name: 'B2 L15',
      bbox: Rect.fromLTWH(2652.88, 3193.84, 201.36, 120.17),
      points: [
        Offset(2843.014, 3193.835),
        Offset(2652.882, 3217.634),
        Offset(2666.191, 3314.008),
        Offset(2854.246, 3289.283),
      ],
    ),
    // id 22: B2 L16
    Phase3LotAnnotation(
      id: 22,
      categoryId: 146,
      name: 'B2 L16',
      bbox: Rect.fromLTWH(2845.00, 3139.88, 204.24, 113.41),
      points: [
        Offset(2844.999, 3161.425),
        Offset(2858.485, 3253.294),
        Offset(3049.237, 3226.998),
        Offset(3034.755, 3139.885),
      ],
    ),
    // id 23: B2 L17
    Phase3LotAnnotation(
      id: 23,
      categoryId: 147,
      name: 'B2 L17',
      bbox: Rect.fromLTWH(2639.84, 3095.89, 203.46, 122.52),
      points: [
        Offset(2639.839, 3120.769),
        Offset(2652.583, 3218.408),
        Offset(2843.298, 3192.931),
        Offset(2826.916, 3095.889),
      ],
    ),
    // id 24: B2 L18
    Phase3LotAnnotation(
      id: 24,
      categoryId: 148,
      name: 'B2 L18',
      bbox: Rect.fromLTWH(2833.66, 3045.43, 203.55, 116.01),
      points: [
        Offset(2833.665, 3069.803),
        Offset(2845.350, 3161.444),
        Offset(3037.213, 3135.885),
        Offset(3021.616, 3045.433),
      ],
    ),
    // id 25: B2 L19
    Phase3LotAnnotation(
      id: 25,
      categoryId: 149,
      name: 'B2 L19',
      bbox: Rect.fromLTWH(2625.96, 3001.80, 200.57, 119.75),
      points: [
        Offset(2813.829, 3001.795),
        Offset(2625.962, 3028.671),
        Offset(2638.585, 3121.544),
        Offset(2826.529, 3097.498),
      ],
    ),
    // id 26: B2 L20
    Phase3LotAnnotation(
      id: 26,
      categoryId: 151,
      name: 'B2 L20',
      bbox: Rect.fromLTWH(2817.61, 2951.20, 204.11, 118.56),
      points: [
        Offset(2817.607, 2975.348),
        Offset(2831.765, 3069.759),
        Offset(3021.716, 3044.079),
        Offset(3008.813, 2951.199),
      ],
    ),
    // id 27: B2 L21
    Phase3LotAnnotation(
      id: 27,
      categoryId: 152,
      name: 'B2 L21',
      bbox: Rect.fromLTWH(2612.64, 2906.40, 202.70, 121.25),
      points: [
        Offset(2798.716, 2906.395),
        Offset(2612.639, 2933.057),
        Offset(2626.143, 3027.645),
        Offset(2815.342, 3001.043),
      ],
    ),
    // id 28: B2 L22
    Phase3LotAnnotation(
      id: 28,
      categoryId: 153,
      name: 'B2 L22',
      bbox: Rect.fromLTWH(2805.33, 2860.25, 202.88, 116.45),
      points: [
        Offset(2805.328, 2883.726),
        Offset(2818.659, 2976.695),
        Offset(3008.204, 2950.900),
        Offset(2994.464, 2860.245),
      ],
    ),
    // id 29: B2 L23
    Phase3LotAnnotation(
      id: 29,
      categoryId: 154,
      name: 'B2 L23',
      bbox: Rect.fromLTWH(2599.19, 2809.11, 199.17, 123.27),
      points: [
        Offset(2784.548, 2809.106),
        Offset(2599.194, 2838.764),
        Offset(2611.938, 2932.378),
        Offset(2798.362, 2903.750),
      ],
    ),
    // id 30: B2 L24
    Phase3LotAnnotation(
      id: 30,
      categoryId: 155,
      name: 'B2 L24',
      bbox: Rect.fromLTWH(2788.33, 2766.06, 207.25, 118.24),
      points: [
        Offset(2788.326, 2793.049),
        Offset(2805.767, 2884.298),
        Offset(2995.578, 2859.094),
        Offset(2980.953, 2766.059),
      ],
    ),
    // id 31: B2 L25
    Phase3LotAnnotation(
      id: 31,
      categoryId: 156,
      name: 'B2 L25',
      bbox: Rect.fromLTWH(2580.29, 2713.71, 202.56, 125.29),
      points: [
        Offset(2768.490, 2713.706),
        Offset(2580.292, 2744.094),
        Offset(2596.412, 2839.000),
        Offset(2782.851, 2809.460),
      ],
    ),
    // id 32: B2 L26
    Phase3LotAnnotation(
      id: 32,
      categoryId: 157,
      name: 'B2 L26',
      bbox: Rect.fromLTWH(2774.85, 2676.20, 204.60, 117.43),
      points: [
        Offset(2774.848, 2702.276),
        Offset(2790.492, 2793.628),
        Offset(2979.447, 2766.985),
        Offset(2965.305, 2676.197),
      ],
    ),
    // id 33: B2 L27
    Phase3LotAnnotation(
      id: 33,
      categoryId: 158,
      name: 'B2 L27',
      bbox: Rect.fromLTWH(2564.37, 2618.31, 204.12, 126.05),
      points: [
        Offset(2753.378, 2618.306),
        Offset(2564.367, 2649.203),
        Offset(2580.978, 2744.360),
        Offset(2768.487, 2712.695),
      ],
    ),
    // id 34: B2 L28
    Phase3LotAnnotation(
      id: 34,
      categoryId: 159,
      name: 'B2 L28',
      bbox: Rect.fromLTWH(2759.99, 2585.37, 206.97, 115.11),
      points: [
        Offset(2759.989, 2607.916),
        Offset(2774.423, 2700.482),
        Offset(2966.958, 2676.086),
        Offset(2951.225, 2585.369),
      ],
    ),
    // id 35: B2 L29
    Phase3LotAnnotation(
      id: 35,
      categoryId: 160,
      name: 'B2 L29',
      bbox: Rect.fromLTWH(2549.41, 2522.91, 202.96, 127.03),
      points: [
        Offset(2738.265, 2522.906),
        Offset(2549.405, 2537.174),
        Offset(2562.533, 2649.938),
        Offset(2752.367, 2616.978),
      ],
    ),
    // id 36: B2 L30
    Phase3LotAnnotation(
      id: 36,
      categoryId: 162,
      name: 'B2 L30',
      bbox: Rect.fromLTWH(2745.91, 2490.89, 202.95, 116.98),
      points: [
        Offset(2745.913, 2500.185),
        Offset(2760.266, 2607.864),
        Offset(2948.860, 2584.668),
        Offset(2936.820, 2490.887),
      ],
    ),
    // id 37: B2 L31
    Phase3LotAnnotation(
      id: 37,
      categoryId: 163,
      name: 'B2 L31',
      bbox: Rect.fromLTWH(2548.07, 2417.39, 191.66, 122.72),
      points: [
        Offset(2737.320, 2424.672),
        Offset(2548.073, 2417.385),
        Offset(2548.815, 2540.104),
        Offset(2739.733, 2522.545),
      ],
    ),
    // id 38: B2 L32
    Phase3LotAnnotation(
      id: 38,
      categoryId: 164,
      name: 'B2 L32',
      bbox: Rect.fromLTWH(2743.43, 2374.61, 192.79, 125.97),
      points: [
        Offset(2747.710, 2374.611),
        Offset(2743.427, 2500.584),
        Offset(2935.396, 2488.072),
        Offset(2936.219, 2395.070),
      ],
    ),
    // id 39: B2 L35
    Phase3LotAnnotation(
      id: 39,
      categoryId: 167,
      name: 'B2 L35',
      bbox: Rect.fromLTWH(2561.08, 2180.98, 205.30, 147.00),
      points: [
        Offset(2586.191, 2180.977),
        Offset(2561.079, 2296.999),
        Offset(2745.969, 2327.977),
        Offset(2766.376, 2233.031),
      ],
    ),
    // id 40: B2 L33
    Phase3LotAnnotation(
      id: 40,
      categoryId: 165,
      name: 'B2 L33',
      bbox: Rect.fromLTWH(2546.12, 2298.10, 199.30, 125.58),
      points: [
        Offset(2559.744, 2298.102),
        Offset(2546.122, 2419.086),
        Offset(2735.686, 2423.684),
        Offset(2745.419, 2327.660),
      ],
    ),
    // id 41: B2 L34
    Phase3LotAnnotation(
      id: 41,
      categoryId: 166,
      name: 'B2 L34',
      bbox: Rect.fromLTWH(2747.18, 2253.71, 204.77, 139.69),
      points: [
        Offset(2769.435, 2253.708),
        Offset(2747.179, 2375.460),
        Offset(2937.359, 2393.399),
        Offset(2951.948, 2303.847),
      ],
    ),
    // id 42: B2 L36
    Phase3LotAnnotation(
      id: 42,
      categoryId: 168,
      name: 'B2 L36',
      bbox: Rect.fromLTWH(2769.39, 2138.50, 216.13, 164.52),
      points: [
        Offset(2811.744, 2138.502),
        Offset(2769.391, 2254.247),
        Offset(2954.081, 2303.024),
        Offset(2985.520, 2213.642),
      ],
    ),
    // id 43: B2 L37
    Phase3LotAnnotation(
      id: 43,
      categoryId: 169,
      name: 'B2 L37',
      bbox: Rect.fromLTWH(2586.88, 2066.29, 213.73, 165.71),
      points: [
        Offset(2800.605, 2143.195),
        Offset(2769.524, 2232.002),
        Offset(2586.878, 2181.018),
        Offset(2627.885, 2066.291),
      ],
    ),
    // id 44: B2 L38
    Phase3LotAnnotation(
      id: 44,
      categoryId: 170,
      name: 'B2 L38',
      bbox: Rect.fromLTWH(2812.76, 2014.15, 249.08, 200.56),
      points: [
        Offset(2881.387, 2014.149),
        Offset(2840.328, 2078.755),
        Offset(2812.763, 2137.779),
        Offset(2987.236, 2214.708),
        Offset(3061.845, 2075.228),
        Offset(2957.151, 2027.771),
      ],
    ),
    // id 45: B2 L39
    Phase3LotAnnotation(
      id: 45,
      categoryId: 171,
      name: 'B2 L39',
      bbox: Rect.fromLTWH(2627.58, 1964.43, 248.48, 177.62),
      points: [
        Offset(2678.385, 1964.427),
        Offset(2627.582, 2067.347),
        Offset(2800.354, 2142.051),
        Offset(2834.495, 2074.767),
        Offset(2876.063, 2009.437),
      ],
    ),
    // id 46: B3 L1
    Phase3LotAnnotation(
      id: 46,
      categoryId: 195,
      name: 'B3 L1',
      bbox: Rect.fromLTWH(2900.10, 1867.54, 242.03, 171.83),
      points: [
        Offset(2964.745, 1867.541),
        Offset(2900.102, 1971.557),
        Offset(2972.565, 1989.385),
        Offset(3082.501, 2039.367),
        Offset(3142.128, 1946.802),
      ],
    ),
    // id 47: B3 L2
    Phase3LotAnnotation(
      id: 47,
      categoryId: 197,
      name: 'B3 L2',
      bbox: Rect.fromLTWH(2694.69, 1801.08, 248.88, 169.79),
      points: [
        Offset(2943.562, 1880.133),
        Offset(2890.126, 1970.869),
        Offset(2694.686, 1926.614),
        Offset(2767.189, 1801.081),
      ],
    ),
    // id 48: B3 L3
    Phase3LotAnnotation(
      id: 48,
      categoryId: 198,
      name: 'B3 L3',
      bbox: Rect.fromLTWH(2965.17, 1776.16, 238.13, 169.43),
      points: [
        Offset(3142.954, 1945.590),
        Offset(3203.302, 1865.158),
        Offset(3033.978, 1776.157),
        Offset(2965.170, 1867.250),
      ],
    ),
    // id 49: B3 L4
    Phase3LotAnnotation(
      id: 49,
      categoryId: 199,
      name: 'B3 L4',
      bbox: Rect.fromLTWH(2767.62, 1707.08, 234.43, 172.05),
      points: [
        Offset(2945.576, 1879.126),
        Offset(3002.044, 1797.588),
        Offset(2829.204, 1707.077),
        Offset(2767.618, 1798.638),
      ],
    ),
    // id 50: B3 L5
    Phase3LotAnnotation(
      id: 50,
      categoryId: 200,
      name: 'B3 L5',
      bbox: Rect.fromLTWH(3031.95, 1688.80, 237.71, 175.30),
      points: [
        Offset(3103.680, 1688.797),
        Offset(3031.949, 1774.088),
        Offset(3203.825, 1864.095),
        Offset(3269.656, 1787.258),
      ],
    ),
    // id 51: B3 L6
    Phase3LotAnnotation(
      id: 51,
      categoryId: 201,
      name: 'B3 L6',
      bbox: Rect.fromLTWH(2828.06, 1619.09, 236.83, 177.46),
      points: [
        Offset(3002.977, 1796.549),
        Offset(3064.894, 1719.960),
        Offset(2899.496, 1619.087),
        Offset(2828.063, 1705.381),
      ],
    ),
    // id 52: B3 L7
    Phase3LotAnnotation(
      id: 52,
      categoryId: 202,
      name: 'B3 L7',
      bbox: Rect.fromLTWH(3104.22, 1606.22, 234.08, 181.36),
      points: [
        Offset(3181.222, 1606.220),
        Offset(3104.215, 1686.551),
        Offset(3270.643, 1787.584),
        Offset(3338.292, 1718.717),
      ],
    ),
    // id 53: B3 L8
    Phase3LotAnnotation(
      id: 53,
      categoryId: 203,
      name: 'B3 L8',
      bbox: Rect.fromLTWH(2901.90, 1534.85, 228.64, 183.54),
      points: [
        Offset(3066.613, 1718.390),
        Offset(3130.536, 1646.623),
        Offset(2974.119, 1534.850),
        Offset(2901.896, 1614.284),
      ],
    ),
    // id 54: B3 L9
    Phase3LotAnnotation(
      id: 54,
      categoryId: 204,
      name: 'B3 L9',
      bbox: Rect.fromLTWH(3183.32, 1529.69, 232.33, 188.07),
      points: [
        Offset(3264.806, 1529.685),
        Offset(3183.318, 1607.121),
        Offset(3340.506, 1717.757),
        Offset(3415.648, 1649.094),
      ],
    ),
    // id 55: B3 L10
    Phase3LotAnnotation(
      id: 55,
      categoryId: 196,
      name: 'B3 L10',
      bbox: Rect.fromLTWH(2971.97, 1457.50, 284.56, 186.90),
      points: [
        Offset(3256.533, 1524.579),
        Offset(3131.075, 1644.405),
        Offset(2971.975, 1531.644),
        Offset(3054.642, 1457.501),
        Offset(3205.202, 1479.483),
      ],
    ),
    // id 56: B4 L1
    Phase3LotAnnotation(
      id: 56,
      categoryId: 205,
      name: 'B4 L1',
      bbox: Rect.fromLTWH(3638.30, 4231.85, 284.86, 210.00),
      points: [
        Offset(3923.159, 4303.343),
        Offset(3736.504, 4441.855),
        Offset(3638.296, 4390.966),
        Offset(3743.778, 4231.855),
        Offset(3834.847, 4278.063),
      ],
    ),
    // id 57: B4 L2
    Phase3LotAnnotation(
      id: 57,
      categoryId: 216,
      name: 'B4 L2',
      bbox: Rect.fromLTWH(3535.07, 4180.29, 208.88, 209.27),
      points: [
        Offset(3666.917, 4180.285),
        Offset(3535.075, 4318.255),
        Offset(3636.976, 4389.553),
        Offset(3743.952, 4232.718),
      ],
    ),
    // id 58: B4 L3
    Phase3LotAnnotation(
      id: 58,
      categoryId: 220,
      name: 'B4 L3',
      bbox: Rect.fromLTWH(3448.86, 4114.03, 216.08, 206.07),
      points: [
        Offset(3664.935, 4179.294),
        Offset(3599.505, 4114.031),
        Offset(3448.857, 4232.873),
        Offset(3495.142, 4282.441),
        Offset(3535.404, 4320.106),
      ],
    ),
    // id 59: B4 L4
    Phase3LotAnnotation(
      id: 59,
      categoryId: 221,
      name: 'B4 L4',
      bbox: Rect.fromLTWH(3375.55, 4042.62, 222.58, 188.35),
      points: [
        Offset(3541.033, 4042.625),
        Offset(3375.549, 4135.622),
        Offset(3412.126, 4190.029),
        Offset(3446.538, 4230.976),
        Offset(3598.127, 4114.763),
      ],
    ),
    // id 60: B4 L5
    Phase3LotAnnotation(
      id: 60,
      categoryId: 222,
      name: 'B4 L5',
      bbox: Rect.fromLTWH(3315.39, 3959.11, 222.84, 174.62),
      points: [
        Offset(3538.230, 4039.347),
        Offset(3493.276, 3959.107),
        Offset(3315.388, 4029.638),
        Offset(3372.579, 4133.725),
      ],
    ),
    // id 61: B4 L6
    Phase3LotAnnotation(
      id: 61,
      categoryId: 223,
      name: 'B4 L6',
      bbox: Rect.fromLTWH(3277.56, 3872.20, 217.92, 156.39),
      points: [
        Offset(3495.474, 3958.897),
        Offset(3470.651, 3902.854),
        Offset(3460.618, 3872.196),
        Offset(3277.556, 3925.982),
        Offset(3315.071, 4028.583),
      ],
    ),
    // id 62: B4 L7
    Phase3LotAnnotation(
      id: 62,
      categoryId: 224,
      name: 'B4 L7',
      bbox: Rect.fromLTWH(3252.19, 3780.82, 208.82, 145.19),
      points: [
        Offset(3441.193, 3780.823),
        Offset(3252.188, 3810.895),
        Offset(3277.601, 3926.016),
        Offset(3461.005, 3871.498),
      ],
    ),
    // id 63: B4 L8
    Phase3LotAnnotation(
      id: 63,
      categoryId: 225,
      name: 'B4 L8',
      bbox: Rect.fromLTWH(3238.98, 3686.68, 201.52, 124.86),
      points: [
        Offset(3424.537, 3686.682),
        Offset(3238.984, 3719.380),
        Offset(3252.361, 3811.543),
        Offset(3440.506, 3780.220),
      ],
    ),
    // id 64: B4 L9
    Phase3LotAnnotation(
      id: 64,
      categoryId: 226,
      name: 'B4 L9',
      bbox: Rect.fromLTWH(3219.60, 3593.99, 206.37, 127.86),
      points: [
        Offset(3407.158, 3593.990),
        Offset(3219.595, 3628.846),
        Offset(3236.783, 3721.849),
        Offset(3425.966, 3686.931),
      ],
    ),
    // id 65: B4 L10
    Phase3LotAnnotation(
      id: 65,
      categoryId: 206,
      name: 'B4 L10',
      bbox: Rect.fromLTWH(3200.14, 3500.57, 207.49, 129.49),
      points: [
        Offset(3389.778, 3500.574),
        Offset(3200.142, 3537.461),
        Offset(3219.692, 3630.059),
        Offset(3407.627, 3593.235),
      ],
    ),
    // id 66: B4 L11
    Phase3LotAnnotation(
      id: 66,
      categoryId: 207,
      name: 'B4 L11',
      bbox: Rect.fromLTWH(3186.32, 3415.27, 203.00, 123.89),
      points: [
        Offset(3373.821, 3415.273),
        Offset(3186.318, 3437.852),
        Offset(3187.730, 3468.380),
        Offset(3202.535, 3539.164),
        Offset(3389.317, 3499.739),
      ],
    ),
    // id 67: B4 L12
    Phase3LotAnnotation(
      id: 67,
      categoryId: 208,
      name: 'B4 L12',
      bbox: Rect.fromLTWH(3171.53, 3321.82, 201.42, 117.29),
      points: [
        Offset(3361.604, 3321.820),
        Offset(3171.527, 3346.470),
        Offset(3184.525, 3439.111),
        Offset(3372.950, 3414.546),
      ],
    ),
    // id 68: B4 L13
    Phase3LotAnnotation(
      id: 68,
      categoryId: 209,
      name: 'B4 L13',
      bbox: Rect.fromLTWH(3369.68, 3295.34, 206.22, 151.76),
      points: [
        Offset(3369.680, 3320.134),
        Offset(3384.120, 3437.120),
        Offset(3387.560, 3447.102),
        Offset(3575.900, 3408.467),
        Offset(3559.151, 3295.343),
      ],
    ),
    // id 69: B4 L14
    Phase3LotAnnotation(
      id: 69,
      categoryId: 210,
      name: 'B4 L14',
      bbox: Rect.fromLTWH(3386.88, 3410.64, 206.87, 126.68),
      points: [
        Offset(3386.881, 3446.262),
        Offset(3404.108, 3537.314),
        Offset(3593.750, 3499.983),
        Offset(3573.258, 3410.637),
      ],
    ),
    // id 70: B4 L15
    Phase3LotAnnotation(
      id: 70,
      categoryId: 211,
      name: 'B4 L15',
      bbox: Rect.fromLTWH(3406.86, 3502.02, 202.27, 125.60),
      points: [
        Offset(3406.858, 3538.043),
        Offset(3421.887, 3627.618),
        Offset(3609.129, 3593.424),
        Offset(3590.641, 3502.019),
      ],
    ),
    // id 71: B4 L16
    Phase3LotAnnotation(
      id: 71,
      categoryId: 212,
      name: 'B4 L16',
      bbox: Rect.fromLTWH(3420.92, 3592.21, 206.37, 125.18),
      points: [
        Offset(3420.917, 3626.577),
        Offset(3437.883, 3717.382),
        Offset(3627.284, 3684.210),
        Offset(3609.571, 3592.205),
      ],
    ),
    // id 72: B4 L17
    Phase3LotAnnotation(
      id: 72,
      categoryId: 213,
      name: 'B4 L17',
      bbox: Rect.fromLTWH(3438.30, 3683.59, 204.69, 138.38),
      points: [
        Offset(3438.296, 3717.821),
        Offset(3455.716, 3821.969),
        Offset(3642.984, 3776.195),
        Offset(3626.557, 3683.593),
      ],
    ),
    // id 73: B4 L18
    Phase3LotAnnotation(
      id: 73,
      categoryId: 214,
      name: 'B4 L18',
      bbox: Rect.fromLTWH(3456.40, 3777.92, 211.94, 184.99),
      points: [
        Offset(3456.400, 3822.099),
        Offset(3465.766, 3864.748),
        Offset(3486.656, 3925.006),
        Offset(3504.489, 3962.908),
        Offset(3668.338, 3866.975),
        Offset(3651.385, 3820.405),
        Offset(3642.118, 3777.920),
      ],
    ),
    // id 74: B4 L19
    Phase3LotAnnotation(
      id: 74,
      categoryId: 215,
      name: 'B4 L19',
      bbox: Rect.fromLTWH(3505.30, 3868.84, 215.06, 224.93),
      points: [
        Offset(3505.298, 3964.628),
        Offset(3547.921, 4038.212),
        Offset(3589.227, 4093.766),
        Offset(3720.358, 3946.714),
        Offset(3691.123, 3909.952),
        Offset(3668.086, 3868.839),
      ],
    ),
    // id 75: B4 L20
    Phase3LotAnnotation(
      id: 75,
      categoryId: 217,
      name: 'B4 L20',
      bbox: Rect.fromLTWH(3591.16, 3947.56, 202.61, 254.59),
      points: [
        Offset(3591.161, 4094.484),
        Offset(3645.120, 4149.673),
        Offset(3710.472, 4202.149),
        Offset(3793.773, 4010.756),
        Offset(3753.718, 3982.882),
        Offset(3720.913, 3947.562),
      ],
    ),
    // id 76: B4 L21
    Phase3LotAnnotation(
      id: 76,
      categoryId: 218,
      name: 'B4 L21',
      bbox: Rect.fromLTWH(3711.54, 4011.18, 175.70, 266.92),
      points: [
        Offset(3711.544, 4203.210),
        Offset(3782.237, 4244.967),
        Offset(3862.290, 4278.098),
        Offset(3887.242, 4048.639),
        Offset(3855.453, 4041.180),
        Offset(3830.512, 4031.290),
        Offset(3795.970, 4011.181),
      ],
    ),
    // id 77: B4 L22
    Phase3LotAnnotation(
      id: 77,
      categoryId: 219,
      name: 'B4 L22',
      bbox: Rect.fromLTWH(3862.18, 4047.24, 161.27, 247.42),
      points: [
        Offset(3888.736, 4048.885),
        Offset(3934.794, 4055.663),
        Offset(3989.057, 4047.239),
        Offset(4023.449, 4222.674),
        Offset(3924.967, 4294.660),
        Offset(3862.177, 4277.987),
      ],
    ),
    // id 78: B5 L1
    Phase3LotAnnotation(
      id: 78,
      categoryId: 227,
      name: 'B5 L1',
      bbox: Rect.fromLTWH(3159.12, 3213.74, 200.42, 118.16),
      points: [
        Offset(3359.536, 3306.361),
        Offset(3169.767, 3331.900),
        Offset(3159.120, 3239.311),
        Offset(3348.133, 3213.741),
      ],
    ),
    // id 79: B5 L2
    Phase3LotAnnotation(
      id: 79,
      categoryId: 238,
      name: 'B5 L2',
      bbox: Rect.fromLTWH(3143.18, 3120.75, 202.61, 117.93),
      points: [
        Offset(3333.104, 3120.753),
        Offset(3143.184, 3146.754),
        Offset(3159.872, 3238.681),
        Offset(3345.791, 3213.370),
      ],
    ),
    // id 80: B5 L3
    Phase3LotAnnotation(
      id: 80,
      categoryId: 242,
      name: 'B5 L3',
      bbox: Rect.fromLTWH(3131.91, 3027.35, 201.51, 118.53),
      points: [
        Offset(3319.965, 3027.345),
        Offset(3131.911, 3053.287),
        Offset(3145.200, 3145.879),
        Offset(3333.423, 3119.185),
      ],
    ),
    // id 81: B5 L4
    Phase3LotAnnotation(
      id: 81,
      categoryId: 243,
      name: 'B5 L4',
      bbox: Rect.fromLTWH(3118.27, 2933.02, 200.99, 122.36),
      points: [
        Offset(3305.423, 2933.024),
        Offset(3118.272, 2962.302),
        Offset(3132.096, 3055.384),
        Offset(3319.262, 3026.593),
      ],
    ),
    // id 82: B5 L5
    Phase3LotAnnotation(
      id: 82,
      categoryId: 244,
      name: 'B5 L5',
      bbox: Rect.fromLTWH(3103.72, 2841.23, 202.78, 120.23),
      points: [
        Offset(3292.056, 2841.230),
        Offset(3103.722, 2870.483),
        Offset(3118.611, 2961.462),
        Offset(3306.504, 2933.129),
      ],
    ),
    // id 83: B5 L6
    Phase3LotAnnotation(
      id: 83,
      categoryId: 245,
      name: 'B5 L6',
      bbox: Rect.fromLTWH(3091.07, 2748.66, 201.42, 121.72),
      points: [
        Offset(3277.899, 2748.656),
        Offset(3091.073, 2777.205),
        Offset(3103.407, 2870.375),
        Offset(3292.490, 2841.510),
      ],
    ),
    // id 84: B5 L7
    Phase3LotAnnotation(
      id: 84,
      categoryId: 246,
      name: 'B5 L7',
      bbox: Rect.fromLTWH(3074.98, 2656.01, 202.17, 122.47),
      points: [
        Offset(3263.563, 2656.011),
        Offset(3074.980, 2684.624),
        Offset(3089.712, 2778.479),
        Offset(3277.146, 2747.903),
      ],
    ),
    // id 85: B5 L8
    Phase3LotAnnotation(
      id: 85,
      categoryId: 247,
      name: 'B5 L8',
      bbox: Rect.fromLTWH(3059.77, 2563.84, 202.13, 122.59),
      points: [
        Offset(3247.410, 2563.843),
        Offset(3059.773, 2594.153),
        Offset(3075.561, 2686.437),
        Offset(3261.900, 2655.903),
      ],
    ),
    // id 86: B5 L9
    Phase3LotAnnotation(
      id: 86,
      categoryId: 248,
      name: 'B5 L9',
      bbox: Rect.fromLTWH(3043.75, 2474.52, 203.04, 119.52),
      points: [
        Offset(3232.805, 2474.523),
        Offset(3043.753, 2497.949),
        Offset(3060.025, 2594.041),
        Offset(3246.798, 2562.565),
      ],
    ),
    // id 87: B5 L10
    Phase3LotAnnotation(
      id: 87,
      categoryId: 228,
      name: 'B5 L10',
      bbox: Rect.fromLTWH(3045.04, 2375.27, 187.68, 121.82),
      points: [
        Offset(3045.356, 2497.084),
        Offset(3045.038, 2397.807),
        Offset(3214.987, 2375.267),
        Offset(3232.714, 2474.191),
      ],
    ),
    // id 88: B5 L11
    Phase3LotAnnotation(
      id: 88,
      categoryId: 229,
      name: 'B5 L11',
      bbox: Rect.fromLTWH(3045.49, 2143.45, 169.34, 255.82),
      points: [
        Offset(3214.833, 2375.285),
        Offset(3175.080, 2153.473),
        Offset(3145.134, 2143.446),
        Offset(3091.966, 2244.403),
        Offset(3079.674, 2270.324),
        Offset(3070.031, 2294.242),
        Offset(3057.606, 2336.330),
        Offset(3047.775, 2383.629),
        Offset(3045.489, 2399.266),
      ],
    ),
    // id 89: B5 L12
    Phase3LotAnnotation(
      id: 89,
      categoryId: 230,
      name: 'B5 L12',
      bbox: Rect.fromLTWH(3183.47, 2158.45, 222.65, 187.13),
      points: [
        Offset(3183.473, 2158.454),
        Offset(3218.280, 2345.584),
        Offset(3406.121, 2314.360),
        Offset(3389.076, 2223.466),
      ],
    ),
    // id 90: B5 L13
    Phase3LotAnnotation(
      id: 90,
      categoryId: 231,
      name: 'B5 L13',
      bbox: Rect.fromLTWH(3217.52, 2316.50, 205.75, 123.44),
      points: [
        Offset(3217.521, 2345.717),
        Offset(3233.295, 2439.947),
        Offset(3423.267, 2404.527),
        Offset(3405.561, 2316.502),
      ],
    ),
    // id 91: B5 L14
    Phase3LotAnnotation(
      id: 91,
      categoryId: 232,
      name: 'B5 L14',
      bbox: Rect.fromLTWH(3234.54, 2407.82, 200.65, 124.11),
      points: [
        Offset(3234.544, 2438.900),
        Offset(3249.409, 2531.933),
        Offset(3435.192, 2498.981),
        Offset(3420.124, 2407.824),
      ],
    ),
    // id 92: B5 L15
    Phase3LotAnnotation(
      id: 92,
      categoryId: 233,
      name: 'B5 L15',
      bbox: Rect.fromLTWH(3251.57, 2501.25, 203.67, 122.84),
      points: [
        Offset(3251.568, 2530.292),
        Offset(3265.859, 2624.091),
        Offset(3455.239, 2591.174),
        Offset(3438.076, 2501.249),
      ],
    ),
    // id 93: B5 L16
    Phase3LotAnnotation(
      id: 93,
      categoryId: 234,
      name: 'B5 L16',
      bbox: Rect.fromLTWH(3266.34, 2593.19, 203.82, 121.33),
      points: [
        Offset(3266.342, 2624.921),
        Offset(3281.714, 2714.527),
        Offset(3470.160, 2684.162),
        Offset(3454.256, 2593.194),
      ],
    ),
    // id 94: B5 L17
    Phase3LotAnnotation(
      id: 94,
      categoryId: 235,
      name: 'B5 L17',
      bbox: Rect.fromLTWH(3280.24, 2684.60, 202.98, 122.83),
      points: [
        Offset(3280.240, 2713.971),
        Offset(3295.469, 2807.428),
        Offset(3483.218, 2775.623),
        Offset(3469.838, 2684.599),
      ],
    ),
    // id 95: B5 L18
    Phase3LotAnnotation(
      id: 95,
      categoryId: 236,
      name: 'B5 L18',
      bbox: Rect.fromLTWH(3294.58, 2779.11, 202.66, 119.36),
      points: [
        Offset(3294.576, 2806.259),
        Offset(3309.637, 2898.462),
        Offset(3497.232, 2869.545),
        Offset(3483.936, 2779.106),
      ],
    ),
    // id 96: B5 L19
    Phase3LotAnnotation(
      id: 96,
      categoryId: 237,
      name: 'B5 L19',
      bbox: Rect.fromLTWH(3310.89, 2869.59, 202.55, 120.02),
      points: [
        Offset(3310.886, 2897.531),
        Offset(3322.149, 2989.609),
        Offset(3513.437, 2961.259),
        Offset(3497.607, 2869.591),
      ],
    ),
    // id 97: B5 L20
    Phase3LotAnnotation(
      id: 97,
      categoryId: 239,
      name: 'B5 L20',
      bbox: Rect.fromLTWH(3323.10, 2963.48, 202.71, 118.71),
      points: [
        Offset(3323.101, 2990.228),
        Offset(3336.817, 3082.190),
        Offset(3525.806, 3055.177),
        Offset(3513.241, 2963.478),
      ],
    ),
    // id 98: B5 L21
    Phase3LotAnnotation(
      id: 98,
      categoryId: 240,
      name: 'B5 L21',
      bbox: Rect.fromLTWH(3336.69, 3055.89, 202.11, 120.10),
      points: [
        Offset(3336.688, 3083.121),
        Offset(3348.556, 3175.997),
        Offset(3538.802, 3147.804),
        Offset(3526.247, 3055.895),
      ],
    ),
    // id 99: B5 L22
    Phase3LotAnnotation(
      id: 99,
      categoryId: 241,
      name: 'B5 L22',
      bbox: Rect.fromLTWH(3348.34, 3148.85, 207.63, 157.65),
      points: [
        Offset(3348.336, 3174.513),
        Offset(3367.068, 3306.497),
        Offset(3555.962, 3279.652),
        Offset(3538.977, 3148.847),
      ],
    ),
    // id 100: B6 L1
    Phase3LotAnnotation(
      id: 100,
      categoryId: 249,
      name: 'B6 L1',
      bbox: Rect.fromLTWH(3165.88, 1981.37, 213.75, 200.02),
      points: [
        Offset(3165.881, 2109.098),
        Offset(3379.627, 2181.395),
        Offset(3375.658, 2146.040),
        Offset(3353.393, 2034.216),
        Offset(3348.147, 2017.638),
        Offset(3336.142, 2001.992),
        Offset(3321.744, 1990.923),
        Offset(3302.875, 1983.815),
        Offset(3286.878, 1981.373),
        Offset(3270.724, 1982.143),
        Offset(3254.727, 1987.701),
        Offset(3242.630, 1995.896),
        Offset(3229.343, 2008.848),
      ],
    ),
    // id 101: B7 L1
    Phase3LotAnnotation(
      id: 101,
      categoryId: 250,
      name: 'B7 L1',
      bbox: Rect.fromLTWH(3422.13, 1719.16, 253.17, 225.12),
      points: [
        Offset(3675.300, 1786.499),
        Offset(3501.857, 1719.164),
        Offset(3437.658, 1771.911),
        Offset(3425.409, 1800.375),
        Offset(3422.127, 1829.329),
        Offset(3444.949, 1943.845),
        Offset(3650.194, 1944.284),
        Offset(3649.014, 1888.870),
        Offset(3658.658, 1847.409),
      ],
    ),
    // id 102: B7 L2
    Phase3LotAnnotation(
      id: 102,
      categoryId: 261,
      name: 'B7 L2',
      bbox: Rect.fromLTWH(3444.85, 1946.46, 218.06, 164.10),
      points: [
        Offset(3444.847, 1946.458),
        Offset(3477.938, 2110.557),
        Offset(3662.909, 2071.055),
        Offset(3651.152, 2008.969),
        Offset(3649.973, 1968.349),
        Offset(3648.831, 1947.567),
      ],
    ),
    // id 103: B7 L3
    Phase3LotAnnotation(
      id: 103,
      categoryId: 265,
      name: 'B7 L3',
      bbox: Rect.fromLTWH(3477.93, 2071.40, 224.69, 213.64),
      points: [
        Offset(3477.933, 2112.312),
        Offset(3499.913, 2223.275),
        Offset(3702.619, 2285.045),
        Offset(3662.333, 2071.404),
      ],
    ),
    // id 104: B7 L4
    Phase3LotAnnotation(
      id: 104,
      categoryId: 266,
      name: 'B7 L4',
      bbox: Rect.fromLTWH(3688.01, 2128.32, 229.28, 232.51),
      points: [
        Offset(3712.191, 2290.484),
        Offset(3688.012, 2163.712),
        Offset(3876.253, 2128.324),
        Offset(3917.290, 2360.837),
      ],
    ),
    // id 105: B7 L5
    Phase3LotAnnotation(
      id: 105,
      categoryId: 267,
      name: 'B7 L5',
      bbox: Rect.fromLTWH(3671.67, 2037.16, 204.47, 127.87),
      points: [
        Offset(3671.673, 2071.561),
        Offset(3689.458, 2165.030),
        Offset(3876.143, 2129.282),
        Offset(3859.726, 2037.160),
      ],
    ),
    // id 106: B7 L6
    Phase3LotAnnotation(
      id: 106,
      categoryId: 268,
      name: 'B7 L6',
      bbox: Rect.fromLTWH(3656.04, 1944.02, 203.67, 127.50),
      points: [
        Offset(3672.003, 2071.527),
        Offset(3659.466, 1997.769),
        Offset(3656.037, 1944.025),
        Offset(3848.771, 1946.131),
        Offset(3848.585, 1976.893),
        Offset(3859.705, 2033.485),
      ],
    ),
    // id 107: B7 L7
    Phase3LotAnnotation(
      id: 107,
      categoryId: 269,
      name: 'B7 L7',
      bbox: Rect.fromLTWH(3657.03, 1787.22, 203.74, 157.81),
      points: [
        Offset(3682.403, 1787.216),
        Offset(3668.847, 1833.725),
        Offset(3661.865, 1873.405),
        Offset(3657.742, 1914.839),
        Offset(3657.035, 1945.023),
        Offset(3848.168, 1944.334),
        Offset(3848.862, 1908.036),
        Offset(3852.608, 1887.978),
        Offset(3860.774, 1852.985),
      ],
    ),
    // id 108: B7 L8
    Phase3LotAnnotation(
      id: 108,
      categoryId: 270,
      name: 'B7 L8',
      bbox: Rect.fromLTWH(3681.86, 1660.47, 220.25, 193.87),
      points: [
        Offset(3748.795, 1660.468),
        Offset(3730.075, 1688.040),
        Offset(3712.694, 1716.033),
        Offset(3697.139, 1749.525),
        Offset(3681.856, 1786.821),
        Offset(3861.062, 1854.342),
        Offset(3868.706, 1830.385),
        Offset(3881.768, 1802.955),
        Offset(3902.101, 1770.524),
      ],
    ),
    // id 109: B7 L9
    Phase3LotAnnotation(
      id: 109,
      categoryId: 271,
      name: 'B7 L9',
      bbox: Rect.fromLTWH(3748.61, 1554.87, 219.87, 216.17),
      points: [
        Offset(3902.279, 1771.043),
        Offset(3927.226, 1740.414),
        Offset(3947.549, 1719.798),
        Offset(3968.477, 1705.311),
        Offset(3855.039, 1554.868),
        Offset(3833.760, 1570.010),
        Offset(3810.752, 1588.504),
        Offset(3778.850, 1621.307),
        Offset(3748.612, 1660.308),
      ],
    ),
    // id 110: B7 L10
    Phase3LotAnnotation(
      id: 110,
      categoryId: 251,
      name: 'B7 L10',
      bbox: Rect.fromLTWH(3854.72, 1485.84, 194.34, 217.55),
      points: [
        Offset(3969.431, 1703.388),
        Offset(3991.682, 1686.827),
        Offset(4014.279, 1674.850),
        Offset(4049.055, 1660.080),
        Offset(3988.735, 1485.841),
        Offset(3957.402, 1496.191),
        Offset(3922.613, 1511.563),
        Offset(3884.602, 1533.374),
        Offset(3854.717, 1552.961),
      ],
    ),
    // id 111: B7 L11
    Phase3LotAnnotation(
      id: 111,
      categoryId: 252,
      name: 'B7 L11',
      bbox: Rect.fromLTWH(3988.43, 1459.08, 152.52, 202.40),
      points: [
        Offset(4049.699, 1661.485),
        Offset(4082.371, 1651.234),
        Offset(4109.819, 1645.408),
        Offset(4140.949, 1644.627),
        Offset(4136.419, 1459.084),
        Offset(4124.324, 1462.165),
        Offset(4050.668, 1468.245),
        Offset(3988.431, 1486.436),
        Offset(4040.976, 1632.441),
      ],
    ),
    // id 112: B7 L12
    Phase3LotAnnotation(
      id: 112,
      categoryId: 253,
      name: 'B7 L12',
      bbox: Rect.fromLTWH(4137.41, 1432.03, 160.39, 224.15),
      points: [
        Offset(4137.407, 1459.498),
        Offset(4232.258, 1437.805),
        Offset(4297.801, 1432.029),
        Offset(4232.887, 1656.182),
        Offset(4208.718, 1649.704),
        Offset(4183.853, 1646.230),
        Offset(4162.372, 1644.035),
        Offset(4142.793, 1643.852),
      ],
    ),
    // id 113: B7 L13
    Phase3LotAnnotation(
      id: 113,
      categoryId: 254,
      name: 'B7 L13',
      bbox: Rect.fromLTWH(4233.96, 1409.46, 273.42, 284.76),
      points: [
        Offset(4233.958, 1655.787),
        Offset(4272.787, 1668.387),
        Offset(4289.895, 1677.286),
        Offset(4318.122, 1694.212),
        Offset(4507.377, 1409.455),
        Offset(4296.379, 1432.497),
      ],
    ),
    // id 114: B7 L14
    Phase3LotAnnotation(
      id: 114,
      categoryId: 255,
      name: 'B7 L14',
      bbox: Rect.fromLTWH(4318.88, 1406.83, 264.53, 349.81),
      points: [
        Offset(4318.884, 1694.442),
        Offset(4337.759, 1707.446),
        Offset(4359.051, 1725.191),
        Offset(4374.999, 1742.994),
        Offset(4381.996, 1756.648),
        Offset(4583.414, 1597.851),
        Offset(4542.580, 1406.833),
        Offset(4507.898, 1409.678),
      ],
    ),
    // id 115: B7 L15
    Phase3LotAnnotation(
      id: 115,
      categoryId: 256,
      name: 'B7 L15',
      bbox: Rect.fromLTWH(4386.18, 1600.41, 229.80, 234.93),
      points: [
        Offset(4583.899, 1600.405),
        Offset(4386.183, 1757.148),
        Offset(4406.823, 1785.220),
        Offset(4421.385, 1809.729),
        Offset(4431.112, 1835.339),
        Offset(4615.979, 1766.867),
      ],
    ),
    // id 116: B7 L16
    Phase3LotAnnotation(
      id: 116,
      categoryId: 257,
      name: 'B7 L16',
      bbox: Rect.fromLTWH(4432.24, 1768.16, 209.23, 159.42),
      points: [
        Offset(4617.092, 1768.156),
        Offset(4432.241, 1838.019),
        Offset(4442.748, 1867.636),
        Offset(4448.865, 1892.132),
        Offset(4454.104, 1927.576),
        Offset(4641.468, 1891.595),
      ],
    ),
    // id 117: B7 L17
    Phase3LotAnnotation(
      id: 117,
      categoryId: 258,
      name: 'B7 L17',
      bbox: Rect.fromLTWH(4453.62, 1891.58, 205.68, 127.44),
      points: [
        Offset(4453.617, 1928.566),
        Offset(4471.231, 2019.014),
        Offset(4659.295, 1985.030),
        Offset(4641.361, 1891.577),
      ],
    ),
    // id 118: B7 L18
    Phase3LotAnnotation(
      id: 118,
      categoryId: 259,
      name: 'B7 L18',
      bbox: Rect.fromLTWH(4471.48, 1984.48, 205.25, 126.78),
      points: [
        Offset(4471.478, 2019.499),
        Offset(4488.372, 2111.259),
        Offset(4676.723, 2077.348),
        Offset(4659.182, 1984.477),
      ],
    ),
    // id 119: B7 L19
    Phase3LotAnnotation(
      id: 119,
      categoryId: 260,
      name: 'B7 L19',
      bbox: Rect.fromLTWH(4488.49, 2076.46, 203.63, 124.64),
      points: [
        Offset(4488.495, 2110.458),
        Offset(4505.258, 2201.099),
        Offset(4692.127, 2168.179),
        Offset(4675.762, 2076.457),
      ],
    ),
    // id 120: B7 L20
    Phase3LotAnnotation(
      id: 120,
      categoryId: 262,
      name: 'B7 L20',
      bbox: Rect.fromLTWH(4504.59, 2170.45, 204.47, 123.98),
      points: [
        Offset(4504.590, 2202.333),
        Offset(4521.665, 2294.437),
        Offset(4709.062, 2262.454),
        Offset(4691.322, 2170.452),
      ],
    ),
    // id 121: B7 L21
    Phase3LotAnnotation(
      id: 121,
      categoryId: 263,
      name: 'B7 L21',
      bbox: Rect.fromLTWH(4522.03, 2261.26, 202.45, 123.98),
      points: [
        Offset(4522.026, 2295.550),
        Offset(4536.471, 2385.246),
        Offset(4724.474, 2354.966),
        Offset(4708.536, 2261.265),
      ],
    ),
    // id 122: B7 L22
    Phase3LotAnnotation(
      id: 122,
      categoryId: 264,
      name: 'B7 L22',
      bbox: Rect.fromLTWH(4536.11, 2354.81, 202.97, 125.15),
      points: [
        Offset(4536.109, 2386.085),
        Offset(4552.348, 2479.956),
        Offset(4739.083, 2446.682),
        Offset(4724.047, 2354.812),
      ],
    ),
    // id 123: B8 L1
    Phase3LotAnnotation(
      id: 123,
      categoryId: 272,
      name: 'B8 L1',
      bbox: Rect.fromLTWH(3506.29, 2263.40, 216.07, 158.12),
      points: [
        Offset(3712.031, 2332.393),
        Offset(3506.287, 2263.403),
        Offset(3536.338, 2421.526),
        Offset(3722.356, 2388.998),
      ],
    ),
    // id 124: B8 L2
    Phase3LotAnnotation(
      id: 124,
      categoryId: 281,
      name: 'B8 L2',
      bbox: Rect.fromLTWH(3537.26, 2387.96, 196.63, 122.99),
      points: [
        Offset(3537.256, 2420.554),
        Offset(3549.001, 2510.956),
        Offset(3733.890, 2481.660),
        Offset(3720.459, 2387.965),
      ],
    ),
    // id 125: B8 L3
    Phase3LotAnnotation(
      id: 125,
      categoryId: 282,
      name: 'B8 L3',
      bbox: Rect.fromLTWH(3549.74, 2477.64, 202.93, 129.31),
      points: [
        Offset(3549.743, 2510.734),
        Offset(3564.593, 2606.943),
        Offset(3752.670, 2572.660),
        Offset(3735.991, 2477.635),
      ],
    ),
    // id 126: B8 L4
    Phase3LotAnnotation(
      id: 126,
      categoryId: 283,
      name: 'B8 L4',
      bbox: Rect.fromLTWH(3565.01, 2571.85, 201.28, 121.16),
      points: [
        Offset(3752.656, 2571.853),
        Offset(3565.013, 2602.245),
        Offset(3580.298, 2693.015),
        Offset(3766.297, 2664.151),
      ],
    ),
    // id 127: B8 L5
    Phase3LotAnnotation(
      id: 127,
      categoryId: 284,
      name: 'B8 L5',
      bbox: Rect.fromLTWH(3579.80, 2664.29, 201.46, 122.98),
      points: [
        Offset(3579.796, 2693.000),
        Offset(3594.684, 2787.270),
        Offset(3781.257, 2757.337),
        Offset(3767.057, 2664.294),
      ],
    ),
    // id 128: B8 L6
    Phase3LotAnnotation(
      id: 128,
      categoryId: 285,
      name: 'B8 L6',
      bbox: Rect.fromLTWH(3593.96, 2757.06, 200.78, 121.07),
      points: [
        Offset(3593.963, 2788.187),
        Offset(3609.453, 2878.126),
        Offset(3794.746, 2850.537),
        Offset(3781.477, 2757.060),
      ],
    ),
    // id 129: B8 L7
    Phase3LotAnnotation(
      id: 129,
      categoryId: 286,
      name: 'B8 L7',
      bbox: Rect.fromLTWH(3609.64, 2849.70, 201.14, 117.41),
      points: [
        Offset(3609.639, 2876.221),
        Offset(3623.544, 2967.115),
        Offset(3810.775, 2941.656),
        Offset(3797.267, 2849.702),
      ],
    ),
    // id 130: B8 L8
    Phase3LotAnnotation(
      id: 130,
      categoryId: 287,
      name: 'B8 L8',
      bbox: Rect.fromLTWH(3621.63, 2942.31, 201.78, 120.32),
      points: [
        Offset(3621.629, 2968.677),
        Offset(3637.543, 3062.632),
        Offset(3823.405, 3036.045),
        Offset(3809.987, 2942.315),
      ],
    ),
    // id 131: B8 L9
    Phase3LotAnnotation(
      id: 131,
      categoryId: 288,
      name: 'B8 L9',
      bbox: Rect.fromLTWH(3635.31, 3035.01, 205.28, 150.43),
      points: [
        Offset(3635.309, 3064.465),
        Offset(3651.849, 3185.441),
        Offset(3840.589, 3159.575),
        Offset(3823.629, 3035.009),
      ],
    ),
    // id 132: B8 L10
    Phase3LotAnnotation(
      id: 132,
      categoryId: 273,
      name: 'B8 L10',
      bbox: Rect.fromLTWH(3835.78, 3039.96, 203.00, 119.56),
      points: [
        Offset(3835.776, 3063.243),
        Offset(3849.767, 3159.518),
        Offset(4038.775, 3131.447),
        Offset(4025.267, 3039.960),
      ],
    ),
    // id 133: B8 L11
    Phase3LotAnnotation(
      id: 133,
      categoryId: 274,
      name: 'B8 L11',
      bbox: Rect.fromLTWH(3823.55, 2950.22, 201.60, 116.22),
      points: [
        Offset(3823.553, 2974.010),
        Offset(3836.889, 3066.437),
        Offset(4025.157, 3040.839),
        Offset(4013.950, 2950.222),
      ],
    ),
    // id 134: B8 L12
    Phase3LotAnnotation(
      id: 134,
      categoryId: 275,
      name: 'B8 L12',
      bbox: Rect.fromLTWH(3808.88, 2855.65, 201.25, 120.37),
      points: [
        Offset(3808.884, 2881.111),
        Offset(3823.672, 2976.020),
        Offset(4010.135, 2949.014),
        Offset(3997.061, 2855.646),
      ],
    ),
    // id 135: B8 L13
    Phase3LotAnnotation(
      id: 135,
      categoryId: 276,
      name: 'B8 L13',
      bbox: Rect.fromLTWH(3794.22, 2765.83, 202.70, 113.58),
      points: [
        Offset(3794.216, 2789.433),
        Offset(3808.512, 2879.415),
        Offset(3996.918, 2853.794),
        Offset(3981.266, 2765.831),
      ],
    ),
    // id 136: B8 L14
    Phase3LotAnnotation(
      id: 136,
      categoryId: 277,
      name: 'B8 L14',
      bbox: Rect.fromLTWH(3780.77, 2671.50, 201.36, 118.93),
      points: [
        Offset(3780.770, 2696.534),
        Offset(3796.112, 2790.431),
        Offset(3982.126, 2763.979),
        Offset(3970.437, 2671.499),
      ],
    ),
    // id 137: B8 L15
    Phase3LotAnnotation(
      id: 137,
      categoryId: 278,
      name: 'B8 L15',
      bbox: Rect.fromLTWH(3766.49, 2580.16, 202.09, 117.80),
      points: [
        Offset(3766.488, 2605.315),
        Offset(3781.434, 2697.961),
        Offset(3968.579, 2672.607),
        Offset(3953.204, 2580.161),
      ],
    ),
    // id 138: B8 L16
    Phase3LotAnnotation(
      id: 138,
      categoryId: 279,
      name: 'B8 L16',
      bbox: Rect.fromLTWH(3751.43, 2488.61, 203.29, 117.19),
      points: [
        Offset(3751.433, 2513.179),
        Offset(3766.083, 2605.802),
        Offset(3954.723, 2578.318),
        Offset(3939.715, 2488.608),
      ],
    ),
    // id 139: B8 L17
    Phase3LotAnnotation(
      id: 139,
      categoryId: 280,
      name: 'B8 L17',
      bbox: Rect.fromLTWH(3720.87, 2338.38, 217.93, 174.97),
      points: [
        Offset(3720.874, 2338.381),
        Offset(3750.321, 2513.356),
        Offset(3938.803, 2487.476),
        Offset(3926.441, 2400.822),
      ],
    ),
    // id 140: B9 L1
    Phase3LotAnnotation(
      id: 140,
      categoryId: 289,
      name: 'B9 L1',
      bbox: Rect.fromLTWH(3652.80, 3173.67, 209.21, 166.57),
      points: [
        Offset(3842.100, 3173.673),
        Offset(3652.799, 3199.831),
        Offset(3670.907, 3340.244),
        Offset(3862.007, 3315.470),
      ],
    ),
    // id 141: B9 L2
    Phase3LotAnnotation(
      id: 141,
      categoryId: 295,
      name: 'B9 L2',
      bbox: Rect.fromLTWH(3672.28, 3315.50, 203.76, 124.04),
      points: [
        Offset(3672.276, 3340.780),
        Offset(3676.888, 3390.167),
        Offset(3689.354, 3439.532),
        Offset(3876.033, 3400.770),
        Offset(3865.722, 3352.243),
        Offset(3862.633, 3315.497),
      ],
    ),
    // id 142: B9 L3
    Phase3LotAnnotation(
      id: 142,
      categoryId: 296,
      name: 'B9 L3',
      bbox: Rect.fromLTWH(3688.58, 3401.79, 205.14, 129.34),
      points: [
        Offset(3688.579, 3439.957),
        Offset(3706.761, 3531.131),
        Offset(3893.716, 3495.357),
        Offset(3876.203, 3401.789),
      ],
    ),
    // id 143: B9 L4
    Phase3LotAnnotation(
      id: 143,
      categoryId: 297,
      name: 'B9 L4',
      bbox: Rect.fromLTWH(3705.59, 3495.40, 204.08, 126.71),
      points: [
        Offset(3705.594, 3531.312),
        Offset(3723.669, 3622.114),
        Offset(3909.669, 3589.551),
        Offset(3893.000, 3495.404),
      ],
    ),
    // id 144: B9 L5
    Phase3LotAnnotation(
      id: 144,
      categoryId: 298,
      name: 'B9 L5',
      bbox: Rect.fromLTWH(3725.26, 3590.26, 202.30, 125.20),
      points: [
        Offset(3725.261, 3622.008),
        Offset(3740.975, 3715.454),
        Offset(3927.559, 3680.969),
        Offset(3909.876, 3590.256),
      ],
    ),
    // id 145: B9 L6
    Phase3LotAnnotation(
      id: 145,
      categoryId: 299,
      name: 'B9 L6',
      bbox: Rect.fromLTWH(3741.85, 3682.88, 201.59, 120.09),
      points: [
        Offset(3741.849, 3716.376),
        Offset(3744.693, 3745.559),
        Offset(3754.473, 3783.316),
        Offset(3762.884, 3802.977),
        Offset(3943.435, 3776.611),
        Offset(3928.433, 3682.884),
      ],
    ),
    // id 146: B9 L7
    Phase3LotAnnotation(
      id: 146,
      categoryId: 300,
      name: 'B9 L7',
      bbox: Rect.fromLTWH(3764.38, 3778.23, 199.30, 138.83),
      points: [
        Offset(3764.377, 3804.030),
        Offset(3781.229, 3835.249),
        Offset(3815.126, 3871.577),
        Offset(3847.865, 3894.101),
        Offset(3890.757, 3910.995),
        Offset(3928.206, 3917.056),
        Offset(3963.681, 3914.017),
        Offset(3943.330, 3778.227),
      ],
    ),
    // id 147: B9 L8
    Phase3LotAnnotation(
      id: 147,
      categoryId: 301,
      name: 'B9 L8',
      bbox: Rect.fromLTWH(3948.52, 3710.13, 183.98, 205.39),
      points: [
        Offset(3948.520, 3741.681),
        Offset(3974.205, 3915.522),
        Offset(4021.666, 3900.062),
        Offset(4061.827, 3874.649),
        Offset(4088.356, 3847.498),
        Offset(4115.679, 3803.612),
        Offset(4124.103, 3781.184),
        Offset(4132.496, 3743.309),
        Offset(4129.379, 3710.134),
      ],
    ),
    // id 148: B9 L9
    Phase3LotAnnotation(
      id: 148,
      categoryId: 302,
      name: 'B9 L9',
      bbox: Rect.fromLTWH(3929.70, 3617.91, 202.26, 122.12),
      points: [
        Offset(3929.698, 3648.257),
        Offset(3947.554, 3740.029),
        Offset(4131.960, 3706.092),
        Offset(4117.784, 3617.908),
      ],
    ),
    // id 149: B9 L10
    Phase3LotAnnotation(
      id: 149,
      categoryId: 290,
      name: 'B9 L10',
      bbox: Rect.fromLTWH(3913.72, 3522.37, 205.68, 124.55),
      points: [
        Offset(3913.721, 3557.020),
        Offset(3929.993, 3646.919),
        Offset(4119.399, 3614.238),
        Offset(4101.648, 3522.366),
      ],
    ),
    // id 150: B9 L11
    Phase3LotAnnotation(
      id: 150,
      categoryId: 291,
      name: 'B9 L11',
      bbox: Rect.fromLTWH(3897.43, 3432.00, 203.22, 125.36),
      points: [
        Offset(3897.426, 3464.250),
        Offset(3915.545, 3557.360),
        Offset(4100.650, 3521.436),
        Offset(4082.813, 3432.000),
      ],
    ),
    // id 151: B9 L12
    Phase3LotAnnotation(
      id: 151,
      categoryId: 292,
      name: 'B9 L12',
      bbox: Rect.fromLTWH(3874.20, 3340.96, 208.81, 124.42),
      points: [
        Offset(3874.199, 3364.375),
        Offset(3895.521, 3465.379),
        Offset(4083.012, 3430.562),
        Offset(4066.150, 3340.958),
      ],
    ),
    // id 152: B9 L13
    Phase3LotAnnotation(
      id: 152,
      categoryId: 293,
      name: 'B9 L13',
      bbox: Rect.fromLTWH(3865.35, 3247.97, 201.41, 116.88),
      points: [
        Offset(3865.353, 3273.483),
        Offset(3876.050, 3364.852),
        Offset(4066.767, 3340.391),
        Offset(4054.718, 3247.974),
      ],
    ),
    // id 153: B9 L14
    Phase3LotAnnotation(
      id: 153,
      categoryId: 294,
      name: 'B9 L14',
      bbox: Rect.fromLTWH(3852.75, 3147.84, 202.38, 125.07),
      points: [
        Offset(3852.751, 3178.036),
        Offset(3863.593, 3272.916),
        Offset(4055.136, 3248.632),
        Offset(4039.907, 3147.841),
      ],
    ),
    // id 154: B10 L1
    Phase3LotAnnotation(
      id: 154,
      categoryId: 7,
      name: 'B10 L1',
      bbox: Rect.fromLTWH(4004.45, 4013.60, 152.49, 199.50),
      points: [
        Offset(4004.447, 4050.125),
        Offset(4055.987, 4036.188),
        Offset(4098.136, 4013.600),
        Offset(4156.939, 4122.469),
        Offset(4035.990, 4213.105),
      ],
    ),
    // id 155: B10 L2
    Phase3LotAnnotation(
      id: 155,
      categoryId: 10,
      name: 'B10 L2',
      bbox: Rect.fromLTWH(4097.88, 3934.27, 185.88, 186.13),
      points: [
        Offset(4159.044, 4120.403),
        Offset(4283.758, 4029.348),
        Offset(4183.224, 3934.272),
        Offset(4162.698, 3959.745),
        Offset(4140.114, 3982.809),
        Offset(4097.875, 4012.921),
      ],
    ),
    // id 156: B10 L3
    Phase3LotAnnotation(
      id: 156,
      categoryId: 11,
      name: 'B10 L3',
      bbox: Rect.fromLTWH(4184.39, 3860.13, 212.20, 169.89),
      points: [
        Offset(4184.388, 3933.855),
        Offset(4202.364, 3906.120),
        Offset(4216.225, 3879.857),
        Offset(4222.778, 3860.127),
        Offset(4396.591, 3945.862),
        Offset(4282.064, 4030.016),
      ],
    ),
    // id 157: B10 L4
    Phase3LotAnnotation(
      id: 157,
      categoryId: 12,
      name: 'B10 L4',
      bbox: Rect.fromLTWH(4223.15, 3767.64, 240.56, 176.46),
      points: [
        Offset(4244.612, 3767.635),
        Offset(4240.732, 3799.931),
        Offset(4234.983, 3829.441),
        Offset(4223.148, 3857.890),
        Offset(4396.604, 3944.099),
        Offset(4463.704, 3893.592),
        Offset(4449.717, 3797.792),
      ],
    ),
    // id 158: B10 L5
    Phase3LotAnnotation(
      id: 158,
      categoryId: 13,
      name: 'B10 L5',
      bbox: Rect.fromLTWH(4237.18, 3642.38, 211.31, 155.16),
      points: [
        Offset(4423.846, 3642.381),
        Offset(4237.182, 3673.077),
        Offset(4240.855, 3698.280),
        Offset(4244.653, 3726.040),
        Offset(4244.249, 3765.092),
        Offset(4448.494, 3797.538),
      ],
    ),
    // id 159: B10 L6
    Phase3LotAnnotation(
      id: 159,
      categoryId: 14,
      name: 'B10 L6',
      bbox: Rect.fromLTWH(4219.02, 3549.11, 205.56, 124.59),
      points: [
        Offset(4409.116, 3549.106),
        Offset(4219.023, 3581.100),
        Offset(4236.184, 3673.695),
        Offset(4424.586, 3641.867),
      ],
    ),
    // id 160: B10 L7
    Phase3LotAnnotation(
      id: 160,
      categoryId: 15,
      name: 'B10 L7',
      bbox: Rect.fromLTWH(4204.77, 3456.07, 203.06, 125.37),
      points: [
        Offset(4391.560, 3456.075),
        Offset(4204.767, 3489.938),
        Offset(4220.209, 3581.448),
        Offset(4407.824, 3548.820),
      ],
    ),
    // id 161: B10 L8
    Phase3LotAnnotation(
      id: 161,
      categoryId: 16,
      name: 'B10 L8',
      bbox: Rect.fromLTWH(4186.26, 3363.73, 206.06, 126.25),
      points: [
        Offset(4373.091, 3363.731),
        Offset(4186.257, 3398.024),
        Offset(4205.532, 3489.979),
        Offset(4392.322, 3455.404),
      ],
    ),
    // id 162: B10 L9
    Phase3LotAnnotation(
      id: 162,
      categoryId: 17,
      name: 'B10 L9',
      bbox: Rect.fromLTWH(4166.69, 3270.58, 207.79, 127.57),
      points: [
        Offset(4356.228, 3270.584),
        Offset(4166.688, 3300.919),
        Offset(4187.026, 3398.156),
        Offset(4374.481, 3361.607),
      ],
    ),
    // id 163: B10 L10
    Phase3LotAnnotation(
      id: 163,
      categoryId: 8,
      name: 'B10 L10',
      bbox: Rect.fromLTWH(4155.68, 3178.24, 202.50, 123.74),
      points: [
        Offset(4345.789, 3178.240),
        Offset(4155.684, 3207.621),
        Offset(4168.661, 3301.982),
        Offset(4358.182, 3270.938),
      ],
    ),
    // id 164: B10 L11
    Phase3LotAnnotation(
      id: 164,
      categoryId: 9,
      name: 'B10 L11',
      bbox: Rect.fromLTWH(4138.09, 3047.26, 204.50, 160.67),
      points: [
        Offset(4138.091, 3074.761),
        Offset(4156.152, 3207.929),
        Offset(4342.593, 3179.466),
        Offset(4326.041, 3047.261),
      ],
    ),
    // id 165: B11 L1
    Phase3LotAnnotation(
      id: 165,
      categoryId: 18,
      name: 'B11 L1',
      bbox: Rect.fromLTWH(4118.35, 2899.60, 205.76, 160.44),
      points: [
        Offset(4305.640, 2899.602),
        Offset(4118.345, 2929.024),
        Offset(4136.384, 3060.043),
        Offset(4324.102, 3031.766),
      ],
    ),
    // id 166: B11 L2
    Phase3LotAnnotation(
      id: 166,
      categoryId: 20,
      name: 'B11 L2',
      bbox: Rect.fromLTWH(4103.33, 2808.86, 202.88, 119.75),
      points: [
        Offset(4291.989, 2808.864),
        Offset(4103.330, 2835.795),
        Offset(4118.524, 2928.616),
        Offset(4306.214, 2899.837),
      ],
    ),
    // id 167: B11 L3
    Phase3LotAnnotation(
      id: 167,
      categoryId: 21,
      name: 'B11 L3',
      bbox: Rect.fromLTWH(4090.47, 2715.99, 202.43, 122.47),
      points: [
        Offset(4278.674, 2715.987),
        Offset(4090.469, 2745.525),
        Offset(4104.685, 2838.458),
        Offset(4292.895, 2807.355),
      ],
    ),
    // id 168: B11 L4
    Phase3LotAnnotation(
      id: 168,
      categoryId: 22,
      name: 'B11 L4',
      bbox: Rect.fromLTWH(4074.09, 2623.57, 204.89, 121.88),
      points: [
        Offset(4263.903, 2623.570),
        Offset(4074.086, 2652.271),
        Offset(4090.102, 2745.449),
        Offset(4278.978, 2715.086),
      ],
    ),
    // id 169: B11 L5
    Phase3LotAnnotation(
      id: 169,
      categoryId: 23,
      name: 'B11 L5',
      bbox: Rect.fromLTWH(4043.20, 2442.72, 220.55, 210.74),
      points: [
        Offset(4043.203, 2442.715),
        Offset(4075.564, 2653.450),
        Offset(4263.752, 2623.868),
        Offset(4241.347, 2483.147),
        Offset(4076.815, 2453.437),
      ],
    ),
    // id 170: B11 L6
    Phase3LotAnnotation(
      id: 170,
      categoryId: 24,
      name: 'B11 L6',
      bbox: Rect.fromLTWH(4249.41, 2485.93, 214.88, 160.28),
      points: [
        Offset(4249.410, 2485.932),
        Offset(4274.670, 2646.213),
        Offset(4464.289, 2617.549),
        Offset(4448.618, 2517.301),
      ],
    ),
    // id 171: B11 L7
    Phase3LotAnnotation(
      id: 171,
      categoryId: 25,
      name: 'B11 L7',
      bbox: Rect.fromLTWH(4275.73, 2618.91, 199.99, 122.79),
      points: [
        Offset(4275.730, 2645.670),
        Offset(4290.940, 2741.703),
        Offset(4475.722, 2715.935),
        Offset(4463.292, 2618.914),
      ],
    ),
    // id 172: B11 L8
    Phase3LotAnnotation(
      id: 172,
      categoryId: 26,
      name: 'B11 L8',
      bbox: Rect.fromLTWH(4291.16, 2715.48, 199.87, 121.19),
      points: [
        Offset(4291.159, 2740.969),
        Offset(4306.635, 2836.668),
        Offset(4491.031, 2810.046),
        Offset(4474.662, 2715.482),
      ],
    ),
    // id 173: B11 L9
    Phase3LotAnnotation(
      id: 173,
      categoryId: 27,
      name: 'B11 L9',
      bbox: Rect.fromLTWH(4306.16, 2813.74, 197.00, 118.02),
      points: [
        Offset(4306.156, 2837.735),
        Offset(4321.422, 2931.758),
        Offset(4503.160, 2907.040),
        Offset(4488.631, 2813.741),
      ],
    ),
    // id 174: B11 L10
    Phase3LotAnnotation(
      id: 174,
      categoryId: 19,
      name: 'B11 L10',
      bbox: Rect.fromLTWH(4321.07, 2908.93, 196.04, 122.16),
      points: [
        Offset(4321.075, 2932.396),
        Offset(4333.391, 3031.094),
        Offset(4517.118, 2997.984),
        Offset(4505.032, 2908.933),
      ],
    ),
    // id 175: B12 L1
    Phase3LotAnnotation(
      id: 175,
      categoryId: 28,
      name: 'B12 L1',
      bbox: Rect.fromLTWH(4018.71, 2272.48, 217.33, 167.82),
      points: [
        Offset(4236.039, 2440.305),
        Offset(4205.801, 2272.482),
        Offset(4018.713, 2306.733),
        Offset(4034.359, 2397.513),
        Offset(4077.202, 2411.885),
      ],
    ),
    // id 176: B12 L2
    Phase3LotAnnotation(
      id: 176,
      categoryId: 31,
      name: 'B12 L2',
      bbox: Rect.fromLTWH(4001.59, 2180.98, 203.97, 125.45),
      points: [
        Offset(4205.557, 2271.794),
        Offset(4189.345, 2180.978),
        Offset(4001.588, 2215.842),
        Offset(4017.560, 2306.430),
      ],
    ),
    // id 177: B12 L3
    Phase3LotAnnotation(
      id: 177,
      categoryId: 32,
      name: 'B12 L3',
      bbox: Rect.fromLTWH(3987.68, 2088.81, 200.16, 124.54),
      points: [
        Offset(4171.582, 2088.812),
        Offset(3987.684, 2124.436),
        Offset(4003.928, 2213.348),
        Offset(4187.842, 2179.455),
      ],
    ),
    // id 178: B12 L4
    Phase3LotAnnotation(
      id: 178,
      categoryId: 33,
      name: 'B12 L4',
      bbox: Rect.fromLTWH(3969.10, 1997.16, 203.27, 126.74),
      points: [
        Offset(4153.454, 1997.163),
        Offset(3969.095, 2031.291),
        Offset(3985.926, 2123.901),
        Offset(4172.365, 2087.904),
      ],
    ),
    // id 179: B12 L5
    Phase3LotAnnotation(
      id: 179,
      categoryId: 34,
      name: 'B12 L5',
      bbox: Rect.fromLTWH(3955.40, 1789.97, 199.79, 240.58),
      points: [
        Offset(4155.192, 1995.184),
        Offset(4116.465, 1789.967),
        Offset(4088.890, 1795.691),
        Offset(4050.918, 1810.436),
        Offset(4024.614, 1827.597),
        Offset(3999.337, 1853.460),
        Offset(3977.676, 1880.657),
        Offset(3964.540, 1911.276),
        Offset(3955.401, 1947.097),
        Offset(3955.944, 1974.514),
        Offset(3967.073, 2030.544),
      ],
    ),
    // id 180: B12 L6
    Phase3LotAnnotation(
      id: 180,
      categoryId: 35,
      name: 'B12 L6',
      bbox: Rect.fromLTWH(4123.33, 1781.56, 219.81, 167.85),
      points: [
        Offset(4123.330, 1788.106),
        Offset(4154.354, 1949.418),
        Offset(4343.138, 1914.557),
        Offset(4333.445, 1881.046),
        Offset(4318.778, 1854.046),
        Offset(4285.708, 1820.110),
        Offset(4250.816, 1799.295),
        Offset(4211.250, 1788.806),
        Offset(4180.206, 1782.452),
        Offset(4157.285, 1781.563),
      ],
    ),
    // id 181: B12 L7
    Phase3LotAnnotation(
      id: 181,
      categoryId: 36,
      name: 'B12 L7',
      bbox: Rect.fromLTWH(4155.69, 1914.88, 204.62, 124.84),
      points: [
        Offset(4155.688, 1946.640),
        Offset(4171.425, 2039.726),
        Offset(4360.311, 2006.734),
        Offset(4342.466, 1914.884),
      ],
    ),
    // id 182: B12 L8
    Phase3LotAnnotation(
      id: 182,
      categoryId: 37,
      name: 'B12 L8',
      bbox: Rect.fromLTWH(4173.60, 2006.95, 201.42, 123.60),
      points: [
        Offset(4173.596, 2039.463),
        Offset(4188.766, 2130.550),
        Offset(4375.021, 2098.636),
        Offset(4359.937, 2006.951),
      ],
    ),
    // id 183: B12 L9
    Phase3LotAnnotation(
      id: 183,
      categoryId: 38,
      name: 'B12 L9',
      bbox: Rect.fromLTWH(4188.70, 2099.23, 202.76, 123.14),
      points: [
        Offset(4188.703, 2131.112),
        Offset(4205.750, 2222.373),
        Offset(4391.462, 2187.780),
        Offset(4376.594, 2099.234),
      ],
    ),
    // id 184: B12 L10
    Phase3LotAnnotation(
      id: 184,
      categoryId: 29,
      name: 'B12 L10',
      bbox: Rect.fromLTWH(4206.83, 2189.46, 203.70, 125.09),
      points: [
        Offset(4206.832, 2221.755),
        Offset(4222.399, 2314.546),
        Offset(4410.534, 2281.629),
        Offset(4393.299, 2189.456),
      ],
    ),
    // id 185: B12 L11
    Phase3LotAnnotation(
      id: 185,
      categoryId: 30,
      name: 'B12 L11',
      bbox: Rect.fromLTWH(4221.94, 2280.21, 223.00, 200.76),
      points: [
        Offset(4221.939, 2315.419),
        Offset(4245.607, 2444.766),
        Offset(4444.935, 2480.968),
        Offset(4408.681, 2280.209),
      ],
    ),
    // id 186: B13 L1
    Phase3LotAnnotation(
      id: 186,
      categoryId: 39,
      name: 'B13 L1',
      bbox: Rect.fromLTWH(4334.29, 3012.73, 206.10, 163.79),
      points: [
        Offset(4518.058, 3012.727),
        Offset(4334.291, 3046.205),
        Offset(4351.859, 3176.517),
        Offset(4540.393, 3105.899),
      ],
    ),
    // id 187: B13 L2
    Phase3LotAnnotation(
      id: 187,
      categoryId: 47,
      name: 'B13 L2',
      bbox: Rect.fromLTWH(4352.86, 3109.42, 231.25, 239.79),
      points: [
        Offset(4352.864, 3176.888),
        Offset(4366.116, 3276.699),
        Offset(4379.825, 3349.201),
        Offset(4584.115, 3193.751),
        Offset(4556.993, 3151.077),
        Offset(4544.035, 3109.415),
      ],
    ),
    // id 188: B13 L3
    Phase3LotAnnotation(
      id: 188,
      categoryId: 48,
      name: 'B13 L3',
      bbox: Rect.fromLTWH(4379.71, 3193.01, 266.81, 392.13),
      points: [
        Offset(4379.708, 3350.342),
        Offset(4423.781, 3585.139),
        Offset(4646.519, 3267.342),
        Offset(4624.906, 3246.386),
        Offset(4599.751, 3220.740),
        Offset(4584.668, 3193.013),
      ],
    ),
    // id 189: B13 L4
    Phase3LotAnnotation(
      id: 189,
      categoryId: 49,
      name: 'B13 L4',
      bbox: Rect.fromLTWH(4423.07, 3269.47, 308.64, 619.96),
      points: [
        Offset(4423.071, 3584.711),
        Offset(4472.553, 3889.425),
        Offset(4579.026, 3809.066),
        Offset(4731.713, 3316.638),
        Offset(4697.690, 3303.147),
        Offset(4672.399, 3287.382),
        Offset(4649.539, 3269.467),
      ],
    ),
    // id 190: B13 L5
    Phase3LotAnnotation(
      id: 190,
      categoryId: 50,
      name: 'B13 L5',
      bbox: Rect.fromLTWH(4577.94, 3316.81, 254.52, 492.98),
      points: [
        Offset(4577.941, 3809.788),
        Offset(4730.983, 3316.807),
        Offset(4772.620, 3331.169),
        Offset(4831.003, 3336.936),
        Offset(4832.463, 3623.602),
      ],
    ),
    // id 191: B13 L6
    Phase3LotAnnotation(
      id: 191,
      categoryId: 51,
      name: 'B13 L6',
      bbox: Rect.fromLTWH(4828.83, 3319.58, 172.94, 303.60),
      points: [
        Offset(4828.829, 3337.953),
        Offset(4870.253, 3337.372),
        Offset(4893.894, 3332.859),
        Offset(4931.055, 3319.582),
        Offset(5001.767, 3539.335),
        Offset(4969.825, 3520.852),
        Offset(4833.189, 3623.183),
      ],
    ),
    // id 192: B13 L7
    Phase3LotAnnotation(
      id: 192,
      categoryId: 52,
      name: 'B13 L7',
      bbox: Rect.fromLTWH(4931.80, 3268.47, 365.63, 391.88),
      points: [
        Offset(4931.797, 3319.030),
        Offset(4967.353, 3305.987),
        Offset(4982.795, 3297.400),
        Offset(5018.403, 3268.467),
        Offset(5297.426, 3660.343),
        Offset(5192.978, 3650.769),
        Offset(4999.064, 3540.053),
      ],
    ),
    // id 193: B13 L8
    Phase3LotAnnotation(
      id: 193,
      categoryId: 53,
      name: 'B13 L8',
      bbox: Rect.fromLTWH(5018.80, 3195.11, 385.28, 472.76),
      points: [
        Offset(5018.802, 3268.778),
        Offset(5047.917, 3239.038),
        Offset(5066.723, 3220.663),
        Offset(5081.121, 3195.106),
        Offset(5375.179, 3414.036),
        Offset(5404.084, 3667.869),
        Offset(5298.511, 3659.722),
      ],
    ),
    // id 194: B13 L9
    Phase3LotAnnotation(
      id: 194,
      categoryId: 54,
      name: 'B13 L9',
      bbox: Rect.fromLTWH(5083.50, 3104.81, 292.91, 307.84),
      points: [
        Offset(5083.505, 3195.614),
        Offset(5104.662, 3153.347),
        Offset(5117.697, 3104.810),
        Offset(5346.904, 3184.842),
        Offset(5376.418, 3412.653),
      ],
    ),
    // id 195: B13 L10
    Phase3LotAnnotation(
      id: 195,
      categoryId: 40,
      name: 'B13 L10',
      bbox: Rect.fromLTWH(5118.58, 3011.69, 227.75, 170.68),
      points: [
        Offset(5130.308, 3011.694),
        Offset(5130.179, 3052.582),
        Offset(5118.584, 3102.862),
        Offset(5346.339, 3182.373),
        Offset(5326.323, 3016.877),
      ],
    ),
    // id 196: B13 L11
    Phase3LotAnnotation(
      id: 196,
      categoryId: 41,
      name: 'B13 L11',
      bbox: Rect.fromLTWH(5119.98, 2892.59, 206.86, 125.08),
      points: [
        Offset(5119.984, 2918.773),
        Offset(5130.998, 2988.214),
        Offset(5131.240, 3012.461),
        Offset(5326.843, 3017.671),
        Offset(5309.344, 2892.594),
      ],
    ),
    // id 197: B13 L12
    Phase3LotAnnotation(
      id: 197,
      categoryId: 42,
      name: 'B13 L12',
      bbox: Rect.fromLTWH(5107.59, 2800.00, 201.39, 118.44),
      points: [
        Offset(5107.594, 2825.851),
        Offset(5121.589, 2918.438),
        Offset(5308.981, 2892.396),
        Offset(5296.430, 2799.995),
      ],
    ),
    // id 198: B13 L13
    Phase3LotAnnotation(
      id: 198,
      categoryId: 43,
      name: 'B13 L13',
      bbox: Rect.fromLTWH(5094.52, 2707.40, 201.77, 119.73),
      points: [
        Offset(5094.523, 2736.341),
        Offset(5108.945, 2827.125),
        Offset(5296.289, 2799.802),
        Offset(5283.379, 2707.400),
      ],
    ),
    // id 199: B13 L14
    Phase3LotAnnotation(
      id: 199,
      categoryId: 44,
      name: 'B13 L14',
      bbox: Rect.fromLTWH(5081.90, 2618.13, 201.25, 117.86),
      points: [
        Offset(5081.899, 2644.315),
        Offset(5096.874, 2735.994),
        Offset(5283.153, 2708.227),
        Offset(5268.356, 2618.132),
      ],
    ),
    // id 200: B13 L15
    Phase3LotAnnotation(
      id: 200,
      categoryId: 45,
      name: 'B13 L15',
      bbox: Rect.fromLTWH(5066.11, 2524.37, 204.14, 120.73),
      points: [
        Offset(5255.236, 2524.372),
        Offset(5066.110, 2552.103),
        Offset(5080.835, 2645.097),
        Offset(5270.251, 2615.067),
      ],
    ),
    // id 201: B13 L16
    Phase3LotAnnotation(
      id: 201,
      categoryId: 46,
      name: 'B13 L16',
      bbox: Rect.fromLTWH(5048.70, 2405.84, 206.51, 148.12),
      points: [
        Offset(5048.699, 2437.480),
        Offset(5067.534, 2553.958),
        Offset(5255.212, 2523.243),
        Offset(5235.833, 2405.836),
      ],
    ),
    // id 202: B14 L1
    Phase3LotAnnotation(
      id: 202,
      categoryId: 55,
      name: 'B14 L1',
      bbox: Rect.fromLTWH(4559.43, 2487.03, 210.07, 175.32),
      points: [
        Offset(4744.358, 2487.026),
        Offset(4559.434, 2516.986),
        Offset(4580.648, 2662.349),
        Offset(4769.507, 2633.833),
      ],
    ),
    // id 203: B14 L2
    Phase3LotAnnotation(
      id: 203,
      categoryId: 60,
      name: 'B14 L2',
      bbox: Rect.fromLTWH(4580.67, 2632.10, 200.86, 124.76),
      points: [
        Offset(4580.669, 2662.596),
        Offset(4596.582, 2756.858),
        Offset(4781.527, 2725.202),
        Offset(4767.862, 2632.100),
      ],
    ),
    // id 204: B14 L3
    Phase3LotAnnotation(
      id: 204,
      categoryId: 61,
      name: 'B14 L3',
      bbox: Rect.fromLTWH(4595.02, 2723.67, 200.04, 123.15),
      points: [
        Offset(4595.020, 2756.915),
        Offset(4609.489, 2846.819),
        Offset(4795.058, 2818.809),
        Offset(4780.196, 2723.670),
      ],
    ),
    // id 205: B14 L4
    Phase3LotAnnotation(
      id: 205,
      categoryId: 62,
      name: 'B14 L4',
      bbox: Rect.fromLTWH(4607.07, 2821.54, 201.98, 117.28),
      points: [
        Offset(4607.070, 2846.087),
        Offset(4622.421, 2938.812),
        Offset(4809.053, 2913.236),
        Offset(4797.796, 2821.537),
      ],
    ),
    // id 206: B14 L5
    Phase3LotAnnotation(
      id: 206,
      categoryId: 63,
      name: 'B14 L5',
      bbox: Rect.fromLTWH(4622.19, 2915.08, 201.50, 116.50),
      points: [
        Offset(4622.189, 2939.348),
        Offset(4632.714, 3031.584),
        Offset(4823.692, 3007.121),
        Offset(4810.507, 2915.082),
      ],
    ),
    // id 207: B14 L6
    Phase3LotAnnotation(
      id: 207,
      categoryId: 64,
      name: 'B14 L6',
      bbox: Rect.fromLTWH(4634.79, 3009.03, 212.86, 190.55),
      points: [
        Offset(4634.792, 3032.218),
        Offset(4647.157, 3087.924),
        Offset(4673.997, 3123.530),
        Offset(4705.942, 3158.775),
        Offset(4753.563, 3186.652),
        Offset(4808.949, 3199.579),
        Offset(4847.649, 3197.810),
        Offset(4821.072, 3009.029),
      ],
    ),
    // id 208: B14 L7
    Phase3LotAnnotation(
      id: 208,
      categoryId: 65,
      name: 'B14 L7',
      bbox: Rect.fromLTWH(4838.08, 3030.08, 181.30, 170.22),
      points: [
        Offset(4838.084, 3057.299),
        Offset(4856.864, 3200.306),
        Offset(4918.011, 3179.128),
        Offset(4959.753, 3148.395),
        Offset(4991.084, 3105.673),
        Offset(5011.808, 3064.343),
        Offset(5019.388, 3030.083),
      ],
    ),
    // id 209: B14 L8
    Phase3LotAnnotation(
      id: 209,
      categoryId: 66,
      name: 'B14 L8',
      bbox: Rect.fromLTWH(4823.56, 2938.46, 199.39, 118.08),
      points: [
        Offset(4823.563, 2963.574),
        Offset(4838.161, 3056.536),
        Offset(5018.326, 3029.428),
        Offset(5022.957, 2987.588),
        Offset(5014.160, 2938.456),
      ],
    ),
    // id 210: B14 L9
    Phase3LotAnnotation(
      id: 210,
      categoryId: 67,
      name: 'B14 L9',
      bbox: Rect.fromLTWH(4812.14, 2842.71, 204.02, 123.49),
      points: [
        Offset(4812.141, 2871.664),
        Offset(4825.837, 2966.199),
        Offset(5016.160, 2938.183),
        Offset(5002.325, 2842.709),
      ],
    ),
    // id 211: B14 L10
    Phase3LotAnnotation(
      id: 211,
      categoryId: 56,
      name: 'B14 L10',
      bbox: Rect.fromLTWH(4800.18, 2751.84, 197.53, 117.12),
      points: [
        Offset(4800.183, 2779.464),
        Offset(4811.419, 2868.961),
        Offset(4997.715, 2844.808),
        Offset(4989.222, 2751.841),
      ],
    ),
    // id 212: B14 L11
    Phase3LotAnnotation(
      id: 212,
      categoryId: 57,
      name: 'B14 L11',
      bbox: Rect.fromLTWH(4785.28, 2660.38, 202.51, 119.54),
      points: [
        Offset(4785.281, 2687.678),
        Offset(4798.157, 2779.923),
        Offset(4987.794, 2752.980),
        Offset(4973.428, 2660.379),
      ],
    ),
    // id 213: B14 L12
    Phase3LotAnnotation(
      id: 213,
      categoryId: 58,
      name: 'B14 L12',
      bbox: Rect.fromLTWH(4770.37, 2568.77, 199.90, 121.80),
      points: [
        Offset(4770.373, 2596.505),
        Offset(4782.909, 2690.571),
        Offset(4970.272, 2664.612),
        Offset(4959.129, 2568.768),
      ],
    ),
    // id 214: B14 L13
    Phase3LotAnnotation(
      id: 214,
      categoryId: 59,
      name: 'B14 L13',
      bbox: Rect.fromLTWH(4755.68, 2455.89, 206.27, 138.13),
      points: [
        Offset(4755.677, 2486.247),
        Offset(4770.311, 2594.014),
        Offset(4961.944, 2569.546),
        Offset(4941.622, 2455.886),
      ],
    ),
    // id 215: B15 L1
    Phase3LotAnnotation(
      id: 215,
      categoryId: 68,
      name: 'B15 L1',
      bbox: Rect.fromLTWH(4727.01, 2291.79, 207.90, 153.16),
      points: [
        Offset(4934.909, 2413.196),
        Offset(4915.723, 2291.792),
        Offset(4727.005, 2325.875),
        Offset(4748.038, 2444.948),
      ],
    ),
    // id 216: B15 L2
    Phase3LotAnnotation(
      id: 216,
      categoryId: 78,
      name: 'B15 L2',
      bbox: Rect.fromLTWH(4711.42, 2198.62, 202.90, 129.41),
      points: [
        Offset(4711.417, 2233.628),
        Offset(4729.599, 2328.029),
        Offset(4914.315, 2292.745),
        Offset(4898.434, 2198.616),
      ],
    ),
    // id 217: B15 L3
    Phase3LotAnnotation(
      id: 217,
      categoryId: 79,
      name: 'B15 L3',
      bbox: Rect.fromLTWH(4692.04, 2110.07, 205.66, 125.62),
      points: [
        Offset(4692.039, 2143.197),
        Offset(4711.533, 2235.697),
        Offset(4897.702, 2197.980),
        Offset(4883.033, 2110.073),
      ],
    ),
    // id 218: B15 L4
    Phase3LotAnnotation(
      id: 218,
      categoryId: 80,
      name: 'B15 L4',
      bbox: Rect.fromLTWH(4677.80, 2017.12, 204.87, 126.19),
      points: [
        Offset(4677.798, 2037.911),
        Offset(4697.802, 2143.313),
        Offset(4882.669, 2108.050),
        Offset(4866.905, 2017.125),
      ],
    ),
    // id 219: B15 L5
    Phase3LotAnnotation(
      id: 219,
      categoryId: 81,
      name: 'B15 L5',
      bbox: Rect.fromLTWH(4645.88, 1878.61, 221.80, 159.59),
      points: [
        Offset(4645.875, 1878.608),
        Offset(4677.016, 2038.193),
        Offset(4867.409, 2014.884),
        Offset(4867.672, 1924.328),
      ],
    ),
    // id 220: B15 L6
    Phase3LotAnnotation(
      id: 220,
      categoryId: 82,
      name: 'B15 L6',
      bbox: Rect.fromLTWH(4606.78, 1671.67, 285.72, 252.27),
      points: [
        Offset(4606.776, 1671.668),
        Offset(4647.208, 1880.238),
        Offset(4867.238, 1923.939),
        Offset(4892.500, 1836.375),
      ],
    ),
    // id 221: B15 L7
    Phase3LotAnnotation(
      id: 221,
      categoryId: 83,
      name: 'B15 L7',
      bbox: Rect.fromLTWH(4554.96, 1417.99, 389.37, 417.08),
      points: [
        Offset(4554.956, 1417.994),
        Offset(4606.630, 1670.109),
        Offset(4897.263, 1835.073),
        Offset(4916.349, 1788.910),
        Offset(4944.325, 1750.179),
        Offset(4641.298, 1421.683),
      ],
    ),
    // id 222: B15 L8
    Phase3LotAnnotation(
      id: 222,
      categoryId: 84,
      name: 'B15 L8',
      bbox: Rect.fromLTWH(4641.66, 1422.34, 385.01, 330.03),
      points: [
        Offset(4641.657, 1422.339),
        Offset(4915.602, 1451.885),
        Offset(5026.666, 1686.883),
        Offset(4991.594, 1712.453),
        Offset(4963.673, 1730.185),
        Offset(4950.921, 1752.364),
      ],
    ),
    // id 223: B15 L9
    Phase3LotAnnotation(
      id: 223,
      categoryId: 85,
      name: 'B15 L9',
      bbox: Rect.fromLTWH(4916.82, 1449.47, 203.10, 239.42),
      points: [
        Offset(4916.823, 1449.468),
        Offset(5023.871, 1688.886),
        Offset(5063.949, 1669.922),
        Offset(5089.766, 1661.444),
        Offset(5119.923, 1657.639),
        Offset(5100.883, 1491.701),
      ],
    ),
    // id 224: B15 L10
    Phase3LotAnnotation(
      id: 224,
      categoryId: 69,
      name: 'B15 L10',
      bbox: Rect.fromLTWH(5102.85, 1495.98, 145.10, 167.42),
      points: [
        Offset(5102.851, 1495.975),
        Offset(5120.750, 1654.031),
        Offset(5144.746, 1652.749),
        Offset(5179.555, 1654.384),
        Offset(5218.735, 1663.392),
        Offset(5247.948, 1530.578),
      ],
    ),
    // id 225: B15 L11
    Phase3LotAnnotation(
      id: 225,
      categoryId: 70,
      name: 'B15 L11',
      bbox: Rect.fromLTWH(5223.58, 1532.15, 166.48, 167.52),
      points: [
        Offset(5247.539, 1532.147),
        Offset(5223.579, 1664.623),
        Offset(5249.790, 1668.418),
        Offset(5288.687, 1685.354),
        Offset(5312.042, 1699.670),
        Offset(5390.063, 1564.600),
      ],
    ),
    // id 226: B15 L12
    Phase3LotAnnotation(
      id: 226,
      categoryId: 71,
      name: 'B15 L12',
      bbox: Rect.fromLTWH(5313.76, 1564.44, 192.24, 201.87),
      points: [
        Offset(5383.185, 1564.444),
        Offset(5447.011, 1579.588),
        Offset(5505.992, 1652.770),
        Offset(5388.191, 1766.312),
        Offset(5366.587, 1741.080),
        Offset(5335.976, 1712.468),
        Offset(5313.757, 1701.658),
      ],
    ),
    // id 227: B15 L13
    Phase3LotAnnotation(
      id: 227,
      categoryId: 72,
      name: 'B15 L13',
      bbox: Rect.fromLTWH(5386.75, 1656.19, 234.39, 188.22),
      points: [
        Offset(5507.158, 1656.186),
        Offset(5386.747, 1764.627),
        Offset(5413.503, 1799.502),
        Offset(5438.018, 1844.409),
        Offset(5621.134, 1737.351),
        Offset(5555.164, 1717.393),
      ],
    ),
    // id 228: B15 L14
    Phase3LotAnnotation(
      id: 228,
      categoryId: 73,
      name: 'B15 L14',
      bbox: Rect.fromLTWH(5438.73, 1736.32, 216.02, 198.93),
      points: [
        Offset(5438.735, 1846.069),
        Offset(5458.143, 1894.479),
        Offset(5464.254, 1935.248),
        Offset(5654.753, 1902.755),
        Offset(5622.315, 1736.317),
      ],
    ),
    // id 229: B15 L15
    Phase3LotAnnotation(
      id: 229,
      categoryId: 74,
      name: 'B15 L15',
      bbox: Rect.fromLTWH(5465.86, 1904.05, 205.19, 124.01),
      points: [
        Offset(5465.864, 1936.500),
        Offset(5480.680, 2028.055),
        Offset(5671.058, 1996.294),
        Offset(5652.563, 1904.047),
      ],
    ),
    // id 230: B15 L16
    Phase3LotAnnotation(
      id: 230,
      categoryId: 75,
      name: 'B15 L16',
      bbox: Rect.fromLTWH(5482.66, 1994.16, 203.41, 126.57),
      points: [
        Offset(5482.658, 2028.222),
        Offset(5497.499, 2120.731),
        Offset(5686.071, 2088.904),
        Offset(5669.090, 1994.164),
      ],
    ),
    // id 231: B15 L17
    Phase3LotAnnotation(
      id: 231,
      categoryId: 76,
      name: 'B15 L17',
      bbox: Rect.fromLTWH(5496.87, 2088.45, 204.60, 125.96),
      points: [
        Offset(5496.869, 2119.944),
        Offset(5516.363, 2214.411),
        Offset(5701.467, 2179.122),
        Offset(5686.646, 2088.450),
      ],
    ),
    // id 232: B15 L18
    Phase3LotAnnotation(
      id: 232,
      categoryId: 77,
      name: 'B15 L18',
      bbox: Rect.fromLTWH(5514.95, 2181.34, 204.95, 139.44),
      points: [
        Offset(5514.955, 2215.542),
        Offset(5534.635, 2320.783),
        Offset(5719.901, 2286.115),
        Offset(5702.744, 2181.343),
      ],
    ),
    // id 233: B16 L1
    Phase3LotAnnotation(
      id: 233,
      categoryId: 86,
      name: 'B16 L1',
      bbox: Rect.fromLTWH(5022.81, 2276.32, 205.78, 124.69),
      points: [
        Offset(5228.585, 2367.638),
        Offset(5212.139, 2276.320),
        Offset(5022.806, 2308.212),
        Offset(5042.017, 2401.014),
      ],
    ),
    // id 234: B16 L2
    Phase3LotAnnotation(
      id: 234,
      categoryId: 88,
      name: 'B16 L2',
      bbox: Rect.fromLTWH(5009.72, 2185.25, 202.43, 122.45),
      points: [
        Offset(5212.154, 2275.548),
        Offset(5197.984, 2185.248),
        Offset(5009.721, 2211.060),
        Offset(5027.439, 2307.698),
      ],
    ),
    // id 235: B16 L3
    Phase3LotAnnotation(
      id: 235,
      categoryId: 89,
      name: 'B16 L3',
      bbox: Rect.fromLTWH(4994.76, 2091.63, 205.43, 121.89),
      points: [
        Offset(5200.190, 2183.154),
        Offset(5182.946, 2091.629),
        Offset(4994.764, 2122.457),
        Offset(5011.119, 2213.518),
      ],
    ),
    // id 236: B16 L4
    Phase3LotAnnotation(
      id: 236,
      categoryId: 90,
      name: 'B16 L4',
      bbox: Rect.fromLTWH(4978.45, 1998.90, 203.20, 125.24),
      points: [
        Offset(5181.654, 2091.523),
        Offset(5165.168, 1998.898),
        Offset(4978.454, 2031.260),
        Offset(4994.541, 2124.137),
      ],
    ),
    // id 237: B16 L5
    Phase3LotAnnotation(
      id: 237,
      categoryId: 91,
      name: 'B16 L5',
      bbox: Rect.fromLTWH(4972.68, 1797.90, 192.18, 235.22),
      points: [
        Offset(5164.860, 1998.509),
        Offset(5127.719, 1797.902),
        Offset(5085.461, 1811.886),
        Offset(5043.107, 1838.984),
        Offset(5008.207, 1880.495),
        Offset(4987.280, 1918.671),
        Offset(4972.681, 1971.410),
        Offset(4973.665, 2033.122),
      ],
    ),
    // id 238: B16 L6
    Phase3LotAnnotation(
      id: 238,
      categoryId: 92,
      name: 'B16 L6',
      bbox: Rect.fromLTWH(5136.52, 1796.81, 220.79, 166.45),
      points: [
        Offset(5136.515, 1797.483),
        Offset(5167.792, 1963.255),
        Offset(5357.302, 1927.896),
        Offset(5335.689, 1888.529),
        Offset(5303.584, 1849.319),
        Offset(5255.997, 1815.928),
        Offset(5208.627, 1797.135),
        Offset(5173.646, 1796.807),
      ],
    ),
    // id 239: B16 L7
    Phase3LotAnnotation(
      id: 239,
      categoryId: 93,
      name: 'B16 L7',
      bbox: Rect.fromLTWH(5167.44, 1932.94, 202.70, 121.28),
      points: [
        Offset(5167.444, 1961.045),
        Offset(5186.469, 2054.226),
        Offset(5370.140, 2020.824),
        Offset(5355.092, 1932.942),
      ],
    ),
    // id 240: B16 L8
    Phase3LotAnnotation(
      id: 240,
      categoryId: 94,
      name: 'B16 L8',
      bbox: Rect.fromLTWH(5184.90, 2022.99, 199.83, 123.28),
      points: [
        Offset(5184.904, 2053.792),
        Offset(5200.326, 2146.271),
        Offset(5384.734, 2114.559),
        Offset(5368.540, 2022.989),
      ],
    ),
    // id 241: B16 L9
    Phase3LotAnnotation(
      id: 241,
      categoryId: 95,
      name: 'B16 L9',
      bbox: Rect.fromLTWH(5202.98, 2116.23, 200.45, 121.17),
      points: [
        Offset(5202.975, 2146.149),
        Offset(5216.691, 2237.407),
        Offset(5403.421, 2207.129),
        Offset(5389.367, 2116.235),
      ],
    ),
    // id 242: B16 L10
    Phase3LotAnnotation(
      id: 242,
      categoryId: 87,
      name: 'B16 L10',
      bbox: Rect.fromLTWH(5216.53, 2207.72, 211.72, 159.51),
      points: [
        Offset(5216.535, 2238.795),
        Offset(5234.459, 2367.234),
        Offset(5428.254, 2337.728),
        Offset(5403.976, 2207.725),
      ],
    ),
    // id 243: B17 L1
    Phase3LotAnnotation(
      id: 243,
      categoryId: 96,
      name: 'B17 L1',
      bbox: Rect.fromLTWH(5244.83, 2376.05, 203.81, 133.98),
      points: [
        Offset(5244.833, 2404.877),
        Offset(5434.253, 2376.047),
        Offset(5448.642, 2480.827),
        Offset(5260.595, 2510.025),
      ],
    ),
    // id 244: B17 L2
    Phase3LotAnnotation(
      id: 244,
      categoryId: 102,
      name: 'B17 L2',
      bbox: Rect.fromLTWH(5260.75, 2482.29, 201.89, 118.93),
      points: [
        Offset(5260.750, 2509.667),
        Offset(5274.284, 2601.214),
        Offset(5462.637, 2572.311),
        Offset(5448.320, 2482.288),
      ],
    ),
    // id 245: B17 L3
    Phase3LotAnnotation(
      id: 245,
      categoryId: 103,
      name: 'B17 L3',
      bbox: Rect.fromLTWH(5275.34, 2573.04, 202.74, 121.54),
      points: [
        Offset(5275.341, 2601.193),
        Offset(5289.368, 2694.584),
        Offset(5478.078, 2665.485),
        Offset(5461.248, 2573.042),
      ],
    ),
    // id 246: B17 L4
    Phase3LotAnnotation(
      id: 246,
      categoryId: 104,
      name: 'B17 L4',
      bbox: Rect.fromLTWH(5287.28, 2666.81, 204.91, 116.57),
      points: [
        Offset(5287.280, 2694.045),
        Offset(5302.176, 2783.379),
        Offset(5492.192, 2754.586),
        Offset(5475.684, 2666.811),
      ],
    ),
    // id 247: B17 L5
    Phase3LotAnnotation(
      id: 247,
      categoryId: 105,
      name: 'B17 L5',
      bbox: Rect.fromLTWH(5302.86, 2758.22, 200.90, 118.89),
      points: [
        Offset(5302.860, 2785.716),
        Offset(5314.887, 2877.113),
        Offset(5503.757, 2848.236),
        Offset(5492.342, 2758.218),
      ],
    ),
    // id 248: B17 L6
    Phase3LotAnnotation(
      id: 248,
      categoryId: 106,
      name: 'B17 L6',
      bbox: Rect.fromLTWH(5317.79, 2852.04, 196.45, 118.43),
      points: [
        Offset(5317.788, 2877.097),
        Offset(5328.001, 2970.468),
        Offset(5514.234, 2938.498),
        Offset(5503.560, 2852.039),
      ],
    ),
    // id 249: B17 L7
    Phase3LotAnnotation(
      id: 249,
      categoryId: 107,
      name: 'B17 L7',
      bbox: Rect.fromLTWH(5329.44, 2940.11, 201.77, 123.13),
      points: [
        Offset(5329.441, 2971.799),
        Offset(5340.115, 3063.248),
        Offset(5531.209, 3032.677),
        Offset(5518.271, 2940.115),
      ],
    ),
    // id 250: B17 L8
    Phase3LotAnnotation(
      id: 250,
      categoryId: 108,
      name: 'B17 L8',
      bbox: Rect.fromLTWH(5340.65, 3033.73, 199.73, 122.04),
      points: [
        Offset(5340.649, 3064.693),
        Offset(5350.805, 3155.773),
        Offset(5540.375, 3126.363),
        Offset(5527.908, 3033.729),
      ],
    ),
    // id 251: B17 L9
    Phase3LotAnnotation(
      id: 251,
      categoryId: 109,
      name: 'B17 L9',
      bbox: Rect.fromLTWH(5354.72, 3126.17, 194.54, 122.42),
      points: [
        Offset(5354.717, 3157.608),
        Offset(5363.665, 3248.584),
        Offset(5549.261, 3214.065),
        Offset(5538.883, 3126.166),
      ],
    ),
    // id 252: B17 L10
    Phase3LotAnnotation(
      id: 252,
      categoryId: 97,
      name: 'B17 L10',
      bbox: Rect.fromLTWH(5365.54, 3216.03, 209.16, 186.11),
      points: [
        Offset(5365.541, 3248.507),
        Offset(5382.552, 3402.148),
        Offset(5574.697, 3305.845),
        Offset(5558.634, 3255.611),
        Offset(5551.816, 3216.034),
      ],
    ),
    // id 253: B17 L11
    Phase3LotAnnotation(
      id: 253,
      categoryId: 98,
      name: 'B17 L11',
      bbox: Rect.fromLTWH(5382.78, 3307.64, 242.63, 292.12),
      points: [
        Offset(5382.785, 3402.376),
        Offset(5403.506, 3599.755),
        Offset(5625.419, 3389.070),
        Offset(5600.537, 3355.080),
        Offset(5576.956, 3307.638),
      ],
    ),
    // id 254: B17 L12
    Phase3LotAnnotation(
      id: 254,
      categoryId: 99,
      name: 'B17 L12',
      bbox: Rect.fromLTWH(5405.45, 3390.16, 283.98, 296.13),
      points: [
        Offset(5405.449, 3602.284),
        Offset(5410.257, 3670.545),
        Offset(5566.453, 3686.286),
        Offset(5689.431, 3458.523),
        Offset(5654.026, 3422.791),
        Offset(5623.092, 3390.158),
      ],
    ),
    // id 255: B17 L13
    Phase3LotAnnotation(
      id: 255,
      categoryId: 100,
      name: 'B17 L13',
      bbox: Rect.fromLTWH(5567.16, 3455.88, 218.46, 247.07),
      points: [
        Offset(5567.163, 3686.239),
        Offset(5693.281, 3455.875),
        Offset(5733.940, 3478.928),
        Offset(5785.620, 3498.659),
        Offset(5742.090, 3702.950),
      ],
    ),
    // id 256: B17 L14
    Phase3LotAnnotation(
      id: 256,
      categoryId: 101,
      name: 'B17 L14',
      bbox: Rect.fromLTWH(5743.80, 3501.89, 147.15, 204.29),
      points: [
        Offset(5785.107, 3501.887),
        Offset(5871.939, 3510.131),
        Offset(5890.944, 3685.949),
        Offset(5800.108, 3706.173),
        Offset(5743.795, 3700.162),
      ],
    ),
    // id 257: B18 L1
    Phase3LotAnnotation(
      id: 257,
      categoryId: 110,
      name: 'B18 L1',
      bbox: Rect.fromLTWH(5885.36, 3479.49, 154.36, 203.43),
      points: [
        Offset(5904.435, 3682.921),
        Offset(5885.362, 3502.229),
        Offset(5926.534, 3500.214),
        Offset(5983.933, 3479.493),
        Offset(6039.726, 3609.447),
        Offset(5961.980, 3672.558),
      ],
    ),
    // id 258: B18 L2
    Phase3LotAnnotation(
      id: 258,
      categoryId: 111,
      name: 'B18 L2',
      bbox: Rect.fromLTWH(5982.12, 3417.85, 174.82, 190.91),
      points: [
        Offset(5982.116, 3480.343),
        Offset(6024.017, 3454.195),
        Offset(6062.497, 3417.850),
        Offset(6156.932, 3518.093),
        Offset(6042.187, 3608.761),
      ],
    ),
    // id 259: B18 L3
    Phase3LotAnnotation(
      id: 259,
      categoryId: 112,
      name: 'B18 L3',
      bbox: Rect.fromLTWH(6063.81, 3332.21, 220.22, 186.72),
      points: [
        Offset(6063.812, 3418.672),
        Offset(6089.398, 3385.631),
        Offset(6106.465, 3364.240),
        Offset(6120.821, 3332.206),
        Offset(6284.027, 3422.581),
        Offset(6158.562, 3518.927),
      ],
    ),
    // id 260: B18 L4
    Phase3LotAnnotation(
      id: 260,
      categoryId: 113,
      name: 'B18 L4',
      bbox: Rect.fromLTWH(6122.36, 3242.61, 317.88, 177.72),
      points: [
        Offset(6151.726, 3242.615),
        Offset(6143.294, 3273.342),
        Offset(6122.361, 3333.288),
        Offset(6285.056, 3420.332),
        Offset(6440.237, 3301.250),
      ],
    ),
    // id 261: B18 L5
    Phase3LotAnnotation(
      id: 261,
      categoryId: 114,
      name: 'B18 L5',
      bbox: Rect.fromLTWH(6149.30, 3109.19, 535.84, 190.92),
      points: [
        Offset(6155.047, 3135.692),
        Offset(6685.143, 3109.189),
        Offset(6439.402, 3300.104),
        Offset(6149.304, 3239.311),
        Offset(6154.930, 3195.923),
      ],
    ),
    // id 262: B18 L6
    Phase3LotAnnotation(
      id: 262,
      categoryId: 115,
      name: 'B18 L6',
      bbox: Rect.fromLTWH(6137.69, 2994.17, 209.20, 143.57),
      points: [
        Offset(6327.554, 2994.171),
        Offset(6137.690, 3020.877),
        Offset(6154.143, 3137.746),
        Offset(6346.892, 3127.087),
      ],
    ),
    // id 263: B18 L7
    Phase3LotAnnotation(
      id: 263,
      categoryId: 116,
      name: 'B18 L7',
      bbox: Rect.fromLTWH(6121.60, 2870.48, 207.19, 154.80),
      points: [
        Offset(6121.595, 2898.072),
        Offset(6137.365, 3025.284),
        Offset(6328.782, 2994.599),
        Offset(6311.857, 2870.484),
      ],
    ),
    // id 264: B18 L8
    Phase3LotAnnotation(
      id: 264,
      categoryId: 117,
      name: 'B18 L8',
      bbox: Rect.fromLTWH(6102.31, 2749.63, 208.51, 147.03),
      points: [
        Offset(6295.538, 2749.628),
        Offset(6102.305, 2774.691),
        Offset(6122.062, 2896.662),
        Offset(6310.815, 2870.004),
      ],
    ),
    // id 265: B18 L9
    Phase3LotAnnotation(
      id: 265,
      categoryId: 118,
      name: 'B18 L9',
      bbox: Rect.fromLTWH(6086.45, 2561.87, 208.75, 213.86),
      points: [
        Offset(6271.362, 2561.874),
        Offset(6132.864, 2582.232),
        Offset(6106.673, 2600.428),
        Offset(6095.772, 2620.566),
        Offset(6086.449, 2636.038),
        Offset(6088.624, 2670.112),
        Offset(6104.675, 2775.733),
        Offset(6295.201, 2745.897),
      ],
    ),
    // id 266: B19 L1
    Phase3LotAnnotation(
      id: 266,
      categoryId: 119,
      name: 'B19 L1',
      bbox: Rect.fromLTWH(5539.10, 2326.08, 208.61, 165.90),
      points: [
        Offset(5725.818, 2326.085),
        Offset(5539.096, 2357.592),
        Offset(5559.576, 2491.985),
        Offset(5747.706, 2458.693),
      ],
    ),
    // id 267: B19 L2
    Phase3LotAnnotation(
      id: 267,
      categoryId: 130,
      name: 'B19 L2',
      bbox: Rect.fromLTWH(5558.99, 2460.52, 202.44, 119.23),
      points: [
        Offset(5748.012, 2460.518),
        Offset(5558.993, 2489.519),
        Offset(5572.925, 2579.752),
        Offset(5761.436, 2551.730),
      ],
    ),
    // id 268: B19 L3
    Phase3LotAnnotation(
      id: 268,
      categoryId: 132,
      name: 'B19 L3',
      bbox: Rect.fromLTWH(5573.40, 2552.77, 202.90, 118.90),
      points: [
        Offset(5573.397, 2580.551),
        Offset(5585.467, 2671.676),
        Offset(5776.293, 2644.763),
        Offset(5762.750, 2552.774),
      ],
    ),
    // id 269: B19 L4
    Phase3LotAnnotation(
      id: 269,
      categoryId: 133,
      name: 'B19 L4',
      bbox: Rect.fromLTWH(5589.55, 2643.48, 198.67, 120.03),
      points: [
        Offset(5589.549, 2673.066),
        Offset(5601.339, 2763.511),
        Offset(5788.223, 2737.739),
        Offset(5774.086, 2643.482),
      ],
    ),
    // id 270: B19 L5
    Phase3LotAnnotation(
      id: 270,
      categoryId: 134,
      name: 'B19 L5',
      bbox: Rect.fromLTWH(5602.80, 2736.78, 198.34, 120.90),
      points: [
        Offset(5602.804, 2763.831),
        Offset(5613.532, 2857.686),
        Offset(5801.144, 2830.891),
        Offset(5788.569, 2736.785),
      ],
    ),
    // id 271: B19 L6
    Phase3LotAnnotation(
      id: 271,
      categoryId: 135,
      name: 'B19 L6',
      bbox: Rect.fromLTWH(5615.49, 2832.52, 198.07, 116.66),
      points: [
        Offset(5615.491, 2859.676),
        Offset(5627.000, 2949.186),
        Offset(5813.556, 2923.277),
        Offset(5800.812, 2832.522),
      ],
    ),
    // id 272: B19 L7
    Phase3LotAnnotation(
      id: 272,
      categoryId: 136,
      name: 'B19 L7',
      bbox: Rect.fromLTWH(5627.28, 2923.70, 200.11, 117.08),
      points: [
        Offset(5627.277, 2950.481),
        Offset(5638.437, 3040.775),
        Offset(5827.387, 3015.270),
        Offset(5815.453, 2923.698),
      ],
    ),
    // id 273: B19 L8
    Phase3LotAnnotation(
      id: 273,
      categoryId: 137,
      name: 'B19 L8',
      bbox: Rect.fromLTWH(5639.33, 3017.18, 199.93, 114.06),
      points: [
        Offset(5639.333, 3043.191),
        Offset(5649.985, 3131.242),
        Offset(5839.267, 3109.923),
        Offset(5826.865, 3017.178),
      ],
    ),
    // id 274: B19 L9
    Phase3LotAnnotation(
      id: 274,
      categoryId: 138,
      name: 'B19 L9',
      bbox: Rect.fromLTWH(5650.25, 3109.16, 200.95, 115.98),
      points: [
        Offset(5650.248, 3131.552),
        Offset(5662.420, 3225.140),
        Offset(5851.201, 3204.022),
        Offset(5838.583, 3109.164),
      ],
    ),
    // id 275: B19 L10
    Phase3LotAnnotation(
      id: 275,
      categoryId: 120,
      name: 'B19 L10',
      bbox: Rect.fromLTWH(5662.55, 3206.03, 209.10, 163.21),
      points: [
        Offset(5848.811, 3206.031),
        Offset(5662.549, 3223.235),
        Offset(5675.217, 3258.623),
        Offset(5702.660, 3300.602),
        Offset(5734.325, 3329.689),
        Offset(5767.160, 3349.568),
        Offset(5809.139, 3366.272),
        Offset(5836.423, 3369.242),
        Offset(5871.645, 3367.931),
        Offset(5851.572, 3210.419),
      ],
    ),
    // id 276: B19 L11
    Phase3LotAnnotation(
      id: 276,
      categoryId: 121,
      name: 'B19 L11',
      bbox: Rect.fromLTWH(5853.92, 3128.47, 190.98, 238.23),
      points: [
        Offset(5853.919, 3157.356),
        Offset(5877.423, 3366.697),
        Offset(5916.551, 3359.684),
        Offset(5959.289, 3338.192),
        Offset(6000.692, 3301.066),
        Offset(6029.485, 3256.949),
        Offset(6042.729, 3221.583),
        Offset(6044.900, 3191.095),
        Offset(6043.161, 3128.467),
      ],
    ),
    // id 277: B19 L12
    Phase3LotAnnotation(
      id: 277,
      categoryId: 122,
      name: 'B19 L12',
      bbox: Rect.fromLTWH(5841.05, 3034.75, 201.60, 121.02),
      points: [
        Offset(5841.053, 3066.486),
        Offset(5854.376, 3155.772),
        Offset(6042.657, 3126.634),
        Offset(6030.583, 3034.753),
      ],
    ),
    // id 278: B19 L13
    Phase3LotAnnotation(
      id: 278,
      categoryId: 123,
      name: 'B19 L13',
      bbox: Rect.fromLTWH(5830.88, 2943.35, 198.86, 122.29),
      points: [
        Offset(5830.879, 2973.039),
        Offset(5840.621, 3065.637),
        Offset(6029.744, 3033.968),
        Offset(6017.285, 2943.346),
      ],
    ),
    // id 279: B19 L14
    Phase3LotAnnotation(
      id: 279,
      categoryId: 124,
      name: 'B19 L14',
      bbox: Rect.fromLTWH(5820.40, 2850.96, 198.28, 120.27),
      points: [
        Offset(5820.396, 2881.060),
        Offset(6006.330, 2850.957),
        Offset(6018.678, 2942.774),
        Offset(5829.180, 2971.228),
      ],
    ),
    // id 280: B19 L15
    Phase3LotAnnotation(
      id: 280,
      categoryId: 125,
      name: 'B19 L15',
      bbox: Rect.fromLTWH(5804.62, 2756.75, 201.25, 124.17),
      points: [
        Offset(5804.618, 2788.772),
        Offset(5818.683, 2880.920),
        Offset(6005.865, 2847.743),
        Offset(5991.368, 2756.750),
      ],
    ),
    // id 281: B19 L16
    Phase3LotAnnotation(
      id: 281,
      categoryId: 126,
      name: 'B19 L16',
      bbox: Rect.fromLTWH(5792.17, 2665.96, 200.12, 123.44),
      points: [
        Offset(5792.173, 2695.641),
        Offset(5804.956, 2789.398),
        Offset(5992.290, 2757.398),
        Offset(5979.345, 2665.960),
      ],
    ),
    // id 282: B19 L17
    Phase3LotAnnotation(
      id: 282,
      categoryId: 127,
      name: 'B19 L17',
      bbox: Rect.fromLTWH(5776.51, 2574.30, 202.14, 124.48),
      points: [
        Offset(5776.506, 2604.404),
        Offset(5791.503, 2698.777),
        Offset(5978.643, 2670.398),
        Offset(5966.694, 2574.298),
      ],
    ),
    // id 283: B19 L18
    Phase3LotAnnotation(
      id: 283,
      categoryId: 128,
      name: 'B19 L18',
      bbox: Rect.fromLTWH(5764.08, 2481.62, 203.10, 123.91),
      points: [
        Offset(5764.079, 2512.217),
        Offset(5779.252, 2605.527),
        Offset(5967.177, 2573.628),
        Offset(5953.436, 2481.617),
      ],
    ),
    // id 284: B19 L19
    Phase3LotAnnotation(
      id: 284,
      categoryId: 129,
      name: 'B19 L19',
      bbox: Rect.fromLTWH(5750.22, 2388.64, 200.50, 122.84),
      points: [
        Offset(5750.222, 2419.583),
        Offset(5938.136, 2388.638),
        Offset(5950.718, 2480.296),
        Offset(5763.488, 2511.479),
      ],
    ),
    // id 285: B19 L20
    Phase3LotAnnotation(
      id: 285,
      categoryId: 131,
      name: 'B19 L20',
      bbox: Rect.fromLTWH(5735.03, 2292.25, 202.60, 127.50),
      points: [
        Offset(5735.034, 2324.242),
        Offset(5750.212, 2419.752),
        Offset(5937.632, 2388.285),
        Offset(5924.877, 2292.253),
      ],
    ),
    // id 286: B20 L1
    Phase3LotAnnotation(
      id: 286,
      categoryId: 178,
      name: 'B20 L1',
      bbox: Rect.fromLTWH(5713.12, 2163.06, 201.81, 121.99),
      points: [
        Offset(5713.124, 2193.267),
        Offset(5901.580, 2163.061),
        Offset(5914.931, 2257.239),
        Offset(5728.060, 2285.047),
      ],
    ),
    // id 287: B20 L2
    Phase3LotAnnotation(
      id: 287,
      categoryId: 180,
      name: 'B20 L2',
      bbox: Rect.fromLTWH(5697.89, 2067.51, 204.22, 125.29),
      points: [
        Offset(5697.890, 2102.101),
        Offset(5712.163, 2192.799),
        Offset(5902.105, 2160.528),
        Offset(5887.004, 2067.506),
      ],
    ),
    // id 288: B20 L3
    Phase3LotAnnotation(
      id: 288,
      categoryId: 181,
      name: 'B20 L3',
      bbox: Rect.fromLTWH(5682.08, 1977.42, 204.92, 124.08),
      points: [
        Offset(5682.077, 2007.998),
        Offset(5698.321, 2101.496),
        Offset(5887.000, 2069.469),
        Offset(5868.040, 1977.418),
      ],
    ),
    // id 289: B20 L4
    Phase3LotAnnotation(
      id: 289,
      categoryId: 182,
      name: 'B20 L4',
      bbox: Rect.fromLTWH(5665.64, 1886.61, 200.44, 121.70),
      points: [
        Offset(5665.641, 1915.741),
        Offset(5681.957, 2008.305),
        Offset(5866.077, 1974.623),
        Offset(5852.913, 1886.608),
      ],
    ),
    // id 290: B20 L5
    Phase3LotAnnotation(
      id: 290,
      categoryId: 183,
      name: 'B20 L5',
      bbox: Rect.fromLTWH(5628.09, 1730.46, 227.01, 186.07),
      points: [
        Offset(5628.091, 1730.459),
        Offset(5665.271, 1916.529),
        Offset(5855.098, 1881.236),
        Offset(5840.678, 1820.721),
        Offset(5843.050, 1795.754),
      ],
    ),
    // id 291: B20 L6
    Phase3LotAnnotation(
      id: 291,
      categoryId: 184,
      name: 'B20 L6',
      bbox: Rect.fromLTWH(5579.40, 1565.61, 316.11, 228.64),
      points: [
        Offset(5579.397, 1713.583),
        Offset(5787.004, 1565.609),
        Offset(5895.509, 1718.238),
        Offset(5874.667, 1734.576),
        Offset(5857.808, 1753.322),
        Offset(5843.268, 1794.249),
      ],
    ),
    // id 292: B20 L7
    Phase3LotAnnotation(
      id: 292,
      categoryId: 185,
      name: 'B20 L7',
      bbox: Rect.fromLTWH(5787.90, 1505.83, 195.47, 212.66),
      points: [
        Offset(5787.898, 1564.328),
        Offset(5875.027, 1505.829),
        Offset(5983.373, 1658.066),
        Offset(5897.178, 1718.487),
      ],
    ),
    // id 293: B20 L8
    Phase3LotAnnotation(
      id: 293,
      categoryId: 186,
      name: 'B20 L8',
      bbox: Rect.fromLTWH(5877.91, 1444.83, 190.33, 211.60),
      points: [
        Offset(5877.907, 1506.221),
        Offset(5960.919, 1444.829),
        Offset(6068.236, 1595.704),
        Offset(5983.381, 1656.433),
      ],
    ),
    // id 294: B20 L9
    Phase3LotAnnotation(
      id: 294,
      categoryId: 187,
      name: 'B20 L9',
      bbox: Rect.fromLTWH(5961.08, 1384.94, 194.06, 209.04),
      points: [
        Offset(5961.080, 1443.557),
        Offset(6046.295, 1384.942),
        Offset(6155.143, 1535.902),
        Offset(6071.641, 1593.977),
      ],
    ),
    // id 295: B20 L10
    Phase3LotAnnotation(
      id: 295,
      categoryId: 179,
      name: 'B20 L10',
      bbox: Rect.fromLTWH(6047.67, 1306.50, 204.14, 226.49),
      points: [
        Offset(6047.670, 1382.032),
        Offset(6152.441, 1306.496),
        Offset(6251.814, 1469.762),
        Offset(6155.023, 1532.991),
      ],
    ),
    // id 296: B21 L1
    Phase3LotAnnotation(
      id: 296,
      categoryId: 188,
      name: 'B21 L1',
      bbox: Rect.fromLTWH(6032.17, 2271.98, 220.07, 202.95),
      points: [
        Offset(6252.238, 2457.590),
        Offset(6224.122, 2271.984),
        Offset(6032.170, 2300.863),
        Offset(6051.503, 2427.740),
        Offset(6083.655, 2466.306),
        Offset(6120.106, 2474.935),
      ],
    ),
    // id 297: B21 L2
    Phase3LotAnnotation(
      id: 297,
      categoryId: 189,
      name: 'B21 L2',
      bbox: Rect.fromLTWH(6013.92, 2157.23, 210.19, 145.69),
      points: [
        Offset(6224.115, 2268.797),
        Offset(6204.588, 2157.230),
        Offset(6013.921, 2186.498),
        Offset(6034.653, 2302.925),
      ],
    ),
    // id 298: B21 L3
    Phase3LotAnnotation(
      id: 298,
      categoryId: 190,
      name: 'B21 L3',
      bbox: Rect.fromLTWH(5996.95, 2041.68, 210.74, 140.84),
      points: [
        Offset(6184.893, 2041.680),
        Offset(5996.951, 2073.444),
        Offset(6015.126, 2182.521),
        Offset(6207.694, 2156.092),
      ],
    ),
    // id 299: B21 L4
    Phase3LotAnnotation(
      id: 299,
      categoryId: 191,
      name: 'B21 L4',
      bbox: Rect.fromLTWH(5977.72, 1924.97, 209.88, 146.61),
      points: [
        Offset(6165.219, 1924.971),
        Offset(5977.725, 1960.150),
        Offset(5999.388, 2071.583),
        Offset(6187.604, 2042.162),
      ],
    ),
    // id 300: B21 L5
    Phase3LotAnnotation(
      id: 300,
      categoryId: 192,
      name: 'B21 L5',
      bbox: Rect.fromLTWH(5960.76, 1698.59, 258.40, 263.78),
      points: [
        Offset(6219.161, 1857.694),
        Offset(6107.808, 1698.590),
        Offset(5993.142, 1781.546),
        Offset(5969.919, 1818.097),
        Offset(5960.761, 1864.462),
        Offset(5977.812, 1962.373),
        Offset(6167.053, 1924.429),
        Offset(6163.873, 1894.144),
      ],
    ),
    // id 301: B21 L6
    Phase3LotAnnotation(
      id: 301,
      categoryId: 193,
      name: 'B21 L6',
      bbox: Rect.fromLTWH(6111.82, 1631.67, 203.66, 222.79),
      points: [
        Offset(6111.825, 1698.945),
        Offset(6207.112, 1631.668),
        Offset(6315.486, 1791.213),
        Offset(6220.487, 1854.454),
      ],
    ),
    // id 302: B21 L7
    Phase3LotAnnotation(
      id: 302,
      categoryId: 194,
      name: 'B21 L7',
      bbox: Rect.fromLTWH(6207.53, 1563.89, 195.55, 224.80),
      points: [
        Offset(6207.527, 1633.549),
        Offset(6303.516, 1563.888),
        Offset(6403.074, 1732.457),
        Offset(6315.961, 1788.689),
      ],
    ),
  ];
}
