import 'package:flutter/material.dart';
import 'phase_lot_annotation.dart';
export 'phase_lot_annotation.dart';

/// Static dataset containing all lot annotations for Phase 1 (7073x8851)
class Phase1AnnotationsData {
  Phase1AnnotationsData._();

  /// Find the annotation at [localPos] within [renderSize].
  static Phase1LotAnnotation? hitTest(Offset localPos, Size renderSize) {
    return PhaseLotAnnotation.hitTestList(annotations, localPos, renderSize);
  }

  static const List<Phase1LotAnnotation> annotations = [
    // id 1: B1 L1
    Phase1LotAnnotation(
      id: 1,
      categoryId: 1,
      name: 'B1 L1',
      bbox: Rect.fromLTWH(2045.65, 5937.47, 300.16, 154.23),
      points: [
        Offset(2055.206, 5937.473),
        Offset(2045.648, 6091.704),
        Offset(2345.812, 5952.597),
      ],
    ),
    // id 2: B1 L2
    Phase1LotAnnotation(
      id: 2,
      categoryId: 12,
      name: 'B1 L2',
      bbox: Rect.fromLTWH(1946.02, 5930.40, 109.19, 171.03),
      points: [
        Offset(2055.206, 5937.473),
        Offset(1954.323, 5930.403),
        Offset(1946.016, 6097.122),
        Offset(2026.803, 6101.433),
        Offset(2044.857, 6091.069),
      ],
    ),
    // id 3: B1 L3
    Phase1LotAnnotation(
      id: 3,
      categoryId: 23,
      name: 'B1 L3',
      bbox: Rect.fromLTWH(1844.61, 5924.44, 110.78, 171.84),
      points: [
        Offset(1955.392, 5930.818),
        Offset(1854.168, 5924.435),
        Offset(1844.610, 6091.701),
        Offset(1945.099, 6096.272),
      ],
    ),
    // id 4: B1 L4
    Phase1LotAnnotation(
      id: 4,
      categoryId: 34,
      name: 'B1 L4',
      bbox: Rect.fromLTWH(1743.78, 5920.52, 108.95, 171.39),
      points: [
        Offset(1852.727, 5925.115),
        Offset(1754.544, 5920.521),
        Offset(1743.779, 6086.524),
        Offset(1844.461, 6091.912),
      ],
    ),
    // id 5: B1 L5
    Phase1LotAnnotation(
      id: 5,
      categoryId: 35,
      name: 'B1 L5',
      bbox: Rect.fromLTWH(1643.82, 5913.44, 112.08, 173.51),
      points: [
        Offset(1755.899, 5921.268),
        Offset(1653.780, 5913.444),
        Offset(1643.817, 6081.812),
        Offset(1744.797, 6086.955),
      ],
    ),
    // id 6: B1 L6
    Phase1LotAnnotation(
      id: 6,
      categoryId: 36,
      name: 'B1 L6',
      bbox: Rect.fromLTWH(1545.14, 5908.26, 107.96, 171.64),
      points: [
        Offset(1653.100, 5913.708),
        Offset(1553.406, 5908.264),
        Offset(1545.140, 6075.485),
        Offset(1644.196, 6079.900),
      ],
    ),
    // id 7: B1 L7
    Phase1LotAnnotation(
      id: 7,
      categoryId: 37,
      name: 'B1 L7',
      bbox: Rect.fromLTWH(1443.06, 5903.66, 109.27, 172.60),
      points: [
        Offset(1552.336, 5908.955),
        Offset(1451.687, 5903.663),
        Offset(1443.065, 6072.250),
        Offset(1543.320, 6076.261),
      ],
    ),
    // id 8: B1 L8
    Phase1LotAnnotation(
      id: 8,
      categoryId: 38,
      name: 'B1 L8',
      bbox: Rect.fromLTWH(1342.51, 5898.17, 108.11, 172.49),
      points: [
        Offset(1450.622, 5903.251),
        Offset(1352.594, 5898.171),
        Offset(1342.513, 6065.414),
        Offset(1443.474, 6070.665),
      ],
    ),
    // id 9: B1 L9
    Phase1LotAnnotation(
      id: 9,
      categoryId: 39,
      name: 'B1 L9',
      bbox: Rect.fromLTWH(1243.59, 5891.45, 108.17, 174.19),
      points: [
        Offset(1351.759, 5897.547),
        Offset(1252.198, 5891.450),
        Offset(1243.587, 6061.281),
        Offset(1343.449, 6065.637),
      ],
    ),
    // id 10: B1 L10
    Phase1LotAnnotation(
      id: 10,
      categoryId: 2,
      name: 'B1 L10',
      bbox: Rect.fromLTWH(1141.98, 5884.85, 110.43, 174.70),
      points: [
        Offset(1252.410, 5891.996),
        Offset(1151.954, 5884.848),
        Offset(1141.980, 6055.411),
        Offset(1244.077, 6059.551),
      ],
    ),
    // id 11: B1 L11
    Phase1LotAnnotation(
      id: 11,
      categoryId: 3,
      name: 'B1 L11',
      bbox: Rect.fromLTWH(1042.62, 5879.32, 109.52, 174.76),
      points: [
        Offset(1152.132, 5884.239),
        Offset(1051.598, 5879.315),
        Offset(1042.616, 6050.784),
        Offset(1143.272, 6054.078),
      ],
    ),
    // id 12: B1 L12
    Phase1LotAnnotation(
      id: 12,
      categoryId: 4,
      name: 'B1 L12',
      bbox: Rect.fromLTWH(941.21, 5873.95, 110.67, 175.83),
      points: [
        Offset(1051.880, 5879.241),
        Offset(950.403, 5873.949),
        Offset(941.213, 6045.292),
        Offset(1042.928, 6049.774),
      ],
    ),
    // id 13: B1 L13
    Phase1LotAnnotation(
      id: 13,
      categoryId: 5,
      name: 'B1 L13',
      bbox: Rect.fromLTWH(841.76, 5868.42, 108.70, 175.35),
      points: [
        Offset(950.455, 5873.589),
        Offset(851.002, 5868.416),
        Offset(841.756, 6039.752),
        Offset(942.193, 6043.766),
      ],
    ),
    // id 14: B1 L14
    Phase1LotAnnotation(
      id: 14,
      categoryId: 6,
      name: 'B1 L14',
      bbox: Rect.fromLTWH(702.35, 5859.97, 149.39, 178.72),
      points: [
        Offset(851.741, 5868.079),
        Offset(738.816, 5859.969),
        Offset(702.348, 6032.578),
        Offset(843.401, 6038.686),
      ],
    ),
    // id 15: B1 L15
    Phase1LotAnnotation(
      id: 15,
      categoryId: 7,
      name: 'B1 L15',
      bbox: Rect.fromLTWH(484.53, 5820.55, 254.73, 209.41),
      points: [
        Offset(640.707, 5820.548),
        Offset(484.533, 6020.164),
        Offset(702.482, 6029.960),
        Offset(739.265, 5860.440),
        Offset(705.237, 5855.390),
        Offset(671.743, 5840.771),
      ],
    ),
    // id 16: B1 L16
    Phase1LotAnnotation(
      id: 16,
      categoryId: 8,
      name: 'B1 L16',
      bbox: Rect.fromLTWH(443.91, 5735.63, 196.95, 283.99),
      points: [
        Offset(640.867, 5820.730),
        Offset(612.568, 5797.526),
        Offset(588.803, 5767.619),
        Offset(573.730, 5735.625),
        Offset(443.914, 5797.786),
        Offset(444.300, 6018.088),
        Offset(487.515, 6019.618),
      ],
    ),
    // id 17: B1 L17
    Phase1LotAnnotation(
      id: 17,
      categoryId: 9,
      name: 'B1 L17',
      bbox: Rect.fromLTWH(444.69, 5630.43, 126.17, 167.45),
      points: [
        Offset(552.301, 5630.428),
        Offset(445.098, 5632.039),
        Offset(444.686, 5797.882),
        Offset(570.853, 5733.531),
        Offset(561.729, 5705.767),
        Offset(554.340, 5673.918),
      ],
    ),
    // id 18: B1 L18
    Phase1LotAnnotation(
      id: 18,
      categoryId: 10,
      name: 'B1 L18',
      bbox: Rect.fromLTWH(444.66, 5466.47, 140.01, 166.30),
      points: [
        Offset(445.926, 5466.474),
        Offset(444.664, 5632.778),
        Offset(552.546, 5630.483),
        Offset(559.055, 5596.210),
        Offset(573.010, 5556.644),
        Offset(584.670, 5536.151),
      ],
    ),
    // id 19: B1 L19
    Phase1LotAnnotation(
      id: 19,
      categoryId: 11,
      name: 'B1 L19',
      bbox: Rect.fromLTWH(444.88, 5276.80, 213.49, 256.18),
      points: [
        Offset(444.883, 5276.803),
        Offset(444.938, 5467.061),
        Offset(585.316, 5532.987),
        Offset(607.781, 5506.207),
        Offset(627.410, 5486.444),
        Offset(658.375, 5465.334),
      ],
    ),
    // id 20: B1 L20
    Phase1LotAnnotation(
      id: 20,
      categoryId: 13,
      name: 'B1 L20',
      bbox: Rect.fromLTWH(446.78, 5274.90, 299.06, 189.51),
      points: [
        Offset(446.784, 5274.902),
        Offset(745.845, 5299.298),
        Offset(736.492, 5436.675),
        Offset(707.754, 5442.353),
        Offset(683.663, 5450.630),
        Offset(660.291, 5464.410),
      ],
    ),
    // id 21: B1 L21
    Phase1LotAnnotation(
      id: 21,
      categoryId: 14,
      name: 'B1 L21',
      bbox: Rect.fromLTWH(737.79, 5297.72, 108.63, 143.40),
      points: [
        Offset(745.274, 5297.716),
        Offset(846.416, 5306.413),
        Offset(837.553, 5441.116),
        Offset(737.791, 5435.000),
      ],
    ),
    // id 22: B1 L22
    Phase1LotAnnotation(
      id: 22,
      categoryId: 15,
      name: 'B1 L22',
      bbox: Rect.fromLTWH(836.60, 5307.22, 109.57, 139.68),
      points: [
        Offset(845.087, 5307.222),
        Offset(946.167, 5313.565),
        Offset(938.172, 5446.902),
        Offset(836.602, 5440.132),
      ],
    ),
    // id 23: B1 L23
    Phase1LotAnnotation(
      id: 23,
      categoryId: 16,
      name: 'B1 L23',
      bbox: Rect.fromLTWH(936.71, 5315.90, 108.95, 136.95),
      points: [
        Offset(945.818, 5315.904),
        Offset(936.713, 5446.125),
        Offset(1038.869, 5452.854),
        Offset(1045.661, 5321.726),
      ],
    ),
    // id 24: B1 L24
    Phase1LotAnnotation(
      id: 24,
      categoryId: 17,
      name: 'B1 L24',
      bbox: Rect.fromLTWH(1038.16, 5322.43, 107.65, 136.00),
      points: [
        Offset(1045.664, 5322.432),
        Offset(1038.156, 5453.140),
        Offset(1139.429, 5458.428),
        Offset(1145.808, 5328.978),
      ],
    ),
    // id 25: B1 L25
    Phase1LotAnnotation(
      id: 25,
      categoryId: 18,
      name: 'B1 L25',
      bbox: Rect.fromLTWH(1137.20, 5328.95, 109.32, 135.17),
      points: [
        Offset(1145.713, 5328.949),
        Offset(1246.522, 5334.925),
        Offset(1240.069, 5464.116),
        Offset(1137.204, 5456.980),
      ],
    ),
    // id 26: B1 L26
    Phase1LotAnnotation(
      id: 26,
      categoryId: 19,
      name: 'B1 L26',
      bbox: Rect.fromLTWH(1238.96, 5336.40, 106.30, 131.93),
      points: [
        Offset(1246.365, 5336.402),
        Offset(1238.958, 5463.215),
        Offset(1339.213, 5468.328),
        Offset(1345.256, 5344.642),
      ],
    ),
    // id 27: B1 L27
    Phase1LotAnnotation(
      id: 27,
      categoryId: 20,
      name: 'B1 L27',
      bbox: Rect.fromLTWH(1339.92, 5344.69, 106.04, 129.46),
      points: [
        Offset(1346.526, 5344.686),
        Offset(1339.919, 5469.122),
        Offset(1439.654, 5474.147),
        Offset(1445.958, 5351.011),
      ],
    ),
    // id 28: B1 L28
    Phase1LotAnnotation(
      id: 28,
      categoryId: 21,
      name: 'B1 L28',
      bbox: Rect.fromLTWH(1440.46, 5351.46, 105.86, 128.63),
      points: [
        Offset(1446.688, 5351.464),
        Offset(1440.460, 5477.115),
        Offset(1541.321, 5480.092),
        Offset(1546.322, 5359.033),
      ],
    ),
    // id 29: B1 L29
    Phase1LotAnnotation(
      id: 29,
      categoryId: 22,
      name: 'B1 L29',
      bbox: Rect.fromLTWH(1540.09, 5359.75, 106.83, 125.82),
      points: [
        Offset(1545.342, 5359.748),
        Offset(1540.086, 5481.078),
        Offset(1638.858, 5485.570),
        Offset(1646.919, 5366.055),
      ],
    ),
    // id 30: B1 L30
    Phase1LotAnnotation(
      id: 30,
      categoryId: 24,
      name: 'B1 L30',
      bbox: Rect.fromLTWH(1639.34, 5366.53, 106.52, 125.10),
      points: [
        Offset(1647.010, 5366.526),
        Offset(1639.338, 5486.838),
        Offset(1740.734, 5491.624),
        Offset(1745.853, 5374.071),
      ],
    ),
    // id 31: B1 L31
    Phase1LotAnnotation(
      id: 31,
      categoryId: 25,
      name: 'B1 L31',
      bbox: Rect.fromLTWH(1741.47, 5374.87, 103.87, 124.89),
      points: [
        Offset(1745.994, 5374.871),
        Offset(1741.467, 5492.548),
        Offset(1839.945, 5499.761),
        Offset(1845.334, 5382.802),
      ],
    ),
    // id 32: B1 L32
    Phase1LotAnnotation(
      id: 32,
      categoryId: 26,
      name: 'B1 L32',
      bbox: Rect.fromLTWH(1840.78, 5383.09, 106.13, 121.97),
      points: [
        Offset(1845.826, 5383.094),
        Offset(1840.778, 5498.305),
        Offset(1941.130, 5505.068),
        Offset(1946.908, 5389.960),
      ],
    ),
    // id 33: B1 L33
    Phase1LotAnnotation(
      id: 33,
      categoryId: 27,
      name: 'B1 L33',
      bbox: Rect.fromLTWH(1941.80, 5389.87, 105.60, 119.70),
      points: [
        Offset(1947.493, 5389.871),
        Offset(1941.801, 5504.574),
        Offset(2042.159, 5509.572),
        Offset(2047.404, 5396.264),
      ],
    ),
    // id 34: B1 L34
    Phase1LotAnnotation(
      id: 34,
      categoryId: 28,
      name: 'B1 L34',
      bbox: Rect.fromLTWH(2040.66, 5397.37, 106.34, 118.06),
      points: [
        Offset(2048.110, 5397.370),
        Offset(2040.662, 5511.019),
        Offset(2141.229, 5515.426),
        Offset(2147.000, 5404.242),
      ],
    ),
    // id 35: B1 L35
    Phase1LotAnnotation(
      id: 35,
      categoryId: 29,
      name: 'B1 L35',
      bbox: Rect.fromLTWH(2141.27, 5404.93, 105.39, 116.81),
      points: [
        Offset(2146.309, 5404.933),
        Offset(2141.273, 5517.194),
        Offset(2240.975, 5521.739),
        Offset(2246.667, 5413.082),
      ],
    ),
    // id 36: B1 L36
    Phase1LotAnnotation(
      id: 36,
      categoryId: 30,
      name: 'B1 L36',
      bbox: Rect.fromLTWH(2240.32, 5413.56, 111.25, 114.17),
      points: [
        Offset(2247.226, 5413.556),
        Offset(2240.319, 5522.159),
        Offset(2345.402, 5527.725),
        Offset(2351.570, 5419.927),
      ],
    ),
    // id 37: B1 L37
    Phase1LotAnnotation(
      id: 37,
      categoryId: 31,
      name: 'B1 L37',
      bbox: Rect.fromLTWH(2346.02, 5420.75, 110.80, 112.41),
      points: [
        Offset(2351.150, 5420.748),
        Offset(2346.025, 5527.716),
        Offset(2452.720, 5533.159),
        Offset(2456.821, 5428.761),
      ],
    ),
    // id 38: B1 L38
    Phase1LotAnnotation(
      id: 38,
      categoryId: 32,
      name: 'B1 L38',
      bbox: Rect.fromLTWH(2452.92, 5428.28, 109.06, 110.84),
      points: [
        Offset(2456.582, 5428.279),
        Offset(2452.923, 5534.527),
        Offset(2556.670, 5539.122),
        Offset(2561.980, 5435.898),
      ],
    ),
    // id 39: B1 L39
    Phase1LotAnnotation(
      id: 39,
      categoryId: 33,
      name: 'B1 L39',
      bbox: Rect.fromLTWH(2556.41, 5436.25, 174.20, 107.97),
      points: [
        Offset(2562.886, 5436.254),
        Offset(2556.408, 5540.572),
        Offset(2632.338, 5544.220),
        Offset(2655.281, 5539.448),
        Offset(2680.930, 5528.646),
        Offset(2706.138, 5505.456),
        Offset(2719.658, 5485.493),
        Offset(2730.610, 5449.819),
      ],
    ),
    // id 40: B2 L1
    Phase1LotAnnotation(
      id: 40,
      categoryId: 185,
      name: 'B2 L1',
      bbox: Rect.fromLTWH(2431.99, 5751.15, 287.25, 112.72),
      points: [
        Offset(2540.300, 5863.868),
        Offset(2719.238, 5781.815),
        Offset(2544.292, 5757.518),
        Offset(2438.109, 5751.147),
        Offset(2431.987, 5859.487),
      ],
    ),
    // id 41: B2 L2
    Phase1LotAnnotation(
      id: 41,
      categoryId: 196,
      name: 'B2 L2',
      bbox: Rect.fromLTWH(2327.20, 5745.89, 110.96, 112.94),
      points: [
        Offset(2333.116, 5745.889),
        Offset(2327.197, 5853.406),
        Offset(2431.421, 5858.828),
        Offset(2438.160, 5751.125),
      ],
    ),
    // id 42: B2 L3
    Phase1LotAnnotation(
      id: 42,
      categoryId: 207,
      name: 'B2 L3',
      bbox: Rect.fromLTWH(2223.68, 5739.60, 110.01, 114.05),
      points: [
        Offset(2333.692, 5745.313),
        Offset(2229.716, 5739.596),
        Offset(2223.680, 5848.114),
        Offset(2327.629, 5853.646),
      ],
    ),
    // id 43: B2 L4
    Phase1LotAnnotation(
      id: 43,
      categoryId: 218,
      name: 'B2 L4',
      bbox: Rect.fromLTWH(2119.18, 5733.88, 110.34, 113.87),
      points: [
        Offset(2229.525, 5739.558),
        Offset(2125.366, 5733.875),
        Offset(2119.182, 5842.143),
        Offset(2223.846, 5847.747),
      ],
    ),
    // id 44: B2 L5
    Phase1LotAnnotation(
      id: 44,
      categoryId: 229,
      name: 'B2 L5',
      bbox: Rect.fromLTWH(2014.24, 5728.69, 111.00, 112.45),
      points: [
        Offset(2125.240, 5734.291),
        Offset(2020.340, 5728.691),
        Offset(2014.243, 5834.812),
        Offset(2118.388, 5841.140),
      ],
    ),
    // id 45: B2 L6
    Phase1LotAnnotation(
      id: 45,
      categoryId: 240,
      name: 'B2 L6',
      bbox: Rect.fromLTWH(1910.22, 5721.55, 111.09, 113.47),
      points: [
        Offset(2021.307, 5728.381),
        Offset(1915.712, 5721.551),
        Offset(1910.222, 5829.513),
        Offset(2014.185, 5835.023),
      ],
    ),
    // id 46: B2 L7
    Phase1LotAnnotation(
      id: 46,
      categoryId: 251,
      name: 'B2 L7',
      bbox: Rect.fromLTWH(1805.49, 5715.23, 110.95, 113.38),
      points: [
        Offset(1916.447, 5722.293),
        Offset(1811.808, 5715.232),
        Offset(1805.493, 5823.416),
        Offset(1910.796, 5828.609),
      ],
    ),
    // id 47: B2 L8
    Phase1LotAnnotation(
      id: 47,
      categoryId: 262,
      name: 'B2 L8',
      bbox: Rect.fromLTWH(1700.70, 5709.44, 111.58, 112.87),
      points: [
        Offset(1812.280, 5714.811),
        Offset(1707.636, 5709.441),
        Offset(1700.703, 5816.771),
        Offset(1805.106, 5822.306),
      ],
    ),
    // id 48: B2 L9
    Phase1LotAnnotation(
      id: 48,
      categoryId: 265,
      name: 'B2 L9',
      bbox: Rect.fromLTWH(1596.14, 5703.15, 112.16, 113.84),
      points: [
        Offset(1708.295, 5710.468),
        Offset(1603.109, 5703.153),
        Offset(1596.140, 5811.582),
        Offset(1702.502, 5816.989),
      ],
    ),
    // id 49: B2 L10
    Phase1LotAnnotation(
      id: 49,
      categoryId: 186,
      name: 'B2 L10',
      bbox: Rect.fromLTWH(1492.58, 5697.27, 110.79, 113.43),
      points: [
        Offset(1603.370, 5702.726),
        Offset(1498.560, 5697.269),
        Offset(1492.582, 5805.580),
        Offset(1596.909, 5810.699),
      ],
    ),
    // id 50: B2 L11
    Phase1LotAnnotation(
      id: 50,
      categoryId: 187,
      name: 'B2 L11',
      bbox: Rect.fromLTWH(1388.01, 5690.36, 110.99, 114.36),
      points: [
        Offset(1394.673, 5690.364),
        Offset(1388.010, 5798.227),
        Offset(1492.150, 5804.720),
        Offset(1499.004, 5696.611),
      ],
    ),
    // id 51: B2 L12
    Phase1LotAnnotation(
      id: 51,
      categoryId: 188,
      name: 'B2 L12',
      bbox: Rect.fromLTWH(1284.10, 5685.15, 110.01, 112.30),
      points: [
        Offset(1290.007, 5685.148),
        Offset(1284.102, 5792.170),
        Offset(1388.366, 5797.445),
        Offset(1394.114, 5690.677),
      ],
    ),
    // id 52: B2 L13
    Phase1LotAnnotation(
      id: 52,
      categoryId: 189,
      name: 'B2 L13',
      bbox: Rect.fromLTWH(1179.67, 5678.70, 110.22, 113.26),
      points: [
        Offset(1289.888, 5685.444),
        Offset(1186.131, 5678.697),
        Offset(1179.670, 5787.158),
        Offset(1284.865, 5791.953),
      ],
    ),
    // id 53: B2 L14
    Phase1LotAnnotation(
      id: 53,
      categoryId: 190,
      name: 'B2 L14',
      bbox: Rect.fromLTWH(1075.24, 5673.34, 110.86, 114.03),
      points: [
        Offset(1186.102, 5678.699),
        Offset(1081.621, 5673.336),
        Offset(1075.239, 5782.150),
        Offset(1180.258, 5787.366),
      ],
    ),
    // id 54: B2 L15
    Phase1LotAnnotation(
      id: 54,
      categoryId: 191,
      name: 'B2 L15',
      bbox: Rect.fromLTWH(970.15, 5666.99, 111.16, 113.05),
      points: [
        Offset(1081.302, 5674.129),
        Offset(976.669, 5666.994),
        Offset(970.147, 5773.937),
        Offset(1075.256, 5780.048),
      ],
    ),
    // id 55: B2 L16
    Phase1LotAnnotation(
      id: 55,
      categoryId: 192,
      name: 'B2 L16',
      bbox: Rect.fromLTWH(865.76, 5660.59, 111.25, 113.29),
      points: [
        Offset(977.009, 5667.242),
        Offset(871.882, 5660.585),
        Offset(865.763, 5767.711),
        Offset(970.913, 5773.872),
      ],
    ),
    // id 56: B2 L17
    Phase1LotAnnotation(
      id: 56,
      categoryId: 193,
      name: 'B2 L17',
      bbox: Rect.fromLTWH(669.19, 5648.85, 203.03, 119.50),
      points: [
        Offset(872.224, 5660.355),
        Offset(669.194, 5648.846),
        Offset(670.529, 5668.526),
        Offset(679.872, 5697.778),
        Offset(694.921, 5721.806),
        Offset(717.353, 5742.891),
        Offset(740.309, 5755.589),
        Offset(763.621, 5762.298),
        Offset(867.702, 5768.349),
      ],
    ),
    // id 57: B2 L18
    Phase1LotAnnotation(
      id: 57,
      categoryId: 194,
      name: 'B2 L18',
      bbox: Rect.fromLTWH(669.78, 5536.63, 209.03, 114.87),
      points: [
        Offset(872.716, 5651.500),
        Offset(878.810, 5542.307),
        Offset(782.244, 5536.634),
        Offset(765.556, 5537.816),
        Offset(745.019, 5542.654),
        Offset(727.391, 5550.820),
        Offset(709.324, 5563.082),
        Offset(697.752, 5573.868),
        Offset(685.985, 5589.639),
        Offset(677.653, 5604.774),
        Offset(672.347, 5623.336),
        Offset(669.778, 5639.714),
      ],
    ),
    // id 58: B2 L19
    Phase1LotAnnotation(
      id: 58,
      categoryId: 195,
      name: 'B2 L19',
      bbox: Rect.fromLTWH(873.12, 5542.78, 110.17, 114.68),
      points: [
        Offset(878.619, 5542.779),
        Offset(873.116, 5651.813),
        Offset(977.111, 5657.461),
        Offset(983.281, 5549.027),
      ],
    ),
    // id 59: B2 L20
    Phase1LotAnnotation(
      id: 59,
      categoryId: 197,
      name: 'B2 L20',
      bbox: Rect.fromLTWH(977.26, 5549.18, 110.69, 114.89),
      points: [
        Offset(983.896, 5549.175),
        Offset(977.255, 5658.139),
        Offset(1082.092, 5664.060),
        Offset(1087.947, 5554.757),
      ],
    ),
    // id 60: B2 L21
    Phase1LotAnnotation(
      id: 60,
      categoryId: 198,
      name: 'B2 L21',
      bbox: Rect.fromLTWH(1081.40, 5555.08, 110.42, 114.49),
      points: [
        Offset(1088.189, 5555.078),
        Offset(1081.402, 5662.759),
        Offset(1185.970, 5669.571),
        Offset(1191.819, 5559.901),
      ],
    ),
    // id 61: B2 L22
    Phase1LotAnnotation(
      id: 61,
      categoryId: 199,
      name: 'B2 L22',
      bbox: Rect.fromLTWH(1186.24, 5560.98, 110.16, 114.33),
      points: [
        Offset(1191.990, 5560.981),
        Offset(1186.237, 5669.896),
        Offset(1290.672, 5675.311),
        Offset(1296.395, 5566.299),
      ],
    ),
    // id 62: B2 L23
    Phase1LotAnnotation(
      id: 62,
      categoryId: 200,
      name: 'B2 L23',
      bbox: Rect.fromLTWH(1290.20, 5567.18, 110.31, 114.17),
      points: [
        Offset(1297.002, 5567.177),
        Offset(1290.203, 5676.065),
        Offset(1395.261, 5681.351),
        Offset(1400.517, 5573.224),
      ],
    ),
    // id 63: B2 L24
    Phase1LotAnnotation(
      id: 63,
      categoryId: 201,
      name: 'B2 L24',
      bbox: Rect.fromLTWH(1394.20, 5573.28, 111.18, 114.06),
      points: [
        Offset(1401.068, 5573.280),
        Offset(1394.204, 5681.547),
        Offset(1499.506, 5687.339),
        Offset(1505.382, 5578.221),
      ],
    ),
    // id 64: B2 L25
    Phase1LotAnnotation(
      id: 64,
      categoryId: 202,
      name: 'B2 L25',
      bbox: Rect.fromLTWH(1499.24, 5578.69, 111.57, 114.99),
      points: [
        Offset(1505.361, 5578.691),
        Offset(1499.235, 5687.525),
        Offset(1604.045, 5693.679),
        Offset(1610.801, 5584.130),
      ],
    ),
    // id 65: B2 L26
    Phase1LotAnnotation(
      id: 65,
      categoryId: 203,
      name: 'B2 L26',
      bbox: Rect.fromLTWH(1603.44, 5584.10, 111.38, 116.03),
      points: [
        Offset(1610.638, 5584.103),
        Offset(1603.438, 5694.416),
        Offset(1708.613, 5700.135),
        Offset(1714.818, 5590.252),
      ],
    ),
    // id 66: B2 L27
    Phase1LotAnnotation(
      id: 66,
      categoryId: 204,
      name: 'B2 L27',
      bbox: Rect.fromLTWH(1708.03, 5590.63, 109.83, 115.63),
      points: [
        Offset(1715.281, 5590.627),
        Offset(1708.030, 5700.216),
        Offset(1813.096, 5706.254),
        Offset(1817.856, 5597.441),
      ],
    ),
    // id 67: B2 L28
    Phase1LotAnnotation(
      id: 67,
      categoryId: 205,
      name: 'B2 L28',
      bbox: Rect.fromLTWH(1812.17, 5597.88, 110.14, 114.17),
      points: [
        Offset(1817.256, 5597.877),
        Offset(1812.168, 5706.704),
        Offset(1917.643, 5712.048),
        Offset(1922.306, 5602.390),
      ],
    ),
    // id 68: B2 L29
    Phase1LotAnnotation(
      id: 68,
      categoryId: 206,
      name: 'B2 L29',
      bbox: Rect.fromLTWH(1917.08, 5602.30, 110.25, 116.54),
      points: [
        Offset(1922.041, 5602.305),
        Offset(1917.083, 5712.644),
        Offset(2021.530, 5718.843),
        Offset(2027.334, 5609.461),
      ],
    ),
    // id 69: B2 L30
    Phase1LotAnnotation(
      id: 69,
      categoryId: 208,
      name: 'B2 L30',
      bbox: Rect.fromLTWH(2020.83, 5609.60, 111.09, 114.49),
      points: [
        Offset(2027.981, 5609.600),
        Offset(2020.832, 5718.241),
        Offset(2125.717, 5724.091),
        Offset(2131.926, 5615.292),
      ],
    ),
    // id 70: B2 L31
    Phase1LotAnnotation(
      id: 70,
      categoryId: 209,
      name: 'B2 L31',
      bbox: Rect.fromLTWH(2125.05, 5615.59, 111.10, 114.81),
      points: [
        Offset(2131.611, 5615.588),
        Offset(2125.049, 5724.114),
        Offset(2230.441, 5730.402),
        Offset(2236.144, 5621.649),
      ],
    ),
    // id 71: B2 L32
    Phase1LotAnnotation(
      id: 71,
      categoryId: 210,
      name: 'B2 L32',
      bbox: Rect.fromLTWH(2230.55, 5622.01, 109.29, 114.25),
      points: [
        Offset(2236.582, 5622.012),
        Offset(2230.547, 5730.381),
        Offset(2334.968, 5736.261),
        Offset(2339.838, 5628.017),
      ],
    ),
    // id 72: B2 L33
    Phase1LotAnnotation(
      id: 72,
      categoryId: 211,
      name: 'B2 L33',
      bbox: Rect.fromLTWH(2333.94, 5628.38, 111.06, 113.98),
      points: [
        Offset(2339.213, 5628.378),
        Offset(2333.944, 5736.811),
        Offset(2439.006, 5742.358),
        Offset(2445.005, 5633.496),
      ],
    ),
    // id 73: B2 L34
    Phase1LotAnnotation(
      id: 73,
      categoryId: 212,
      name: 'B2 L34',
      bbox: Rect.fromLTWH(2438.76, 5633.79, 111.39, 114.87),
      points: [
        Offset(2444.982, 5633.790),
        Offset(2438.760, 5742.062),
        Offset(2544.821, 5748.663),
        Offset(2550.153, 5639.470),
      ],
    ),
    // id 74: B2 L35
    Phase1LotAnnotation(
      id: 74,
      categoryId: 213,
      name: 'B2 L35',
      bbox: Rect.fromLTWH(2544.80, 5640.19, 190.70, 134.50),
      points: [
        Offset(2550.259, 5640.185),
        Offset(2544.799, 5747.920),
        Offset(2735.500, 5774.687),
        Offset(2681.265, 5640.619),
        Offset(2660.305, 5643.813),
        Offset(2635.295, 5644.820),
        Offset(2614.696, 5644.914),
      ],
    ),
    // id 75: B2 L36
    Phase1LotAnnotation(
      id: 75,
      categoryId: 214,
      name: 'B2 L36',
      bbox: Rect.fromLTWH(2680.87, 5587.39, 208.24, 186.92),
      points: [
        Offset(2680.867, 5640.377),
        Offset(2734.726, 5774.310),
        Offset(2889.111, 5701.886),
        Offset(2783.982, 5587.391),
        Offset(2764.821, 5603.585),
        Offset(2744.680, 5617.229),
        Offset(2720.665, 5628.728),
      ],
    ),
    // id 76: B2 L37
    Phase1LotAnnotation(
      id: 76,
      categoryId: 215,
      name: 'B2 L37',
      bbox: Rect.fromLTWH(2784.81, 5499.67, 332.02, 202.00),
      points: [
        Offset(2889.211, 5701.678),
        Offset(2784.811, 5586.468),
        Offset(2806.820, 5562.177),
        Offset(2823.133, 5536.649),
        Offset(2833.909, 5513.641),
        Offset(2839.505, 5499.674),
        Offset(3116.829, 5598.884),
      ],
    ),
    // id 77: B2 L38
    Phase1LotAnnotation(
      id: 77,
      categoryId: 216,
      name: 'B2 L38',
      bbox: Rect.fromLTWH(2839.10, 5366.92, 373.89, 232.02),
      points: [
        Offset(3116.864, 5598.932),
        Offset(3212.998, 5553.842),
        Offset(3061.103, 5366.916),
        Offset(2843.825, 5398.523),
        Offset(2846.362, 5412.630),
        Offset(2848.064, 5428.824),
        Offset(2848.353, 5444.192),
        Offset(2847.113, 5459.629),
        Offset(2843.571, 5480.619),
        Offset(2839.104, 5498.809),
      ],
    ),
    // id 78: B2 L39
    Phase1LotAnnotation(
      id: 78,
      categoryId: 217,
      name: 'B2 L39',
      bbox: Rect.fromLTWH(2808.43, 5176.13, 252.43, 223.14),
      points: [
        Offset(3060.851, 5366.756),
        Offset(2996.627, 5288.763),
        Offset(2991.871, 5176.134),
        Offset(2808.426, 5315.747),
        Offset(2820.435, 5334.251),
        Offset(2831.455, 5354.373),
        Offset(2840.178, 5376.703),
        Offset(2844.732, 5399.276),
      ],
    ),
    // id 79: B2 L40
    Phase1LotAnnotation(
      id: 79,
      categoryId: 219,
      name: 'B2 L40',
      bbox: Rect.fromLTWH(2740.98, 5109.73, 249.93, 205.77),
      points: [
        Offset(2749.636, 5109.728),
        Offset(2740.983, 5255.061),
        Offset(2764.635, 5270.188),
        Offset(2782.143, 5285.348),
        Offset(2798.401, 5302.668),
        Offset(2808.284, 5315.499),
        Offset(2990.910, 5176.305),
      ],
    ),
    // id 80: B2 L41
    Phase1LotAnnotation(
      id: 80,
      categoryId: 220,
      name: 'B2 L41',
      bbox: Rect.fromLTWH(2640.84, 5101.36, 108.16, 154.37),
      points: [
        Offset(2749.006, 5109.373),
        Offset(2648.829, 5101.358),
        Offset(2640.843, 5230.037),
        Offset(2670.427, 5231.211),
        Offset(2689.127, 5235.016),
        Offset(2711.180, 5240.715),
        Offset(2740.226, 5255.729),
      ],
    ),
    // id 81: B2 L42
    Phase1LotAnnotation(
      id: 81,
      categoryId: 221,
      name: 'B2 L42',
      bbox: Rect.fromLTWH(2541.96, 5093.32, 106.69, 136.04),
      points: [
        Offset(2648.649, 5101.502),
        Offset(2548.333, 5093.323),
        Offset(2541.955, 5221.670),
        Offset(2639.959, 5229.358),
      ],
    ),
    // id 82: B2 L43
    Phase1LotAnnotation(
      id: 82,
      categoryId: 222,
      name: 'B2 L43',
      bbox: Rect.fromLTWH(2442.27, 5085.46, 106.94, 136.13),
      points: [
        Offset(2549.215, 5093.454),
        Offset(2449.010, 5085.464),
        Offset(2442.274, 5211.348),
        Offset(2540.745, 5221.593),
      ],
    ),
    // id 83: B2 L44
    Phase1LotAnnotation(
      id: 83,
      categoryId: 223,
      name: 'B2 L44',
      bbox: Rect.fromLTWH(2341.69, 5077.71, 108.21, 133.35),
      points: [
        Offset(2449.902, 5085.268),
        Offset(2347.730, 5077.713),
        Offset(2341.688, 5202.295),
        Offset(2441.823, 5211.058),
      ],
    ),
    // id 84: B2 L45
    Phase1LotAnnotation(
      id: 84,
      categoryId: 224,
      name: 'B2 L45',
      bbox: Rect.fromLTWH(2242.19, 5069.40, 106.37, 132.32),
      points: [
        Offset(2348.560, 5078.380),
        Offset(2248.305, 5069.396),
        Offset(2242.188, 5192.585),
        Offset(2343.076, 5201.721),
      ],
    ),
    // id 85: B2 L46
    Phase1LotAnnotation(
      id: 85,
      categoryId: 225,
      name: 'B2 L46',
      bbox: Rect.fromLTWH(2142.03, 5061.29, 107.16, 131.62),
      points: [
        Offset(2249.187, 5069.525),
        Offset(2148.530, 5061.289),
        Offset(2142.025, 5185.269),
        Offset(2241.369, 5192.904),
      ],
    ),
    // id 86: B2 L47
    Phase1LotAnnotation(
      id: 86,
      categoryId: 226,
      name: 'B2 L47',
      bbox: Rect.fromLTWH(2042.64, 5052.71, 105.69, 132.16),
      points: [
        Offset(2148.337, 5061.162),
        Offset(2048.347, 5052.707),
        Offset(2042.643, 5174.871),
        Offset(2142.299, 5184.862),
      ],
    ),
    // id 87: B2 L48
    Phase1LotAnnotation(
      id: 87,
      categoryId: 227,
      name: 'B2 L48',
      bbox: Rect.fromLTWH(1942.49, 5045.19, 106.48, 129.17),
      points: [
        Offset(2048.964, 5052.799),
        Offset(1947.845, 5045.191),
        Offset(1942.488, 5166.395),
        Offset(2042.734, 5174.364),
      ],
    ),
    // id 88: B2 L49
    Phase1LotAnnotation(
      id: 88,
      categoryId: 228,
      name: 'B2 L49',
      bbox: Rect.fromLTWH(1841.17, 5037.24, 106.94, 128.25),
      points: [
        Offset(1948.114, 5045.420),
        Offset(1848.635, 5037.237),
        Offset(1841.173, 5155.789),
        Offset(1941.979, 5165.490),
      ],
    ),
    // id 89: B2 L50
    Phase1LotAnnotation(
      id: 89,
      categoryId: 230,
      name: 'B2 L50',
      bbox: Rect.fromLTWH(1741.98, 5029.04, 107.26, 126.34),
      points: [
        Offset(1849.233, 5036.565),
        Offset(1748.722, 5029.041),
        Offset(1741.977, 5146.286),
        Offset(1840.645, 5155.376),
      ],
    ),
    // id 90: B2 L51
    Phase1LotAnnotation(
      id: 90,
      categoryId: 231,
      name: 'B2 L51',
      bbox: Rect.fromLTWH(1643.38, 5021.35, 104.97, 124.51),
      points: [
        Offset(1748.350, 5029.635),
        Offset(1647.736, 5021.349),
        Offset(1643.383, 5137.372),
        Offset(1742.057, 5145.859),
      ],
    ),
    // id 91: B2 L52
    Phase1LotAnnotation(
      id: 91,
      categoryId: 232,
      name: 'B2 L52',
      bbox: Rect.fromLTWH(1543.29, 5013.89, 105.10, 122.87),
      points: [
        Offset(1648.393, 5021.728),
        Offset(1548.579, 5013.885),
        Offset(1543.290, 5128.507),
        Offset(1643.350, 5136.759),
      ],
    ),
    // id 92: B2 L53
    Phase1LotAnnotation(
      id: 92,
      categoryId: 233,
      name: 'B2 L53',
      bbox: Rect.fromLTWH(1442.67, 5005.87, 105.95, 121.08),
      points: [
        Offset(1548.621, 5013.987),
        Offset(1447.513, 5005.865),
        Offset(1442.668, 5118.692),
        Offset(1543.415, 5126.942),
      ],
    ),
    // id 93: B2 L54
    Phase1LotAnnotation(
      id: 93,
      categoryId: 234,
      name: 'B2 L54',
      bbox: Rect.fromLTWH(1341.85, 4997.63, 106.14, 120.26),
      points: [
        Offset(1447.988, 5005.386),
        Offset(1347.999, 4997.632),
        Offset(1341.847, 5108.525),
        Offset(1442.218, 5117.892),
      ],
    ),
    // id 94: B2 L55
    Phase1LotAnnotation(
      id: 94,
      categoryId: 235,
      name: 'B2 L55',
      bbox: Rect.fromLTWH(1242.45, 4989.61, 106.20, 119.51),
      points: [
        Offset(1348.646, 4997.645),
        Offset(1248.324, 4989.607),
        Offset(1242.450, 5099.514),
        Offset(1342.451, 5109.121),
      ],
    ),
    // id 95: B2 L56
    Phase1LotAnnotation(
      id: 95,
      categoryId: 236,
      name: 'B2 L56',
      bbox: Rect.fromLTWH(1141.55, 4982.06, 106.89, 117.91),
      points: [
        Offset(1248.444, 4989.044),
        Offset(1147.643, 4982.059),
        Offset(1141.554, 5091.308),
        Offset(1242.799, 5099.969),
      ],
    ),
    // id 96: B2 L57
    Phase1LotAnnotation(
      id: 96,
      categoryId: 237,
      name: 'B2 L57',
      bbox: Rect.fromLTWH(1041.71, 4973.26, 106.53, 116.18),
      points: [
        Offset(1148.241, 4981.303),
        Offset(1047.787, 4973.263),
        Offset(1041.707, 5079.535),
        Offset(1141.473, 5089.441),
      ],
    ),
    // id 97: B2 L58
    Phase1LotAnnotation(
      id: 97,
      categoryId: 238,
      name: 'B2 L58',
      bbox: Rect.fromLTWH(941.67, 4965.11, 106.37, 114.85),
      points: [
        Offset(1048.039, 4973.132),
        Offset(948.116, 4965.107),
        Offset(941.665, 5072.790),
        Offset(1042.524, 5079.958),
      ],
    ),
    // id 98: B2 L59
    Phase1LotAnnotation(
      id: 98,
      categoryId: 239,
      name: 'B2 L59',
      bbox: Rect.fromLTWH(839.76, 4957.04, 109.79, 114.13),
      points: [
        Offset(949.557, 4964.961),
        Offset(846.200, 4957.040),
        Offset(839.764, 5061.726),
        Offset(942.278, 5071.174),
      ],
    ),
    // id 99: B2 L60
    Phase1LotAnnotation(
      id: 99,
      categoryId: 241,
      name: 'B2 L60',
      bbox: Rect.fromLTWH(697.42, 4946.77, 148.96, 114.14),
      points: [
        Offset(846.379, 4957.766),
        Offset(697.418, 4946.773),
        Offset(698.569, 4967.862),
        Offset(704.069, 4990.670),
        Offset(722.192, 5020.388),
        Offset(744.464, 5040.553),
        Offset(768.160, 5052.146),
        Offset(787.078, 5056.841),
        Offset(811.722, 5059.858),
        Offset(840.055, 5060.917),
      ],
    ),
    // id 100: B2 L61
    Phase1LotAnnotation(
      id: 100,
      categoryId: 242,
      name: 'B2 L61',
      bbox: Rect.fromLTWH(696.25, 4838.73, 157.03, 108.60),
      points: [
        Offset(846.774, 4947.329),
        Offset(853.287, 4843.179),
        Offset(798.801, 4838.731),
        Offset(785.601, 4839.253),
        Offset(769.200, 4843.322),
        Offset(750.919, 4851.652),
        Offset(735.357, 4862.988),
        Offset(721.531, 4876.768),
        Offset(709.088, 4893.238),
        Offset(702.466, 4910.850),
        Offset(699.209, 4920.765),
        Offset(696.254, 4937.009),
      ],
    ),
    // id 101: B2 L62
    Phase1LotAnnotation(
      id: 101,
      categoryId: 243,
      name: 'B2 L62',
      bbox: Rect.fromLTWH(847.20, 4841.93, 108.46, 113.77),
      points: [
        Offset(847.204, 4948.189),
        Offset(853.250, 4841.934),
        Offset(955.662, 4848.519),
        Offset(948.226, 4955.708),
      ],
    ),
    // id 102: B2 L63
    Phase1LotAnnotation(
      id: 102,
      categoryId: 244,
      name: 'B2 L63',
      bbox: Rect.fromLTWH(948.42, 4848.85, 106.45, 113.99),
      points: [
        Offset(955.148, 4848.847),
        Offset(948.420, 4955.977),
        Offset(1049.296, 4962.839),
        Offset(1054.871, 4855.750),
      ],
    ),
    // id 103: B2 L64
    Phase1LotAnnotation(
      id: 103,
      categoryId: 245,
      name: 'B2 L64',
      bbox: Rect.fromLTWH(1049.08, 4855.73, 105.60, 115.89),
      points: [
        Offset(1054.490, 4855.728),
        Offset(1049.079, 4964.120),
        Offset(1148.853, 4971.619),
        Offset(1154.674, 4862.612),
      ],
    ),
    // id 104: B2 L65
    Phase1LotAnnotation(
      id: 104,
      categoryId: 246,
      name: 'B2 L65',
      bbox: Rect.fromLTWH(1148.81, 4862.18, 105.48, 118.05),
      points: [
        Offset(1153.832, 4862.179),
        Offset(1148.814, 4972.591),
        Offset(1249.151, 4980.231),
        Offset(1254.291, 4869.290),
      ],
    ),
    // id 105: B2 L66
    Phase1LotAnnotation(
      id: 105,
      categoryId: 247,
      name: 'B2 L66',
      bbox: Rect.fromLTWH(1248.85, 4869.49, 105.88, 118.37),
      points: [
        Offset(1254.464, 4869.489),
        Offset(1248.850, 4980.110),
        Offset(1350.524, 4987.863),
        Offset(1354.734, 4876.202),
      ],
    ),
    // id 106: B2 L67
    Phase1LotAnnotation(
      id: 106,
      categoryId: 248,
      name: 'B2 L67',
      bbox: Rect.fromLTWH(1348.97, 4876.37, 106.60, 120.10),
      points: [
        Offset(1354.667, 4876.370),
        Offset(1348.965, 4988.614),
        Offset(1449.411, 4996.469),
        Offset(1455.561, 4884.247),
      ],
    ),
    // id 107: B2 L68
    Phase1LotAnnotation(
      id: 107,
      categoryId: 249,
      name: 'B2 L68',
      bbox: Rect.fromLTWH(1448.82, 4884.54, 107.00, 119.77),
      points: [
        Offset(1455.729, 4884.541),
        Offset(1448.825, 4996.295),
        Offset(1549.536, 5004.306),
        Offset(1555.826, 4889.986),
      ],
    ),
    // id 108: B2 L69
    Phase1LotAnnotation(
      id: 108,
      categoryId: 250,
      name: 'B2 L69',
      bbox: Rect.fromLTWH(1549.07, 4890.56, 107.41, 121.54),
      points: [
        Offset(1555.932, 4890.562),
        Offset(1549.067, 5003.972),
        Offset(1650.093, 5012.099),
        Offset(1656.480, 4897.745),
      ],
    ),
    // id 109: B2 L70
    Phase1LotAnnotation(
      id: 109,
      categoryId: 252,
      name: 'B2 L70',
      bbox: Rect.fromLTWH(1649.33, 4897.87, 106.27, 122.63),
      points: [
        Offset(1656.564, 4897.873),
        Offset(1649.334, 5012.422),
        Offset(1750.038, 5020.498),
        Offset(1755.604, 4903.999),
      ],
    ),
    // id 110: B2 L71
    Phase1LotAnnotation(
      id: 110,
      categoryId: 253,
      name: 'B2 L71',
      bbox: Rect.fromLTWH(1750.30, 4904.32, 106.87, 123.65),
      points: [
        Offset(1754.616, 4904.324),
        Offset(1750.297, 5020.043),
        Offset(1849.159, 5027.969),
        Offset(1857.168, 4911.893),
      ],
    ),
    // id 111: B2 L72
    Phase1LotAnnotation(
      id: 111,
      categoryId: 254,
      name: 'B2 L72',
      bbox: Rect.fromLTWH(1848.42, 4911.64, 107.60, 123.81),
      points: [
        Offset(1856.969, 4911.635),
        Offset(1848.420, 5027.786),
        Offset(1950.240, 5035.446),
        Offset(1956.024, 4919.616),
      ],
    ),
    // id 112: B2 L73
    Phase1LotAnnotation(
      id: 112,
      categoryId: 255,
      name: 'B2 L73',
      bbox: Rect.fromLTWH(1949.25, 4919.81, 106.09, 123.92),
      points: [
        Offset(1956.311, 4919.806),
        Offset(1949.247, 5036.629),
        Offset(2049.390, 5043.725),
        Offset(2055.339, 4925.806),
      ],
    ),
    // id 113: B2 L74
    Phase1LotAnnotation(
      id: 113,
      categoryId: 256,
      name: 'B2 L74',
      bbox: Rect.fromLTWH(2048.93, 4926.26, 107.45, 125.60),
      points: [
        Offset(2055.653, 4926.256),
        Offset(2048.932, 5044.311),
        Offset(2149.255, 5051.852),
        Offset(2156.381, 4933.445),
      ],
    ),
    // id 114: B2 L75
    Phase1LotAnnotation(
      id: 114,
      categoryId: 257,
      name: 'B2 L75',
      bbox: Rect.fromLTWH(2149.12, 4933.09, 107.92, 125.99),
      points: [
        Offset(2156.464, 4933.089),
        Offset(2149.124, 5051.823),
        Offset(2249.901, 5059.082),
        Offset(2257.045, 4938.090),
      ],
    ),
    // id 115: B2 L76
    Phase1LotAnnotation(
      id: 115,
      categoryId: 258,
      name: 'B2 L76',
      bbox: Rect.fromLTWH(2249.96, 4939.59, 106.74, 127.85),
      points: [
        Offset(2257.348, 4939.588),
        Offset(2249.958, 5059.964),
        Offset(2349.490, 5067.441),
        Offset(2356.693, 4946.623),
      ],
    ),
    // id 116: B2 L77
    Phase1LotAnnotation(
      id: 116,
      categoryId: 259,
      name: 'B2 L77',
      bbox: Rect.fromLTWH(2349.38, 4946.47, 108.18, 129.65),
      points: [
        Offset(2356.690, 4946.469),
        Offset(2349.383, 5067.588),
        Offset(2449.568, 5076.115),
        Offset(2457.559, 4954.324),
      ],
    ),
    // id 117: B2 L78
    Phase1LotAnnotation(
      id: 117,
      categoryId: 260,
      name: 'B2 L78',
      bbox: Rect.fromLTWH(2449.54, 4954.21, 107.40, 129.07),
      points: [
        Offset(2457.753, 4954.210),
        Offset(2449.536, 5075.673),
        Offset(2550.283, 5083.285),
        Offset(2556.937, 4962.021),
      ],
    ),
    // id 118: B2 L79
    Phase1LotAnnotation(
      id: 118,
      categoryId: 261,
      name: 'B2 L79',
      bbox: Rect.fromLTWH(2549.66, 4961.95, 107.13, 130.32),
      points: [
        Offset(2556.235, 4961.951),
        Offset(2549.656, 5083.733),
        Offset(2649.435, 5092.269),
        Offset(2656.788, 4967.953),
      ],
    ),
    // id 119: B2 L80
    Phase1LotAnnotation(
      id: 119,
      categoryId: 263,
      name: 'B2 L80',
      bbox: Rect.fromLTWH(2649.73, 4968.83, 106.04, 130.58),
      points: [
        Offset(2657.297, 4968.832),
        Offset(2755.767, 4973.122),
        Offset(2749.737, 5099.413),
        Offset(2649.731, 5092.091),
      ],
    ),
    // id 120: B2 L81
    Phase1LotAnnotation(
      id: 120,
      categoryId: 264,
      name: 'B2 L81',
      bbox: Rect.fromLTWH(2749.16, 4988.18, 326.90, 181.67),
      points: [
        Offset(2754.919, 4988.184),
        Offset(2749.164, 5099.405),
        Offset(3000.706, 5169.858),
        Offset(3076.066, 5093.712),
        Offset(2984.300, 5003.997),
      ],
    ),
    // id 121: B3 L1
    Phase1LotAnnotation(
      id: 121,
      categoryId: 278,
      name: 'B3 L1',
      bbox: Rect.fromLTWH(2564.20, 5326.00, 165.84, 110.85),
      points: [
        Offset(2569.095, 5326.001),
        Offset(2564.200, 5426.564),
        Offset(2730.041, 5436.852),
        Offset(2726.597, 5400.986),
        Offset(2708.382, 5368.207),
        Offset(2680.509, 5343.138),
        Offset(2647.025, 5329.297),
      ],
    ),
    // id 122: B3 L2
    Phase1LotAnnotation(
      id: 122,
      categoryId: 289,
      name: 'B3 L2',
      bbox: Rect.fromLTWH(2458.25, 5313.55, 109.97, 113.72),
      points: [
        Offset(2568.216, 5323.510),
        Offset(2464.732, 5313.551),
        Offset(2458.246, 5419.885),
        Offset(2563.130, 5427.275),
      ],
    ),
    // id 123: B3 L3
    Phase1LotAnnotation(
      id: 123,
      categoryId: 293,
      name: 'B3 L3',
      bbox: Rect.fromLTWH(2351.06, 5305.46, 113.69, 114.12),
      points: [
        Offset(2464.747, 5313.250),
        Offset(2356.639, 5305.460),
        Offset(2351.058, 5412.425),
        Offset(2457.907, 5419.578),
      ],
    ),
    // id 124: B3 L4
    Phase1LotAnnotation(
      id: 124,
      categoryId: 294,
      name: 'B3 L4',
      bbox: Rect.fromLTWH(2247.33, 5296.16, 109.20, 115.37),
      points: [
        Offset(2356.533, 5305.767),
        Offset(2252.018, 5296.156),
        Offset(2247.332, 5403.440),
        Offset(2351.807, 5411.525),
      ],
    ),
    // id 125: B3 L5
    Phase1LotAnnotation(
      id: 125,
      categoryId: 295,
      name: 'B3 L5',
      bbox: Rect.fromLTWH(2147.19, 5285.24, 105.24, 118.27),
      points: [
        Offset(2252.427, 5295.074),
        Offset(2151.875, 5285.244),
        Offset(2147.192, 5396.076),
        Offset(2248.320, 5403.516),
      ],
    ),
    // id 126: B3 L6
    Phase1LotAnnotation(
      id: 126,
      categoryId: 296,
      name: 'B3 L6',
      bbox: Rect.fromLTWH(2048.16, 5276.49, 103.25, 118.77),
      points: [
        Offset(2151.405, 5285.346),
        Offset(2054.261, 5276.489),
        Offset(2048.158, 5387.360),
        Offset(2147.534, 5395.258),
      ],
    ),
    // id 127: B3 L7
    Phase1LotAnnotation(
      id: 127,
      categoryId: 297,
      name: 'B3 L7',
      bbox: Rect.fromLTWH(1947.12, 5266.09, 107.75, 122.48),
      points: [
        Offset(2054.872, 5276.366),
        Offset(1953.554, 5266.092),
        Offset(1947.123, 5381.417),
        Offset(2047.664, 5388.567),
      ],
    ),
    // id 128: B3 L8
    Phase1LotAnnotation(
      id: 128,
      categoryId: 298,
      name: 'B3 L8',
      bbox: Rect.fromLTWH(1847.21, 5258.26, 107.39, 122.34),
      points: [
        Offset(1954.598, 5265.890),
        Offset(1853.020, 5258.258),
        Offset(1847.206, 5374.340),
        Offset(1947.717, 5380.595),
      ],
    ),
    // id 129: B3 L9
    Phase1LotAnnotation(
      id: 129,
      categoryId: 299,
      name: 'B3 L9',
      bbox: Rect.fromLTWH(1746.60, 5247.56, 106.97, 125.25),
      points: [
        Offset(1853.575, 5258.407),
        Offset(1753.135, 5247.556),
        Offset(1746.604, 5365.758),
        Offset(1847.127, 5372.805),
      ],
    ),
    // id 130: B3 L10
    Phase1LotAnnotation(
      id: 130,
      categoryId: 279,
      name: 'B3 L10',
      bbox: Rect.fromLTWH(1646.31, 5237.94, 106.24, 126.81),
      points: [
        Offset(1752.553, 5247.182),
        Offset(1653.407, 5237.939),
        Offset(1646.313, 5359.479),
        Offset(1746.821, 5364.752),
      ],
    ),
    // id 131: B3 L11
    Phase1LotAnnotation(
      id: 131,
      categoryId: 280,
      name: 'B3 L11',
      bbox: Rect.fromLTWH(1546.69, 5228.05, 105.59, 129.42),
      points: [
        Offset(1652.279, 5236.706),
        Offset(1553.036, 5228.050),
        Offset(1546.693, 5350.564),
        Offset(1646.640, 5357.474),
      ],
    ),
    // id 132: B3 L12
    Phase1LotAnnotation(
      id: 132,
      categoryId: 281,
      name: 'B3 L12',
      bbox: Rect.fromLTWH(1445.95, 5220.00, 106.80, 131.60),
      points: [
        Offset(1552.753, 5227.726),
        Offset(1452.768, 5220.003),
        Offset(1445.954, 5344.440),
        Offset(1546.342, 5351.598),
      ],
    ),
    // id 133: B3 L13
    Phase1LotAnnotation(
      id: 133,
      categoryId: 282,
      name: 'B3 L13',
      bbox: Rect.fromLTWH(1346.95, 5210.27, 105.54, 132.78),
      points: [
        Offset(1452.485, 5220.146),
        Offset(1352.769, 5210.266),
        Offset(1346.946, 5335.483),
        Offset(1446.159, 5343.042),
      ],
    ),
    // id 134: B3 L14
    Phase1LotAnnotation(
      id: 134,
      categoryId: 283,
      name: 'B3 L14',
      bbox: Rect.fromLTWH(1246.00, 5201.87, 106.95, 133.59),
      points: [
        Offset(1352.953, 5209.018),
        Offset(1253.325, 5201.874),
        Offset(1245.999, 5327.895),
        Offset(1347.639, 5335.463),
      ],
    ),
    // id 135: B3 L15
    Phase1LotAnnotation(
      id: 135,
      categoryId: 284,
      name: 'B3 L15',
      bbox: Rect.fromLTWH(1146.93, 5193.15, 105.75, 135.18),
      points: [
        Offset(1252.679, 5201.535),
        Offset(1152.217, 5193.146),
        Offset(1146.932, 5321.636),
        Offset(1246.578, 5328.327),
      ],
    ),
    // id 136: B3 L16
    Phase1LotAnnotation(
      id: 136,
      categoryId: 285,
      name: 'B3 L16',
      bbox: Rect.fromLTWH(1046.61, 5182.70, 105.05, 137.55),
      points: [
        Offset(1151.656, 5192.555),
        Offset(1051.695, 5182.696),
        Offset(1046.606, 5312.908),
        Offset(1147.105, 5320.248),
      ],
    ),
    // id 137: B3 L17
    Phase1LotAnnotation(
      id: 137,
      categoryId: 286,
      name: 'B3 L17',
      bbox: Rect.fromLTWH(946.46, 5174.57, 105.67, 138.51),
      points: [
        Offset(1052.130, 5182.079),
        Offset(952.125, 5174.572),
        Offset(946.457, 5305.486),
        Offset(1046.430, 5313.083),
      ],
    ),
    // id 138: B3 L18
    Phase1LotAnnotation(
      id: 138,
      categoryId: 287,
      name: 'B3 L18',
      bbox: Rect.fromLTWH(846.76, 5163.92, 105.10, 141.58),
      points: [
        Offset(951.856, 5175.344),
        Offset(854.096, 5163.917),
        Offset(846.756, 5298.898),
        Offset(945.522, 5305.495),
      ],
    ),
    // id 139: B3 L19
    Phase1LotAnnotation(
      id: 139,
      categoryId: 288,
      name: 'B3 L19',
      bbox: Rect.fromLTWH(745.64, 5153.79, 108.18, 143.85),
      points: [
        Offset(853.827, 5163.371),
        Offset(751.814, 5153.789),
        Offset(745.643, 5289.892),
        Offset(846.627, 5297.644),
      ],
    ),
    // id 140: B3 L20
    Phase1LotAnnotation(
      id: 140,
      categoryId: 290,
      name: 'B3 L20',
      bbox: Rect.fromLTWH(442.85, 5092.34, 310.47, 197.41),
      points: [
        Offset(745.748, 5289.748),
        Offset(442.853, 5269.138),
        Offset(641.358, 5092.342),
        Offset(656.778, 5108.042),
        Offset(679.116, 5124.236),
        Offset(703.483, 5138.147),
        Offset(728.873, 5147.165),
        Offset(753.325, 5154.599),
      ],
    ),
    // id 141: B3 L21
    Phase1LotAnnotation(
      id: 141,
      categoryId: 291,
      name: 'B3 L21',
      bbox: Rect.fromLTWH(444.57, 5007.60, 196.04, 258.76),
      points: [
        Offset(640.604, 5092.848),
        Offset(621.507, 5072.114),
        Offset(603.913, 5044.482),
        Offset(592.934, 5017.666),
        Offset(589.836, 5007.602),
        Offset(444.569, 5042.039),
        Offset(445.008, 5266.366),
      ],
    ),
    // id 142: B3 L22
    Phase1LotAnnotation(
      id: 142,
      categoryId: 292,
      name: 'B3 L22',
      bbox: Rect.fromLTWH(445.25, 4869.28, 144.48, 172.78),
      points: [
        Offset(445.247, 4869.283),
        Offset(446.186, 5042.062),
        Offset(589.727, 5005.202),
        Offset(583.682, 4981.700),
        Offset(579.605, 4954.781),
        Offset(580.523, 4930.318),
        Offset(584.136, 4906.623),
      ],
    ),
    // id 143: B3 L23
    Phase1LotAnnotation(
      id: 143,
      categoryId: 293,
      name: 'B3 L23',
      bbox: Rect.fromLTWH(445.19, 4607.37, 189.18, 296.53),
      points: [
        Offset(445.247, 4607.373),
        Offset(445.192, 4870.257),
        Offset(585.354, 4903.899),
        Offset(588.687, 4889.342),
        Offset(593.662, 4871.686),
        Offset(602.440, 4852.259),
        Offset(612.496, 4834.832),
        Offset(625.231, 4818.939),
        Offset(634.372, 4808.418),
      ],
    ),
    // id 144: B3 L24
    Phase1LotAnnotation(
      id: 144,
      categoryId: 294,
      name: 'B3 L24',
      bbox: Rect.fromLTWH(445.25, 4606.63, 282.56, 199.64),
      points: [
        Offset(445.247, 4606.625),
        Offset(727.809, 4627.668),
        Offset(720.744, 4747.583),
        Offset(697.184, 4757.173),
        Offset(678.175, 4768.346),
        Offset(654.229, 4786.451),
        Offset(635.459, 4806.267),
      ],
    ),
    // id 145: B3 L25
    Phase1LotAnnotation(
      id: 145,
      categoryId: 295,
      name: 'B3 L25',
      bbox: Rect.fromLTWH(719.73, 4625.77, 108.15, 124.32),
      points: [
        Offset(728.110, 4627.578),
        Offset(827.884, 4625.771),
        Offset(821.477, 4739.351),
        Offset(792.623, 4737.434),
        Offset(766.341, 4738.907),
        Offset(740.843, 4743.195),
        Offset(719.733, 4750.094),
      ],
    ),
    // id 146: B3 L26
    Phase1LotAnnotation(
      id: 146,
      categoryId: 296,
      name: 'B3 L26',
      bbox: Rect.fromLTWH(822.78, 4625.33, 105.41, 121.06),
      points: [
        Offset(828.384, 4625.333),
        Offset(822.784, 4741.570),
        Offset(921.494, 4746.393),
        Offset(928.197, 4633.775),
      ],
    ),
    // id 147: B3 L27
    Phase1LotAnnotation(
      id: 147,
      categoryId: 297,
      name: 'B3 L27',
      bbox: Rect.fromLTWH(921.08, 4634.31, 106.87, 119.73),
      points: [
        Offset(927.910, 4634.312),
        Offset(921.082, 4748.273),
        Offset(1022.826, 4754.043),
        Offset(1027.948, 4641.433),
      ],
    ),
    // id 148: B3 L28
    Phase1LotAnnotation(
      id: 148,
      categoryId: 298,
      name: 'B3 L28',
      bbox: Rect.fromLTWH(1021.68, 4641.80, 107.13, 117.58),
      points: [
        Offset(1028.184, 4641.796),
        Offset(1128.812, 4648.902),
        Offset(1120.920, 4759.377),
        Offset(1021.680, 4753.750),
      ],
    ),
    // id 149: B3 L29
    Phase1LotAnnotation(
      id: 149,
      categoryId: 299,
      name: 'B3 L29',
      bbox: Rect.fromLTWH(1123.78, 4650.03, 105.47, 116.95),
      points: [
        Offset(1129.207, 4650.027),
        Offset(1123.781, 4761.961),
        Offset(1222.354, 4766.978),
        Offset(1229.247, 4656.762),
      ],
    ),
    // id 150: B3 L30
    Phase1LotAnnotation(
      id: 150,
      categoryId: 300,
      name: 'B3 L30',
      bbox: Rect.fromLTWH(1222.92, 4656.76, 105.86, 116.13),
      points: [
        Offset(1227.236, 4656.762),
        Offset(1222.921, 4768.267),
        Offset(1323.032, 4772.891),
        Offset(1328.785, 4664.388),
      ],
    ),
    // id 151: B3 L31
    Phase1LotAnnotation(
      id: 151,
      categoryId: 301,
      name: 'B3 L31',
      bbox: Rect.fromLTWH(1321.85, 4667.24, 106.16, 113.71),
      points: [
        Offset(1328.258, 4667.238),
        Offset(1321.851, 4774.510),
        Offset(1423.309, 4780.950),
        Offset(1428.009, 4673.073),
      ],
    ),
    // id 152: B3 L32
    Phase1LotAnnotation(
      id: 152,
      categoryId: 302,
      name: 'B3 L32',
      bbox: Rect.fromLTWH(1423.19, 4674.72, 105.38, 114.19),
      points: [
        Offset(1427.784, 4674.721),
        Offset(1423.186, 4782.283),
        Offset(1519.859, 4788.915),
        Offset(1528.561, 4681.842),
      ],
    ),
    // id 153: B3 L33
    Phase1LotAnnotation(
      id: 153,
      categoryId: 303,
      name: 'B3 L33',
      bbox: Rect.fromLTWH(1523.28, 4681.46, 108.33, 115.17),
      points: [
        Offset(1527.310, 4681.456),
        Offset(1523.276, 4788.588),
        Offset(1625.436, 4796.627),
        Offset(1631.606, 4689.311),
      ],
    ),
    // id 154: B3 L34
    Phase1LotAnnotation(
      id: 154,
      categoryId: 304,
      name: 'B3 L34',
      bbox: Rect.fromLTWH(1626.94, 4688.94, 111.00, 113.59),
      points: [
        Offset(1632.074, 4688.939),
        Offset(1626.938, 4796.881),
        Offset(1732.544, 4802.525),
        Offset(1737.934, 4696.721),
      ],
    ),
    // id 155: B3 L35
    Phase1LotAnnotation(
      id: 155,
      categoryId: 305,
      name: 'B3 L35',
      bbox: Rect.fromLTWH(1732.89, 4698.67, 108.82, 110.89),
      points: [
        Offset(1736.838, 4698.667),
        Offset(1732.892, 4804.306),
        Offset(1835.423, 4809.555),
        Offset(1841.713, 4705.510),
      ],
    ),
    // id 156: B3 L36
    Phase1LotAnnotation(
      id: 156,
      categoryId: 306,
      name: 'B3 L36',
      bbox: Rect.fromLTWH(1838.12, 4704.65, 107.98, 111.95),
      points: [
        Offset(1840.854, 4704.654),
        Offset(1838.121, 4812.327),
        Offset(1940.856, 4816.603),
        Offset(1946.100, 4714.593),
      ],
    ),
    // id 157: B3 L37
    Phase1LotAnnotation(
      id: 157,
      categoryId: 307,
      name: 'B3 L37',
      bbox: Rect.fromLTWH(1940.51, 4714.38, 110.05, 110.74),
      points: [
        Offset(1945.618, 4714.382),
        Offset(1940.508, 4819.117),
        Offset(2044.755, 4825.124),
        Offset(2050.555, 4721.395),
      ],
    ),
    // id 158: B3 L38
    Phase1LotAnnotation(
      id: 158,
      categoryId: 308,
      name: 'B3 L38',
      bbox: Rect.fromLTWH(2046.13, 4721.87, 225.40, 112.62),
      points: [
        Offset(2050.382, 4721.865),
        Offset(2046.132, 4825.486),
        Offset(2172.159, 4834.487),
        Offset(2198.417, 4829.196),
        Offset(2226.178, 4815.273),
        Offset(2245.523, 4797.296),
        Offset(2257.829, 4779.135),
        Offset(2267.902, 4757.331),
        Offset(2271.535, 4739.661),
      ],
    ),
    // id 159: B4 L1
    Phase1LotAnnotation(
      id: 159,
      categoryId: 309,
      name: 'B4 L1',
      bbox: Rect.fromLTWH(2050.46, 4609.21, 219.58, 119.39),
      points: [
        Offset(2050.456, 4712.533),
        Offset(2056.649, 4609.214),
        Offset(2189.279, 4620.421),
        Offset(2218.757, 4632.063),
        Offset(2238.205, 4647.206),
        Offset(2254.763, 4668.222),
        Offset(2264.605, 4689.421),
        Offset(2269.690, 4712.305),
        Offset(2270.039, 4728.599),
      ],
    ),
    // id 160: B4 L2
    Phase1LotAnnotation(
      id: 160,
      categoryId: 320,
      name: 'B4 L2',
      bbox: Rect.fromLTWH(1945.92, 4601.46, 110.31, 111.38),
      points: [
        Offset(2056.221, 4609.347),
        Offset(1952.796, 4601.464),
        Offset(1945.915, 4704.444),
        Offset(2051.109, 4712.841),
      ],
    ),
    // id 161: B4 L3
    Phase1LotAnnotation(
      id: 161,
      categoryId: 331,
      name: 'B4 L3',
      bbox: Rect.fromLTWH(1841.47, 4591.95, 110.99, 113.32),
      points: [
        Offset(1952.459, 4601.277),
        Offset(1847.469, 4591.945),
        Offset(1841.473, 4697.284),
        Offset(1946.602, 4705.262),
      ],
    ),
    // id 162: B4 L4
    Phase1LotAnnotation(
      id: 162,
      categoryId: 332,
      name: 'B4 L4',
      bbox: Rect.fromLTWH(1737.80, 4583.05, 109.17, 113.36),
      points: [
        Offset(1846.967, 4592.630),
        Offset(1742.660, 4583.053),
        Offset(1737.798, 4688.777),
        Offset(1841.578, 4696.410),
      ],
    ),
    // id 163: B4 L5
    Phase1LotAnnotation(
      id: 163,
      categoryId: 333,
      name: 'B4 L5',
      bbox: Rect.fromLTWH(1633.89, 4573.90, 108.17, 115.51),
      points: [
        Offset(1742.052, 4583.983),
        Offset(1638.893, 4573.897),
        Offset(1633.885, 4679.902),
        Offset(1737.003, 4689.403),
      ],
    ),
    // id 164: B4 L6
    Phase1LotAnnotation(
      id: 164,
      categoryId: 334,
      name: 'B4 L6',
      bbox: Rect.fromLTWH(1529.88, 4563.84, 108.76, 116.49),
      points: [
        Offset(1638.641, 4574.055),
        Offset(1534.203, 4563.836),
        Offset(1529.880, 4671.967),
        Offset(1633.687, 4680.330),
      ],
    ),
    // id 165: B4 L7
    Phase1LotAnnotation(
      id: 165,
      categoryId: 335,
      name: 'B4 L7',
      bbox: Rect.fromLTWH(1428.51, 4555.49, 106.02, 116.15),
      points: [
        Offset(1534.528, 4564.383),
        Offset(1433.362, 4555.491),
        Offset(1428.507, 4664.739),
        Offset(1529.742, 4671.643),
      ],
    ),
    // id 166: B4 L8
    Phase1LotAnnotation(
      id: 166,
      categoryId: 336,
      name: 'B4 L8',
      bbox: Rect.fromLTWH(1329.47, 4546.28, 104.61, 117.32),
      points: [
        Offset(1434.082, 4555.881),
        Offset(1335.058, 4546.277),
        Offset(1329.473, 4656.526),
        Offset(1429.209, 4663.597),
      ],
    ),
    // id 167: B4 L9
    Phase1LotAnnotation(
      id: 167,
      categoryId: 337,
      name: 'B4 L9',
      bbox: Rect.fromLTWH(1228.74, 4538.98, 106.91, 117.54),
      points: [
        Offset(1335.650, 4545.937),
        Offset(1234.603, 4538.983),
        Offset(1228.742, 4649.415),
        Offset(1329.572, 4656.522),
      ],
    ),
    // id 168: B4 L10
    Phase1LotAnnotation(
      id: 168,
      categoryId: 310,
      name: 'B4 L10',
      bbox: Rect.fromLTWH(1128.46, 4529.39, 106.31, 119.44),
      points: [
        Offset(1234.770, 4539.596),
        Offset(1134.377, 4529.386),
        Offset(1128.459, 4641.354),
        Offset(1229.796, 4648.825),
      ],
    ),
    // id 169: B4 L11
    Phase1LotAnnotation(
      id: 169,
      categoryId: 311,
      name: 'B4 L11',
      bbox: Rect.fromLTWH(1028.87, 4520.40, 105.60, 119.97),
      points: [
        Offset(1134.467, 4528.643),
        Offset(1034.591, 4520.397),
        Offset(1028.865, 4632.574),
        Offset(1128.637, 4640.368),
      ],
    ),
    // id 170: B4 L12
    Phase1LotAnnotation(
      id: 170,
      categoryId: 312,
      name: 'B4 L12',
      bbox: Rect.fromLTWH(928.83, 4511.52, 106.05, 121.64),
      points: [
        Offset(1034.888, 4520.701),
        Offset(933.583, 4511.521),
        Offset(928.834, 4625.362),
        Offset(1029.232, 4633.160),
      ],
    ),
    // id 171: B4 L13
    Phase1LotAnnotation(
      id: 171,
      categoryId: 313,
      name: 'B4 L13',
      bbox: Rect.fromLTWH(828.24, 4503.05, 105.04, 121.17),
      points: [
        Offset(933.283, 4511.349),
        Offset(832.595, 4503.054),
        Offset(828.244, 4616.695),
        Offset(928.548, 4624.220),
      ],
    ),
    // id 172: B4 L14
    Phase1LotAnnotation(
      id: 172,
      categoryId: 314,
      name: 'B4 L14',
      bbox: Rect.fromLTWH(727.22, 4497.18, 105.76, 121.09),
      points: [
        Offset(832.980, 4503.279),
        Offset(773.605, 4497.184),
        Offset(735.498, 4498.965),
        Offset(727.223, 4618.271),
        Offset(828.697, 4617.111),
      ],
    ),
    // id 173: B4 L15
    Phase1LotAnnotation(
      id: 173,
      categoryId: 315,
      name: 'B4 L15',
      bbox: Rect.fromLTWH(445.72, 4455.13, 289.84, 161.82),
      points: [
        Offset(735.559, 4497.515),
        Offset(706.135, 4489.980),
        Offset(681.090, 4480.399),
        Offset(660.831, 4469.822),
        Offset(644.744, 4457.154),
        Offset(642.927, 4455.125),
        Offset(445.716, 4597.446),
        Offset(728.452, 4616.942),
      ],
    ),
    // id 174: B4 L16
    Phase1LotAnnotation(
      id: 174,
      categoryId: 316,
      name: 'B4 L16',
      bbox: Rect.fromLTWH(445.32, 4374.73, 197.76, 221.72),
      points: [
        Offset(574.727, 4374.729),
        Offset(445.317, 4416.790),
        Offset(445.398, 4596.449),
        Offset(643.078, 4455.496),
        Offset(626.221, 4443.794),
        Offset(606.387, 4427.263),
        Offset(596.365, 4411.771),
        Offset(583.349, 4393.660),
      ],
    ),
    // id 175: B4 L17
    Phase1LotAnnotation(
      id: 175,
      categoryId: 317,
      name: 'B4 L17',
      bbox: Rect.fromLTWH(445.60, 4242.14, 128.78, 173.59),
      points: [
        Offset(445.601, 4242.144),
        Offset(445.964, 4415.730),
        Offset(574.378, 4375.722),
        Offset(562.552, 4348.917),
        Offset(554.916, 4323.533),
        Offset(551.867, 4295.491),
        Offset(553.011, 4262.753),
      ],
    ),
    // id 176: B4 L18
    Phase1LotAnnotation(
      id: 176,
      categoryId: 318,
      name: 'B4 L18',
      bbox: Rect.fromLTWH(445.60, 4077.28, 129.82, 183.06),
      points: [
        Offset(445.601, 4077.278),
        Offset(446.159, 4242.640),
        Offset(551.369, 4260.341),
        Offset(552.556, 4245.932),
        Offset(554.907, 4226.071),
        Offset(560.861, 4200.482),
        Offset(575.425, 4165.081),
      ],
    ),
    // id 177: B4 L19
    Phase1LotAnnotation(
      id: 177,
      categoryId: 319,
      name: 'B4 L19',
      bbox: Rect.fromLTWH(445.60, 3866.87, 214.15, 296.51),
      points: [
        Offset(445.601, 3866.871),
        Offset(446.353, 4078.638),
        Offset(574.635, 4163.377),
        Offset(587.243, 4142.735),
        Offset(600.602, 4122.246),
        Offset(620.655, 4100.428),
        Offset(644.208, 4078.939),
        Offset(659.750, 4066.708),
      ],
    ),
    // id 178: B4 L20
    Phase1LotAnnotation(
      id: 178,
      categoryId: 321,
      name: 'B4 L20',
      bbox: Rect.fromLTWH(446.96, 3866.63, 304.71, 200.22),
      points: [
        Offset(446.957, 3866.630),
        Offset(751.668, 3895.462),
        Offset(738.837, 4031.965),
        Offset(721.764, 4036.926),
        Offset(702.117, 4043.271),
        Offset(684.691, 4052.051),
        Offset(660.209, 4066.854),
      ],
    ),
    // id 179: B4 L21
    Phase1LotAnnotation(
      id: 179,
      categoryId: 322,
      name: 'B4 L21',
      bbox: Rect.fromLTWH(738.12, 3895.62, 130.81, 137.71),
      points: [
        Offset(750.707, 3895.615),
        Offset(868.933, 3906.272),
        Offset(854.674, 4031.175),
        Offset(808.142, 4026.505),
        Offset(781.904, 4026.193),
        Offset(738.123, 4033.326),
      ],
    ),
    // id 180: B4 L22
    Phase1LotAnnotation(
      id: 180,
      categoryId: 323,
      name: 'B4 L22',
      bbox: Rect.fromLTWH(854.43, 3906.55, 114.04, 133.69),
      points: [
        Offset(868.197, 3906.545),
        Offset(968.466, 3916.052),
        Offset(955.912, 4040.231),
        Offset(854.426, 4030.985),
      ],
    ),
    // id 181: B4 L23
    Phase1LotAnnotation(
      id: 181,
      categoryId: 324,
      name: 'B4 L23',
      bbox: Rect.fromLTWH(956.85, 3915.43, 110.83, 134.86),
      points: [
        Offset(967.927, 3915.425),
        Offset(956.848, 4040.639),
        Offset(1057.496, 4050.285),
        Offset(1067.681, 3923.221),
      ],
    ),
    // id 182: B4 L24
    Phase1LotAnnotation(
      id: 182,
      categoryId: 325,
      name: 'B4 L24',
      bbox: Rect.fromLTWH(1056.99, 3924.05, 109.92, 133.61),
      points: [
        Offset(1067.937, 3924.054),
        Offset(1056.986, 4049.802),
        Offset(1156.505, 4057.660),
        Offset(1166.904, 3933.289),
      ],
    ),
    // id 183: B4 L25
    Phase1LotAnnotation(
      id: 183,
      categoryId: 326,
      name: 'B4 L25',
      bbox: Rect.fromLTWH(1156.54, 3932.50, 111.04, 135.46),
      points: [
        Offset(1167.387, 3932.502),
        Offset(1267.573, 3942.174),
        Offset(1256.937, 4067.963),
        Offset(1156.535, 4057.524),
      ],
    ),
    // id 184: B4 L26
    Phase1LotAnnotation(
      id: 184,
      categoryId: 327,
      name: 'B4 L26',
      bbox: Rect.fromLTWH(1254.82, 3942.69, 114.08, 133.50),
      points: [
        Offset(1267.992, 3942.686),
        Offset(1368.904, 3952.380),
        Offset(1354.415, 4076.186),
        Offset(1254.821, 4067.674),
      ],
    ),
    // id 185: B4 L27
    Phase1LotAnnotation(
      id: 185,
      categoryId: 328,
      name: 'B4 L27',
      bbox: Rect.fromLTWH(1355.27, 3951.99, 112.06, 131.83),
      points: [
        Offset(1368.205, 3951.988),
        Offset(1355.272, 4077.440),
        Offset(1455.746, 4083.820),
        Offset(1467.332, 3960.495),
      ],
    ),
    // id 186: B4 L28
    Phase1LotAnnotation(
      id: 186,
      categoryId: 329,
      name: 'B4 L28',
      bbox: Rect.fromLTWH(1455.64, 3960.44, 112.51, 135.11),
      points: [
        Offset(1467.556, 3960.436),
        Offset(1568.142, 3968.673),
        Offset(1555.217, 4095.547),
        Offset(1455.637, 4085.114),
      ],
    ),
    // id 187: B4 L29
    Phase1LotAnnotation(
      id: 187,
      categoryId: 330,
      name: 'B4 L29',
      bbox: Rect.fromLTWH(1557.06, 3969.39, 156.27, 127.17),
      points: [
        Offset(1567.673, 3969.388),
        Offset(1557.058, 4095.558),
        Offset(1585.281, 4096.559),
        Offset(1607.323, 4094.109),
        Offset(1626.580, 4088.943),
        Offset(1645.488, 4080.682),
        Offset(1670.306, 4064.048),
        Offset(1690.190, 4042.697),
        Offset(1702.453, 4020.528),
        Offset(1709.962, 4000.394),
        Offset(1713.324, 3981.684),
      ],
    ),
    // id 188: B5 L1
    Phase1LotAnnotation(
      id: 188,
      categoryId: 338,
      name: 'B5 L1',
      bbox: Rect.fromLTWH(2644.24, 4718.29, 123.76, 157.10),
      points: [
        Offset(2715.251, 4718.290),
        Offset(2651.637, 4719.556),
        Offset(2644.237, 4868.964),
        Offset(2763.841, 4875.394),
        Offset(2767.993, 4775.292),
      ],
    ),
    // id 189: B5 L2
    Phase1LotAnnotation(
      id: 189,
      categoryId: 349,
      name: 'B5 L2',
      bbox: Rect.fromLTWH(2527.79, 4719.20, 123.63, 148.56),
      points: [
        Offset(2651.416, 4719.202),
        Offset(2534.963, 4721.665),
        Offset(2527.785, 4859.766),
        Offset(2644.556, 4867.758),
      ],
    ),
    // id 190: B5 L3
    Phase1LotAnnotation(
      id: 190,
      categoryId: 360,
      name: 'B5 L3',
      bbox: Rect.fromLTWH(2382.61, 4721.48, 152.54, 137.44),
      points: [
        Offset(2535.146, 4721.482),
        Offset(2387.762, 4724.125),
        Offset(2386.955, 4742.333),
        Offset(2386.713, 4754.199),
        Offset(2384.164, 4763.323),
        Offset(2382.607, 4776.776),
        Offset(2383.395, 4787.105),
        Offset(2386.004, 4800.858),
        Offset(2391.427, 4813.226),
        Offset(2400.449, 4827.098),
        Offset(2413.283, 4839.332),
        Offset(2429.016, 4847.870),
        Offset(2445.696, 4852.594),
        Offset(2528.116, 4858.926),
      ],
    ),
    // id 191: B5 L4
    Phase1LotAnnotation(
      id: 191,
      categoryId: 366,
      name: 'B5 L4',
      bbox: Rect.fromLTWH(2356.15, 4506.72, 351.27, 207.87),
      points: [
        Offset(2523.291, 4506.724),
        Offset(2356.151, 4618.237),
        Offset(2363.402, 4628.172),
        Offset(2368.952, 4641.856),
        Offset(2376.587, 4660.239),
        Offset(2380.673, 4677.368),
        Offset(2385.183, 4695.405),
        Offset(2385.666, 4714.596),
        Offset(2707.416, 4709.691),
      ],
    ),
    // id 192: B5 L5
    Phase1LotAnnotation(
      id: 192,
      categoryId: 367,
      name: 'B5 L5',
      bbox: Rect.fromLTWH(2282.97, 4408.69, 239.36, 207.56),
      points: [
        Offset(2306.709, 4408.692),
        Offset(2282.973, 4544.373),
        Offset(2309.180, 4563.463),
        Offset(2328.521, 4581.010),
        Offset(2356.060, 4616.256),
        Offset(2522.337, 4506.911),
        Offset(2456.188, 4431.243),
      ],
    ),
    // id 193: B5 L6
    Phase1LotAnnotation(
      id: 193,
      categoryId: 368,
      name: 'B5 L6',
      bbox: Rect.fromLTWH(2184.12, 4391.37, 122.80, 154.12),
      points: [
        Offset(2195.911, 4391.366),
        Offset(2184.124, 4519.233),
        Offset(2210.135, 4521.683),
        Offset(2236.662, 4527.062),
        Offset(2262.130, 4535.672),
        Offset(2283.185, 4545.486),
        Offset(2306.921, 4409.341),
      ],
    ),
    // id 194: B5 L7
    Phase1LotAnnotation(
      id: 194,
      categoryId: 369,
      name: 'B5 L7',
      bbox: Rect.fromLTWH(2084.36, 4382.63, 112.01, 135.87),
      points: [
        Offset(2196.367, 4391.366),
        Offset(2095.941, 4382.629),
        Offset(2084.362, 4512.765),
        Offset(2184.421, 4518.501),
      ],
    ),
    // id 195: B5 L8
    Phase1LotAnnotation(
      id: 195,
      categoryId: 370,
      name: 'B5 L8',
      bbox: Rect.fromLTWH(1985.40, 4373.58, 110.73, 137.19),
      points: [
        Offset(2096.128, 4382.729),
        Offset(1996.916, 4373.578),
        Offset(1985.397, 4503.429),
        Offset(2083.757, 4510.772),
      ],
    ),
    // id 196: B5 L9
    Phase1LotAnnotation(
      id: 196,
      categoryId: 371,
      name: 'B5 L9',
      bbox: Rect.fromLTWH(1884.04, 4364.73, 113.07, 137.09),
      points: [
        Offset(1997.112, 4373.583),
        Offset(1896.175, 4364.728),
        Offset(1884.042, 4494.976),
        Offset(1985.260, 4501.817),
      ],
    ),
    // id 197: B5 L10
    Phase1LotAnnotation(
      id: 197,
      categoryId: 339,
      name: 'B5 L10',
      bbox: Rect.fromLTWH(1784.74, 4357.25, 111.15, 136.97),
      points: [
        Offset(1895.888, 4365.376),
        Offset(1796.266, 4357.245),
        Offset(1784.742, 4486.845),
        Offset(1884.587, 4494.212),
      ],
    ),
    // id 198: B5 L11
    Phase1LotAnnotation(
      id: 198,
      categoryId: 340,
      name: 'B5 L11',
      bbox: Rect.fromLTWH(1686.15, 4347.68, 110.34, 136.61),
      points: [
        Offset(1796.489, 4356.713),
        Offset(1696.540, 4347.675),
        Offset(1686.148, 4476.461),
        Offset(1785.360, 4484.282),
      ],
    ),
    // id 199: B5 L12
    Phase1LotAnnotation(
      id: 199,
      categoryId: 341,
      name: 'B5 L12',
      bbox: Rect.fromLTWH(1585.75, 4339.34, 111.52, 136.94),
      points: [
        Offset(1697.260, 4347.980),
        Offset(1596.581, 4339.338),
        Offset(1585.745, 4468.867),
        Offset(1686.201, 4476.280),
      ],
    ),
    // id 200: B5 L13
    Phase1LotAnnotation(
      id: 200,
      categoryId: 342,
      name: 'B5 L13',
      bbox: Rect.fromLTWH(1484.15, 4329.93, 112.62, 138.60),
      points: [
        Offset(1596.777, 4338.930),
        Offset(1496.072, 4329.930),
        Offset(1484.153, 4459.400),
        Offset(1586.630, 4468.525),
      ],
    ),
    // id 201: B5 L14
    Phase1LotAnnotation(
      id: 201,
      categoryId: 343,
      name: 'B5 L14',
      bbox: Rect.fromLTWH(1384.15, 4321.19, 111.41, 137.61),
      points: [
        Offset(1495.554, 4330.267),
        Offset(1395.460, 4321.192),
        Offset(1384.146, 4450.144),
        Offset(1484.830, 4458.803),
      ],
    ),
    // id 202: B5 L15
    Phase1LotAnnotation(
      id: 202,
      categoryId: 344,
      name: 'B5 L15',
      bbox: Rect.fromLTWH(1285.17, 4312.23, 110.53, 137.80),
      points: [
        Offset(1395.698, 4321.148),
        Offset(1296.377, 4312.231),
        Offset(1285.169, 4441.094),
        Offset(1384.119, 4450.033),
      ],
    ),
    // id 203: B5 L16
    Phase1LotAnnotation(
      id: 203,
      categoryId: 345,
      name: 'B5 L16',
      bbox: Rect.fromLTWH(1185.43, 4303.75, 111.32, 136.99),
      points: [
        Offset(1296.755, 4312.484),
        Offset(1196.792, 4303.753),
        Offset(1185.432, 4432.636),
        Offset(1285.306, 4440.745),
      ],
    ),
    // id 204: B5 L17
    Phase1LotAnnotation(
      id: 204,
      categoryId: 346,
      name: 'B5 L17',
      bbox: Rect.fromLTWH(1083.72, 4294.50, 113.18, 139.06),
      points: [
        Offset(1196.899, 4303.365),
        Offset(1096.937, 4294.504),
        Offset(1083.723, 4426.159),
        Offset(1185.256, 4433.565),
      ],
    ),
    // id 205: B5 L18
    Phase1LotAnnotation(
      id: 205,
      categoryId: 347,
      name: 'B5 L18',
      bbox: Rect.fromLTWH(984.50, 4284.86, 112.38, 139.49),
      points: [
        Offset(1096.874, 4293.904),
        Offset(995.779, 4284.858),
        Offset(984.498, 4415.866),
        Offset(1084.790, 4424.346),
      ],
    ),
    // id 206: B5 L19
    Phase1LotAnnotation(
      id: 206,
      categoryId: 348,
      name: 'B5 L19',
      bbox: Rect.fromLTWH(883.60, 4276.54, 112.23, 139.04),
      points: [
        Offset(995.820, 4284.671),
        Offset(896.504, 4276.536),
        Offset(883.595, 4406.037),
        Offset(985.399, 4415.574),
      ],
    ),
    // id 207: B5 L20
    Phase1LotAnnotation(
      id: 207,
      categoryId: 350,
      name: 'B5 L20',
      bbox: Rect.fromLTWH(667.57, 4256.05, 228.69, 149.68),
      points: [
        Offset(896.262, 4276.520),
        Offset(667.574, 4256.052),
        Offset(669.352, 4278.342),
        Offset(674.843, 4305.855),
        Offset(686.892, 4331.669),
        Offset(702.452, 4353.011),
        Offset(721.214, 4370.165),
        Offset(746.297, 4385.066),
        Offset(774.127, 4395.628),
        Offset(785.356, 4397.690),
        Offset(884.304, 4405.736),
      ],
    ),
    // id 208: B5 L21
    Phase1LotAnnotation(
      id: 208,
      categoryId: 351,
      name: 'B5 L21',
      bbox: Rect.fromLTWH(667.27, 4126.04, 241.54, 140.51),
      points: [
        Offset(898.438, 4266.548),
        Offset(908.804, 4135.146),
        Offset(811.824, 4126.675),
        Offset(798.088, 4126.039),
        Offset(775.820, 4129.008),
        Offset(755.452, 4135.236),
        Offset(734.565, 4145.040),
        Offset(714.982, 4159.556),
        Offset(702.845, 4171.094),
        Offset(690.589, 4186.810),
        Offset(680.681, 4203.668),
        Offset(673.571, 4222.118),
        Offset(668.091, 4245.047),
        Offset(667.269, 4249.742),
      ],
    ),
    // id 209: B5 L22
    Phase1LotAnnotation(
      id: 209,
      categoryId: 352,
      name: 'B5 L22',
      bbox: Rect.fromLTWH(897.54, 4135.12, 112.40, 141.20),
      points: [
        Offset(908.275, 4135.115),
        Offset(1009.941, 4144.211),
        Offset(997.553, 4276.310),
        Offset(897.542, 4267.513),
      ],
    ),
    // id 210: B5 L23
    Phase1LotAnnotation(
      id: 210,
      categoryId: 353,
      name: 'B5 L23',
      bbox: Rect.fromLTWH(997.64, 4144.69, 112.25, 140.76),
      points: [
        Offset(1009.499, 4144.690),
        Offset(1109.892, 4152.864),
        Offset(1097.143, 4285.453),
        Offset(997.640, 4276.251),
      ],
    ),
    // id 211: B5 L24
    Phase1LotAnnotation(
      id: 211,
      categoryId: 354,
      name: 'B5 L24',
      bbox: Rect.fromLTWH(1097.29, 4153.35, 113.48, 141.45),
      points: [
        Offset(1110.266, 4153.354),
        Offset(1210.772, 4161.894),
        Offset(1197.709, 4294.805),
        Offset(1097.289, 4285.087),
      ],
    ),
    // id 212: B5 L25
    Phase1LotAnnotation(
      id: 212,
      categoryId: 355,
      name: 'B5 L25',
      bbox: Rect.fromLTWH(1197.27, 4161.56, 112.46, 141.32),
      points: [
        Offset(1210.578, 4161.561),
        Offset(1309.721, 4171.318),
        Offset(1298.055, 4302.882),
        Offset(1197.266, 4293.282),
      ],
    ),
    // id 213: B5 L26
    Phase1LotAnnotation(
      id: 213,
      categoryId: 356,
      name: 'B5 L26',
      bbox: Rect.fromLTWH(1297.73, 4171.59, 111.54, 139.92),
      points: [
        Offset(1309.522, 4171.592),
        Offset(1409.276, 4180.831),
        Offset(1397.007, 4311.510),
        Offset(1297.732, 4302.890),
      ],
    ),
    // id 214: B5 L27
    Phase1LotAnnotation(
      id: 214,
      categoryId: 357,
      name: 'B5 L27',
      bbox: Rect.fromLTWH(1397.02, 4180.71, 112.31, 139.74),
      points: [
        Offset(1409.377, 4180.711),
        Offset(1509.332, 4189.907),
        Offset(1496.906, 4320.448),
        Offset(1397.022, 4311.841),
      ],
    ),
    // id 215: B5 L28
    Phase1LotAnnotation(
      id: 215,
      categoryId: 358,
      name: 'B5 L28',
      bbox: Rect.fromLTWH(1496.71, 4190.23, 113.65, 138.03),
      points: [
        Offset(1509.354, 4190.230),
        Offset(1496.712, 4320.522),
        Offset(1598.785, 4328.261),
        Offset(1610.365, 4198.448),
      ],
    ),
    // id 216: B5 L29
    Phase1LotAnnotation(
      id: 216,
      categoryId: 359,
      name: 'B5 L29',
      bbox: Rect.fromLTWH(1597.25, 4198.72, 111.51, 139.94),
      points: [
        Offset(1610.780, 4198.720),
        Offset(1708.762, 4208.222),
        Offset(1697.034, 4338.661),
        Offset(1597.248, 4329.410),
      ],
    ),
    // id 217: B5 L30
    Phase1LotAnnotation(
      id: 217,
      categoryId: 361,
      name: 'B5 L30',
      bbox: Rect.fromLTWH(1696.75, 4208.98, 111.55, 138.77),
      points: [
        Offset(1708.488, 4208.981),
        Offset(1808.306, 4217.639),
        Offset(1797.338, 4347.755),
        Offset(1696.752, 4339.014),
      ],
    ),
    // id 218: B5 L31
    Phase1LotAnnotation(
      id: 218,
      categoryId: 362,
      name: 'B5 L31',
      bbox: Rect.fromLTWH(1797.67, 4218.14, 110.92, 137.97),
      points: [
        Offset(1808.887, 4218.139),
        Offset(1908.589, 4225.739),
        Offset(1896.941, 4356.112),
        Offset(1797.669, 4346.990),
      ],
    ),
    // id 219: B5 L32
    Phase1LotAnnotation(
      id: 219,
      categoryId: 363,
      name: 'B5 L32',
      bbox: Rect.fromLTWH(1896.64, 4226.02, 114.06, 139.25),
      points: [
        Offset(1908.881, 4226.023),
        Offset(2010.701, 4235.404),
        Offset(1997.511, 4365.276),
        Offset(1896.643, 4356.625),
      ],
    ),
    // id 220: B5 L33
    Phase1LotAnnotation(
      id: 220,
      categoryId: 364,
      name: 'B5 L33',
      bbox: Rect.fromLTWH(1997.38, 4235.88, 111.93, 138.32),
      points: [
        Offset(2010.790, 4235.883),
        Offset(2109.310, 4243.923),
        Offset(2097.849, 4374.198),
        Offset(1997.382, 4364.598),
      ],
    ),
    // id 221: B5 L34
    Phase1LotAnnotation(
      id: 221,
      categoryId: 365,
      name: 'B5 L34',
      bbox: Rect.fromLTWH(2097.52, 4244.55, 112.21, 138.11),
      points: [
        Offset(2109.278, 4244.546),
        Offset(2097.516, 4374.050),
        Offset(2197.596, 4382.656),
        Offset(2209.727, 4252.342),
      ],
    ),
    // id 222: B5 L35
    Phase1LotAnnotation(
      id: 222,
      categoryId: 365,
      name: 'B5 L35',
      bbox: Rect.fromLTWH(2197.04, 4252.93, 251.85, 169.12),
      points: [
        Offset(2210.136, 4252.926),
        Offset(2197.040, 4381.979),
        Offset(2448.888, 4422.042),
        Offset(2301.503, 4261.353),
      ],
    ),
    // id 223: B6 L1
    Phase1LotAnnotation(
      id: 223,
      categoryId: 372,
      name: 'B6 L1',
      bbox: Rect.fromLTWH(1568.57, 3834.13, 145.97, 139.53),
      points: [
        Offset(1714.538, 3973.655),
        Offset(1568.572, 3960.314),
        Offset(1578.970, 3834.125),
        Offset(1615.408, 3838.275),
        Offset(1644.003, 3849.348),
        Offset(1669.107, 3865.832),
        Offset(1690.682, 3889.397),
        Offset(1704.680, 3914.308),
        Offset(1711.868, 3939.080),
        Offset(1714.443, 3959.579),
      ],
    ),
    // id 224: B6 L2
    Phase1LotAnnotation(
      id: 224,
      categoryId: 378,
      name: 'B6 L2',
      bbox: Rect.fromLTWH(1468.81, 3826.58, 109.69, 132.69),
      points: [
        Offset(1567.452, 3959.266),
        Offset(1468.809, 3950.339),
        Offset(1479.681, 3826.575),
        Offset(1578.499, 3836.012),
      ],
    ),
    // id 225: B6 L3
    Phase1LotAnnotation(
      id: 225,
      categoryId: 379,
      name: 'B6 L3',
      bbox: Rect.fromLTWH(1368.99, 3818.10, 109.71, 132.58),
      points: [
        Offset(1478.699, 3825.966),
        Offset(1378.273, 3818.101),
        Offset(1368.986, 3941.869),
        Offset(1468.809, 3950.683),
      ],
    ),
    // id 226: B6 L4
    Phase1LotAnnotation(
      id: 226,
      categoryId: 380,
      name: 'B6 L4',
      bbox: Rect.fromLTWH(1268.23, 3809.03, 110.10, 132.02),
      points: [
        Offset(1378.325, 3818.321),
        Offset(1278.419, 3809.034),
        Offset(1268.228, 3933.122),
        Offset(1369.517, 3941.054),
      ],
    ),
    // id 227: B6 L5
    Phase1LotAnnotation(
      id: 227,
      categoryId: 381,
      name: 'B6 L5',
      bbox: Rect.fromLTWH(1168.58, 3800.04, 109.57, 132.70),
      points: [
        Offset(1278.142, 3809.021),
        Offset(1179.832, 3800.037),
        Offset(1168.576, 3924.107),
        Offset(1268.864, 3932.735),
      ],
    ),
    // id 228: B6 L6
    Phase1LotAnnotation(
      id: 228,
      categoryId: 382,
      name: 'B6 L6',
      bbox: Rect.fromLTWH(1067.74, 3792.65, 111.07, 130.94),
      points: [
        Offset(1178.814, 3800.983),
        Offset(1079.254, 3792.647),
        Offset(1067.740, 3915.289),
        Offset(1168.671, 3923.582),
      ],
    ),
    // id 229: B6 L7
    Phase1LotAnnotation(
      id: 229,
      categoryId: 383,
      name: 'B6 L7',
      bbox: Rect.fromLTWH(968.72, 3783.54, 109.92, 131.06),
      points: [
        Offset(1078.643, 3791.575),
        Offset(979.621, 3783.537),
        Offset(968.723, 3907.048),
        Offset(1069.446, 3914.595),
      ],
    ),
    // id 230: B6 L8
    Phase1LotAnnotation(
      id: 230,
      categoryId: 384,
      name: 'B6 L8',
      bbox: Rect.fromLTWH(867.66, 3773.81, 112.09, 131.52),
      points: [
        Offset(979.749, 3783.051),
        Offset(878.146, 3773.811),
        Offset(867.655, 3896.699),
        Offset(968.946, 3905.334),
      ],
    ),
    // id 231: B6 L9
    Phase1LotAnnotation(
      id: 231,
      categoryId: 385,
      name: 'B6 L9',
      bbox: Rect.fromLTWH(768.28, 3764.01, 110.80, 133.26),
      points: [
        Offset(879.080, 3773.403),
        Offset(778.387, 3764.007),
        Offset(768.283, 3888.180),
        Offset(868.104, 3897.266),
      ],
    ),
    // id 232: B6 L10
    Phase1LotAnnotation(
      id: 232,
      categoryId: 372,
      name: 'B6 L10',
      bbox: Rect.fromLTWH(639.47, 3741.51, 139.21, 145.71),
      points: [
        Offset(778.681, 3763.350),
        Offset(751.723, 3760.380),
        Offset(729.657, 3754.720),
        Offset(703.200, 3743.366),
        Offset(700.822, 3741.507),
        Offset(639.467, 3875.980),
        Offset(768.445, 3887.215),
      ],
    ),
    // id 233: B6 L11
    Phase1LotAnnotation(
      id: 233,
      categoryId: 373,
      name: 'B6 L11',
      bbox: Rect.fromLTWH(447.57, 3688.06, 250.87, 187.58),
      points: [
        Offset(698.433, 3741.766),
        Offset(672.967, 3730.157),
        Offset(652.334, 3716.340),
        Offset(621.755, 3688.063),
        Offset(447.566, 3859.001),
        Offset(639.707, 3875.647),
      ],
    ),
    // id 234: B6 L12
    Phase1LotAnnotation(
      id: 234,
      categoryId: 374,
      name: 'B6 L12',
      bbox: Rect.fromLTWH(446.15, 3608.39, 175.48, 251.41),
      points: [
        Offset(566.716, 3608.388),
        Offset(446.150, 3650.406),
        Offset(446.340, 3859.801),
        Offset(621.625, 3688.154),
        Offset(600.718, 3663.036),
        Offset(582.416, 3637.052),
      ],
    ),
    // id 235: B6 L13
    Phase1LotAnnotation(
      id: 235,
      categoryId: 375,
      name: 'B6 L13',
      bbox: Rect.fromLTWH(445.95, 3481.10, 122.77, 169.89),
      points: [
        Offset(446.068, 3481.099),
        Offset(445.951, 3650.986),
        Offset(568.720, 3606.222),
        Offset(560.058, 3578.228),
        Offset(553.088, 3545.156),
        Offset(551.975, 3522.974),
        Offset(553.676, 3490.310),
      ],
    ),
    // id 236: B6 L14
    Phase1LotAnnotation(
      id: 236,
      categoryId: 376,
      name: 'B6 L14',
      bbox: Rect.fromLTWH(446.07, 3334.99, 132.81, 154.13),
      points: [
        Offset(446.068, 3334.992),
        Offset(446.826, 3481.172),
        Offset(552.349, 3489.117),
        Offset(556.212, 3466.312),
        Offset(566.230, 3431.348),
        Offset(578.881, 3406.087),
      ],
    ),
    // id 237: B6 L15
    Phase1LotAnnotation(
      id: 237,
      categoryId: 377,
      name: 'B6 L15',
      bbox: Rect.fromLTWH(445.60, 3239.04, 358.64, 165.25),
      points: [
        Offset(446.368, 3239.036),
        Offset(445.601, 3334.875),
        Offset(580.664, 3404.282),
        Offset(595.449, 3377.397),
        Offset(614.897, 3351.595),
        Offset(642.325, 3326.183),
        Offset(670.526, 3306.071),
        Offset(703.957, 3288.210),
        Offset(745.240, 3275.734),
        Offset(804.243, 3267.689),
      ],
    ),
    // id 238: B7 L1
    Phase1LotAnnotation(
      id: 238,
      categoryId: 386,
      name: 'B7 L1',
      bbox: Rect.fromLTWH(1982.99, 4006.47, 221.58, 147.73),
      points: [
        Offset(2204.569, 4154.207),
        Offset(1982.990, 4131.394),
        Offset(1994.524, 4006.474),
        Offset(2080.266, 4014.198),
      ],
    ),
    // id 239: B7 L2
    Phase1LotAnnotation(
      id: 239,
      categoryId: 397,
      name: 'B7 L2',
      bbox: Rect.fromLTWH(1819.83, 3992.73, 174.32, 138.98),
      points: [
        Offset(1994.147, 4006.747),
        Offset(1828.586, 3992.730),
        Offset(1826.539, 4013.950),
        Offset(1822.930, 4030.095),
        Offset(1819.829, 4040.809),
        Offset(1820.301, 4053.161),
        Offset(1823.033, 4066.862),
        Offset(1827.486, 4080.106),
        Offset(1839.007, 4096.420),
        Offset(1852.566, 4109.412),
        Offset(1873.184, 4119.792),
        Offset(1888.824, 4122.861),
        Offset(1985.169, 4131.711),
      ],
    ),
    // id 240: B7 L3
    Phase1LotAnnotation(
      id: 240,
      categoryId: 402,
      name: 'B7 L3',
      bbox: Rect.fromLTWH(1812.20, 3833.03, 259.33, 174.32),
      points: [
        Offset(2071.531, 4007.342),
        Offset(1831.555, 3983.952),
        Offset(1830.571, 3945.848),
        Offset(1826.293, 3913.769),
        Offset(1812.204, 3872.665),
        Offset(1910.098, 3833.026),
      ],
    ),
    // id 241: B7 L4
    Phase1LotAnnotation(
      id: 241,
      categoryId: 403,
      name: 'B7 L4',
      bbox: Rect.fromLTWH(1750.88, 3624.83, 302.19, 245.56),
      points: [
        Offset(1862.948, 3624.834),
        Offset(1750.884, 3782.726),
        Offset(1776.381, 3808.815),
        Offset(1793.567, 3833.770),
        Offset(1811.100, 3870.395),
        Offset(1912.009, 3832.956),
        Offset(2053.074, 3643.150),
      ],
    ),
    // id 242: B7 L5
    Phase1LotAnnotation(
      id: 242,
      categoryId: 404,
      name: 'B7 L5',
      bbox: Rect.fromLTWH(1645.03, 3605.54, 216.20, 177.39),
      points: [
        Offset(1658.416, 3605.536),
        Offset(1645.025, 3737.795),
        Offset(1670.256, 3742.229),
        Offset(1696.229, 3750.998),
        Offset(1723.251, 3764.198),
        Offset(1747.032, 3781.510),
        Offset(1750.124, 3782.928),
        Offset(1861.228, 3625.320),
      ],
    ),
    // id 243: B7 L6
    Phase1LotAnnotation(
      id: 243,
      categoryId: 405,
      name: 'B7 L6',
      bbox: Rect.fromLTWH(1544.58, 3596.12, 112.64, 141.48),
      points: [
        Offset(1657.225, 3605.536),
        Offset(1556.413, 3596.117),
        Offset(1544.582, 3732.572),
        Offset(1604.639, 3737.458),
        Offset(1644.487, 3737.593),
      ],
    ),
    // id 244: B7 L7
    Phase1LotAnnotation(
      id: 244,
      categoryId: 406,
      name: 'B7 L7',
      bbox: Rect.fromLTWH(1444.60, 3586.44, 111.43, 145.71),
      points: [
        Offset(1556.030, 3596.607),
        Offset(1456.597, 3586.436),
        Offset(1444.601, 3723.178),
        Offset(1542.841, 3732.149),
      ],
    ),
    // id 245: B7 L8
    Phase1LotAnnotation(
      id: 245,
      categoryId: 407,
      name: 'B7 L8',
      bbox: Rect.fromLTWH(1344.96, 3576.60, 111.06, 146.38),
      points: [
        Offset(1456.025, 3586.488),
        Offset(1356.957, 3576.596),
        Offset(1344.963, 3712.010),
        Offset(1442.882, 3722.976),
      ],
    ),
    // id 246: B7 L9
    Phase1LotAnnotation(
      id: 246,
      categoryId: 408,
      name: 'B7 L9',
      bbox: Rect.fromLTWH(1245.02, 3567.83, 112.56, 144.70),
      points: [
        Offset(1357.571, 3576.524),
        Offset(1256.559, 3567.825),
        Offset(1245.016, 3703.823),
        Offset(1344.500, 3712.529),
      ],
    ),
    // id 247: B7 L10
    Phase1LotAnnotation(
      id: 247,
      categoryId: 387,
      name: 'B7 L10',
      bbox: Rect.fromLTWH(1143.77, 3557.01, 113.75, 145.39),
      points: [
        Offset(1257.526, 3567.320),
        Offset(1157.479, 3557.006),
        Offset(1143.774, 3695.956),
        Offset(1243.900, 3702.400),
      ],
    ),
    // id 248: B7 L11
    Phase1LotAnnotation(
      id: 248,
      categoryId: 388,
      name: 'B7 L11',
      bbox: Rect.fromLTWH(1044.68, 3547.24, 112.52, 148.32),
      points: [
        Offset(1157.200, 3556.724),
        Offset(1057.374, 3547.242),
        Offset(1044.683, 3686.937),
        Offset(1144.851, 3695.561),
      ],
    ),
    // id 249: B7 L12
    Phase1LotAnnotation(
      id: 249,
      categoryId: 389,
      name: 'B7 L12',
      bbox: Rect.fromLTWH(944.77, 3537.44, 112.26, 149.18),
      points: [
        Offset(1057.035, 3547.677),
        Offset(957.137, 3537.439),
        Offset(944.773, 3677.791),
        Offset(1043.932, 3686.621),
      ],
    ),
    // id 250: B7 L13
    Phase1LotAnnotation(
      id: 250,
      categoryId: 390,
      name: 'B7 L13',
      bbox: Rect.fromLTWH(844.58, 3526.84, 112.47, 151.55),
      points: [
        Offset(957.046, 3537.064),
        Offset(856.755, 3526.838),
        Offset(844.580, 3668.367),
        Offset(944.799, 3678.387),
      ],
    ),
    // id 251: B7 L14
    Phase1LotAnnotation(
      id: 251,
      categoryId: 391,
      name: 'B7 L14',
      bbox: Rect.fromLTWH(668.22, 3510.45, 188.95, 157.21),
      points: [
        Offset(857.174, 3527.163),
        Offset(669.199, 3510.454),
        Offset(668.225, 3529.879),
        Offset(671.780, 3552.502),
        Offset(683.560, 3583.372),
        Offset(704.023, 3615.449),
        Offset(731.770, 3639.034),
        Offset(760.452, 3655.050),
        Offset(786.021, 3663.405),
        Offset(845.654, 3667.660),
      ],
    ),
    // id 252: B7 L15
    Phase1LotAnnotation(
      id: 252,
      categoryId: 392,
      name: 'B7 L15',
      bbox: Rect.fromLTWH(668.93, 3371.60, 201.73, 146.43),
      points: [
        Offset(857.781, 3518.032),
        Offset(870.651, 3376.974),
        Offset(809.127, 3371.603),
        Offset(778.554, 3375.898),
        Offset(754.734, 3385.027),
        Offset(726.120, 3401.120),
        Offset(705.532, 3420.208),
        Offset(689.725, 3440.912),
        Offset(679.270, 3463.044),
        Offset(671.750, 3482.125),
        Offset(668.925, 3501.160),
      ],
    ),
    // id 253: B7 L16
    Phase1LotAnnotation(
      id: 253,
      categoryId: 393,
      name: 'B7 L16',
      bbox: Rect.fromLTWH(857.63, 3377.67, 112.80, 150.93),
      points: [
        Offset(871.109, 3377.667),
        Offset(970.423, 3385.580),
        Offset(957.555, 3528.598),
        Offset(857.625, 3518.285),
      ],
    ),
    // id 254: B7 L17
    Phase1LotAnnotation(
      id: 254,
      categoryId: 394,
      name: 'B7 L17',
      bbox: Rect.fromLTWH(957.66, 3386.22, 112.78, 151.18),
      points: [
        Offset(969.677, 3386.217),
        Offset(1070.442, 3394.637),
        Offset(1057.988, 3537.399),
        Offset(957.660, 3527.744),
      ],
    ),
    // id 255: B7 L18
    Phase1LotAnnotation(
      id: 255,
      categoryId: 395,
      name: 'B7 L18',
      bbox: Rect.fromLTWH(1057.71, 3394.81, 112.65, 153.00),
      points: [
        Offset(1070.887, 3394.811),
        Offset(1057.714, 3537.987),
        Offset(1158.519, 3547.809),
        Offset(1170.366, 3403.155),
      ],
    ),
    // id 256: B7 L19
    Phase1LotAnnotation(
      id: 256,
      categoryId: 396,
      name: 'B7 L19',
      bbox: Rect.fromLTWH(1157.77, 3403.74, 113.03, 153.11),
      points: [
        Offset(1170.296, 3403.740),
        Offset(1157.768, 3547.760),
        Offset(1259.014, 3556.852),
        Offset(1270.799, 3412.397),
      ],
    ),
    // id 257: B7 L20
    Phase1LotAnnotation(
      id: 257,
      categoryId: 398,
      name: 'B7 L20',
      bbox: Rect.fromLTWH(1258.25, 3413.97, 112.00, 151.77),
      points: [
        Offset(1271.559, 3413.969),
        Offset(1258.254, 3556.708),
        Offset(1358.629, 3565.742),
        Offset(1370.255, 3421.729),
      ],
    ),
    // id 258: B7 L21
    Phase1LotAnnotation(
      id: 258,
      categoryId: 399,
      name: 'B7 L21',
      bbox: Rect.fromLTWH(1356.69, 3422.80, 113.61, 154.40),
      points: [
        Offset(1370.543, 3422.798),
        Offset(1470.299, 3430.067),
        Offset(1457.466, 3577.194),
        Offset(1356.692, 3567.765),
      ],
    ),
    // id 259: B7 L22
    Phase1LotAnnotation(
      id: 259,
      categoryId: 400,
      name: 'B7 L22',
      bbox: Rect.fromLTWH(1457.16, 3430.53, 115.80, 156.50),
      points: [
        Offset(1472.097, 3430.528),
        Offset(1572.955, 3437.675),
        Offset(1557.102, 3587.029),
        Offset(1457.159, 3577.666),
      ],
    ),
    // id 260: B7 L23
    Phase1LotAnnotation(
      id: 260,
      categoryId: 401,
      name: 'B7 L23',
      bbox: Rect.fromLTWH(1557.30, 3420.82, 116.67, 176.15),
      points: [
        Offset(1572.102, 3437.671),
        Offset(1600.998, 3438.054),
        Offset(1637.374, 3433.708),
        Offset(1673.972, 3420.822),
        Offset(1657.425, 3596.970),
        Offset(1557.302, 3587.467),
      ],
    ),
    // id 261: B8 L1
    Phase1LotAnnotation(
      id: 261,
      categoryId: 409,
      name: 'B8 L1',
      bbox: Rect.fromLTWH(2773.20, 4455.95, 205.55, 204.91),
      points: [
        Offset(2894.888, 4455.954),
        Offset(2773.204, 4567.383),
        Offset(2856.398, 4660.863),
        Offset(2978.757, 4548.183),
      ],
    ),
    // id 262: B8 L2
    Phase1LotAnnotation(
      id: 262,
      categoryId: 410,
      name: 'B8 L2',
      bbox: Rect.fromLTWH(2856.32, 4547.84, 206.57, 205.48),
      points: [
        Offset(2979.857, 4547.839),
        Offset(2856.317, 4660.199),
        Offset(2941.556, 4753.320),
        Offset(3062.885, 4642.195),
      ],
    ),
    // id 263: B8 L3
    Phase1LotAnnotation(
      id: 263,
      categoryId: 411,
      name: 'B8 L3',
      bbox: Rect.fromLTWH(2940.28, 4642.71, 208.31, 203.43),
      points: [
        Offset(3064.290, 4642.712),
        Offset(2940.275, 4752.918),
        Offset(3025.422, 4846.143),
        Offset(3148.584, 4734.713),
      ],
    ),
    // id 264: B8 L4
    Phase1LotAnnotation(
      id: 264,
      categoryId: 412,
      name: 'B8 L4',
      bbox: Rect.fromLTWH(3024.80, 4734.57, 208.89, 202.69),
      points: [
        Offset(3147.368, 4734.574),
        Offset(3024.800, 4845.691),
        Offset(3110.326, 4937.264),
        Offset(3233.685, 4826.371),
      ],
    ),
    // id 265: B8 L5
    Phase1LotAnnotation(
      id: 265,
      categoryId: 413,
      name: 'B8 L5',
      bbox: Rect.fromLTWH(3110.80, 4827.67, 212.44, 200.28),
      points: [
        Offset(3234.090, 4827.672),
        Offset(3110.800, 4938.932),
        Offset(3199.888, 5027.953),
        Offset(3323.235, 4914.351),
      ],
    ),
    // id 266: B8 L6
    Phase1LotAnnotation(
      id: 266,
      categoryId: 414,
      name: 'B8 L6',
      bbox: Rect.fromLTWH(3199.96, 4913.41, 212.71, 201.18),
      points: [
        Offset(3323.687, 4913.405),
        Offset(3199.961, 5026.313),
        Offset(3289.909, 5114.586),
        Offset(3412.674, 5000.914),
      ],
    ),
    // id 267: B8 L7
    Phase1LotAnnotation(
      id: 267,
      categoryId: 415,
      name: 'B8 L7',
      bbox: Rect.fromLTWH(3289.59, 5003.32, 214.42, 199.19),
      points: [
        Offset(3412.608, 5003.315),
        Offset(3289.593, 5115.319),
        Offset(3378.688, 5202.508),
        Offset(3504.011, 5089.689),
      ],
    ),
    // id 268: B8 L8
    Phase1LotAnnotation(
      id: 268,
      categoryId: 416,
      name: 'B8 L8',
      bbox: Rect.fromLTWH(3379.02, 5092.71, 212.08, 198.22),
      points: [
        Offset(3379.016, 5203.882),
        Offset(3468.651, 5290.935),
        Offset(3591.100, 5179.915),
        Offset(3503.954, 5092.711),
      ],
    ),
    // id 269: B8 L9
    Phase1LotAnnotation(
      id: 269,
      categoryId: 417,
      name: 'B8 L9',
      bbox: Rect.fromLTWH(3468.22, 5180.05, 265.04, 217.14),
      points: [
        Offset(3592.454, 5180.050),
        Offset(3468.215, 5291.646),
        Offset(3568.773, 5390.023),
        Offset(3569.402, 5397.190),
        Offset(3733.251, 5319.094),
      ],
    ),
    // id 270: B9 L1
    Phase1LotAnnotation(
      id: 270,
      categoryId: 418,
      name: 'B9 L1',
      bbox: Rect.fromLTWH(2586.81, 4252.52, 207.19, 203.12),
      points: [
        Offset(2711.178, 4252.524),
        Offset(2586.806, 4363.026),
        Offset(2673.103, 4455.641),
        Offset(2793.994, 4346.527),
      ],
    ),
    // id 271: B9 L2
    Phase1LotAnnotation(
      id: 271,
      categoryId: 419,
      name: 'B9 L2',
      bbox: Rect.fromLTWH(2503.02, 4159.46, 207.26, 201.48),
      points: [
        Offset(2625.739, 4159.460),
        Offset(2503.020, 4269.646),
        Offset(2587.598, 4360.941),
        Offset(2710.277, 4252.352),
      ],
    ),
    // id 272: B9 L3
    Phase1LotAnnotation(
      id: 272,
      categoryId: 420,
      name: 'B9 L3',
      bbox: Rect.fromLTWH(2419.11, 4064.87, 206.42, 204.25),
      points: [
        Offset(2541.283, 4064.870),
        Offset(2419.108, 4177.576),
        Offset(2504.541, 4269.121),
        Offset(2625.527, 4158.837),
      ],
    ),
    // id 273: B9 L4
    Phase1LotAnnotation(
      id: 273,
      categoryId: 421,
      name: 'B9 L4',
      bbox: Rect.fromLTWH(2334.95, 3971.97, 206.53, 203.85),
      points: [
        Offset(2457.671, 3971.968),
        Offset(2334.946, 4085.113),
        Offset(2418.264, 4175.814),
        Offset(2541.471, 4064.556),
      ],
    ),
    // id 274: B9 L5
    Phase1LotAnnotation(
      id: 274,
      categoryId: 422,
      name: 'B9 L5',
      bbox: Rect.fromLTWH(2250.42, 3882.30, 207.62, 201.76),
      points: [
        Offset(2374.337, 3882.296),
        Offset(2250.424, 3991.089),
        Offset(2334.910, 4084.054),
        Offset(2458.044, 3972.024),
      ],
    ),
    // id 275: B9 L6
    Phase1LotAnnotation(
      id: 275,
      categoryId: 423,
      name: 'B9 L6',
      bbox: Rect.fromLTWH(2167.00, 3787.85, 207.20, 203.38),
      points: [
        Offset(2290.448, 3787.854),
        Offset(2166.997, 3899.676),
        Offset(2249.187, 3991.231),
        Offset(2374.195, 3881.108),
      ],
    ),
    // id 276: B9 L7
    Phase1LotAnnotation(
      id: 276,
      categoryId: 424,
      name: 'B9 L7',
      bbox: Rect.fromLTWH(2119.64, 3684.82, 169.33, 214.09),
      points: [
        Offset(2197.546, 3684.817),
        Offset(2132.436, 3771.395),
        Offset(2124.122, 3789.761),
        Offset(2119.639, 3807.731),
        Offset(2119.774, 3828.835),
        Offset(2126.089, 3849.299),
        Offset(2137.305, 3869.308),
        Offset(2166.957, 3898.907),
        Offset(2288.973, 3787.455),
      ],
    ),
    // id 277: B10 L1
    Phase1LotAnnotation(
      id: 277,
      categoryId: 40,
      name: 'B10 L1',
      bbox: Rect.fromLTWH(2706.19, 4181.97, 187.23, 189.29),
      points: [
        Offset(2706.193, 4246.242),
        Offset(2780.762, 4181.972),
        Offset(2893.427, 4306.058),
        Offset(2818.456, 4371.264),
      ],
    ),
    // id 278: B10 L12
    Phase1LotAnnotation(
      id: 278,
      categoryId: 43,
      name: 'B10 L12',
      bbox: Rect.fromLTWH(2582.70, 4042.58, 194.40, 197.14),
      points: [
        Offset(2582.696, 4106.441),
        Offset(2655.825, 4042.577),
        Offset(2777.095, 4175.684),
        Offset(2700.527, 4239.713),
      ],
    ),
    // id 279: B10 L2
    Phase1LotAnnotation(
      id: 279,
      categoryId: 44,
      name: 'B10 L2',
      bbox: Rect.fromLTWH(2783.04, 4115.96, 189.48, 188.89),
      points: [
        Offset(2783.038, 4179.709),
        Offset(2854.669, 4115.962),
        Offset(2972.513, 4241.122),
        Offset(2894.648, 4304.855),
      ],
    ),
    // id 280: B10 L3
    Phase1LotAnnotation(
      id: 280,
      categoryId: 45,
      name: 'B10 L3',
      bbox: Rect.fromLTWH(2857.78, 4050.75, 190.17, 195.28),
      points: [
        Offset(2857.782, 4116.382),
        Offset(2928.984, 4050.747),
        Offset(3047.950, 4175.858),
        Offset(2971.355, 4246.027),
      ],
    ),
    // id 281: B10 L4
    Phase1LotAnnotation(
      id: 281,
      categoryId: 46,
      name: 'B10 L4',
      bbox: Rect.fromLTWH(2929.57, 3983.02, 192.38, 192.36),
      points: [
        Offset(2929.574, 4048.055),
        Offset(3000.816, 3983.020),
        Offset(3121.952, 4109.611),
        Offset(3048.460, 4175.384),
      ],
    ),
    // id 282: B10 L5
    Phase1LotAnnotation(
      id: 282,
      categoryId: 47,
      name: 'B10 L5',
      bbox: Rect.fromLTWH(3001.70, 3916.20, 197.15, 192.13),
      points: [
        Offset(3001.697, 3982.801),
        Offset(3074.420, 3916.196),
        Offset(3198.842, 4042.609),
        Offset(3124.563, 4108.328),
      ],
    ),
    // id 283: B10 L6
    Phase1LotAnnotation(
      id: 283,
      categoryId: 48,
      name: 'B10 L6',
      bbox: Rect.fromLTWH(3074.97, 3784.58, 255.16, 257.01),
      points: [
        Offset(3074.965, 3915.257),
        Offset(3212.454, 3784.583),
        Offset(3317.142, 3869.228),
        Offset(3325.487, 3887.938),
        Offset(3330.120, 3909.327),
        Offset(3324.024, 3930.305),
        Offset(3312.786, 3943.810),
        Offset(3201.216, 4041.589),
      ],
    ),
    // id 284: B10 L7
    Phase1LotAnnotation(
      id: 284,
      categoryId: 49,
      name: 'B10 L7',
      bbox: Rect.fromLTWH(2957.05, 3677.65, 247.84, 220.71),
      points: [
        Offset(2957.050, 3773.300),
        Offset(3042.749, 3690.284),
        Offset(3058.754, 3677.646),
        Offset(3092.558, 3680.969),
        Offset(3107.874, 3690.440),
        Offset(3204.892, 3775.738),
        Offset(3078.807, 3898.358),
      ],
    ),
    // id 285: B10 L8
    Phase1LotAnnotation(
      id: 285,
      categoryId: 50,
      name: 'B10 L8',
      bbox: Rect.fromLTWH(2881.17, 3774.45, 196.16, 193.69),
      points: [
        Offset(2954.760, 3774.445),
        Offset(2881.174, 3842.571),
        Offset(3002.887, 3968.133),
        Offset(3077.335, 3897.615),
      ],
    ),
    // id 286: B10 L9
    Phase1LotAnnotation(
      id: 286,
      categoryId: 51,
      name: 'B10 L9',
      bbox: Rect.fromLTWH(2808.47, 3844.37, 193.89, 191.52),
      points: [
        Offset(2882.342, 3844.368),
        Offset(2808.474, 3908.733),
        Offset(2928.550, 4035.892),
        Offset(3002.368, 3968.366),
      ],
    ),
    // id 287: B10 L10
    Phase1LotAnnotation(
      id: 287,
      categoryId: 41,
      name: 'B10 L10',
      bbox: Rect.fromLTWH(2731.69, 3910.68, 195.99, 194.10),
      points: [
        Offset(2808.224, 3910.678),
        Offset(2731.691, 3974.072),
        Offset(2853.905, 4104.773),
        Offset(2927.678, 4039.447),
      ],
    ),
    // id 288: B10 L11
    Phase1LotAnnotation(
      id: 288,
      categoryId: 42,
      name: 'B10 L11',
      bbox: Rect.fromLTWH(2660.11, 3973.64, 190.36, 198.30),
      points: [
        Offset(2732.666, 3973.643),
        Offset(2660.114, 4042.027),
        Offset(2776.406, 4171.946),
        Offset(2850.475, 4107.621),
      ],
    ),
    // id 289: B11 L1
    Phase1LotAnnotation(
      id: 289,
      categoryId: 52,
      name: 'B11 L1',
      bbox: Rect.fromLTWH(2873.91, 4367.52, 161.54, 153.77),
      points: [
        Offset(2959.032, 4521.293),
        Offset(3035.447, 4459.413),
        Offset(2951.029, 4367.520),
        Offset(2873.907, 4430.490),
      ],
    ),
    // id 290: B11 L2
    Phase1LotAnnotation(
      id: 290,
      categoryId: 58,
      name: 'B11 L2',
      bbox: Rect.fromLTWH(2952.67, 4303.93, 160.35, 154.24),
      points: [
        Offset(3029.427, 4303.935),
        Offset(2952.674, 4367.607),
        Offset(3034.931, 4458.171),
        Offset(3113.020, 4394.070),
      ],
    ),
    // id 291: B11 L3
    Phase1LotAnnotation(
      id: 291,
      categoryId: 59,
      name: 'B11 L3',
      bbox: Rect.fromLTWH(3030.04, 4239.98, 161.12, 154.89),
      points: [
        Offset(3030.044, 4303.317),
        Offset(3104.932, 4239.976),
        Offset(3191.164, 4328.333),
        Offset(3114.091, 4394.861),
      ],
    ),
    // id 292: B11 L4
    Phase1LotAnnotation(
      id: 292,
      categoryId: 60,
      name: 'B11 L4',
      bbox: Rect.fromLTWH(3104.76, 4173.55, 161.38, 154.75),
      points: [
        Offset(3104.761, 4240.333),
        Offset(3180.826, 4173.554),
        Offset(3266.137, 4262.775),
        Offset(3191.591, 4328.299),
      ],
    ),
    // id 293: B11 L5
    Phase1LotAnnotation(
      id: 293,
      categoryId: 61,
      name: 'B11 L5',
      bbox: Rect.fromLTWH(3180.71, 4106.47, 162.41, 156.12),
      points: [
        Offset(3180.713, 4173.026),
        Offset(3256.911, 4106.465),
        Offset(3343.119, 4194.339),
        Offset(3267.736, 4262.580),
      ],
    ),
    // id 294: B11 L6
    Phase1LotAnnotation(
      id: 294,
      categoryId: 62,
      name: 'B11 L6',
      bbox: Rect.fromLTWH(3257.28, 4040.25, 160.91, 153.68),
      points: [
        Offset(3257.282, 4106.337),
        Offset(3331.041, 4040.250),
        Offset(3418.195, 4127.245),
        Offset(3342.653, 4193.927),
      ],
    ),
    // id 295: B11 L7
    Phase1LotAnnotation(
      id: 295,
      categoryId: 63,
      name: 'B11 L7',
      bbox: Rect.fromLTWH(3332.19, 3975.62, 178.28, 151.72),
      points: [
        Offset(3332.187, 4040.366),
        Offset(3396.585, 3980.722),
        Offset(3418.916, 3975.616),
        Offset(3443.307, 3982.389),
        Offset(3510.469, 4040.501),
        Offset(3418.677, 4127.339),
      ],
    ),
    // id 296: B11 L8
    Phase1LotAnnotation(
      id: 296,
      categoryId: 64,
      name: 'B11 L8',
      bbox: Rect.fromLTWH(3416.60, 4048.06, 172.43, 183.65),
      points: [
        Offset(3416.596, 4142.151),
        Offset(3520.675, 4048.056),
        Offset(3579.165, 4097.904),
        Offset(3589.021, 4121.118),
        Offset(3588.380, 4148.266),
        Offset(3577.622, 4166.726),
        Offset(3505.843, 4231.702),
      ],
    ),
    // id 297: B11 L9
    Phase1LotAnnotation(
      id: 297,
      categoryId: 65,
      name: 'B11 L9',
      bbox: Rect.fromLTWH(3341.47, 4143.39, 162.89, 154.26),
      points: [
        Offset(3415.978, 4143.386),
        Offset(3341.471, 4208.563),
        Offset(3429.387, 4297.647),
        Offset(3504.364, 4231.213),
      ],
    ),
    // id 298: B11 L10
    Phase1LotAnnotation(
      id: 298,
      categoryId: 53,
      name: 'B11 L10',
      bbox: Rect.fromLTWH(3267.65, 4208.22, 162.78, 156.21),
      points: [
        Offset(3340.644, 4208.223),
        Offset(3267.652, 4273.362),
        Offset(3355.910, 4364.435),
        Offset(3430.429, 4297.104),
      ],
    ),
    // id 299: B11 L11
    Phase1LotAnnotation(
      id: 299,
      categoryId: 54,
      name: 'B11 L11',
      bbox: Rect.fromLTWH(3192.35, 4273.68, 162.98, 157.00),
      points: [
        Offset(3267.162, 4273.678),
        Offset(3192.354, 4337.330),
        Offset(3279.635, 4430.680),
        Offset(3355.336, 4364.182),
      ],
    ),
    // id 300: B11 L12
    Phase1LotAnnotation(
      id: 300,
      categoryId: 55,
      name: 'B11 L12',
      bbox: Rect.fromLTWH(3117.12, 4337.90, 161.59, 157.27),
      points: [
        Offset(3193.063, 4337.897),
        Offset(3117.118, 4401.518),
        Offset(3201.727, 4495.168),
        Offset(3278.704, 4431.351),
      ],
    ),
    // id 301: B11 L14
    Phase1LotAnnotation(
      id: 301,
      categoryId: 56,
      name: 'B11 L14',
      bbox: Rect.fromLTWH(3040.81, 4401.86, 161.37, 156.32),
      points: [
        Offset(3117.528, 4401.858),
        Offset(3040.805, 4466.804),
        Offset(3124.849, 4558.178),
        Offset(3202.176, 4494.878),
      ],
    ),
    // id 302: B11 L15
    Phase1LotAnnotation(
      id: 302,
      categoryId: 57,
      name: 'B11 L15',
      bbox: Rect.fromLTWH(2964.71, 4466.34, 160.42, 155.59),
      points: [
        Offset(3040.542, 4466.336),
        Offset(2964.713, 4529.817),
        Offset(3046.854, 4621.927),
        Offset(3125.131, 4557.918),
      ],
    ),
    // id 303: B12 L1
    Phase1LotAnnotation(
      id: 303,
      categoryId: 66,
      name: 'B12 L1',
      bbox: Rect.fromLTWH(3583.04, 4202.02, 187.84, 156.95),
      points: [
        Offset(3770.884, 4266.320),
        Offset(3672.415, 4358.969),
        Offset(3583.040, 4270.027),
        Offset(3652.554, 4208.365),
        Offset(3673.385, 4202.024),
        Offset(3694.442, 4204.386),
        Offset(3709.763, 4212.723),
      ],
    ),
    // id 304: B12 L3
    Phase1LotAnnotation(
      id: 304,
      categoryId: 73,
      name: 'B12 L3',
      bbox: Rect.fromLTWH(3511.38, 4271.23, 162.37, 155.79),
      points: [
        Offset(3583.053, 4271.226),
        Offset(3511.377, 4336.879),
        Offset(3597.858, 4427.015),
        Offset(3673.749, 4360.284),
      ],
    ),
    // id 305: B12 L5
    Phase1LotAnnotation(
      id: 305,
      categoryId: 75,
      name: 'B12 L5',
      bbox: Rect.fromLTWH(3434.07, 4337.49, 163.50, 157.50),
      points: [
        Offset(3510.661, 4337.486),
        Offset(3434.065, 4405.877),
        Offset(3521.854, 4494.989),
        Offset(3597.566, 4427.459),
      ],
    ),
    // id 306: B12 L7
    Phase1LotAnnotation(
      id: 306,
      categoryId: 77,
      name: 'B12 L7',
      bbox: Rect.fromLTWH(3359.42, 4406.13, 162.52, 155.33),
      points: [
        Offset(3433.825, 4406.133),
        Offset(3359.415, 4471.538),
        Offset(3445.223, 4561.464),
        Offset(3521.937, 4494.578),
      ],
    ),
    // id 307: B12 L9
    Phase1LotAnnotation(
      id: 307,
      categoryId: 79,
      name: 'B12 L9',
      bbox: Rect.fromLTWH(3284.31, 4471.69, 159.97, 154.93),
      points: [
        Offset(3358.987, 4471.688),
        Offset(3284.306, 4534.846),
        Offset(3367.241, 4626.616),
        Offset(3444.279, 4560.800),
      ],
    ),
    // id 308: B12 L11
    Phase1LotAnnotation(
      id: 308,
      categoryId: 68,
      name: 'B12 L11',
      bbox: Rect.fromLTWH(3207.63, 4535.50, 159.31, 154.89),
      points: [
        Offset(3284.150, 4535.503),
        Offset(3207.626, 4600.131),
        Offset(3289.523, 4690.397),
        Offset(3366.939, 4628.118),
      ],
    ),
    // id 309: B12 L15
    Phase1LotAnnotation(
      id: 309,
      categoryId: 71,
      name: 'B12 L15',
      bbox: Rect.fromLTWH(3131.34, 4601.64, 159.49, 176.68),
      points: [
        Offset(3205.831, 4601.638),
        Offset(3188.112, 4617.019),
        Offset(3184.244, 4633.952),
        Offset(3190.274, 4652.180),
        Offset(3196.894, 4658.920),
        Offset(3131.338, 4711.615),
        Offset(3188.840, 4778.319),
        Offset(3290.823, 4693.008),
      ],
    ),
    // id 310: B12 L14
    Phase1LotAnnotation(
      id: 310,
      categoryId: 70,
      name: 'B12 L14',
      bbox: Rect.fromLTWH(3196.79, 4720.28, 164.48, 150.76),
      points: [
        Offset(3196.785, 4782.922),
        Offset(3271.228, 4720.283),
        Offset(3361.262, 4809.570),
        Offset(3284.075, 4871.041),
      ],
    ),
    // id 311: B12 L12
    Phase1LotAnnotation(
      id: 311,
      categoryId: 69,
      name: 'B12 L12',
      bbox: Rect.fromLTWH(3271.97, 4657.40, 163.69, 150.57),
      points: [
        Offset(3271.967, 4720.566),
        Offset(3347.174, 4657.399),
        Offset(3435.658, 4743.221),
        Offset(3359.794, 4807.965),
      ],
    ),
    // id 312: B12 L10
    Phase1LotAnnotation(
      id: 312,
      categoryId: 67,
      name: 'B12 L10',
      bbox: Rect.fromLTWH(3347.97, 4591.70, 166.44, 153.80),
      points: [
        Offset(3347.965, 4657.912),
        Offset(3422.850, 4591.704),
        Offset(3514.405, 4679.977),
        Offset(3437.713, 4745.505),
      ],
    ),
    // id 313: B12 L8
    Phase1LotAnnotation(
      id: 313,
      categoryId: 78,
      name: 'B12 L8',
      bbox: Rect.fromLTWH(3423.32, 4528.78, 164.96, 151.94),
      points: [
        Offset(3423.323, 4592.402),
        Offset(3498.904, 4528.777),
        Offset(3588.281, 4614.413),
        Offset(3513.625, 4680.718),
      ],
    ),
    // id 314: B12 L6
    Phase1LotAnnotation(
      id: 314,
      categoryId: 76,
      name: 'B12 L6',
      bbox: Rect.fromLTWH(3499.38, 4461.90, 166.61, 151.70),
      points: [
        Offset(3499.380, 4528.541),
        Offset(3572.473, 4461.898),
        Offset(3665.992, 4547.702),
        Offset(3591.463, 4613.595),
      ],
    ),
    // id 315: B12 L4
    Phase1LotAnnotation(
      id: 315,
      categoryId: 74,
      name: 'B12 L4',
      bbox: Rect.fromLTWH(3573.61, 4396.37, 166.13, 152.72),
      points: [
        Offset(3573.610, 4462.669),
        Offset(3646.571, 4396.365),
        Offset(3739.744, 4479.552),
        Offset(3664.422, 4549.086),
      ],
    ),
    // id 316: B12 L2
    Phase1LotAnnotation(
      id: 316,
      categoryId: 72,
      name: 'B12 L2',
      bbox: Rect.fromLTWH(3648.60, 4274.05, 200.61, 206.60),
      points: [
        Offset(3648.595, 4394.770),
        Offset(3780.422, 4274.052),
        Offset(3834.758, 4320.381),
        Offset(3847.616, 4340.668),
        Offset(3849.204, 4361.016),
        Offset(3842.218, 4385.862),
        Offset(3826.414, 4401.081),
        Offset(3741.539, 4480.651),
      ],
    ),
    // id 317: B14 L1
    Phase1LotAnnotation(
      id: 317,
      categoryId: 80,
      name: 'B14 L1',
      bbox: Rect.fromLTWH(3824.94, 4428.22, 257.97, 216.29),
      points: [
        Offset(3969.307, 4644.514),
        Offset(4082.910, 4538.660),
        Offset(3962.009, 4432.412),
        Offset(3948.079, 4428.223),
        Offset(3931.655, 4429.225),
        Offset(3914.545, 4433.853),
        Offset(3905.841, 4441.018),
        Offset(3824.937, 4517.630),
      ],
    ),
    // id 318: B14 L3
    Phase1LotAnnotation(
      id: 318,
      categoryId: 88,
      name: 'B14 L3',
      bbox: Rect.fromLTWH(3751.84, 4517.73, 217.35, 195.53),
      points: [
        Offset(3823.979, 4517.726),
        Offset(3751.841, 4583.209),
        Offset(3895.800, 4713.258),
        Offset(3969.188, 4645.565),
      ],
    ),
    // id 319: B14 L5
    Phase1LotAnnotation(
      id: 319,
      categoryId: 90,
      name: 'B14 L5',
      bbox: Rect.fromLTWH(3674.74, 4584.11, 219.74, 198.59),
      points: [
        Offset(3751.016, 4584.110),
        Offset(3674.736, 4651.611),
        Offset(3818.017, 4782.698),
        Offset(3894.475, 4713.901),
      ],
    ),
    // id 320: B14 L7
    Phase1LotAnnotation(
      id: 320,
      categoryId: 92,
      name: 'B14 L7',
      bbox: Rect.fromLTWH(3600.06, 4652.95, 218.16, 198.00),
      points: [
        Offset(3675.227, 4652.948),
        Offset(3600.058, 4717.914),
        Offset(3741.655, 4850.952),
        Offset(3818.218, 4783.434),
      ],
    ),
    // id 321: B14 L9
    Phase1LotAnnotation(
      id: 321,
      categoryId: 94,
      name: 'B14 L9',
      bbox: Rect.fromLTWH(3522.65, 4718.67, 218.02, 199.43),
      points: [
        Offset(3599.110, 4718.673),
        Offset(3522.652, 4783.488),
        Offset(3664.106, 4918.104),
        Offset(3740.672, 4850.223),
      ],
    ),
    // id 322: B14 L11
    Phase1LotAnnotation(
      id: 322,
      categoryId: 82,
      name: 'B14 L11',
      bbox: Rect.fromLTWH(3447.79, 4783.26, 216.89, 199.27),
      points: [
        Offset(3522.558, 4783.264),
        Offset(3447.785, 4846.627),
        Offset(3585.775, 4982.531),
        Offset(3664.679, 4916.997),
      ],
    ),
    // id 323: B14 L15
    Phase1LotAnnotation(
      id: 323,
      categoryId: 85,
      name: 'B14 L15',
      bbox: Rect.fromLTWH(3369.87, 4847.85, 215.77, 221.05),
      points: [
        Offset(3447.203, 4847.854),
        Offset(3433.616, 4858.427),
        Offset(3427.180, 4871.900),
        Offset(3426.355, 4888.557),
        Offset(3435.455, 4905.031),
        Offset(3369.869, 4957.167),
        Offset(3480.989, 5068.906),
        Offset(3585.635, 4983.206),
      ],
    ),
    // id 324: B14 L16
    Phase1LotAnnotation(
      id: 324,
      categoryId: 86,
      name: 'B14 L16',
      bbox: Rect.fromLTWH(3489.67, 5012.88, 199.20, 183.34),
      points: [
        Offset(3489.665, 5075.714),
        Offset(3565.282, 5012.878),
        Offset(3688.867, 5134.849),
        Offset(3609.520, 5196.220),
      ],
    ),
    // id 325: B14 L14
    Phase1LotAnnotation(
      id: 325,
      categoryId: 84,
      name: 'B14 L14',
      bbox: Rect.fromLTWH(3566.38, 4949.83, 201.62, 183.55),
      points: [
        Offset(3566.375, 5012.628),
        Offset(3641.147, 4949.827),
        Offset(3767.998, 5072.230),
        Offset(3691.426, 5133.375),
      ],
    ),
    // id 326: B14 L12
    Phase1LotAnnotation(
      id: 326,
      categoryId: 83,
      name: 'B14 L12',
      bbox: Rect.fromLTWH(3642.17, 4884.68, 206.33, 188.07),
      points: [
        Offset(3642.170, 4948.925),
        Offset(3714.427, 4884.681),
        Offset(3848.504, 5011.955),
        Offset(3770.827, 5072.754),
      ],
    ),
    // id 327: B14 L10
    Phase1LotAnnotation(
      id: 327,
      categoryId: 81,
      name: 'B14 L10',
      bbox: Rect.fromLTWH(3713.94, 4820.60, 215.17, 192.41),
      points: [
        Offset(3713.937, 4885.531),
        Offset(3789.285, 4820.595),
        Offset(3929.107, 4949.054),
        Offset(3847.416, 5013.004),
      ],
    ),
    // id 328: B14 L8
    Phase1LotAnnotation(
      id: 328,
      categoryId: 93,
      name: 'B14 L8',
      bbox: Rect.fromLTWH(3789.89, 4756.78, 214.67, 191.87),
      points: [
        Offset(3789.890, 4819.745),
        Offset(3862.725, 4756.783),
        Offset(4004.562, 4885.459),
        Offset(3929.041, 4948.654),
      ],
    ),
    // id 329: B14 L6
    Phase1LotAnnotation(
      id: 329,
      categoryId: 91,
      name: 'B14 L6',
      bbox: Rect.fromLTWH(3862.85, 4689.78, 218.61, 196.00),
      points: [
        Offset(3862.853, 4755.753),
        Offset(3934.485, 4689.784),
        Offset(4081.466, 4821.859),
        Offset(4004.041, 4885.786),
      ],
    ),
    // id 330: B14 L4
    Phase1LotAnnotation(
      id: 330,
      categoryId: 89,
      name: 'B14 L4',
      bbox: Rect.fromLTWH(3935.82, 4623.24, 220.00, 198.18),
      points: [
        Offset(3935.816, 4689.369),
        Offset(4006.798, 4623.236),
        Offset(4155.815, 4756.748),
        Offset(4081.742, 4821.415),
      ],
    ),
    // id 331: B14 L2
    Phase1LotAnnotation(
      id: 331,
      categoryId: 87,
      name: 'B14 L2',
      bbox: Rect.fromLTWH(4006.99, 4545.75, 214.48, 211.04),
      points: [
        Offset(4006.985, 4622.386),
        Offset(4091.895, 4545.751),
        Offset(4208.378, 4644.584),
        Offset(4218.807, 4662.435),
        Offset(4221.461, 4681.077),
        Offset(4220.676, 4696.295),
        Offset(4211.612, 4713.524),
        Offset(4157.653, 4756.795),
      ],
    ),
    // id 332: B15 L1
    Phase1LotAnnotation(
      id: 332,
      categoryId: 95,
      name: 'B15 L1',
      bbox: Rect.fromLTWH(3280.89, 3619.47, 243.86, 210.17),
      points: [
        Offset(3388.224, 3619.468),
        Offset(3280.885, 3729.725),
        Offset(3388.844, 3821.739),
        Offset(3408.707, 3829.635),
        Offset(3429.086, 3825.900),
        Offset(3447.015, 3817.060),
        Offset(3524.747, 3738.198),
      ],
    ),
    // id 333: B15 L2
    Phase1LotAnnotation(
      id: 333,
      categoryId: 105,
      name: 'B15 L2',
      bbox: Rect.fromLTWH(3154.70, 3492.98, 225.98, 231.57),
      points: [
        Offset(3380.683, 3613.938),
        Offset(3272.728, 3724.543),
        Offset(3160.169, 3624.100),
        Offset(3154.700, 3604.288),
        Offset(3157.251, 3582.703),
        Offset(3168.966, 3564.188),
        Offset(3239.245, 3492.977),
      ],
    ),
    // id 334: B15 L3
    Phase1LotAnnotation(
      id: 334,
      categoryId: 116,
      name: 'B15 L3',
      bbox: Rect.fromLTWH(3389.01, 3547.92, 208.01, 190.34),
      points: [
        Offset(3389.009, 3618.698),
        Offset(3457.037, 3547.919),
        Offset(3597.021, 3668.601),
        Offset(3527.119, 3738.259),
      ],
    ),
    // id 335: B15 L4
    Phase1LotAnnotation(
      id: 335,
      categoryId: 123,
      name: 'B15 L4',
      bbox: Rect.fromLTWH(3240.72, 3419.45, 210.22, 193.99),
      points: [
        Offset(3381.186, 3613.435),
        Offset(3450.940, 3540.068),
        Offset(3309.851, 3419.450),
        Offset(3240.720, 3490.499),
      ],
    ),
    // id 336: B15 L5
    Phase1LotAnnotation(
      id: 336,
      categoryId: 124,
      name: 'B15 L5',
      bbox: Rect.fromLTWH(3457.60, 3477.41, 210.72, 191.25),
      points: [
        Offset(3457.597, 3547.078),
        Offset(3522.787, 3477.413),
        Offset(3668.320, 3597.973),
        Offset(3596.669, 3668.666),
      ],
    ),
    // id 337: B15 L6
    Phase1LotAnnotation(
      id: 337,
      categoryId: 125,
      name: 'B15 L6',
      bbox: Rect.fromLTWH(3310.31, 3347.15, 210.18, 193.37),
      points: [
        Offset(3310.305, 3418.889),
        Offset(3380.141, 3347.153),
        Offset(3520.486, 3465.778),
        Offset(3452.216, 3540.525),
      ],
    ),
    // id 338: B15 L7
    Phase1LotAnnotation(
      id: 338,
      categoryId: 126,
      name: 'B15 L7',
      bbox: Rect.fromLTWH(3524.46, 3404.77, 211.63, 192.38),
      points: [
        Offset(3524.457, 3476.197),
        Offset(3589.250, 3404.766),
        Offset(3736.083, 3524.025),
        Offset(3668.566, 3597.146),
      ],
    ),
    // id 339: B15 L8
    Phase1LotAnnotation(
      id: 339,
      categoryId: 127,
      name: 'B15 L8',
      bbox: Rect.fromLTWH(3379.68, 3239.02, 214.70, 227.33),
      points: [
        Offset(3379.678, 3347.002),
        Offset(3412.259, 3311.041),
        Offset(3421.106, 3293.468),
        Offset(3418.844, 3262.273),
        Offset(3575.120, 3239.015),
        Offset(3594.382, 3362.928),
        Offset(3593.930, 3377.151),
        Offset(3589.441, 3390.296),
        Offset(3580.573, 3402.392),
        Offset(3521.154, 3466.341),
      ],
    ),
    // id 340: B15 L9
    Phase1LotAnnotation(
      id: 340,
      categoryId: 128,
      name: 'B15 L9',
      bbox: Rect.fromLTWH(3589.31, 3306.34, 223.05, 218.90),
      points: [
        Offset(3589.305, 3404.813),
        Offset(3599.018, 3389.461),
        Offset(3602.128, 3377.673),
        Offset(3602.906, 3365.630),
        Offset(3598.986, 3335.756),
        Offset(3789.880, 3306.342),
        Offset(3812.355, 3434.685),
        Offset(3807.807, 3446.899),
        Offset(3799.626, 3462.290),
        Offset(3737.746, 3525.240),
      ],
    ),
    // id 341: B15 L10
    Phase1LotAnnotation(
      id: 341,
      categoryId: 96,
      name: 'B15 L10',
      bbox: Rect.fromLTWH(3404.71, 3139.26, 170.43, 122.78),
      points: [
        Offset(3418.386, 3262.045),
        Offset(3404.705, 3161.999),
        Offset(3558.640, 3139.264),
        Offset(3575.130, 3237.619),
      ],
    ),
    // id 342: B15 L11
    Phase1LotAnnotation(
      id: 342,
      categoryId: 97,
      name: 'B15 L11',
      bbox: Rect.fromLTWH(3583.78, 3206.83, 206.37, 128.64),
      points: [
        Offset(3583.776, 3237.413),
        Offset(3599.469, 3335.475),
        Offset(3790.145, 3305.782),
        Offset(3771.223, 3206.834),
      ],
    ),
    // id 343: B15 L12
    Phase1LotAnnotation(
      id: 343,
      categoryId: 98,
      name: 'B15 L12',
      bbox: Rect.fromLTWH(3568.66, 3108.40, 202.52, 127.96),
      points: [
        Offset(3568.659, 3137.624),
        Offset(3583.907, 3236.358),
        Offset(3771.180, 3207.421),
        Offset(3753.095, 3108.400),
      ],
    ),
    // id 344: B15 L14
    Phase1LotAnnotation(
      id: 344,
      categoryId: 99,
      name: 'B15 L14',
      bbox: Rect.fromLTWH(3387.72, 3039.49, 171.80, 123.08),
      points: [
        Offset(3387.721, 3064.985),
        Offset(3404.126, 3162.571),
        Offset(3559.516, 3137.392),
        Offset(3543.500, 3039.491),
      ],
    ),
    // id 345: B15 L15
    Phase1LotAnnotation(
      id: 345,
      categoryId: 100,
      name: 'B15 L15',
      bbox: Rect.fromLTWH(3552.06, 3009.67, 200.03, 128.03),
      points: [
        Offset(3552.060, 3038.876),
        Offset(3567.797, 3137.699),
        Offset(3752.085, 3108.860),
        Offset(3735.372, 3009.670),
      ],
    ),
    // id 346: B15 L16
    Phase1LotAnnotation(
      id: 346,
      categoryId: 101,
      name: 'B15 L16',
      bbox: Rect.fromLTWH(3372.64, 2940.66, 170.09, 123.84),
      points: [
        Offset(3372.640, 2963.439),
        Offset(3388.092, 3064.498),
        Offset(3542.731, 3038.898),
        Offset(3527.679, 2940.656),
      ],
    ),
    // id 347: B15 L17
    Phase1LotAnnotation(
      id: 347,
      categoryId: 102,
      name: 'B15 L17',
      bbox: Rect.fromLTWH(3537.53, 2911.70, 197.89, 127.68),
      points: [
        Offset(3537.527, 2939.309),
        Offset(3552.498, 3039.375),
        Offset(3735.415, 3010.776),
        Offset(3717.304, 2911.696),
      ],
    ),
    // id 348: B15 L18
    Phase1LotAnnotation(
      id: 348,
      categoryId: 103,
      name: 'B15 L18',
      bbox: Rect.fromLTWH(3356.56, 2840.78, 171.74, 122.10),
      points: [
        Offset(3511.889, 2840.779),
        Offset(3356.555, 2864.870),
        Offset(3372.224, 2962.881),
        Offset(3528.296, 2941.173),
      ],
    ),
    // id 349: B15 L19
    Phase1LotAnnotation(
      id: 349,
      categoryId: 104,
      name: 'B15 L19',
      bbox: Rect.fromLTWH(3521.51, 2813.63, 195.65, 124.83),
      points: [
        Offset(3696.381, 2813.633),
        Offset(3521.513, 2839.701),
        Offset(3537.195, 2938.461),
        Offset(3717.167, 2911.227),
      ],
    ),
    // id 350: B15 L20
    Phase1LotAnnotation(
      id: 350,
      categoryId: 106,
      name: 'B15 L20',
      bbox: Rect.fromLTWH(3340.42, 2741.37, 172.20, 124.66),
      points: [
        Offset(3340.424, 2766.148),
        Offset(3356.137, 2866.034),
        Offset(3512.625, 2840.850),
        Offset(3495.995, 2741.374),
      ],
    ),
    // id 351: B15 L21
    Phase1LotAnnotation(
      id: 351,
      categoryId: 107,
      name: 'B15 L21',
      bbox: Rect.fromLTWH(3506.19, 2713.46, 192.26, 126.52),
      points: [
        Offset(3506.186, 2740.967),
        Offset(3520.995, 2839.974),
        Offset(3698.449, 2812.854),
        Offset(3679.227, 2713.458),
      ],
    ),
    // id 352: B15 L22
    Phase1LotAnnotation(
      id: 352,
      categoryId: 108,
      name: 'B15 L22',
      bbox: Rect.fromLTWH(3324.15, 2642.21, 172.39, 123.13),
      points: [
        Offset(3480.219, 2642.211),
        Offset(3324.145, 2666.043),
        Offset(3340.797, 2765.340),
        Offset(3496.533, 2741.743),
      ],
    ),
    // id 353: B15 L23
    Phase1LotAnnotation(
      id: 353,
      categoryId: 109,
      name: 'B15 L23',
      bbox: Rect.fromLTWH(3489.84, 2616.25, 190.42, 124.51),
      points: [
        Offset(3489.841, 2642.207),
        Offset(3505.387, 2740.759),
        Offset(3680.265, 2713.411),
        Offset(3661.121, 2616.249),
      ],
    ),
    // id 354: B15 L24
    Phase1LotAnnotation(
      id: 354,
      categoryId: 110,
      name: 'B15 L24',
      bbox: Rect.fromLTWH(3309.52, 2543.68, 170.50, 122.53),
      points: [
        Offset(3464.635, 2543.681),
        Offset(3309.523, 2566.786),
        Offset(3324.718, 2666.215),
        Offset(3480.022, 2641.834),
      ],
    ),
    // id 355: B15 L25
    Phase1LotAnnotation(
      id: 355,
      categoryId: 111,
      name: 'B15 L25',
      bbox: Rect.fromLTWH(3474.66, 2515.74, 185.76, 126.28),
      points: [
        Offset(3474.659, 2542.855),
        Offset(3490.019, 2642.021),
        Offset(3660.418, 2614.553),
        Offset(3643.014, 2515.738),
      ],
    ),
    // id 356: B15 L26
    Phase1LotAnnotation(
      id: 356,
      categoryId: 112,
      name: 'B15 L26',
      bbox: Rect.fromLTWH(3293.14, 2444.65, 172.36, 122.68),
      points: [
        Offset(3449.051, 2444.649),
        Offset(3293.144, 2468.455),
        Offset(3308.738, 2567.328),
        Offset(3465.505, 2543.868),
      ],
    ),
    // id 357: B15 L27
    Phase1LotAnnotation(
      id: 357,
      categoryId: 113,
      name: 'B15 L27',
      bbox: Rect.fromLTWH(3458.97, 2418.40, 184.76, 124.09),
      points: [
        Offset(3458.966, 2444.456),
        Offset(3474.614, 2542.493),
        Offset(3643.727, 2515.850),
        Offset(3623.246, 2418.400),
      ],
    ),
    // id 358: B15 L28
    Phase1LotAnnotation(
      id: 358,
      categoryId: 114,
      name: 'B15 L28',
      bbox: Rect.fromLTWH(3277.41, 2345.11, 171.56, 123.23),
      points: [
        Offset(3432.965, 2345.113),
        Offset(3277.405, 2369.139),
        Offset(3292.573, 2468.339),
        Offset(3448.963, 2444.062),
      ],
    ),
    // id 359: B15 L29
    Phase1LotAnnotation(
      id: 359,
      categoryId: 115,
      name: 'B15 L29',
      bbox: Rect.fromLTWH(3442.52, 2318.14, 182.00, 125.24),
      points: [
        Offset(3442.516, 2344.108),
        Offset(3458.147, 2443.380),
        Offset(3624.514, 2417.200),
        Offset(3605.757, 2318.136),
      ],
    ),
    // id 360: B15 L30
    Phase1LotAnnotation(
      id: 360,
      categoryId: 117,
      name: 'B15 L30',
      bbox: Rect.fromLTWH(3261.92, 2246.58, 172.51, 121.86),
      points: [
        Offset(3417.883, 2246.583),
        Offset(3261.916, 2269.623),
        Offset(3277.419, 2368.442),
        Offset(3434.427, 2344.273),
      ],
    ),
    // id 361: B15 L31
    Phase1LotAnnotation(
      id: 361,
      categoryId: 118,
      name: 'B15 L31',
      bbox: Rect.fromLTWH(3426.93, 2221.60, 179.29, 121.92),
      points: [
        Offset(3426.932, 2245.075),
        Offset(3441.929, 2343.521),
        Offset(3606.223, 2316.944),
        Offset(3588.320, 2221.601),
      ],
    ),
    // id 362: B15 L32
    Phase1LotAnnotation(
      id: 362,
      categoryId: 119,
      name: 'B15 L32',
      bbox: Rect.fromLTWH(3247.30, 2148.22, 170.16, 122.43),
      points: [
        Offset(3401.496, 2148.222),
        Offset(3247.298, 2170.512),
        Offset(3261.354, 2270.650),
        Offset(3417.459, 2245.645),
      ],
    ),
    // id 363: B15 L33
    Phase1LotAnnotation(
      id: 363,
      categoryId: 120,
      name: 'B15 L33',
      bbox: Rect.fromLTWH(3411.53, 2121.41, 177.50, 124.30),
      points: [
        Offset(3568.695, 2121.410),
        Offset(3411.531, 2145.558),
        Offset(3426.455, 2245.708),
        Offset(3589.027, 2220.241),
      ],
    ),
    // id 364: B15 L34
    Phase1LotAnnotation(
      id: 364,
      categoryId: 121,
      name: 'B15 L34',
      bbox: Rect.fromLTWH(3226.51, 2038.83, 175.15, 132.37),
      points: [
        Offset(3226.510, 2039.100),
        Offset(3247.671, 2171.201),
        Offset(3401.663, 2146.952),
        Offset(3384.503, 2038.829),
      ],
    ),
    // id 365: B15 L35
    Phase1LotAnnotation(
      id: 365,
      categoryId: 122,
      name: 'B15 L35',
      bbox: Rect.fromLTWH(3394.26, 2039.97, 174.94, 105.47),
      points: [
        Offset(3394.256, 2039.972),
        Offset(3411.417, 2145.444),
        Offset(3569.199, 2120.892),
        Offset(3552.498, 2040.383),
      ],
    ),
    // id 366: B16 L1
    Phase1LotAnnotation(
      id: 366,
      categoryId: 129,
      name: 'B16 L1',
      bbox: Rect.fromLTWH(3580.22, 3881.02, 205.91, 173.92),
      points: [
        Offset(3692.343, 3881.019),
        Offset(3580.223, 3990.267),
        Offset(3643.777, 4046.262),
        Offset(3663.608, 4054.937),
        Offset(3687.191, 4054.725),
        Offset(3708.389, 4042.875),
        Offset(3786.136, 3962.918),
      ],
    ),
    // id 367: B16 L2
    Phase1LotAnnotation(
      id: 367,
      categoryId: 136,
      name: 'B16 L2',
      bbox: Rect.fromLTWH(3500.40, 3791.76, 185.09, 192.36),
      points: [
        Offset(3685.492, 3875.748),
        Offset(3572.564, 3984.126),
        Offset(3511.707, 3930.030),
        Offset(3500.401, 3904.457),
        Offset(3507.263, 3875.376),
        Offset(3519.878, 3860.020),
        Offset(3591.801, 3791.764),
      ],
    ),
    // id 368: B16 L3
    Phase1LotAnnotation(
      id: 368,
      categoryId: 137,
      name: 'B16 L3',
      bbox: Rect.fromLTWH(3692.87, 3809.39, 166.14, 154.59),
      points: [
        Offset(3692.870, 3880.492),
        Offset(3764.984, 3809.393),
        Offset(3859.009, 3892.906),
        Offset(3785.670, 3963.978),
      ],
    ),
    // id 369: B16 L4
    Phase1LotAnnotation(
      id: 369,
      categoryId: 138,
      name: 'B16 L4',
      bbox: Rect.fromLTWH(3592.82, 3722.50, 164.12, 152.84),
      points: [
        Offset(3592.818, 3791.601),
        Offset(3661.799, 3722.499),
        Offset(3756.935, 3803.867),
        Offset(3685.760, 3875.337),
      ],
    ),
    // id 370: B16 L5
    Phase1LotAnnotation(
      id: 370,
      categoryId: 139,
      name: 'B16 L5',
      bbox: Rect.fromLTWH(3765.60, 3737.39, 163.26, 153.93),
      points: [
        Offset(3765.600, 3808.816),
        Offset(3835.067, 3737.388),
        Offset(3928.859, 3819.530),
        Offset(3858.015, 3891.314),
      ],
    ),
    // id 371: B16 L6
    Phase1LotAnnotation(
      id: 371,
      categoryId: 140,
      name: 'B16 L6',
      bbox: Rect.fromLTWH(3662.07, 3650.63, 165.01, 153.64),
      points: [
        Offset(3662.074, 3722.211),
        Offset(3732.706, 3650.626),
        Offset(3827.087, 3731.790),
        Offset(3756.636, 3804.268),
      ],
    ),
    // id 372: B16 L7
    Phase1LotAnnotation(
      id: 372,
      categoryId: 141,
      name: 'B16 L7',
      bbox: Rect.fromLTWH(3836.10, 3665.92, 161.50, 153.39),
      points: [
        Offset(3836.104, 3736.655),
        Offset(3903.592, 3665.922),
        Offset(3997.603, 3747.733),
        Offset(3929.056, 3819.307),
      ],
    ),
    // id 373: B16 L8
    Phase1LotAnnotation(
      id: 373,
      categoryId: 142,
      name: 'B16 L8',
      bbox: Rect.fromLTWH(3731.87, 3577.90, 165.77, 154.79),
      points: [
        Offset(3731.870, 3651.235),
        Offset(3802.764, 3577.899),
        Offset(3897.643, 3659.242),
        Offset(3828.757, 3732.688),
      ],
    ),
    // id 374: B16 L9
    Phase1LotAnnotation(
      id: 374,
      categoryId: 143,
      name: 'B16 L9',
      bbox: Rect.fromLTWH(3904.74, 3593.55, 161.98, 153.62),
      points: [
        Offset(3904.735, 3665.992),
        Offset(3973.697, 3593.547),
        Offset(4066.713, 3673.947),
        Offset(3997.648, 3747.169),
      ],
    ),
    // id 375: B16 L10
    Phase1LotAnnotation(
      id: 375,
      categoryId: 130,
      name: 'B16 L10',
      bbox: Rect.fromLTWH(3803.02, 3503.42, 164.81, 157.87),
      points: [
        Offset(3803.019, 3577.979),
        Offset(3873.422, 3503.423),
        Offset(3967.832, 3587.474),
        Offset(3897.398, 3661.294),
      ],
    ),
    // id 376: B16 L11
    Phase1LotAnnotation(
      id: 376,
      categoryId: 131,
      name: 'B16 L11',
      bbox: Rect.fromLTWH(3974.30, 3518.83, 160.92, 154.26),
      points: [
        Offset(3974.302, 3592.736),
        Offset(4042.630, 3518.833),
        Offset(4135.222, 3600.124),
        Offset(4068.057, 3673.091),
      ],
    ),
    // id 377: B16 L12
    Phase1LotAnnotation(
      id: 377,
      categoryId: 132,
      name: 'B16 L12',
      bbox: Rect.fromLTWH(3872.96, 3431.48, 163.08, 155.46),
      points: [
        Offset(3968.505, 3586.938),
        Offset(4036.038, 3512.630),
        Offset(3940.083, 3431.480),
        Offset(3872.957, 3503.880),
      ],
    ),
    // id 378: B16 L14
    Phase1LotAnnotation(
      id: 378,
      categoryId: 133,
      name: 'B16 L14',
      bbox: Rect.fromLTWH(3942.21, 3358.34, 159.60, 155.34),
      points: [
        Offset(4035.964, 3513.682),
        Offset(4101.805, 3438.648),
        Offset(4009.899, 3358.339),
        Offset(3942.207, 3431.348),
      ],
    ),
    // id 379: B16 L15
    Phase1LotAnnotation(
      id: 379,
      categoryId: 134,
      name: 'B16 L15',
      bbox: Rect.fromLTWH(4042.29, 3340.35, 177.21, 260.53),
      points: [
        Offset(4042.289, 3518.425),
        Offset(4203.449, 3340.354),
        Offset(4219.499, 3488.557),
        Offset(4218.262, 3508.838),
        Offset(4207.258, 3523.102),
        Offset(4136.122, 3600.886),
      ],
    ),
    // id 380: B16 L16
    Phase1LotAnnotation(
      id: 380,
      categoryId: 135,
      name: 'B16 L16',
      bbox: Rect.fromLTWH(4009.76, 3227.15, 192.56, 212.39),
      points: [
        Offset(4009.763, 3359.426),
        Offset(4113.931, 3240.244),
        Offset(4130.417, 3230.238),
        Offset(4149.209, 3227.146),
        Offset(4166.368, 3231.737),
        Offset(4182.198, 3241.131),
        Offset(4191.449, 3257.148),
        Offset(4194.498, 3267.896),
        Offset(4202.327, 3328.166),
        Offset(4102.168, 3439.534),
      ],
    ),
    // id 381: B17 L1
    Phase1LotAnnotation(
      id: 381,
      categoryId: 144,
      name: 'B17 L1',
      bbox: Rect.fromLTWH(3762.52, 4017.19, 182.99, 192.07),
      points: [
        Offset(3945.511, 4099.801),
        Offset(3853.088, 4017.194),
        Offset(3771.840, 4094.808),
        Offset(3762.518, 4112.947),
        Offset(3763.385, 4134.140),
        Offset(3769.884, 4155.101),
        Offset(3782.964, 4165.031),
        Offset(3832.712, 4209.262),
      ],
    ),
    // id 382: B17 L2
    Phase1LotAnnotation(
      id: 382,
      categoryId: 154,
      name: 'B17 L2',
      bbox: Rect.fromLTWH(3840.10, 4105.15, 208.96, 174.00),
      points: [
        Offset(3840.095, 4216.019),
        Offset(3954.250, 4105.147),
        Offset(4049.053, 4190.645),
        Offset(3984.110, 4252.868),
        Offset(3958.910, 4274.869),
        Offset(3940.855, 4279.143),
        Offset(3912.557, 4277.622),
        Offset(3897.319, 4265.782),
      ],
    ),
    // id 383: B17 L3
    Phase1LotAnnotation(
      id: 383,
      categoryId: 157,
      name: 'B17 L3',
      bbox: Rect.fromLTWH(3853.01, 3948.45, 163.95, 150.62),
      points: [
        Offset(3945.737, 4099.068),
        Offset(4016.957, 4029.320),
        Offset(3920.728, 3948.446),
        Offset(3853.006, 4016.771),
      ],
    ),
    // id 384: B17 L4
    Phase1LotAnnotation(
      id: 384,
      categoryId: 158,
      name: 'B17 L4',
      bbox: Rect.fromLTWH(3953.67, 4036.71, 161.58, 150.68),
      points: [
        Offset(3953.671, 4104.993),
        Offset(4021.465, 4036.715),
        Offset(4115.254, 4115.259),
        Offset(4044.976, 4187.391),
      ],
    ),
    // id 385: B17 L5
    Phase1LotAnnotation(
      id: 385,
      categoryId: 159,
      name: 'B17 L5',
      bbox: Rect.fromLTWH(3921.03, 3876.25, 167.70, 152.10),
      points: [
        Offset(3921.033, 3947.737),
        Offset(3990.980, 3876.248),
        Offset(4088.729, 3955.992),
        Offset(4018.003, 4028.347),
      ],
    ),
    // id 386: B17 L6
    Phase1LotAnnotation(
      id: 386,
      categoryId: 160,
      name: 'B17 L6',
      bbox: Rect.fromLTWH(4022.22, 3966.26, 163.41, 148.16),
      points: [
        Offset(4022.216, 4036.063),
        Offset(4092.638, 3966.261),
        Offset(4185.630, 4044.964),
        Offset(4117.244, 4114.422),
      ],
    ),
    // id 387: B17 L7
    Phase1LotAnnotation(
      id: 387,
      categoryId: 161,
      name: 'B17 L7',
      bbox: Rect.fromLTWH(3989.99, 3801.35, 169.44, 154.55),
      points: [
        Offset(4089.416, 3955.896),
        Offset(4159.433, 3882.695),
        Offset(4061.391, 3801.346),
        Offset(3989.992, 3876.335),
      ],
    ),
    // id 388: B17 L8
    Phase1LotAnnotation(
      id: 388,
      categoryId: 162,
      name: 'B17 L8',
      bbox: Rect.fromLTWH(4093.13, 3893.18, 161.11, 151.74),
      points: [
        Offset(4093.125, 3964.797),
        Offset(4160.392, 3893.178),
        Offset(4254.232, 3972.163),
        Offset(4186.745, 4044.921),
      ],
    ),
    // id 389: B17 L9
    Phase1LotAnnotation(
      id: 389,
      categoryId: 163,
      name: 'B17 L9',
      bbox: Rect.fromLTWH(4061.23, 3731.16, 167.40, 152.02),
      points: [
        Offset(4061.228, 3801.607),
        Offset(4128.994, 3731.164),
        Offset(4228.632, 3809.213),
        Offset(4157.155, 3883.182),
      ],
    ),
    // id 390: B17 L10
    Phase1LotAnnotation(
      id: 390,
      categoryId: 145,
      name: 'B17 L10',
      bbox: Rect.fromLTWH(4162.78, 3822.75, 162.91, 148.06),
      points: [
        Offset(4162.779, 3894.410),
        Offset(4229.577, 3822.747),
        Offset(4325.689, 3899.750),
        Offset(4258.185, 3970.810),
      ],
    ),
    // id 391: B17 L11
    Phase1LotAnnotation(
      id: 391,
      categoryId: 146,
      name: 'B17 L11',
      bbox: Rect.fromLTWH(4130.74, 3655.82, 166.41, 151.77),
      points: [
        Offset(4229.507, 3807.587),
        Offset(4297.154, 3732.558),
        Offset(4197.107, 3655.818),
        Offset(4130.741, 3730.083),
      ],
    ),
    // id 392: B17 L12
    Phase1LotAnnotation(
      id: 392,
      categoryId: 147,
      name: 'B17 L12',
      bbox: Rect.fromLTWH(4228.13, 3750.36, 165.85, 146.53),
      points: [
        Offset(4228.128, 3823.118),
        Offset(4295.992, 3750.363),
        Offset(4393.973, 3824.138),
        Offset(4326.634, 3896.890),
      ],
    ),
    // id 393: B17 L14
    Phase1LotAnnotation(
      id: 393,
      categoryId: 148,
      name: 'B17 L14',
      bbox: Rect.fromLTWH(4297.55, 3674.73, 164.34, 152.30),
      points: [
        Offset(4297.554, 3749.836),
        Offset(4362.822, 3674.728),
        Offset(4461.898, 3751.450),
        Offset(4393.263, 3827.024),
      ],
    ),
    // id 394: B17 L15
    Phase1LotAnnotation(
      id: 394,
      categoryId: 149,
      name: 'B17 L15',
      bbox: Rect.fromLTWH(4197.83, 3583.00, 167.93, 149.62),
      points: [
        Offset(4297.113, 3732.621),
        Offset(4365.760, 3659.435),
        Offset(4266.475, 3583.000),
        Offset(4197.831, 3655.059),
      ],
    ),
    // id 395: B17 L16
    Phase1LotAnnotation(
      id: 395,
      categoryId: 150,
      name: 'B17 L16',
      bbox: Rect.fromLTWH(4363.58, 3549.91, 184.60, 201.06),
      points: [
        Offset(4363.584, 3676.681),
        Offset(4474.702, 3549.912),
        Offset(4478.600, 3557.892),
        Offset(4535.554, 3628.222),
        Offset(4548.182, 3650.536),
        Offset(4540.715, 3663.885),
        Offset(4462.081, 3750.969),
      ],
    ),
    // id 396: B17 L17
    Phase1LotAnnotation(
      id: 396,
      categoryId: 151,
      name: 'B17 L17',
      bbox: Rect.fromLTWH(4266.07, 3468.03, 205.71, 191.05),
      points: [
        Offset(4304.218, 3485.769),
        Offset(4307.774, 3518.056),
        Offset(4302.772, 3538.713),
        Offset(4293.660, 3554.340),
        Offset(4266.072, 3582.310),
        Offset(4364.827, 3659.081),
        Offset(4471.779, 3538.705),
        Offset(4458.444, 3468.033),
      ],
    ),
    // id 397: B17 L18
    Phase1LotAnnotation(
      id: 397,
      categoryId: 152,
      name: 'B17 L18',
      bbox: Rect.fromLTWH(4290.23, 3368.91, 167.37, 117.09),
      points: [
        Offset(4457.598, 3466.784),
        Offset(4452.678, 3442.673),
        Offset(4427.156, 3368.910),
        Offset(4290.232, 3386.107),
        Offset(4303.563, 3485.995),
      ],
    ),
    // id 398: B17 L19
    Phase1LotAnnotation(
      id: 398,
      categoryId: 153,
      name: 'B17 L19',
      bbox: Rect.fromLTWH(4280.04, 3268.64, 155.74, 115.92),
      points: [
        Offset(4435.771, 3268.640),
        Offset(4280.035, 3284.942),
        Offset(4290.921, 3384.563),
        Offset(4427.744, 3369.704),
        Offset(4423.352, 3363.944),
      ],
    ),
    // id 399: B17 L20
    Phase1LotAnnotation(
      id: 399,
      categoryId: 155,
      name: 'B17 L20',
      bbox: Rect.fromLTWH(4267.74, 3168.13, 172.32, 118.61),
      points: [
        Offset(4423.216, 3168.129),
        Offset(4267.735, 3184.712),
        Offset(4281.232, 3286.735),
        Offset(4438.674, 3267.892),
        Offset(4440.053, 3244.778),
      ],
    ),
    // id 400: B17 L21
    Phase1LotAnnotation(
      id: 400,
      categoryId: 156,
      name: 'B17 L21',
      bbox: Rect.fromLTWH(4254.57, 2878.09, 170.76, 307.67),
      points: [
        Offset(4412.089, 2878.094),
        Offset(4254.568, 3072.205),
        Offset(4269.320, 3185.767),
        Offset(4425.331, 3167.935),
        Offset(4389.407, 3056.952),
      ],
    ),
    // id 401: B18 L1
    Phase1LotAnnotation(
      id: 401,
      categoryId: 164,
      name: 'B18 L1',
      bbox: Rect.fromLTWH(4023.86, 4243.34, 243.05, 241.32),
      points: [
        Offset(4156.479, 4484.661),
        Offset(4266.915, 4379.896),
        Offset(4108.353, 4243.337),
        Offset(4037.024, 4317.207),
        Offset(4026.641, 4329.027),
        Offset(4023.861, 4357.326),
        Offset(4028.701, 4376.672),
      ],
    ),
    // id 402: B18 L2
    Phase1LotAnnotation(
      id: 402,
      categoryId: 166,
      name: 'B18 L2',
      bbox: Rect.fromLTWH(4162.84, 4387.88, 263.32, 221.89),
      points: [
        Offset(4271.452, 4387.880),
        Offset(4162.844, 4497.051),
        Offset(4282.578, 4601.012),
        Offset(4313.057, 4609.770),
        Offset(4327.691, 4606.984),
        Offset(4346.314, 4595.589),
        Offset(4426.160, 4521.460),
      ],
    ),
    // id 403: B18 L3
    Phase1LotAnnotation(
      id: 403,
      categoryId: 167,
      name: 'B18 L3',
      bbox: Rect.fromLTWH(4111.41, 4173.01, 228.94, 206.87),
      points: [
        Offset(4264.903, 4379.876),
        Offset(4340.342, 4307.878),
        Offset(4179.577, 4173.011),
        Offset(4111.406, 4244.059),
      ],
    ),
    // id 404: B18 L4
    Phase1LotAnnotation(
      id: 404,
      categoryId: 168,
      name: 'B18 L4',
      bbox: Rect.fromLTWH(4272.51, 4299.76, 243.40, 219.33),
      points: [
        Offset(4272.509, 4386.970),
        Offset(4360.214, 4299.755),
        Offset(4515.911, 4435.915),
        Offset(4426.947, 4519.084),
      ],
    ),
    // id 405: B18 L5
    Phase1LotAnnotation(
      id: 405,
      categoryId: 169,
      name: 'B18 L5',
      bbox: Rect.fromLTWH(4181.60, 4101.44, 228.99, 204.95),
      points: [
        Offset(4338.398, 4306.380),
        Offset(4410.583, 4233.758),
        Offset(4250.929, 4101.435),
        Offset(4181.596, 4174.472),
      ],
    ),
    // id 406: B18 L6
    Phase1LotAnnotation(
      id: 406,
      categoryId: 170,
      name: 'B18 L6',
      bbox: Rect.fromLTWH(4359.59, 4080.55, 246.86, 355.40),
      points: [
        Offset(4359.592, 4299.439),
        Offset(4568.562, 4080.551),
        Offset(4554.341, 4129.078),
        Offset(4542.659, 4228.948),
        Offset(4570.853, 4299.749),
        Offset(4606.455, 4352.679),
        Offset(4516.653, 4435.954),
      ],
    ),
    // id 407: B18 L7
    Phase1LotAnnotation(
      id: 407,
      categoryId: 171,
      name: 'B18 L7',
      bbox: Rect.fromLTWH(4251.08, 4029.73, 229.48, 204.76),
      points: [
        Offset(4251.077, 4101.176),
        Offset(4319.422, 4029.728),
        Offset(4480.559, 4161.502),
        Offset(4409.656, 4234.483),
      ],
    ),
    // id 408: B18 L8
    Phase1LotAnnotation(
      id: 408,
      categoryId: 172,
      name: 'B18 L8',
      bbox: Rect.fromLTWH(4319.48, 3957.11, 232.73, 203.02),
      points: [
        Offset(4319.479, 4029.864),
        Offset(4387.854, 3957.114),
        Offset(4552.212, 4086.566),
        Offset(4480.141, 4160.132),
      ],
    ),
    // id 409: B18 L9
    Phase1LotAnnotation(
      id: 409,
      categoryId: 173,
      name: 'B18 L9',
      bbox: Rect.fromLTWH(4388.68, 3882.17, 210.93, 203.31),
      points: [
        Offset(4388.682, 3957.045),
        Offset(4456.699, 3882.172),
        Offset(4599.614, 3994.049),
        Offset(4580.168, 4037.999),
        Offset(4573.102, 4064.338),
        Offset(4551.888, 4085.480),
      ],
    ),
    // id 410: B18 L10
    Phase1LotAnnotation(
      id: 410,
      categoryId: 165,
      name: 'B18 L10',
      bbox: Rect.fromLTWH(4457.01, 3727.56, 165.96, 266.58),
      points: [
        Offset(4457.009, 3882.146),
        Offset(4594.216, 3727.555),
        Offset(4618.192, 3766.994),
        Offset(4622.967, 3841.737),
        Offset(4621.043, 3939.786),
        Offset(4597.817, 3994.140),
      ],
    ),
    // id 411: B19 L1
    Phase1LotAnnotation(
      id: 411,
      categoryId: 174,
      name: 'B19 L1',
      bbox: Rect.fromLTWH(4519.51, 4430.35, 223.22, 268.10),
      points: [
        Offset(4646.303, 4430.352),
        Offset(4519.508, 4548.853),
        Offset(4699.546, 4698.454),
        Offset(4742.724, 4600.803),
        Offset(4701.337, 4557.360),
        Offset(4663.384, 4455.868),
      ],
    ),
    // id 412: B19 L2
    Phase1LotAnnotation(
      id: 412,
      categoryId: 177,
      name: 'B19 L2',
      bbox: Rect.fromLTWH(4447.33, 4548.67, 251.47, 239.88),
      points: [
        Offset(4519.940, 4548.666),
        Offset(4447.333, 4615.499),
        Offset(4649.310, 4788.544),
        Offset(4663.687, 4778.006),
        Offset(4698.799, 4696.443),
      ],
    ),
    // id 413: B19 L3
    Phase1LotAnnotation(
      id: 413,
      categoryId: 178,
      name: 'B19 L3',
      bbox: Rect.fromLTWH(4372.90, 4616.21, 277.25, 231.95),
      points: [
        Offset(4446.187, 4616.209),
        Offset(4372.903, 4682.456),
        Offset(4559.535, 4848.154),
        Offset(4650.156, 4788.875),
      ],
    ),
    // id 414: B19 L4
    Phase1LotAnnotation(
      id: 414,
      categoryId: 179,
      name: 'B19 L4',
      bbox: Rect.fromLTWH(4296.10, 4684.31, 265.37, 220.82),
      points: [
        Offset(4372.181, 4684.306),
        Offset(4296.101, 4748.704),
        Offset(4475.452, 4905.125),
        Offset(4561.472, 4847.341),
      ],
    ),
    // id 415: B19 L5
    Phase1LotAnnotation(
      id: 415,
      categoryId: 180,
      name: 'B19 L5',
      bbox: Rect.fromLTWH(4219.18, 4750.90, 255.51, 214.22),
      points: [
        Offset(4296.599, 4750.897),
        Offset(4219.176, 4814.613),
        Offset(4388.542, 4965.120),
        Offset(4474.687, 4906.053),
      ],
    ),
    // id 416: B19 L6
    Phase1LotAnnotation(
      id: 416,
      categoryId: 181,
      name: 'B19 L6',
      bbox: Rect.fromLTWH(4144.57, 4816.51, 244.94, 206.83),
      points: [
        Offset(4219.491, 4816.508),
        Offset(4144.570, 4878.899),
        Offset(4301.087, 5023.340),
        Offset(4389.510, 4963.797),
      ],
    ),
    // id 417: B19 L7
    Phase1LotAnnotation(
      id: 417,
      categoryId: 182,
      name: 'B19 L7',
      bbox: Rect.fromLTWH(4068.64, 4878.62, 231.09, 204.58),
      points: [
        Offset(4144.961, 4878.617),
        Offset(4068.641, 4943.118),
        Offset(4213.156, 5083.195),
        Offset(4299.735, 5022.985),
      ],
    ),
    // id 418: B19 L8
    Phase1LotAnnotation(
      id: 418,
      categoryId: 183,
      name: 'B19 L8',
      bbox: Rect.fromLTWH(3990.25, 4943.83, 223.19, 193.81),
      points: [
        Offset(4068.878, 4943.830),
        Offset(3990.254, 5007.176),
        Offset(4123.990, 5137.640),
        Offset(4151.238, 5123.990),
        Offset(4213.441, 5082.586),
      ],
    ),
    // id 419: B19 L9
    Phase1LotAnnotation(
      id: 419,
      categoryId: 184,
      name: 'B19 L9',
      bbox: Rect.fromLTWH(3909.54, 5007.22, 214.71, 176.58),
      points: [
        Offset(3989.881, 5007.216),
        Offset(3909.537, 5071.338),
        Offset(4027.197, 5183.791),
        Offset(4124.248, 5136.834),
      ],
    ),
    // id 420: B19 L10
    Phase1LotAnnotation(
      id: 420,
      categoryId: 175,
      name: 'B19 L10',
      bbox: Rect.fromLTWH(3831.85, 5071.15, 193.28, 158.39),
      points: [
        Offset(3909.725, 5071.153),
        Offset(3831.853, 5134.119),
        Offset(3930.262, 5229.538),
        Offset(4025.135, 5183.773),
      ],
    ),
    // id 421: B19 L11
    Phase1LotAnnotation(
      id: 421,
      categoryId: 176,
      name: 'B19 L11',
      bbox: Rect.fromLTWH(3698.70, 5134.81, 230.22, 184.36),
      points: [
        Offset(3829.761, 5134.814),
        Offset(3763.079, 5184.170),
        Offset(3756.310, 5203.570),
        Offset(3756.695, 5219.012),
        Offset(3765.790, 5231.728),
        Offset(3698.696, 5282.782),
        Offset(3734.184, 5319.171),
        Offset(3928.913, 5228.877),
      ],
    ),
    // id 422: B20 L1
    Phase1LotAnnotation(
      id: 422,
      categoryId: 266,
      name: 'B20 L1',
      bbox: Rect.fromLTWH(3842.44, 3107.69, 232.32, 202.07),
      points: [
        Offset(4065.223, 3107.686),
        Offset(3842.437, 3141.629),
        Offset(3868.008, 3269.100),
        Offset(3872.560, 3286.269),
        Offset(3891.248, 3304.027),
        Offset(3913.186, 3309.761),
        Offset(3938.528, 3305.718),
        Offset(3956.379, 3292.352),
        Offset(4074.755, 3157.048),
      ],
    ),
    // id 423: B20 L2
    Phase1LotAnnotation(
      id: 423,
      categoryId: 270,
      name: 'B20 L2',
      bbox: Rect.fromLTWH(3824.30, 3008.67, 240.86, 134.38),
      points: [
        Offset(4046.701, 3008.667),
        Offset(3824.303, 3042.577),
        Offset(3842.562, 3143.047),
        Offset(4065.158, 3107.433),
      ],
    ),
    // id 424: B20 L3
    Phase1LotAnnotation(
      id: 424,
      categoryId: 271,
      name: 'B20 L3',
      bbox: Rect.fromLTWH(3805.65, 2911.27, 240.40, 131.12),
      points: [
        Offset(4028.134, 2911.268),
        Offset(3805.650, 2944.146),
        Offset(3823.905, 3042.386),
        Offset(4046.050, 3008.502),
      ],
    ),
    // id 425: B20 L4
    Phase1LotAnnotation(
      id: 425,
      categoryId: 272,
      name: 'B20 L4',
      bbox: Rect.fromLTWH(3787.81, 2811.93, 240.03, 132.83),
      points: [
        Offset(4009.730, 2811.927),
        Offset(3787.811, 2844.843),
        Offset(3806.566, 2944.754),
        Offset(4027.840, 2910.336),
      ],
    ),
    // id 426: B20 L5
    Phase1LotAnnotation(
      id: 426,
      categoryId: 273,
      name: 'B20 L5',
      bbox: Rect.fromLTWH(3769.03, 2713.43, 240.59, 133.38),
      points: [
        Offset(3991.226, 2713.430),
        Offset(3769.033, 2747.581),
        Offset(3787.782, 2846.806),
        Offset(4009.624, 2811.174),
      ],
    ),
    // id 427: B20 L6
    Phase1LotAnnotation(
      id: 427,
      categoryId: 274,
      name: 'B20 L6',
      bbox: Rect.fromLTWH(3750.21, 2614.24, 241.87, 133.07),
      points: [
        Offset(3972.955, 2614.238),
        Offset(3750.207, 2647.877),
        Offset(3770.013, 2747.312),
        Offset(3992.081, 2713.110),
      ],
    ),
    // id 428: B20 L7
    Phase1LotAnnotation(
      id: 428,
      categoryId: 275,
      name: 'B20 L7',
      bbox: Rect.fromLTWH(3732.79, 2514.25, 239.97, 134.85),
      points: [
        Offset(3954.477, 2514.253),
        Offset(3732.789, 2548.915),
        Offset(3751.611, 2649.101),
        Offset(3972.763, 2613.872),
      ],
    ),
    // id 429: B20 L8
    Phase1LotAnnotation(
      id: 429,
      categoryId: 276,
      name: 'B20 L8',
      bbox: Rect.fromLTWH(3714.94, 2416.56, 239.81, 132.55),
      points: [
        Offset(3936.738, 2416.557),
        Offset(3714.944, 2450.567),
        Offset(3732.881, 2549.102),
        Offset(3954.757, 2514.545),
      ],
    ),
    // id 430: B20 L9
    Phase1LotAnnotation(
      id: 430,
      categoryId: 277,
      name: 'B20 L9',
      bbox: Rect.fromLTWH(3696.34, 2318.33, 240.10, 132.30),
      points: [
        Offset(3917.794, 2318.325),
        Offset(3696.342, 2351.438),
        Offset(3714.246, 2450.622),
        Offset(3936.442, 2416.340),
      ],
    ),
    // id 431: B20 L10
    Phase1LotAnnotation(
      id: 431,
      categoryId: 267,
      name: 'B20 L10',
      bbox: Rect.fromLTWH(3676.27, 2220.20, 241.53, 132.67),
      points: [
        Offset(3898.959, 2220.198),
        Offset(3676.271, 2253.172),
        Offset(3697.403, 2352.870),
        Offset(3917.800, 2317.576),
      ],
    ),
    // id 432: B20 L11
    Phase1LotAnnotation(
      id: 432,
      categoryId: 268,
      name: 'B20 L11',
      bbox: Rect.fromLTWH(3657.61, 2122.43, 243.14, 132.58),
      points: [
        Offset(3874.231, 2122.428),
        Offset(3657.614, 2154.018),
        Offset(3677.522, 2255.012),
        Offset(3900.751, 2218.963),
        Offset(3895.551, 2188.489),
      ],
    ),
    // id 433: B20 L12
    Phase1LotAnnotation(
      id: 433,
      categoryId: 269,
      name: 'B20 L12',
      bbox: Rect.fromLTWH(3637.08, 2042.27, 236.95, 111.31),
      points: [
        Offset(3874.029, 2121.418),
        Offset(3853.677, 2044.545),
        Offset(3637.077, 2042.270),
        Offset(3659.916, 2153.577),
      ],
    ),
  ];
}
