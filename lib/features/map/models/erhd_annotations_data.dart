import 'package:flutter/material.dart';
import 'phase_lot_annotation.dart';
export 'phase_lot_annotation.dart';

/// Static dataset containing all lot annotations for ERHD (4961x3508)
class ErhdAnnotationsData {
  ErhdAnnotationsData._();

  /// Find the annotation at [localPos] within [renderSize].
  static ErhdLotAnnotation? hitTest(Offset localPos, Size renderSize) {
    return PhaseLotAnnotation.hitTestList(annotations, localPos, renderSize);
  }

  static const List<ErhdLotAnnotation> annotations = [
    // id 1: B1 L1
    ErhdLotAnnotation(
      id: 1,
      categoryId: 1,
      name: 'B1 L1',
      bbox: Rect.fromLTWH(3312.30, 1154.67, 211.62, 399.63),
      points: [
        Offset(3362.010, 1154.671),
        Offset(3312.300, 1185.176),
        Offset(3312.555, 1553.860),
        Offset(3504.862, 1554.299),
        Offset(3518.967, 1546.776),
        Offset(3523.924, 1531.452),
        Offset(3523.095, 1249.223),
      ],
    ),
    // id 2: B1 L2
    ErhdLotAnnotation(
      id: 2,
      categoryId: 2,
      name: 'B1 L2',
      bbox: Rect.fromLTWH(3103.96, 1183.92, 209.40, 371.73),
      points: [
        Offset(3310.959, 1183.919),
        Offset(3103.957, 1297.094),
        Offset(3105.608, 1554.649),
        Offset(3313.361, 1555.646),
      ],
    ),
    // id 3: B1 L3
    ErhdLotAnnotation(
      id: 3,
      categoryId: 3,
      name: 'B1 L3',
      bbox: Rect.fromLTWH(2896.76, 1297.68, 208.98, 258.01),
      points: [
        Offset(3105.740, 1555.496),
        Offset(2897.610, 1555.687),
        Offset(2896.758, 1411.261),
        Offset(3104.784, 1297.680),
      ],
    ),
    // id 4: B1 L4
    ErhdLotAnnotation(
      id: 4,
      categoryId: 4,
      name: 'B1 L4',
      bbox: Rect.fromLTWH(2554.65, 1409.64, 346.43, 145.29),
      points: [
        Offset(2894.934, 1554.934),
        Offset(2554.648, 1553.017),
        Offset(2555.088, 1419.923),
        Offset(2805.620, 1462.342),
        Offset(2901.078, 1409.640),
      ],
    ),
    // id 5: B1 L5
    ErhdLotAnnotation(
      id: 5,
      categoryId: 5,
      name: 'B1 L5',
      bbox: Rect.fromLTWH(2169.13, 1270.03, 385.69, 284.64),
      points: [
        Offset(2551.041, 1421.527),
        Offset(2493.706, 1413.096),
        Offset(2169.134, 1270.025),
        Offset(2170.628, 1554.598),
        Offset(2554.822, 1554.662),
      ],
    ),
    // id 6: B1 L6
    ErhdLotAnnotation(
      id: 6,
      categoryId: 6,
      name: 'B1 L6',
      bbox: Rect.fromLTWH(1961.17, 1167.99, 208.37, 386.81),
      points: [
        Offset(2168.607, 1268.850),
        Offset(1961.166, 1167.990),
        Offset(1961.924, 1554.801),
        Offset(2169.533, 1554.720),
      ],
    ),
    // id 7: B2 L1
    ErhdLotAnnotation(
      id: 7,
      categoryId: 13,
      name: 'B2 L1',
      bbox: Rect.fromLTWH(2096.67, 1616.18, 153.31, 314.07),
      points: [
        Offset(2096.670, 1616.183),
        Offset(2097.164, 1930.096),
        Offset(2234.519, 1930.255),
        Offset(2244.239, 1927.131),
        Offset(2247.669, 1911.115),
        Offset(2249.981, 1897.724),
        Offset(2249.917, 1632.675),
        Offset(2243.756, 1624.685),
        Offset(2231.724, 1616.324),
      ],
    ),
    // id 8: B2 L2
    ErhdLotAnnotation(
      id: 8,
      categoryId: 14,
      name: 'B2 L2',
      bbox: Rect.fromLTWH(1946.69, 1616.49, 151.49, 311.48),
      points: [
        Offset(2098.176, 1927.972),
        Offset(1946.688, 1927.484),
        Offset(1947.241, 1618.183),
        Offset(2097.711, 1616.495),
      ],
    ),
    // id 9: B2 L3
    ErhdLotAnnotation(
      id: 9,
      categoryId: 15,
      name: 'B2 L3',
      bbox: Rect.fromLTWH(1795.42, 1616.36, 152.74, 313.90),
      points: [
        Offset(1795.424, 1617.689),
        Offset(1796.983, 1928.596),
        Offset(1946.200, 1930.255),
        Offset(1948.165, 1616.359),
      ],
    ),
    // id 10: B2 L4
    ErhdLotAnnotation(
      id: 10,
      categoryId: 16,
      name: 'B2 L4',
      bbox: Rect.fromLTWH(1644.78, 1617.69, 151.30, 311.62),
      points: [
        Offset(1795.424, 1617.689),
        Offset(1644.778, 1619.101),
        Offset(1645.272, 1928.513),
        Offset(1796.077, 1929.308),
      ],
    ),
    // id 11: B2 L5
    ErhdLotAnnotation(
      id: 11,
      categoryId: 17,
      name: 'B2 L5',
      bbox: Rect.fromLTWH(1495.36, 1617.20, 150.95, 313.70),
      points: [
        Offset(1646.307, 1617.689),
        Offset(1495.361, 1617.201),
        Offset(1496.726, 1930.896),
        Offset(1645.643, 1929.414),
      ],
    ),
    // id 12: B2 L6
    ErhdLotAnnotation(
      id: 12,
      categoryId: 18,
      name: 'B2 L6',
      bbox: Rect.fromLTWH(1343.85, 1617.69, 151.86, 312.62),
      points: [
        Offset(1494.178, 1617.689),
        Offset(1343.850, 1617.913),
        Offset(1344.932, 1930.314),
        Offset(1495.708, 1929.614),
      ],
    ),
    // id 13: B2 L7
    ErhdLotAnnotation(
      id: 13,
      categoryId: 19,
      name: 'B2 L7',
      bbox: Rect.fromLTWH(1194.77, 1617.48, 150.51, 312.81),
      points: [
        Offset(1345.062, 1617.689),
        Offset(1196.075, 1617.477),
        Offset(1194.774, 1930.290),
        Offset(1345.285, 1929.149),
      ],
    ),
    // id 14: B2 L8
    ErhdLotAnnotation(
      id: 14,
      categoryId: 20,
      name: 'B2 L8',
      bbox: Rect.fromLTWH(1041.66, 1617.59, 153.77, 313.14),
      points: [
        Offset(1195.380, 1618.348),
        Offset(1053.883, 1617.595),
        Offset(1045.328, 1625.461),
        Offset(1044.840, 1634.146),
        Offset(1041.657, 1644.636),
        Offset(1042.086, 1913.781),
        Offset(1045.564, 1921.323),
        Offset(1056.325, 1926.101),
        Offset(1066.251, 1930.737),
        Offset(1195.427, 1928.843),
      ],
    ),
    // id 15: B3 L1
    ErhdLotAnnotation(
      id: 15,
      categoryId: 21,
      name: 'B3 L1',
      bbox: Rect.fromLTWH(3367.78, 1615.87, 153.31, 159.44),
      points: [
        Offset(3521.096, 1772.524),
        Offset(3369.275, 1775.313),
        Offset(3367.784, 1617.385),
        Offset(3508.876, 1615.869),
        Offset(3520.210, 1625.045),
        Offset(3520.484, 1640.627),
      ],
    ),
    // id 16: B3 L2
    ErhdLotAnnotation(
      id: 16,
      categoryId: 29,
      name: 'B3 L2',
      bbox: Rect.fromLTWH(3367.80, 1772.36, 153.46, 158.15),
      points: [
        Offset(3367.796, 1774.121),
        Offset(3368.433, 1930.502),
        Offset(3504.809, 1930.452),
        Offset(3515.363, 1921.308),
        Offset(3521.252, 1911.365),
        Offset(3519.075, 1772.356),
      ],
    ),
    // id 17: B3 L3
    ErhdLotAnnotation(
      id: 17,
      categoryId: 30,
      name: 'B3 L3',
      bbox: Rect.fromLTWH(3217.13, 1616.66, 152.02, 156.86),
      points: [
        Offset(3217.129, 1617.840),
        Offset(3217.990, 1773.522),
        Offset(3369.150, 1771.838),
        Offset(3366.449, 1616.661),
      ],
    ),
    // id 18: B3 L4
    ErhdLotAnnotation(
      id: 18,
      categoryId: 31,
      name: 'B3 L4',
      bbox: Rect.fromLTWH(3216.09, 1774.12, 151.72, 155.22),
      points: [
        Offset(3216.094, 1774.121),
        Offset(3216.992, 1929.342),
        Offset(3367.815, 1927.676),
        Offset(3366.811, 1774.333),
      ],
    ),
    // id 19: B3 L5
    ErhdLotAnnotation(
      id: 19,
      categoryId: 32,
      name: 'B3 L5',
      bbox: Rect.fromLTWH(3065.21, 1617.61, 153.70, 156.42),
      points: [
        Offset(3214.497, 1617.628),
        Offset(3068.009, 1617.609),
        Offset(3065.215, 1774.034),
        Offset(3218.913, 1773.753),
      ],
    ),
    // id 20: B3 L6
    ErhdLotAnnotation(
      id: 20,
      categoryId: 33,
      name: 'B3 L6',
      bbox: Rect.fromLTWH(3066.96, 1772.52, 150.81, 157.32),
      points: [
        Offset(3217.691, 1772.524),
        Offset(3066.961, 1773.878),
        Offset(3067.735, 1929.616),
        Offset(3217.772, 1929.847),
      ],
    ),
    // id 21: B3 L7
    ErhdLotAnnotation(
      id: 21,
      categoryId: 34,
      name: 'B3 L7',
      bbox: Rect.fromLTWH(2917.00, 1618.25, 151.94, 155.63),
      points: [
        Offset(3066.007, 1619.462),
        Offset(2916.999, 1618.252),
        Offset(2917.180, 1773.878),
        Offset(3068.939, 1772.880),
      ],
    ),
    // id 22: B3 L8
    ErhdLotAnnotation(
      id: 22,
      categoryId: 35,
      name: 'B3 L8',
      bbox: Rect.fromLTWH(2917.48, 1772.84, 151.45, 157.08),
      points: [
        Offset(2917.479, 1774.121),
        Offset(2917.978, 1929.541),
        Offset(3066.256, 1929.916),
        Offset(3068.932, 1772.836),
      ],
    ),
    // id 23: B3 L9
    ErhdLotAnnotation(
      id: 23,
      categoryId: 36,
      name: 'B3 L9',
      bbox: Rect.fromLTWH(2766.77, 1616.03, 150.29, 158.88),
      points: [
        Offset(2915.882, 1616.031),
        Offset(2767.324, 1616.742),
        Offset(2766.775, 1774.913),
        Offset(2917.061, 1774.209),
      ],
    ),
    // id 24: B3 L10
    ErhdLotAnnotation(
      id: 24,
      categoryId: 22,
      name: 'B3 L10',
      bbox: Rect.fromLTWH(2766.40, 1772.38, 150.90, 156.77),
      points: [
        Offset(2915.882, 1772.524),
        Offset(2766.900, 1772.381),
        Offset(2766.401, 1929.148),
        Offset(2917.298, 1928.955),
      ],
    ),
    // id 25: B3 L11
    ErhdLotAnnotation(
      id: 25,
      categoryId: 23,
      name: 'B3 L11',
      bbox: Rect.fromLTWH(2614.10, 1617.63, 153.29, 157.04),
      points: [
        Offset(2767.374, 1617.628),
        Offset(2614.099, 1618.015),
        Offset(2616.569, 1774.670),
        Offset(2767.386, 1773.803),
      ],
    ),
    // id 26: B3 L12
    ErhdLotAnnotation(
      id: 26,
      categoryId: 24,
      name: 'B3 L12',
      bbox: Rect.fromLTWH(2616.29, 1774.12, 151.96, 156.19),
      points: [
        Offset(2617.268, 1774.121),
        Offset(2616.295, 1930.315),
        Offset(2767.324, 1928.356),
        Offset(2768.259, 1774.782),
      ],
    ),
    // id 27: B3 L15
    ErhdLotAnnotation(
      id: 27,
      categoryId: 26,
      name: 'B3 L15',
      bbox: Rect.fromLTWH(2464.63, 1616.03, 150.79, 159.55),
      points: [
        Offset(2614.074, 1616.031),
        Offset(2464.967, 1616.618),
        Offset(2464.630, 1775.581),
        Offset(2615.415, 1773.722),
      ],
    ),
    // id 28: B3 L14
    ErhdLotAnnotation(
      id: 28,
      categoryId: 25,
      name: 'B3 L14',
      bbox: Rect.fromLTWH(2467.56, 1773.48, 150.08, 156.66),
      points: [
        Offset(2617.636, 1773.791),
        Offset(2467.917, 1773.485),
        Offset(2467.555, 1930.140),
        Offset(2616.682, 1926.959),
      ],
    ),
    // id 29: B3 L16
    ErhdLotAnnotation(
      id: 29,
      categoryId: 27,
      name: 'B3 L16',
      bbox: Rect.fromLTWH(2310.90, 1773.71, 156.26, 156.65),
      points: [
        Offset(2467.162, 1774.121),
        Offset(2310.900, 1773.710),
        Offset(2311.218, 1908.277),
        Offset(2318.416, 1922.306),
        Offset(2331.971, 1930.359),
        Offset(2466.526, 1929.485),
      ],
    ),
    // id 30: B3 L17
    ErhdLotAnnotation(
      id: 30,
      categoryId: 28,
      name: 'B3 L17',
      bbox: Rect.fromLTWH(2311.14, 1617.63, 156.78, 157.52),
      points: [
        Offset(2463.969, 1617.628),
        Offset(2330.942, 1617.759),
        Offset(2319.483, 1624.115),
        Offset(2311.143, 1636.472),
        Offset(2313.002, 1773.878),
        Offset(2467.923, 1775.144),
      ],
    ),
    // id 31: B4 L1
    ErhdLotAnnotation(
      id: 31,
      categoryId: 37,
      name: 'B4 L1',
      bbox: Rect.fromLTWH(825.57, 2021.69, 154.80, 159.96),
      points: [
        Offset(825.572, 2023.339),
        Offset(826.221, 2181.656),
        Offset(980.377, 2180.358),
        Offset(979.191, 2040.346),
        Offset(967.760, 2021.694),
      ],
    ),
    // id 32: B4 L2
    ErhdLotAnnotation(
      id: 32,
      categoryId: 38,
      name: 'B4 L2',
      bbox: Rect.fromLTWH(826.23, 2179.46, 153.56, 156.60),
      points: [
        Offset(826.821, 2179.460),
        Offset(826.231, 2335.680),
        Offset(963.511, 2336.060),
        Offset(979.791, 2317.409),
        Offset(978.669, 2180.929),
      ],
    ),
    // id 33: B4 L3
    ErhdLotAnnotation(
      id: 33,
      categoryId: 39,
      name: 'B4 L3',
      bbox: Rect.fromLTWH(675.60, 2179.27, 150.75, 156.29),
      points: [
        Offset(825.572, 2180.709),
        Offset(675.602, 2179.265),
        Offset(676.349, 2335.558),
        Offset(826.348, 2334.392),
      ],
    ),
    // id 34: B4 L4
    ErhdLotAnnotation(
      id: 34,
      categoryId: 40,
      name: 'B4 L4',
      bbox: Rect.fromLTWH(87.31, 2022.36, 894.46, 591.59),
      points: [
        Offset(87.312, 2550.420),
        Offset(627.277, 2022.355),
        Offset(826.756, 2024.354),
        Offset(827.091, 2179.878),
        Offset(674.194, 2179.692),
        Offset(677.036, 2400.233),
        Offset(971.013, 2400.018),
        Offset(981.772, 2414.863),
        Offset(979.743, 2596.170),
        Offset(774.640, 2613.941),
      ],
    ),
    // id 35: B5 L1
    ErhdLotAnnotation(
      id: 35,
      categoryId: 41,
      name: 'B5 L1',
      bbox: Rect.fromLTWH(2095.48, 2022.47, 154.38, 158.38),
      points: [
        Offset(2095.480, 2023.486),
        Offset(2097.466, 2180.859),
        Offset(2249.861, 2179.477),
        Offset(2249.771, 2037.230),
        Offset(2235.387, 2022.475),
      ],
    ),
    // id 36: B5 L2
    ErhdLotAnnotation(
      id: 36,
      categoryId: 49,
      name: 'B5 L2',
      bbox: Rect.fromLTWH(2095.48, 2179.73, 154.48, 156.52),
      points: [
        Offset(2095.480, 2179.728),
        Offset(2097.012, 2335.994),
        Offset(2233.167, 2336.251),
        Offset(2244.129, 2326.935),
        Offset(2248.754, 2318.809),
        Offset(2249.957, 2180.422),
      ],
    ),
    // id 37: B5 L3
    ErhdLotAnnotation(
      id: 37,
      categoryId: 50,
      name: 'B5 L3',
      bbox: Rect.fromLTWH(1946.29, 2023.12, 152.14, 156.78),
      points: [
        Offset(2093.948, 2023.486),
        Offset(1946.287, 2023.121),
        Offset(1946.753, 2179.901),
        Offset(2098.424, 2179.513),
      ],
    ),
    // id 38: B5 L4
    ErhdLotAnnotation(
      id: 38,
      categoryId: 51,
      name: 'B5 L4',
      bbox: Rect.fromLTWH(1947.27, 2180.22, 149.74, 157.11),
      points: [
        Offset(2097.012, 2181.260),
        Offset(1947.274, 2180.219),
        Offset(1948.955, 2337.328),
        Offset(2096.748, 2333.959),
      ],
    ),
    // id 39: B5 L5
    ErhdLotAnnotation(
      id: 39,
      categoryId: 52,
      name: 'B5 L5',
      bbox: Rect.fromLTWH(1795.09, 2022.88, 154.57, 158.31),
      points: [
        Offset(1943.833, 2023.486),
        Offset(1795.089, 2022.882),
        Offset(1797.159, 2181.194),
        Offset(1949.655, 2179.459),
      ],
    ),
    // id 40: B5 L6
    ErhdLotAnnotation(
      id: 40,
      categoryId: 53,
      name: 'B5 L6',
      bbox: Rect.fromLTWH(1795.78, 2180.91, 153.62, 155.49),
      points: [
        Offset(1949.398, 2180.913),
        Offset(1796.208, 2181.134),
        Offset(1795.777, 2336.221),
        Offset(1947.106, 2336.407),
      ],
    ),
    // id 41: B5 L7
    ErhdLotAnnotation(
      id: 41,
      categoryId: 54,
      name: 'B5 L7',
      bbox: Rect.fromLTWH(1645.45, 2023.49, 151.15, 155.67),
      points: [
        Offset(1795.250, 2023.486),
        Offset(1645.453, 2024.150),
        Offset(1646.242, 2179.154),
        Offset(1796.603, 2178.370),
      ],
    ),
    // id 42: B5 L8
    ErhdLotAnnotation(
      id: 42,
      categoryId: 55,
      name: 'B5 L8',
      bbox: Rect.fromLTWH(1646.67, 2179.10, 150.11, 156.97),
      points: [
        Offset(1796.782, 2179.728),
        Offset(1646.673, 2179.100),
        Offset(1647.613, 2334.821),
        Offset(1794.544, 2336.072),
      ],
    ),
    // id 43: B5 L9
    ErhdLotAnnotation(
      id: 43,
      categoryId: 56,
      name: 'B5 L9',
      bbox: Rect.fromLTWH(1494.54, 2024.23, 152.23, 156.52),
      points: [
        Offset(1645.028, 2024.228),
        Offset(1494.536, 2025.161),
        Offset(1494.739, 2180.745),
        Offset(1646.769, 2178.501),
      ],
    ),
    // id 44: B5 L10
    ErhdLotAnnotation(
      id: 44,
      categoryId: 42,
      name: 'B5 L10',
      bbox: Rect.fromLTWH(1495.47, 2179.46, 150.76, 157.93),
      points: [
        Offset(1495.469, 2180.781),
        Offset(1496.864, 2337.394),
        Offset(1646.093, 2336.556),
        Offset(1646.224, 2179.465),
      ],
    ),
    // id 45: B5 L11
    ErhdLotAnnotation(
      id: 45,
      categoryId: 43,
      name: 'B5 L11',
      bbox: Rect.fromLTWH(1344.49, 2024.19, 152.51, 156.80),
      points: [
        Offset(1495.021, 2025.018),
        Offset(1344.487, 2024.192),
        Offset(1346.414, 2180.990),
        Offset(1497.001, 2178.196),
      ],
    ),
    // id 46: B5 L12
    ErhdLotAnnotation(
      id: 46,
      categoryId: 44,
      name: 'B5 L12',
      bbox: Rect.fromLTWH(1345.85, 2179.73, 149.70, 156.74),
      points: [
        Offset(1495.021, 2179.728),
        Offset(1345.851, 2181.188),
        Offset(1347.012, 2336.472),
        Offset(1495.547, 2335.635),
      ],
    ),
    // id 47: B5 L15
    ErhdLotAnnotation(
      id: 47,
      categoryId: 46,
      name: 'B5 L15',
      bbox: Rect.fromLTWH(1192.18, 2021.95, 151.19, 159.44),
      points: [
        Offset(1343.374, 2021.954),
        Offset(1192.182, 2023.713),
        Offset(1195.174, 2181.391),
        Offset(1342.710, 2179.854),
      ],
    ),
    // id 48: B5 L14
    ErhdLotAnnotation(
      id: 48,
      categoryId: 45,
      name: 'B5 L14',
      bbox: Rect.fromLTWH(1195.98, 2180.79, 151.83, 156.93),
      points: [
        Offset(1196.323, 2181.260),
        Offset(1195.976, 2337.717),
        Offset(1346.641, 2335.491),
        Offset(1347.808, 2180.787),
      ],
    ),
    // id 49: B5 L17
    ErhdLotAnnotation(
      id: 49,
      categoryId: 48,
      name: 'B5 L17',
      bbox: Rect.fromLTWH(1041.22, 2023.06, 152.99, 156.00),
      points: [
        Offset(1193.259, 2023.486),
        Offset(1054.082, 2023.061),
        Offset(1041.565, 2039.073),
        Offset(1041.218, 2179.058),
        Offset(1194.211, 2178.795),
      ],
    ),
    // id 50: B5 L16
    ErhdLotAnnotation(
      id: 50,
      categoryId: 47,
      name: 'B5 L16',
      bbox: Rect.fromLTWH(1041.73, 2179.34, 153.58, 157.79),
      points: [
        Offset(1194.791, 2179.728),
        Offset(1042.325, 2179.345),
        Offset(1041.732, 2319.390),
        Offset(1058.492, 2337.137),
        Offset(1195.312, 2334.911),
      ],
    ),
    // id 51: B6 L1
    ErhdLotAnnotation(
      id: 51,
      categoryId: 57,
      name: 'B6 L1',
      bbox: Rect.fromLTWH(3368.01, 2022.20, 153.73, 158.29),
      points: [
        Offset(3368.372, 2179.665),
        Offset(3368.013, 2022.196),
        Offset(3507.674, 2023.365),
        Offset(3521.739, 2041.007),
        Offset(3520.822, 2180.491),
      ],
    ),
    // id 52: B6 L2
    ErhdLotAnnotation(
      id: 52,
      categoryId: 65,
      name: 'B6 L2',
      bbox: Rect.fromLTWH(3367.82, 2178.47, 154.69, 158.19),
      points: [
        Offset(3368.597, 2178.469),
        Offset(3367.825, 2336.340),
        Offset(3506.751, 2336.656),
        Offset(3521.814, 2320.034),
        Offset(3522.511, 2179.215),
      ],
    ),
    // id 53: B6 L3
    ErhdLotAnnotation(
      id: 53,
      categoryId: 66,
      name: 'B6 L3',
      bbox: Rect.fromLTWH(3216.70, 2023.62, 151.17, 156.34),
      points: [
        Offset(3367.825, 2024.582),
        Offset(3217.643, 2023.623),
        Offset(3216.700, 2179.965),
        Offset(3367.868, 2178.534),
      ],
    ),
    // id 54: B6 L4
    ErhdLotAnnotation(
      id: 54,
      categoryId: 67,
      name: 'B6 L4',
      bbox: Rect.fromLTWH(3217.47, 2178.47, 148.72, 155.87),
      points: [
        Offset(3217.600, 2178.469),
        Offset(3217.466, 2334.340),
        Offset(3366.184, 2333.428),
        Offset(3366.120, 2179.558),
      ],
    ),
    // id 55: B6 L5
    ErhdLotAnnotation(
      id: 55,
      categoryId: 68,
      name: 'B6 L5',
      bbox: Rect.fromLTWH(3066.24, 2024.45, 152.61, 154.69),
      points: [
        Offset(3218.844, 2024.448),
        Offset(3066.239, 2025.467),
        Offset(3067.505, 2179.134),
        Offset(3217.627, 2178.560),
      ],
    ),
    // id 56: B6 L6
    ErhdLotAnnotation(
      id: 56,
      categoryId: 69,
      name: 'B6 L6',
      bbox: Rect.fromLTWH(3066.60, 2178.47, 150.97, 157.14),
      points: [
        Offset(3066.604, 2178.469),
        Offset(3067.231, 2335.605),
        Offset(3217.574, 2334.506),
        Offset(3216.936, 2179.048),
      ],
    ),
    // id 57: B6 L7
    ErhdLotAnnotation(
      id: 57,
      categoryId: 70,
      name: 'B6 L7',
      bbox: Rect.fromLTWH(2915.52, 2023.45, 152.46, 156.24),
      points: [
        Offset(3067.977, 2024.727),
        Offset(2915.521, 2023.446),
        Offset(2916.674, 2179.681),
        Offset(3066.797, 2178.485),
      ],
    ),
    // id 58: B6 L8
    ErhdLotAnnotation(
      id: 58,
      categoryId: 71,
      name: 'B6 L8',
      bbox: Rect.fromLTWH(2916.66, 2179.43, 151.03, 155.86),
      points: [
        Offset(2918.680, 2180.507),
        Offset(2916.658, 2335.289),
        Offset(3067.692, 2333.986),
        Offset(3066.481, 2179.429),
      ],
    ),
    // id 59: B6 L9
    ErhdLotAnnotation(
      id: 59,
      categoryId: 72,
      name: 'B6 L9',
      bbox: Rect.fromLTWH(2765.98, 2023.35, 150.72, 155.85),
      points: [
        Offset(2915.607, 2023.355),
        Offset(2765.983, 2023.708),
        Offset(2766.268, 2179.209),
        Offset(2916.701, 2178.904),
      ],
    ),
    // id 60: B6 L10
    ErhdLotAnnotation(
      id: 60,
      categoryId: 58,
      name: 'B6 L10',
      bbox: Rect.fromLTWH(2766.50, 2178.47, 150.85, 157.65),
      points: [
        Offset(2767.356, 2178.469),
        Offset(2766.503, 2335.992),
        Offset(2917.355, 2336.115),
        Offset(2916.615, 2180.373),
      ],
    ),
    // id 61: B6 L11
    ErhdLotAnnotation(
      id: 61,
      categoryId: 59,
      name: 'B6 L11',
      bbox: Rect.fromLTWH(2615.75, 2023.35, 151.60, 156.87),
      points: [
        Offset(2767.356, 2023.355),
        Offset(2616.729, 2024.229),
        Offset(2615.754, 2180.223),
        Offset(2766.804, 2178.829),
      ],
    ),
    // id 62: B6 L12
    ErhdLotAnnotation(
      id: 62,
      categoryId: 60,
      name: 'B6 L12',
      bbox: Rect.fromLTWH(2615.97, 2178.47, 151.39, 157.21),
      points: [
        Offset(2767.356, 2178.469),
        Offset(2616.241, 2179.461),
        Offset(2615.968, 2335.681),
        Offset(2766.863, 2334.898),
      ],
    ),
    // id 63: B6 L15
    ErhdLotAnnotation(
      id: 63,
      categoryId: 62,
      name: 'B6 L15',
      bbox: Rect.fromLTWH(2465.16, 2023.35, 152.42, 156.34),
      points: [
        Offset(2616.359, 2023.355),
        Offset(2465.159, 2024.700),
        Offset(2465.813, 2179.697),
        Offset(2617.577, 2176.855),
      ],
    ),
    // id 64: B6 L14
    ErhdLotAnnotation(
      id: 64,
      categoryId: 61,
      name: 'B6 L14',
      bbox: Rect.fromLTWH(2466.01, 2177.10, 150.35, 158.29),
      points: [
        Offset(2616.359, 2177.097),
        Offset(2466.012, 2180.249),
        Offset(2466.038, 2335.391),
        Offset(2615.432, 2334.828),
      ],
    ),
    // id 65: B6 L17
    ErhdLotAnnotation(
      id: 65,
      categoryId: 64,
      name: 'B6 L17',
      bbox: Rect.fromLTWH(2312.46, 2023.06, 154.28, 155.87),
      points: [
        Offset(2462.617, 2023.355),
        Offset(2328.351, 2023.065),
        Offset(2312.500, 2038.894),
        Offset(2312.457, 2178.930),
        Offset(2466.736, 2177.177),
      ],
    ),
    // id 66: B6 L16
    ErhdLotAnnotation(
      id: 66,
      categoryId: 63,
      name: 'B6 L16',
      bbox: Rect.fromLTWH(2312.95, 2178.47, 152.41, 157.93),
      points: [
        Offset(2465.363, 2178.469),
        Offset(2313.235, 2179.531),
        Offset(2312.951, 2322.892),
        Offset(2333.284, 2336.260),
        Offset(2464.317, 2336.399),
      ],
    ),
    // id 67: B7 L1
    ErhdLotAnnotation(
      id: 67,
      categoryId: 73,
      name: 'B7 L1',
      bbox: Rect.fromLTWH(3001.48, 2397.66, 521.74, 156.97),
      points: [
        Offset(3520.301, 2472.350),
        Offset(3376.960, 2551.929),
        Offset(3001.479, 2554.632),
        Offset(3002.512, 2397.659),
        Offset(3507.669, 2399.865),
        Offset(3523.222, 2419.385),
      ],
    ),
    // id 68: B7 L2
    ErhdLotAnnotation(
      id: 68,
      categoryId: 75,
      name: 'B7 L2',
      bbox: Rect.fromLTWH(2685.23, 2397.74, 316.82, 198.33),
      points: [
        Offset(2999.717, 2397.739),
        Offset(2685.235, 2398.858),
        Offset(2687.599, 2596.071),
        Offset(3002.055, 2552.121),
      ],
    ),
    // id 69: B7 L3
    ErhdLotAnnotation(
      id: 69,
      categoryId: 76,
      name: 'B7 L3',
      bbox: Rect.fromLTWH(2478.58, 2397.74, 208.76, 211.08),
      points: [
        Offset(2684.314, 2397.739),
        Offset(2478.576, 2397.871),
        Offset(2481.001, 2608.815),
        Offset(2619.254, 2604.993),
        Offset(2687.341, 2595.064),
      ],
    ),
    // id 70: B7 L4
    ErhdLotAnnotation(
      id: 70,
      categoryId: 77,
      name: 'B7 L4',
      bbox: Rect.fromLTWH(2273.11, 2397.65, 208.06, 217.43),
      points: [
        Offset(2480.828, 2399.434),
        Offset(2273.561, 2397.646),
        Offset(2273.110, 2615.075),
        Offset(2481.173, 2607.205),
      ],
    ),
    // id 71: B7 L5
    ErhdLotAnnotation(
      id: 71,
      categoryId: 78,
      name: 'B7 L5',
      bbox: Rect.fromLTWH(2062.07, 2397.53, 211.38, 226.44),
      points: [
        Offset(2270.560, 2397.739),
        Offset(2062.067, 2397.527),
        Offset(2065.465, 2623.964),
        Offset(2273.448, 2615.585),
      ],
    ),
    // id 72: B7 L6
    ErhdLotAnnotation(
      id: 72,
      categoryId: 79,
      name: 'B7 L6',
      bbox: Rect.fromLTWH(1856.28, 2398.34, 210.21, 233.81),
      points: [
        Offset(2065.564, 2399.507),
        Offset(1856.276, 2398.341),
        Offset(1858.813, 2632.151),
        Offset(2066.485, 2623.116),
      ],
    ),
    // id 73: B7 L7
    ErhdLotAnnotation(
      id: 73,
      categoryId: 80,
      name: 'B7 L7',
      bbox: Rect.fromLTWH(1649.89, 2399.97, 207.69, 233.43),
      points: [
        Offset(1857.574, 2400.494),
        Offset(1649.889, 2399.971),
        Offset(1651.446, 2622.149),
        Offset(1834.530, 2633.396),
        Offset(1854.448, 2627.693),
      ],
    ),
    // id 74: B7 L8
    ErhdLotAnnotation(
      id: 74,
      categoryId: 81,
      name: 'B7 L8',
      bbox: Rect.fromLTWH(1442.77, 2398.98, 208.16, 222.49),
      points: [
        Offset(1649.929, 2399.434),
        Offset(1442.893, 2398.977),
        Offset(1442.767, 2610.411),
        Offset(1650.923, 2621.467),
      ],
    ),
    // id 75: B7 L9
    ErhdLotAnnotation(
      id: 75,
      categoryId: 82,
      name: 'B7 L9',
      bbox: Rect.fromLTWH(1242.07, 2397.74, 201.36, 212.28),
      points: [
        Offset(1443.052, 2397.739),
        Offset(1243.812, 2398.977),
        Offset(1242.070, 2600.012),
        Offset(1443.430, 2610.014),
      ],
    ),
    // id 76: B7 L10
    ErhdLotAnnotation(
      id: 76,
      categoryId: 74,
      name: 'B7 L10',
      bbox: Rect.fromLTWH(1041.74, 2398.06, 202.14, 201.44),
      points: [
        Offset(1242.958, 2399.434),
        Offset(1060.284, 2398.063),
        Offset(1041.744, 2412.735),
        Offset(1041.764, 2588.394),
        Offset(1243.885, 2599.502),
      ],
    ),
    // id 77: B8 L1
    ErhdLotAnnotation(
      id: 77,
      categoryId: 83,
      name: 'B8 L1',
      bbox: Rect.fromLTWH(3615.19, 1313.30, 368.55, 244.03),
      points: [
        Offset(3615.766, 1313.299),
        Offset(3615.194, 1542.414),
        Offset(3633.206, 1557.329),
        Offset(3983.741, 1555.297),
        Offset(3983.603, 1432.397),
        Offset(3842.309, 1452.436),
      ],
    ),
    // id 78: B8 L2
    ErhdLotAnnotation(
      id: 78,
      categoryId: 84,
      name: 'B8 L2',
      bbox: Rect.fromLTWH(3983.45, 1392.50, 286.42, 165.31),
      points: [
        Offset(3983.781, 1433.614),
        Offset(4239.661, 1392.505),
        Offset(4267.039, 1461.846),
        Offset(4269.860, 1557.066),
        Offset(3983.445, 1557.816),
      ],
    ),
    // id 79: B8 L3
    ErhdLotAnnotation(
      id: 79,
      categoryId: 85,
      name: 'B8 L3',
      bbox: Rect.fromLTWH(4267.06, 1385.47, 185.41, 171.12),
      points: [
        Offset(4267.979, 1463.911),
        Offset(4452.145, 1385.468),
        Offset(4452.467, 1556.592),
        Offset(4267.059, 1555.573),
      ],
    ),
    // id 80: B8 L4
    ErhdLotAnnotation(
      id: 80,
      categoryId: 86,
      name: 'B8 L4',
      bbox: Rect.fromLTWH(4452.32, 1289.19, 232.68, 267.43),
      points: [
        Offset(4453.006, 1385.567),
        Offset(4684.995, 1289.190),
        Offset(4546.687, 1556.619),
        Offset(4452.316, 1555.731),
      ],
    ),
    // id 81: B9 L1
    ErhdLotAnnotation(
      id: 81,
      categoryId: 87,
      name: 'B9 L1',
      bbox: Rect.fromLTWH(3613.92, 1619.84, 239.74, 125.03),
      points: [
        Offset(3853.660, 1742.481),
        Offset(3853.502, 1621.205),
        Offset(3628.320, 1619.844),
        Offset(3613.918, 1639.034),
        Offset(3615.779, 1744.874),
      ],
    ),
    // id 82: B9 L2
    ErhdLotAnnotation(
      id: 82,
      categoryId: 88,
      name: 'B9 L2',
      bbox: Rect.fromLTWH(3853.23, 1619.04, 235.73, 126.02),
      points: [
        Offset(3854.114, 1621.081),
        Offset(3853.226, 1745.052),
        Offset(4088.766, 1742.592),
        Offset(4088.957, 1619.035),
      ],
    ),
    // id 83: B9 L3
    ErhdLotAnnotation(
      id: 83,
      categoryId: 89,
      name: 'B9 L3',
      bbox: Rect.fromLTWH(4090.23, 1618.63, 233.97, 125.35),
      points: [
        Offset(4091.620, 1620.791),
        Offset(4090.233, 1743.980),
        Offset(4322.938, 1742.566),
        Offset(4324.208, 1618.628),
      ],
    ),
    // id 84: B9 L4
    ErhdLotAnnotation(
      id: 84,
      categoryId: 90,
      name: 'B9 L4',
      bbox: Rect.fromLTWH(4321.69, 1617.44, 180.22, 250.85),
      points: [
        Offset(4321.689, 1619.581),
        Offset(4322.222, 1868.287),
        Offset(4381.580, 1867.636),
        Offset(4394.042, 1853.326),
        Offset(4501.908, 1643.342),
        Offset(4500.008, 1627.045),
        Offset(4486.283, 1617.437),
      ],
    ),
    // id 85: B9 L5
    ErhdLotAnnotation(
      id: 85,
      categoryId: 91,
      name: 'B9 L5',
      bbox: Rect.fromLTWH(3614.15, 1743.53, 240.47, 149.99),
      points: [
        Offset(3614.595, 1744.164),
        Offset(3614.155, 1893.521),
        Offset(3838.022, 1892.672),
        Offset(3854.620, 1868.234),
        Offset(3853.614, 1743.533),
      ],
    ),
    // id 86: B9 L6
    ErhdLotAnnotation(
      id: 86,
      categoryId: 92,
      name: 'B9 L6',
      bbox: Rect.fromLTWH(3851.98, 1744.16, 236.66, 128.11),
      points: [
        Offset(3851.977, 1744.164),
        Offset(3852.989, 1872.272),
        Offset(4088.641, 1870.102),
        Offset(4088.155, 1744.381),
      ],
    ),
    // id 87: B9 L7
    ErhdLotAnnotation(
      id: 87,
      categoryId: 93,
      name: 'B9 L7',
      bbox: Rect.fromLTWH(4088.31, 1743.89, 236.00, 125.95),
      points: [
        Offset(4089.976, 1743.895),
        Offset(4088.312, 1869.537),
        Offset(4322.919, 1869.846),
        Offset(4324.313, 1746.210),
      ],
    ),
    // id 88: B9 L8
    ErhdLotAnnotation(
      id: 88,
      categoryId: 94,
      name: 'B9 L8',
      bbox: Rect.fromLTWH(3614.70, 1894.92, 221.50, 262.36),
      points: [
        Offset(3616.486, 1895.309),
        Offset(3614.704, 2144.972),
        Offset(3624.834, 2156.974),
        Offset(3636.448, 2157.283),
        Offset(3681.757, 2137.603),
        Offset(3836.203, 1894.921),
      ],
    ),
    // id 89: B10 L1
    ErhdLotAnnotation(
      id: 89,
      categoryId: 7,
      name: 'B10 L1',
      bbox: Rect.fromLTWH(3614.03, 2133.12, 297.73, 286.86),
      points: [
        Offset(3911.761, 2235.919),
        Offset(3891.848, 2269.787),
        Offset(3614.026, 2419.980),
        Offset(3617.048, 2242.277),
        Offset(3708.701, 2192.340),
        Offset(3725.707, 2178.802),
        Offset(3752.663, 2133.121),
      ],
    ),
    // id 90: B10 L2
    ErhdLotAnnotation(
      id: 90,
      categoryId: 8,
      name: 'B10 L2',
      bbox: Rect.fromLTWH(3756.75, 1932.77, 303.57, 302.12),
      points: [
        Offset(3756.753, 2132.093),
        Offset(3884.971, 1932.769),
        Offset(4060.326, 1933.283),
        Offset(4036.654, 2051.133),
        Offset(3914.789, 2234.891),
      ],
    ),
    // id 91: B10 L3
    ErhdLotAnnotation(
      id: 91,
      categoryId: 9,
      name: 'B10 L3',
      bbox: Rect.fromLTWH(4035.35, 1932.44, 297.59, 196.33),
      points: [
        Offset(4061.097, 1932.437),
        Offset(4035.346, 2050.716),
        Offset(4253.161, 2128.768),
        Offset(4332.932, 1932.489),
      ],
    ),
    // id 92: B10 L4
    ErhdLotAnnotation(
      id: 92,
      categoryId: 10,
      name: 'B10 L4',
      bbox: Rect.fromLTWH(4251.57, 1931.37, 310.63, 279.43),
      points: [
        Offset(4334.378, 1931.752),
        Offset(4424.214, 1931.375),
        Offset(4562.200, 2001.647),
        Offset(4452.256, 2210.802),
        Offset(4251.567, 2128.894),
      ],
    ),
    // id 93: B11 L1
    ErhdLotAnnotation(
      id: 93,
      categoryId: 11,
      name: 'B11 L1',
      bbox: Rect.fromLTWH(4458.29, 1595.96, 275.51, 351.27),
      points: [
        Offset(4595.535, 1595.957),
        Offset(4458.285, 1863.202),
        Offset(4462.718, 1877.959),
        Offset(4588.475, 1947.224),
        Offset(4733.795, 1670.189),
      ],
    ),
    // id 94: B11 L2
    ErhdLotAnnotation(
      id: 94,
      categoryId: 12,
      name: 'B11 L2',
      bbox: Rect.fromLTWH(4597.15, 1319.93, 275.61, 348.09),
      points: [
        Offset(4740.889, 1319.932),
        Offset(4597.147, 1597.454),
        Offset(4733.227, 1668.021),
        Offset(4872.760, 1398.579),
      ],
    ),
  ];
}
