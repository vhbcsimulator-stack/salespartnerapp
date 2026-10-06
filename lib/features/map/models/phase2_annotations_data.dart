import 'package:flutter/material.dart';
import 'phase_lot_annotation.dart';
export 'phase_lot_annotation.dart';

/// Static dataset containing all lot annotations for Phase 2
class Phase2AnnotationsData {
  Phase2AnnotationsData._();

  /// Find the annotation at [localPos] within [renderSize].
  /// Checks fast bounding box + direct path containment first, then inflated bounds, and falls back to proximity.
  static Phase2LotAnnotation? hitTest(Offset localPos, Size renderSize) {
    return PhaseLotAnnotation.hitTestList(annotations, localPos, renderSize);
  }

  static const List<Phase2LotAnnotation> annotations = [
    // id 529: B1 L1
    Phase2LotAnnotation(
      id: 529,
      categoryId: 1,
      name: 'B1 L1',
      bbox: Rect.fromLTWH(699.55, 169.67, 43.34, 49.57),
      points: [
        Offset(704.245, 196.614),
        Offset(699.546, 210.616),
        Offset(716.163, 219.122),
        Offset(726.362, 219.241),
        Offset(730.52, 217.177),
        Offset(732.554, 214.076),
        Offset(741.99, 190.719),
        Offset(742.882, 186.734),
        Offset(742.541, 182.575),
        Offset(739.515, 178.455),
        Offset(722.911, 169.671),
        Offset(704.245, 196.614),
      ],
    ),
    // id 511: B2 L1
    Phase2LotAnnotation(
      id: 511,
      categoryId: 173,
      name: 'B2 L1',
      bbox: Rect.fromLTWH(681.81, 244.46, 50.1, 33.41),
      points: [
        Offset(681.807, 258.527),
        Offset(722.784, 277.874),
        Offset(731.907, 255.954),
        Offset(714.555, 247.888),
        Offset(710.45, 247.738),
        Offset(706.725, 249.565),
        Offset(703.608, 253.402),
        Offset(686.634, 244.461),
        Offset(681.807, 258.527),
      ],
    ),
    // id 512: B2 L2
    Phase2LotAnnotation(
      id: 512,
      categoryId: 183,
      name: 'B2 L2',
      bbox: Rect.fromLTWH(723.8, 255.65, 29.78, 32.15),
      points: [
        Offset(723.795, 278.53),
        Offset(745.231, 287.807),
        Offset(753.572, 263.532),
        Offset(733.014, 255.653),
        Offset(723.795, 278.53),
      ],
    ),
    // id 513: B2 L3
    Phase2LotAnnotation(
      id: 513,
      categoryId: 184,
      name: 'B2 L3',
      bbox: Rect.fromLTWH(745.34, 263.98, 29.74, 31.88),
      points: [
        Offset(745.344, 287.878),
        Offset(766.929, 295.859),
        Offset(775.088, 270.994),
        Offset(753.731, 263.984),
        Offset(745.344, 287.878),
      ],
    ),
    // id 514: B2 L4
    Phase2LotAnnotation(
      id: 514,
      categoryId: 185,
      name: 'B2 L4',
      bbox: Rect.fromLTWH(767.29, 271.4, 28.97, 31.39),
      points: [
        Offset(767.287, 295.78),
        Offset(789.025, 302.792),
        Offset(796.253, 277.756),
        Offset(775.455, 271.398),
        Offset(767.287, 295.78),
      ],
    ),
    // id 515: B2 L5
    Phase2LotAnnotation(
      id: 515,
      categoryId: 186,
      name: 'B2 L5',
      bbox: Rect.fromLTWH(789.96, 277.73, 27.24, 30.71),
      points: [
        Offset(789.957, 303.142),
        Offset(812.286, 308.439),
        Offset(817.2, 283.315),
        Offset(795.803, 277.734),
        Offset(789.957, 303.142),
      ],
    ),
    // id 516: B2 L6
    Phase2LotAnnotation(
      id: 516,
      categoryId: 187,
      name: 'B2 L6',
      bbox: Rect.fromLTWH(812.27, 283.2, 26.83, 31.97),
      points: [
        Offset(812.267, 309.579),
        Offset(835.177, 315.172),
        Offset(839.093, 288.042),
        Offset(817.181, 283.199),
        Offset(812.267, 309.579),
      ],
    ),
    // id 517: B2 L7
    Phase2LotAnnotation(
      id: 517,
      categoryId: 188,
      name: 'B2 L7',
      bbox: Rect.fromLTWH(835.02, 288.68, 25.81, 30.04),
      points: [
        Offset(835.017, 315.686),
        Offset(857.528, 318.721),
        Offset(860.826, 291.945),
        Offset(838.857, 288.679),
        Offset(835.017, 315.686),
      ],
    ),
    // id 518: B2 L8
    Phase2LotAnnotation(
      id: 518,
      categoryId: 189,
      name: 'B2 L8',
      bbox: Rect.fromLTWH(857.99, 292.63, 24.79, 29.85),
      points: [
        Offset(857.992, 319.636),
        Offset(880.029, 322.485),
        Offset(882.786, 295.255),
        Offset(861.244, 292.631),
        Offset(857.992, 319.636),
      ],
    ),
    // id 519: B2 L9
    Phase2LotAnnotation(
      id: 519,
      categoryId: 190,
      name: 'B2 L9',
      bbox: Rect.fromLTWH(880.27, 295.53, 23.49, 29.25),
      points: [
        Offset(880.271, 323.437),
        Offset(901.669, 324.788),
        Offset(903.765, 297.364),
        Offset(883.106, 295.533),
        Offset(880.271, 323.437),
      ],
    ),
    // id 520: B2 L10
    Phase2LotAnnotation(
      id: 520,
      categoryId: 174,
      name: 'B2 L10',
      bbox: Rect.fromLTWH(877.24, 326.09, 23.74, 30.41),
      points: [
        Offset(877.236, 353.937),
        Offset(898.472, 356.496),
        Offset(900.977, 328.541),
        Offset(879.98, 326.09),
        Offset(877.236, 353.937),
      ],
    ),
    // id 521: B2 L11
    Phase2LotAnnotation(
      id: 521,
      categoryId: 175,
      name: 'B2 L11',
      bbox: Rect.fromLTWH(852.45, 322.28, 27.19, 31.42),
      points: [
        Offset(852.451, 350.509),
        Offset(875.824, 353.704),
        Offset(879.645, 325.549),
        Offset(856.574, 322.281),
        Offset(852.451, 350.509),
      ],
    ),
    // id 522: B2 L12
    Phase2LotAnnotation(
      id: 522,
      categoryId: 176,
      name: 'B2 L12',
      bbox: Rect.fromLTWH(828.43, 317.88, 28.46, 32.18),
      points: [
        Offset(828.428, 346.032),
        Offset(851.809, 350.061),
        Offset(856.883, 321.958),
        Offset(833.751, 317.881),
        Offset(828.428, 346.032),
      ],
    ),
    // id 523: B2 L14
    Phase2LotAnnotation(
      id: 523,
      categoryId: 177,
      name: 'B2 L14',
      bbox: Rect.fromLTWH(804.91, 313.76, 29.02, 31.23),
      points: [
        Offset(804.909, 339.937),
        Offset(828.098, 344.988),
        Offset(833.933, 317.311),
        Offset(810.652, 313.756),
        Offset(804.909, 339.937),
      ],
    ),
    // id 524: B2 L15
    Phase2LotAnnotation(
      id: 524,
      categoryId: 178,
      name: 'B2 L15',
      bbox: Rect.fromLTWH(780.97, 305.51, 30.04, 33.7),
      points: [
        Offset(780.972, 333.45),
        Offset(804.803, 339.204),
        Offset(811.008, 312.64),
        Offset(788.103, 305.507),
        Offset(780.972, 333.45),
      ],
    ),
    // id 525: B2 L16
    Phase2LotAnnotation(
      id: 525,
      categoryId: 179,
      name: 'B2 L16',
      bbox: Rect.fromLTWH(757.96, 298.91, 30.17, 33.74),
      points: [
        Offset(757.959, 325.688),
        Offset(780.918, 332.648),
        Offset(788.129, 305.715),
        Offset(765.83, 298.907),
        Offset(757.959, 325.688),
      ],
    ),
    // id 526: B2 L17
    Phase2LotAnnotation(
      id: 526,
      categoryId: 180,
      name: 'B2 L17',
      bbox: Rect.fromLTWH(735.43, 291.43, 30.88, 33.44),
      points: [
        Offset(735.425, 316.964),
        Offset(757.675, 324.87),
        Offset(766.306, 298.537),
        Offset(744.274, 291.428),
        Offset(735.425, 316.964),
      ],
    ),
    // id 527: B2 L18
    Phase2LotAnnotation(
      id: 527,
      categoryId: 181,
      name: 'B2 L18',
      bbox: Rect.fromLTWH(712.24, 281.86, 32.51, 34.85),
      points: [
        Offset(712.242, 307.29),
        Offset(734.838, 316.707),
        Offset(744.749, 290.474),
        Offset(722.107, 281.858),
        Offset(712.242, 307.29),
      ],
    ),
    // id 528: B2 L19
    Phase2LotAnnotation(
      id: 528,
      categoryId: 182,
      name: 'B2 L19',
      bbox: Rect.fromLTWH(670.83, 261.49, 50.96, 46.05),
      points: [
        Offset(711.428, 307.537),
        Offset(721.788, 281.121),
        Offset(681.055, 261.49),
        Offset(670.831, 288.268),
        Offset(711.428, 307.537),
      ],
    ),
    // id 493: B3 L1
    Phase2LotAnnotation(
      id: 493,
      categoryId: 388,
      name: 'B3 L1',
      bbox: Rect.fromLTWH(906.55, 298.06, 24.17, 30.02),
      points: [
        Offset(906.547, 326.741),
        Offset(930.188, 328.08),
        Offset(930.716, 299.364),
        Offset(908.174, 298.063),
        Offset(906.547, 326.741),
      ],
    ),
    // id 494: B3 L2
    Phase2LotAnnotation(
      id: 494,
      categoryId: 398,
      name: 'B3 L2',
      bbox: Rect.fromLTWH(930.13, 299.36, 24.69, 29.11),
      points: [
        Offset(930.134, 328.257),
        Offset(954.827, 328.472),
        Offset(954.107, 299.788),
        Offset(930.962, 299.358),
        Offset(930.134, 328.257),
      ],
    ),
    // id 497: B3 L3
    Phase2LotAnnotation(
      id: 497,
      categoryId: 399,
      name: 'B3 L3',
      bbox: Rect.fromLTWH(954.79, 300.43, 23.9, 28.14),
      points: [
        Offset(955.215, 328.562),
        Offset(978.689, 328.026),
        Offset(978.204, 300.426),
        Offset(954.787, 300.653),
        Offset(955.215, 328.562),
      ],
    ),
    // id 499: B3 L4
    Phase2LotAnnotation(
      id: 499,
      categoryId: 400,
      name: 'B3 L4',
      bbox: Rect.fromLTWH(978.35, 299.15, 24.67, 29.48),
      points: [
        Offset(978.583, 328.635),
        Offset(1003.026, 327.282),
        Offset(1001.205, 299.154),
        Offset(978.352, 300.135),
        Offset(978.583, 328.635),
      ],
    ),
    // id 501: B3 L5
    Phase2LotAnnotation(
      id: 501,
      categoryId: 401,
      name: 'B3 L5',
      bbox: Rect.fromLTWH(1001.14, 297.36, 26.31, 30.08),
      points: [
        Offset(1003.482, 327.44),
        Offset(1027.45, 325.734),
        Offset(1025.132, 297.357),
        Offset(1001.14, 299.099),
        Offset(1003.482, 327.44),
      ],
    ),
    // id 502: B3 L6
    Phase2LotAnnotation(
      id: 502,
      categoryId: 402,
      name: 'B3 L6',
      bbox: Rect.fromLTWH(1024.96, 294.51, 25.82, 29.78),
      points: [
        Offset(1027.408, 324.287),
        Offset(1050.789, 321.038),
        Offset(1048.034, 294.505),
        Offset(1024.965, 297.286),
        Offset(1027.408, 324.287),
      ],
    ),
    // id 503: B3 L7
    Phase2LotAnnotation(
      id: 503,
      categoryId: 403,
      name: 'B3 L7',
      bbox: Rect.fromLTWH(1048.27, 291.1, 27.45, 29.87),
      points: [
        Offset(1051.299, 320.971),
        Offset(1075.717, 317.473),
        Offset(1070.59, 291.1),
        Offset(1048.271, 294.438),
        Offset(1051.299, 320.971),
      ],
    ),
    // id 504: B3 L8
    Phase2LotAnnotation(
      id: 504,
      categoryId: 404,
      name: 'B3 L8',
      bbox: Rect.fromLTWH(1071.69, 285.56, 27.15, 31.75),
      points: [
        Offset(1075.497, 317.306),
        Offset(1098.848, 312.388),
        Offset(1092.72, 285.559),
        Offset(1071.694, 290.83),
        Offset(1075.497, 317.306),
      ],
    ),
    // id 505: B3 L9
    Phase2LotAnnotation(
      id: 505,
      categoryId: 405,
      name: 'B3 L9',
      bbox: Rect.fromLTWH(1093.59, 282.81, 39.86, 29.6),
      points: [
        Offset(1099.312, 312.409),
        Offset(1133.445, 302.376),
        Offset(1114.15, 283.257),
        Offset(1105.479, 282.813),
        Offset(1093.589, 286.151),
        Offset(1099.312, 312.409),
      ],
    ),
    // id 506: B3 L10
    Phase2LotAnnotation(
      id: 506,
      categoryId: 389,
      name: 'B3 L10',
      bbox: Rect.fromLTWH(1099.8, 304.88, 49.9, 36.95),
      points: [
        Offset(1106.307, 341.83),
        Offset(1142.61, 333.174),
        Offset(1146.408, 329.711),
        Offset(1149.641, 325.213),
        Offset(1149.706, 317.606),
        Offset(1136.403, 304.883),
        Offset(1099.804, 314.637),
        Offset(1106.307, 341.83),
      ],
    ),
    // id 507: B3 L11
    Phase2LotAnnotation(
      id: 507,
      categoryId: 390,
      name: 'B3 L11',
      bbox: Rect.fromLTWH(1075.7, 314.81, 29.58, 33.37),
      points: [
        Offset(1080.714, 348.183),
        Offset(1105.28, 342.2),
        Offset(1099.289, 314.809),
        Offset(1075.698, 320.322),
        Offset(1080.714, 348.183),
      ],
    ),
    // id 508: B3 L12
    Phase2LotAnnotation(
      id: 508,
      categoryId: 391,
      name: 'B3 L12',
      bbox: Rect.fromLTWH(1051.64, 319.92, 29.38, 32.05),
      points: [
        Offset(1056.165, 351.97),
        Offset(1081.015, 347.921),
        Offset(1075.43, 319.924),
        Offset(1051.638, 323.441),
        Offset(1056.165, 351.97),
      ],
    ),
    // id 509: B3 L14
    Phase2LotAnnotation(
      id: 509,
      categoryId: 392,
      name: 'B3 L14',
      bbox: Rect.fromLTWH(1027.6, 323.76, 27.91, 32.03),
      points: [
        Offset(1030.25, 355.788),
        Offset(1055.505, 352.011),
        Offset(1051.812, 323.76),
        Offset(1027.595, 327.802),
        Offset(1030.25, 355.788),
      ],
    ),
    // id 510: B3 L15
    Phase2LotAnnotation(
      id: 510,
      categoryId: 393,
      name: 'B3 L15',
      bbox: Rect.fromLTWH(1003.73, 327.48, 27.18, 30.13),
      points: [
        Offset(1005.214, 357.607),
        Offset(1030.906, 355.608),
        Offset(1027.368, 327.478),
        Offset(1003.73, 330.692),
        Offset(1005.214, 357.607),
      ],
    ),
    // id 500: B3 L16
    Phase2LotAnnotation(
      id: 500,
      categoryId: 394,
      name: 'B3 L16',
      bbox: Rect.fromLTWH(978.83, 330.75, 26.18, 28.9),
      points: [
        Offset(978.83, 359.652),
        Offset(1005.008, 358.402),
        Offset(1003.754, 330.749),
        Offset(979.129, 330.951),
        Offset(978.83, 359.652),
      ],
    ),
    // id 498: B3 L17
    Phase2LotAnnotation(
      id: 498,
      categoryId: 395,
      name: 'B3 L17',
      bbox: Rect.fromLTWH(954.14, 331.15, 25.03, 28.26),
      points: [
        Offset(954.137, 359.405),
        Offset(979.165, 359.224),
        Offset(978.689, 331.146),
        Offset(954.528, 331.469),
        Offset(954.137, 359.405),
      ],
    ),
    // id 495: B3 L18
    Phase2LotAnnotation(
      id: 495,
      categoryId: 396,
      name: 'B3 L18',
      bbox: Rect.fromLTWH(929.27, 330.43, 24.75, 28.52),
      points: [
        Offset(929.265, 358.035),
        Offset(953.668, 358.951),
        Offset(954.01, 331.337),
        Offset(929.926, 330.433),
        Offset(929.265, 358.035),
      ],
    ),
    // id 496: B3 L19
    Phase2LotAnnotation(
      id: 496,
      categoryId: 397,
      name: 'B3 L19',
      bbox: Rect.fromLTWH(903.53, 328.88, 25.91, 29.29),
      points: [
        Offset(903.531, 356.952),
        Offset(928.58, 358.167),
        Offset(929.436, 330.634),
        Offset(905.325, 328.88),
        Offset(903.531, 356.952),
      ],
    ),
    // id 571: B4 L1
    Phase2LotAnnotation(
      id: 571,
      categoryId: 447,
      name: 'B4 L1',
      bbox: Rect.fromLTWH(1121.05, 165.93, 128.9, 130.11),
      points: [
        Offset(1168.263, 296.038),
        Offset(1249.947, 216.739),
        Offset(1224.923, 165.933),
        Offset(1145.734, 243.012),
        Offset(1121.051, 251.499),
        Offset(1168.263, 296.038),
      ],
    ),
    // id 572: B4 L2
    Phase2LotAnnotation(
      id: 572,
      categoryId: 457,
      name: 'B4 L2',
      bbox: Rect.fromLTWH(1167.93, 217.03, 87.26, 102.31),
      points: [
        Offset(1167.927, 296.896),
        Offset(1192.114, 319.335),
        Offset(1255.124, 259.037),
        Offset(1255.183, 226.656),
        Offset(1250.265, 217.026),
        Offset(1167.927, 296.896),
      ],
    ),
    // id 573: B4 L3
    Phase2LotAnnotation(
      id: 573,
      categoryId: 468,
      name: 'B4 L3',
      bbox: Rect.fromLTWH(1191.97, 260.03, 73.7, 82.59),
      points: [
        Offset(1191.972, 319.683),
        Offset(1215.869, 342.623),
        Offset(1265.673, 294.189),
        Offset(1254.429, 283.562),
        Offset(1255.139, 260.03),
        Offset(1191.972, 319.683),
      ],
    ),
    // id 574: B4 L4
    Phase2LotAnnotation(
      id: 574,
      categoryId: 472,
      name: 'B4 L4',
      bbox: Rect.fromLTWH(1216.2, 294.43, 73.21, 71.16),
      points: [
        Offset(1216.198, 342.78),
        Offset(1240.47, 365.591),
        Offset(1289.405, 318.791),
        Offset(1265.746, 294.433),
        Offset(1216.198, 342.78),
      ],
    ),
    // id 575: B4 L5
    Phase2LotAnnotation(
      id: 575,
      categoryId: 473,
      name: 'B4 L5',
      bbox: Rect.fromLTWH(1240.39, 319.38, 71.7, 69.46),
      points: [
        Offset(1240.393, 365.925),
        Offset(1264.363, 388.838),
        Offset(1312.094, 343.014),
        Offset(1289.542, 319.375),
        Offset(1240.393, 365.925),
      ],
    ),
    // id 576: B4 L6
    Phase2LotAnnotation(
      id: 576,
      categoryId: 474,
      name: 'B4 L6',
      bbox: Rect.fromLTWH(1264.87, 343.17, 70.58, 69.13),
      points: [
        Offset(1264.872, 389.131),
        Offset(1289.129, 412.296),
        Offset(1335.449, 367.098),
        Offset(1312.191, 343.171),
        Offset(1264.872, 389.131),
      ],
    ),
    // id 577: B4 L7
    Phase2LotAnnotation(
      id: 577,
      categoryId: 475,
      name: 'B4 L7',
      bbox: Rect.fromLTWH(1289.12, 367.54, 69.25, 67.82),
      points: [
        Offset(1289.123, 412.901),
        Offset(1313.106, 435.36),
        Offset(1358.374, 390.737),
        Offset(1335.413, 367.54),
        Offset(1289.123, 412.901),
      ],
    ),
    // id 578: B4 L8
    Phase2LotAnnotation(
      id: 578,
      categoryId: 476,
      name: 'B4 L8',
      bbox: Rect.fromLTWH(1313.08, 391.05, 69.46, 67.87),
      points: [
        Offset(1313.079, 435.927),
        Offset(1337.108, 458.915),
        Offset(1382.542, 414.417),
        Offset(1358.921, 391.048),
        Offset(1313.079, 435.927),
      ],
    ),
    // id 579: B4 L9
    Phase2LotAnnotation(
      id: 579,
      categoryId: 477,
      name: 'B4 L9',
      bbox: Rect.fromLTWH(1337.48, 414.8, 68.52, 67.13),
      points: [
        Offset(1337.479, 459.073),
        Offset(1361.193, 481.93),
        Offset(1406.004, 438.54),
        Offset(1382.612, 414.803),
        Offset(1337.479, 459.073),
      ],
    ),
    // id 580: B4 L10
    Phase2LotAnnotation(
      id: 580,
      categoryId: 448,
      name: 'B4 L10',
      bbox: Rect.fromLTWH(1361.36, 438.93, 67.97, 66.07),
      points: [
        Offset(1361.356, 482.111),
        Offset(1385.37, 504.998),
        Offset(1429.326, 461.879),
        Offset(1405.939, 438.926),
        Offset(1361.356, 482.111),
      ],
    ),
    // id 581: B4 L11
    Phase2LotAnnotation(
      id: 581,
      categoryId: 449,
      name: 'B4 L11',
      bbox: Rect.fromLTWH(1385.34, 462.72, 66.84, 65.57),
      points: [
        Offset(1385.336, 506.089),
        Offset(1409.567, 528.292),
        Offset(1452.178, 486.657),
        Offset(1429.161, 462.721),
        Offset(1385.336, 506.089),
      ],
    ),
    // id 582: B4 L12
    Phase2LotAnnotation(
      id: 582,
      categoryId: 450,
      name: 'B4 L12',
      bbox: Rect.fromLTWH(1409.23, 487.09, 65.9, 64.37),
      points: [
        Offset(1409.227, 528.898),
        Offset(1433.85, 551.455),
        Offset(1475.125, 510.805),
        Offset(1451.81, 487.09),
        Offset(1409.227, 528.898),
      ],
    ),
    // id 583: B4 L14
    Phase2LotAnnotation(
      id: 583,
      categoryId: 451,
      name: 'B4 L14',
      bbox: Rect.fromLTWH(1433.68, 510.68, 65.98, 64.17),
      points: [
        Offset(1433.68, 551.913),
        Offset(1457.133, 574.852),
        Offset(1499.658, 534.333),
        Offset(1476.16, 510.683),
        Offset(1433.68, 551.913),
      ],
    ),
    // id 584: B4 L15
    Phase2LotAnnotation(
      id: 584,
      categoryId: 452,
      name: 'B4 L15',
      bbox: Rect.fromLTWH(1457.8, 534.68, 65.67, 63.7),
      points: [
        Offset(1457.801, 574.969),
        Offset(1481.405, 598.382),
        Offset(1523.472, 557.885),
        Offset(1500.261, 534.681),
        Offset(1457.801, 574.969),
      ],
    ),
    // id 585: B4 L16
    Phase2LotAnnotation(
      id: 585,
      categoryId: 453,
      name: 'B4 L16',
      bbox: Rect.fromLTWH(1481.56, 558.19, 65.92, 63.31),
      points: [
        Offset(1481.559, 598.336),
        Offset(1506.027, 621.501),
        Offset(1547.478, 581.257),
        Offset(1523.483, 558.19),
        Offset(1481.559, 598.336),
      ],
    ),
    // id 586: B4 L17
    Phase2LotAnnotation(
      id: 586,
      categoryId: 454,
      name: 'B4 L17',
      bbox: Rect.fromLTWH(1506.14, 581.41, 65.08, 62.46),
      points: [
        Offset(1506.138, 621.93),
        Offset(1530.681, 643.872),
        Offset(1571.213, 604.067),
        Offset(1546.705, 581.412),
        Offset(1506.138, 621.93),
      ],
    ),
    // id 587: B4 L18
    Phase2LotAnnotation(
      id: 587,
      categoryId: 455,
      name: 'B4 L18',
      bbox: Rect.fromLTWH(1530.28, 604.63, 79.97, 76.72),
      points: [
        Offset(1530.279, 644.41),
        Offset(1564.736, 678.24),
        Offset(1569.533, 681.356),
        Offset(1576.964, 681.199),
        Offset(1581.069, 678.426),
        Offset(1610.254, 633.516),
        Offset(1584.796, 617.179),
        Offset(1571.074, 604.634),
        Offset(1530.279, 644.41),
      ],
    ),
    // id 588: B4 L19
    Phase2LotAnnotation(
      id: 588,
      categoryId: 456,
      name: 'B4 L19',
      bbox: Rect.fromLTWH(1586.68, 599.38, 35.67, 33.62),
      points: [
        Offset(1610.433, 632.998),
        Offset(1622.348, 614.623),
        Offset(1597.924, 599.382),
        Offset(1586.679, 617.228),
        Offset(1610.433, 632.998),
      ],
    ),
    // id 589: B4 L20
    Phase2LotAnnotation(
      id: 589,
      categoryId: 458,
      name: 'B4 L20',
      bbox: Rect.fromLTWH(1598.31, 581.09, 35.9, 33.51),
      points: [
        Offset(1622.569, 614.599),
        Offset(1634.205, 596.28),
        Offset(1610.311, 581.093),
        Offset(1598.309, 598.9),
        Offset(1622.569, 614.599),
      ],
    ),
    // id 590: B4 L21
    Phase2LotAnnotation(
      id: 590,
      categoryId: 459,
      name: 'B4 L21',
      bbox: Rect.fromLTWH(1610.92, 562.05, 36.02, 33.53),
      points: [
        Offset(1634.876, 595.581),
        Offset(1646.94, 578.043),
        Offset(1622.415, 562.051),
        Offset(1610.924, 580.265),
        Offset(1634.876, 595.581),
      ],
    ),
    // id 591: B4 L22
    Phase2LotAnnotation(
      id: 591,
      categoryId: 460,
      name: 'B4 L22',
      bbox: Rect.fromLTWH(1622.97, 543.57, 35.84, 33.02),
      points: [
        Offset(1646.516, 576.586),
        Offset(1658.808, 558.199),
        Offset(1634.942, 543.565),
        Offset(1622.965, 561.057),
        Offset(1646.516, 576.586),
      ],
    ),
    // id 592: B4 L23
    Phase2LotAnnotation(
      id: 592,
      categoryId: 461,
      name: 'B4 L23',
      bbox: Rect.fromLTWH(1635.01, 524.51, 36.02, 33.58),
      points: [
        Offset(1658.902, 558.08),
        Offset(1671.03, 539.913),
        Offset(1646.827, 524.505),
        Offset(1635.006, 542.995),
        Offset(1658.902, 558.08),
      ],
    ),
    // id 593: B4 L24
    Phase2LotAnnotation(
      id: 593,
      categoryId: 462,
      name: 'B4 L24',
      bbox: Rect.fromLTWH(1647.43, 505.54, 34.64, 32.9),
      points: [
        Offset(1647.434, 523.397),
        Offset(1670.938, 538.442),
        Offset(1682.077, 521.535),
        Offset(1659.257, 505.54),
        Offset(1647.434, 523.397),
      ],
    ),
    // id 594: B4 L25
    Phase2LotAnnotation(
      id: 594,
      categoryId: 463,
      name: 'B4 L25',
      bbox: Rect.fromLTWH(1659.8, 487.38, 34.1, 32.59),
      points: [
        Offset(1659.798, 505.077),
        Offset(1682.949, 519.968),
        Offset(1693.895, 502.458),
        Offset(1670.556, 487.377),
        Offset(1659.798, 505.077),
      ],
    ),
    // id 595: B4 L26
    Phase2LotAnnotation(
      id: 595,
      categoryId: 464,
      name: 'B4 L26',
      bbox: Rect.fromLTWH(1672.4, 468.46, 34.2, 32.26),
      points: [
        Offset(1672.4, 484.992),
        Offset(1694.887, 500.716),
        Offset(1706.605, 484.283),
        Offset(1682.597, 468.455),
        Offset(1672.4, 484.992),
      ],
    ),
    // id 596: B4 L27
    Phase2LotAnnotation(
      id: 596,
      categoryId: 465,
      name: 'B4 L27',
      bbox: Rect.fromLTWH(1684.4, 450.26, 33.92, 32.19),
      points: [
        Offset(1684.402, 467.071),
        Offset(1707.091, 482.45),
        Offset(1718.323, 464.397),
        Offset(1694.932, 450.258),
        Offset(1684.402, 467.071),
      ],
    ),
    // id 597: B4 L28
    Phase2LotAnnotation(
      id: 597,
      categoryId: 466,
      name: 'B4 L28',
      bbox: Rect.fromLTWH(1695.34, 430.9, 35.15, 32.77),
      points: [
        Offset(1695.336, 449.511),
        Offset(1719.735, 463.673),
        Offset(1730.485, 446.43),
        Offset(1706.966, 430.899),
        Offset(1695.336, 449.511),
      ],
    ),
    // id 598: B4 L29
    Phase2LotAnnotation(
      id: 598,
      categoryId: 467,
      name: 'B4 L29',
      bbox: Rect.fromLTWH(1707.87, 411.98, 35.74, 33.8),
      points: [
        Offset(1707.873, 429.629),
        Offset(1732.187, 445.777),
        Offset(1743.61, 427.082),
        Offset(1719.58, 411.977),
        Offset(1707.873, 429.629),
      ],
    ),
    // id 599: B4 L30
    Phase2LotAnnotation(
      id: 599,
      categoryId: 469,
      name: 'B4 L30',
      bbox: Rect.fromLTWH(1719.33, 393.34, 36.86, 33.83),
      points: [
        Offset(1719.327, 410.955),
        Offset(1743.957, 427.174),
        Offset(1756.184, 408.736),
        Offset(1731.335, 393.342),
        Offset(1719.327, 410.955),
      ],
    ),
    // id 600: B4 L31
    Phase2LotAnnotation(
      id: 600,
      categoryId: 470,
      name: 'B4 L31',
      bbox: Rect.fromLTWH(1731.63, 374.42, 36.57, 34.39),
      points: [
        Offset(1731.634, 392.567),
        Offset(1756.638, 408.808),
        Offset(1768.208, 389.555),
        Offset(1743.662, 374.42),
        Offset(1731.634, 392.567),
      ],
    ),
    // id 601: B4 L32
    Phase2LotAnnotation(
      id: 601,
      categoryId: 471,
      name: 'B4 L32',
      bbox: Rect.fromLTWH(1744, 356.07, 34.01, 32.94),
      points: [
        Offset(1743.997, 374.367),
        Offset(1768.305, 389.011),
        Offset(1778.003, 374.242),
        Offset(1755.13, 356.072),
        Offset(1743.997, 374.367),
      ],
    ),
    // id 471: B5 L1
    Phase2LotAnnotation(
      id: 471,
      categoryId: 478,
      name: 'B5 L1',
      bbox: Rect.fromLTWH(1158.22, 346.26, 41.64, 30.57),
      points: [
        Offset(1166.523, 376.83),
        Offset(1199.857, 365.345),
        Offset(1180.043, 346.263),
        Offset(1171.141, 346.387),
        Offset(1158.221, 350.304),
        Offset(1166.523, 376.83),
      ],
    ),
    // id 472: B5 L2
    Phase2LotAnnotation(
      id: 472,
      categoryId: 488,
      name: 'B5 L2',
      bbox: Rect.fromLTWH(1167.82, 367.11, 46.25, 38.7),
      points: [
        Offset(1175.26, 405.807),
        Offset(1208.77, 393.653),
        Offset(1214.074, 388.358),
        Offset(1213.52, 378.418),
        Offset(1201.515, 367.11),
        Offset(1167.823, 379.195),
        Offset(1175.26, 405.807),
      ],
    ),
    // id 473: B5 L3
    Phase2LotAnnotation(
      id: 473,
      categoryId: 493,
      name: 'B5 L3',
      bbox: Rect.fromLTWH(1135.85, 350.64, 30.8, 32.66),
      points: [
        Offset(1135.846, 358.362),
        Offset(1142.587, 383.298),
        Offset(1166.645, 376.991),
        Offset(1157.983, 350.635),
        Offset(1135.846, 358.362),
      ],
    ),
    // id 474: B5 L4
    Phase2LotAnnotation(
      id: 474,
      categoryId: 494,
      name: 'B5 L4',
      bbox: Rect.fromLTWH(1143.83, 379.2, 32.04, 33.29),
      points: [
        Offset(1143.825, 386.362),
        Offset(1151.397, 412.487),
        Offset(1175.869, 405.124),
        Offset(1167.343, 379.195),
        Offset(1143.825, 386.362),
      ],
    ),
    // id 475: B5 L5
    Phase2LotAnnotation(
      id: 475,
      categoryId: 495,
      name: 'B5 L5',
      bbox: Rect.fromLTWH(1113.78, 358.11, 29.35, 31.47),
      points: [
        Offset(1119.368, 389.587),
        Offset(1143.13, 383.448),
        Offset(1135.865, 358.113),
        Offset(1113.783, 364.079),
        Offset(1119.368, 389.587),
      ],
    ),
    // id 476: B5 L6
    Phase2LotAnnotation(
      id: 476,
      categoryId: 496,
      name: 'B5 L6',
      bbox: Rect.fromLTWH(1120.66, 385.91, 30.3, 33.19),
      points: [
        Offset(1126.676, 419.091),
        Offset(1150.957, 412.44),
        Offset(1143.743, 385.906),
        Offset(1120.655, 393.064),
        Offset(1126.676, 419.091),
      ],
    ),
    // id 477: B5 L7
    Phase2LotAnnotation(
      id: 477,
      categoryId: 497,
      name: 'B5 L7',
      bbox: Rect.fromLTWH(1090.61, 364.08, 29.66, 31.3),
      points: [
        Offset(1090.605, 369.132),
        Offset(1096.074, 395.374),
        Offset(1120.269, 389.73),
        Offset(1113.344, 364.075),
        Offset(1090.605, 369.132),
      ],
    ),
    // id 478: B5 L8
    Phase2LotAnnotation(
      id: 478,
      categoryId: 498,
      name: 'B5 L8',
      bbox: Rect.fromLTWH(1096.72, 393.35, 29.77, 31.12),
      points: [
        Offset(1096.721, 398.127),
        Offset(1100.995, 424.478),
        Offset(1126.488, 419.047),
        Offset(1120.064, 393.354),
        Offset(1096.721, 398.127),
      ],
    ),
    // id 479: B5 L9
    Phase2LotAnnotation(
      id: 479,
      categoryId: 499,
      name: 'B5 L9',
      bbox: Rect.fromLTWH(1067.51, 369.82, 29.37, 29.93),
      points: [
        Offset(1072.106, 399.744),
        Offset(1096.877, 395.991),
        Offset(1091.097, 369.819),
        Offset(1067.505, 373.195),
        Offset(1072.106, 399.744),
      ],
    ),
    // id 480: B5 L10
    Phase2LotAnnotation(
      id: 480,
      categoryId: 479,
      name: 'B5 L10',
      bbox: Rect.fromLTWH(1072.78, 398.58, 28.73, 30.28),
      points: [
        Offset(1076.39, 428.854),
        Offset(1101.513, 424.898),
        Offset(1096.556, 398.578),
        Offset(1072.785, 402.234),
        Offset(1076.39, 428.854),
      ],
    ),
    // id 481: B5 L11
    Phase2LotAnnotation(
      id: 481,
      categoryId: 480,
      name: 'B5 L11',
      bbox: Rect.fromLTWH(1045.67, 373.24, 26.84, 30.53),
      points: [
        Offset(1048.474, 403.77),
        Offset(1072.508, 400.501),
        Offset(1068.025, 373.235),
        Offset(1045.665, 376.555),
        Offset(1048.474, 403.77),
      ],
    ),
    // id 482: B5 L12
    Phase2LotAnnotation(
      id: 482,
      categoryId: 481,
      name: 'B5 L12',
      bbox: Rect.fromLTWH(1048.79, 402.41, 28.07, 30.55),
      points: [
        Offset(1051.734, 432.959),
        Offset(1076.856, 429.189),
        Offset(1072.927, 402.414),
        Offset(1048.785, 405.834),
        Offset(1051.734, 432.959),
      ],
    ),
    // id 484: B5 L14
    Phase2LotAnnotation(
      id: 484,
      categoryId: 482,
      name: 'B5 L14',
      bbox: Rect.fromLTWH(1024.3, 406.08, 26.73, 30.27),
      points: [
        Offset(1026.188, 436.35),
        Offset(1051.034, 433.236),
        Offset(1048.44, 406.085),
        Offset(1024.305, 408.234),
        Offset(1026.188, 436.35),
      ],
    ),
    // id 483: B5 L15
    Phase2LotAnnotation(
      id: 483,
      categoryId: 483,
      name: 'B5 L15',
      bbox: Rect.fromLTWH(1022.36, 376.81, 25.84, 29.63),
      points: [
        Offset(1023.971, 406.447),
        Offset(1048.208, 403.926),
        Offset(1045.162, 376.815),
        Offset(1022.364, 379.147),
        Offset(1023.971, 406.447),
      ],
    ),
    // id 486: B5 L16
    Phase2LotAnnotation(
      id: 486,
      categoryId: 484,
      name: 'B5 L16',
      bbox: Rect.fromLTWH(999.83, 408.84, 26.83, 28.73),
      points: [
        Offset(1001.597, 437.569),
        Offset(1026.652, 435.97),
        Offset(1024.471, 408.842),
        Offset(999.826, 410.394),
        Offset(1001.597, 437.569),
      ],
    ),
    // id 485: B5 L17
    Phase2LotAnnotation(
      id: 485,
      categoryId: 485,
      name: 'B5 L17',
      bbox: Rect.fromLTWH(999.11, 379.23, 25.54, 29.09),
      points: [
        Offset(1000.202, 408.322),
        Offset(1024.65, 406.317),
        Offset(1022.268, 379.229),
        Offset(999.106, 381.115),
        Offset(1000.202, 408.322),
      ],
    ),
    // id 488: B5 L18
    Phase2LotAnnotation(
      id: 488,
      categoryId: 486,
      name: 'B5 L18',
      bbox: Rect.fromLTWH(976.07, 410.97, 24.93, 27.59),
      points: [
        Offset(976.157, 438.558),
        Offset(1000.995, 437.847),
        Offset(999.647, 410.97),
        Offset(976.066, 411.594),
        Offset(976.157, 438.558),
      ],
    ),
    // id 487: B5 L19
    Phase2LotAnnotation(
      id: 487,
      categoryId: 487,
      name: 'B5 L19',
      bbox: Rect.fromLTWH(975.83, 380.89, 24.56, 28.18),
      points: [
        Offset(975.86, 409.067),
        Offset(1000.389, 408.303),
        Offset(998.939, 380.89),
        Offset(975.826, 382.074),
        Offset(975.86, 409.067),
      ],
    ),
    // id 490: B5 L20
    Phase2LotAnnotation(
      id: 490,
      categoryId: 489,
      name: 'B5 L20',
      bbox: Rect.fromLTWH(950.86, 411.83, 25.35, 26.18),
      points: [
        Offset(950.862, 438.018),
        Offset(975.761, 437.954),
        Offset(976.208, 411.898),
        Offset(950.866, 411.834),
        Offset(950.862, 438.018),
      ],
    ),
    // id 489: B5 L21
    Phase2LotAnnotation(
      id: 489,
      categoryId: 490,
      name: 'B5 L21',
      bbox: Rect.fromLTWH(951.42, 381.83, 24.67, 27.26),
      points: [
        Offset(951.418, 408.956),
        Offset(976.089, 409.093),
        Offset(975.266, 381.909),
        Offset(952.066, 381.834),
        Offset(951.418, 408.956),
      ],
    ),
    // id 492: B5 L22
    Phase2LotAnnotation(
      id: 492,
      categoryId: 491,
      name: 'B5 L22',
      bbox: Rect.fromLTWH(925.49, 411.49, 25.75, 26.7),
      points: [
        Offset(925.493, 438.188),
        Offset(950.566, 438.186),
        Offset(951.246, 411.487),
        Offset(927.107, 411.834),
        Offset(925.493, 438.188),
      ],
    ),
    // id 491: B5 L23
    Phase2LotAnnotation(
      id: 491,
      categoryId: 492,
      name: 'B5 L23',
      bbox: Rect.fromLTWH(927.81, 381.76, 24.07, 27.71),
      points: [
        Offset(927.807, 409.471),
        Offset(951.398, 408.911),
        Offset(951.878, 381.948),
        Offset(929.071, 381.759),
        Offset(927.807, 409.471),
      ],
    ),
    // id 449: B6 L1
    Phase2LotAnnotation(
      id: 449,
      categoryId: 500,
      name: 'B6 L1',
      bbox: Rect.fromLTWH(901.76, 380.23, 23.37, 27.62),
      points: [
        Offset(901.756, 406.538),
        Offset(923.74, 407.85),
        Offset(925.125, 380.966),
        Offset(904.264, 380.231),
        Offset(901.756, 406.538),
      ],
    ),
    // id 450: B6 L2
    Phase2LotAnnotation(
      id: 450,
      categoryId: 510,
      name: 'B6 L2',
      bbox: Rect.fromLTWH(899.07, 409.35, 24.04, 28.1),
      points: [
        Offset(900.779, 409.347),
        Offset(899.068, 436.134),
        Offset(921.576, 437.442),
        Offset(923.104, 410.334),
        Offset(900.779, 409.347),
      ],
    ),
    // id 451: B6 L3
    Phase2LotAnnotation(
      id: 451,
      categoryId: 515,
      name: 'B6 L3',
      bbox: Rect.fromLTWH(879.55, 378.15, 24.52, 28.69),
      points: [
        Offset(883.05, 378.147),
        Offset(879.551, 404.412),
        Offset(901.819, 406.836),
        Offset(904.069, 380.036),
        Offset(883.05, 378.147),
      ],
    ),
    // id 452: B6 L4
    Phase2LotAnnotation(
      id: 452,
      categoryId: 516,
      name: 'B6 L4',
      bbox: Rect.fromLTWH(875.89, 407.41, 25.08, 28.34),
      points: [
        Offset(875.893, 433.319),
        Offset(898.042, 435.754),
        Offset(900.978, 409.138),
        Offset(878.757, 407.41),
        Offset(875.893, 433.319),
      ],
    ),
    // id 453: B6 L5
    Phase2LotAnnotation(
      id: 453,
      categoryId: 517,
      name: 'B6 L5',
      bbox: Rect.fromLTWH(856.84, 375.13, 26, 28.97),
      points: [
        Offset(856.838, 401.451),
        Offset(879.277, 404.096),
        Offset(882.84, 377.574),
        Offset(861.858, 375.126),
        Offset(856.838, 401.451),
      ],
    ),
    // id 454: B6 L5
    Phase2LotAnnotation(
      id: 454,
      categoryId: 517,
      name: 'B6 L5',
      bbox: Rect.fromLTWH(852.25, 403.81, 26.8, 29.86),
      points: [
        Offset(852.247, 430.336),
        Offset(875.366, 433.662),
        Offset(879.045, 407.403),
        Offset(856.686, 403.806),
        Offset(852.247, 430.336),
      ],
    ),
    // id 455: B6 L7
    Phase2LotAnnotation(
      id: 455,
      categoryId: 518,
      name: 'B6 L7',
      bbox: Rect.fromLTWH(835.59, 371.28, 26.22, 29.69),
      points: [
        Offset(835.591, 397.121),
        Offset(856.995, 400.967),
        Offset(861.81, 374.655),
        Offset(840.243, 371.279),
        Offset(835.591, 397.121),
      ],
    ),
    // id 456: B6 L8
    Phase2LotAnnotation(
      id: 456,
      categoryId: 519,
      name: 'B6 L8',
      bbox: Rect.fromLTWH(829.64, 399.65, 27.18, 30.32),
      points: [
        Offset(829.644, 426.563),
        Offset(852.265, 429.968),
        Offset(856.826, 403.859),
        Offset(835.076, 399.646),
        Offset(829.644, 426.563),
      ],
    ),
    // id 457: B6 L9
    Phase2LotAnnotation(
      id: 457,
      categoryId: 520,
      name: 'B6 L9',
      bbox: Rect.fromLTWH(813.62, 366.61, 27.05, 29.98),
      points: [
        Offset(813.623, 393.122),
        Offset(835.221, 396.585),
        Offset(840.671, 370.716),
        Offset(819.811, 366.609),
        Offset(813.623, 393.122),
      ],
    ),
    // id 458: B6 L10
    Phase2LotAnnotation(
      id: 458,
      categoryId: 501,
      name: 'B6 L10',
      bbox: Rect.fromLTWH(806.44, 395.41, 28.38, 30.21),
      points: [
        Offset(806.443, 421.111),
        Offset(829.249, 425.615),
        Offset(834.82, 399.822),
        Offset(812.806, 395.409),
        Offset(806.443, 421.111),
      ],
    ),
    // id 459: B6 L11
    Phase2LotAnnotation(
      id: 459,
      categoryId: 502,
      name: 'B6 L11',
      bbox: Rect.fromLTWH(792.14, 361.6, 27.27, 30.91),
      points: [
        Offset(792.136, 387.459),
        Offset(813.28, 392.512),
        Offset(819.41, 366.168),
        Offset(799.319, 361.599),
        Offset(792.136, 387.459),
      ],
    ),
    // id 460: B6 L12
    Phase2LotAnnotation(
      id: 460,
      categoryId: 503,
      name: 'B6 L12',
      bbox: Rect.fromLTWH(784.3, 389.77, 28.25, 31.54),
      points: [
        Offset(784.3, 416.366),
        Offset(806.729, 421.31),
        Offset(812.553, 395.232),
        Offset(791.596, 389.766),
        Offset(784.3, 416.366),
      ],
    ),
    // id 462: B6 L14
    Phase2LotAnnotation(
      id: 462,
      categoryId: 504,
      name: 'B6 L14',
      bbox: Rect.fromLTWH(762.35, 384.72, 28.84, 31.41),
      points: [
        Offset(762.346, 410.417),
        Offset(783.777, 416.131),
        Offset(791.19, 389.344),
        Offset(769.829, 384.718),
        Offset(762.346, 410.417),
      ],
    ),
    // id 461: B6 L15
    Phase2LotAnnotation(
      id: 461,
      categoryId: 505,
      name: 'B6 L15',
      bbox: Rect.fromLTWH(771.37, 356.26, 27.9, 30.61),
      points: [
        Offset(771.371, 381.357),
        Offset(792.186, 386.861),
        Offset(799.27, 361.505),
        Offset(778.521, 356.256),
        Offset(771.371, 381.357),
      ],
    ),
    // id 464: B6 L16
    Phase2LotAnnotation(
      id: 464,
      categoryId: 506,
      name: 'B6 L16',
      bbox: Rect.fromLTWH(739.47, 377.37, 30.27, 32.35),
      points: [
        Offset(739.468, 403.05),
        Offset(761.545, 409.722),
        Offset(769.735, 384.793),
        Offset(748.925, 377.373),
        Offset(739.468, 403.05),
      ],
    ),
    // id 463: B6 L17
    Phase2LotAnnotation(
      id: 463,
      categoryId: 507,
      name: 'B6 L17',
      bbox: Rect.fromLTWH(749.83, 349.68, 28.6, 30.92),
      points: [
        Offset(749.829, 375.272),
        Offset(770.332, 380.605),
        Offset(778.428, 355.73),
        Offset(758.562, 349.681),
        Offset(749.829, 375.272),
      ],
    ),
    // id 466: B6 L18
    Phase2LotAnnotation(
      id: 466,
      categoryId: 508,
      name: 'B6 L18',
      bbox: Rect.fromLTWH(709.41, 363.78, 39.22, 38.55),
      points: [
        Offset(709.405, 389.635),
        Offset(733.586, 402.101),
        Offset(739.811, 402.324),
        Offset(748.626, 377.354),
        Offset(717.068, 363.778),
        Offset(709.405, 389.635),
      ],
    ),
    // id 465: B6 L19
    Phase2LotAnnotation(
      id: 465,
      categoryId: 509,
      name: 'B6 L19',
      bbox: Rect.fromLTWH(717.46, 337.42, 40.16, 37.83),
      points: [
        Offset(717.463, 362.23),
        Offset(749.386, 375.253),
        Offset(757.62, 349.364),
        Offset(725.824, 337.421),
        Offset(717.463, 362.23),
      ],
    ),
    // id 468: B6 L20
    Phase2LotAnnotation(
      id: 468,
      categoryId: 511,
      name: 'B6 L20',
      bbox: Rect.fromLTWH(677.45, 354.58, 39.35, 34.93),
      points: [
        Offset(677.448, 381.493),
        Offset(709.032, 389.506),
        Offset(716.798, 363.92),
        Offset(682.223, 354.577),
        Offset(677.448, 381.493),
      ],
    ),
    // id 467: B6 L21
    Phase2LotAnnotation(
      id: 467,
      categoryId: 512,
      name: 'B6 L21',
      bbox: Rect.fromLTWH(683.38, 321.85, 42.1, 39.68),
      points: [
        Offset(683.378, 351.788),
        Offset(717.368, 361.535),
        Offset(725.478, 338.324),
        Offset(688.463, 321.853),
        Offset(683.378, 351.788),
      ],
    ),
    // id 470: B6 L22
    Phase2LotAnnotation(
      id: 470,
      categoryId: 513,
      name: 'B6 L22',
      bbox: Rect.fromLTWH(637.95, 350.54, 43.6, 30.28),
      points: [
        Offset(681.553, 354.507),
        Offset(666.118, 351.451),
        Offset(648.904, 350.539),
        Offset(637.952, 378.11),
        Offset(660.27, 378.244),
        Offset(676.787, 380.814),
        Offset(681.553, 354.507),
      ],
    ),
    // id 469: B6 L23
    Phase2LotAnnotation(
      id: 469,
      categoryId: 514,
      name: 'B6 L23',
      bbox: Rect.fromLTWH(648.95, 317.47, 39.32, 34.15),
      points: [
        Offset(682.968, 321.015),
        Offset(677.553, 325.199),
        Offset(660.421, 317.473),
        Offset(648.953, 348.65),
        Offset(682.136, 351.627),
        Offset(688.268, 321.464),
        Offset(682.968, 321.015),
      ],
    ),
    // id 425: B7 L1
    Phase2LotAnnotation(
      id: 425,
      categoryId: 521,
      name: 'B7 L1',
      bbox: Rect.fromLTWH(1217.88, 406.99, 43.02, 33.17),
      points: [
        Offset(1223.804, 440.163),
        Offset(1260.895, 424.758),
        Offset(1242.514, 407.358),
        Offset(1234.387, 406.991),
        Offset(1217.878, 413.751),
        Offset(1223.804, 440.163),
      ],
    ),
    // id 426: B7 L2
    Phase2LotAnnotation(
      id: 426,
      categoryId: 531,
      name: 'B7 L2',
      bbox: Rect.fromLTWH(1225.21, 426.2, 49.5, 40.75),
      points: [
        Offset(1231.423, 466.949),
        Offset(1268.561, 452.439),
        Offset(1272.843, 448.813),
        Offset(1274.71, 445.745),
        Offset(1274.246, 436.446),
        Offset(1262.404, 426.201),
        Offset(1225.212, 442.027),
        Offset(1231.423, 466.949),
      ],
    ),
    // id 427: B7 L3
    Phase2LotAnnotation(
      id: 427,
      categoryId: 538,
      name: 'B7 L3',
      bbox: Rect.fromLTWH(1195.06, 414.01, 29.46, 34.12),
      points: [
        Offset(1195.059, 421.991),
        Offset(1201.024, 448.125),
        Offset(1224.52, 439.882),
        Offset(1217.566, 414.01),
        Offset(1195.059, 421.991),
      ],
    ),
    // id 428: B7 L4
    Phase2LotAnnotation(
      id: 428,
      categoryId: 539,
      name: 'B7 L4',
      bbox: Rect.fromLTWH(1201.64, 442.42, 30.05, 33.77),
      points: [
        Offset(1201.639, 449.909),
        Offset(1208.019, 476.185),
        Offset(1231.69, 467.386),
        Offset(1224.934, 442.415),
        Offset(1201.639, 449.909),
      ],
    ),
    // id 429: B7 L5
    Phase2LotAnnotation(
      id: 429,
      categoryId: 540,
      name: 'B7 L5',
      bbox: Rect.fromLTWH(1172.71, 421.97, 28.1, 33.79),
      points: [
        Offset(1172.712, 429.647),
        Offset(1178.524, 455.758),
        Offset(1200.807, 448.031),
        Offset(1195.135, 421.966),
        Offset(1172.712, 429.647),
      ],
    ),
    // id 430: B7 L6
    Phase2LotAnnotation(
      id: 430,
      categoryId: 541,
      name: 'B7 L6',
      bbox: Rect.fromLTWH(1178.52, 449.92, 29.41, 34),
      points: [
        Offset(1178.522, 457.921),
        Offset(1183.437, 483.917),
        Offset(1207.929, 475.992),
        Offset(1201.696, 449.921),
        Offset(1178.522, 457.921),
      ],
    ),
    // id 431: B7 L7
    Phase2LotAnnotation(
      id: 431,
      categoryId: 542,
      name: 'B7 L7',
      bbox: Rect.fromLTWH(1150.65, 429.77, 27.67, 32.56),
      points: [
        Offset(1150.648, 435.757),
        Offset(1154.769, 462.326),
        Offset(1178.314, 455.359),
        Offset(1172.872, 429.771),
        Offset(1150.648, 435.757),
      ],
    ),
    // id 432: B7 L8
    Phase2LotAnnotation(
      id: 432,
      categoryId: 543,
      name: 'B7 L8',
      bbox: Rect.fromLTWH(1157.01, 457.95, 26.56, 32.39),
      points: [
        Offset(1159.323, 490.344),
        Offset(1183.577, 483.113),
        Offset(1179.189, 457.951),
        Offset(1157.014, 464.35),
        Offset(1159.323, 490.344),
      ],
    ),
    // id 433: B7 L9
    Phase2LotAnnotation(
      id: 433,
      categoryId: 544,
      name: 'B7 L9',
      bbox: Rect.fromLTWH(1129.43, 435.78, 25.92, 32.36),
      points: [
        Offset(1131.43, 468.138),
        Offset(1155.35, 461.903),
        Offset(1151.334, 435.776),
        Offset(1129.434, 441.262),
        Offset(1131.43, 468.138),
      ],
    ),
    // id 434: B7 L10
    Phase2LotAnnotation(
      id: 434,
      categoryId: 522,
      name: 'B7 L10',
      bbox: Rect.fromLTWH(1132.99, 464.58, 26.23, 31.67),
      points: [
        Offset(1132.988, 469.84),
        Offset(1135.313, 496.254),
        Offset(1159.216, 490.509),
        Offset(1156.641, 464.585),
        Offset(1132.988, 469.84),
      ],
    ),
    // id 435: B7 L11
    Phase2LotAnnotation(
      id: 435,
      categoryId: 523,
      name: 'B7 L11',
      bbox: Rect.fromLTWH(1106.09, 441.42, 26.07, 31.75),
      points: [
        Offset(1108.083, 473.167),
        Offset(1132.16, 468.177),
        Offset(1129.329, 441.421),
        Offset(1106.086, 446.579),
        Offset(1108.083, 473.167),
      ],
    ),
    // id 436: B7 L12
    Phase2LotAnnotation(
      id: 436,
      categoryId: 524,
      name: 'B7 L12',
      bbox: Rect.fromLTWH(1108.37, 470.37, 27.01, 31.22),
      points: [
        Offset(1110.622, 501.592),
        Offset(1135.377, 496.53),
        Offset(1132.172, 470.369),
        Offset(1108.371, 475.806),
        Offset(1110.622, 501.592),
      ],
    ),
    // id 438: B7 L14
    Phase2LotAnnotation(
      id: 438,
      categoryId: 525,
      name: 'B7 L14',
      bbox: Rect.fromLTWH(1085.35, 475.87, 25.8, 29.97),
      points: [
        Offset(1086.947, 505.843),
        Offset(1111.148, 501.549),
        Offset(1109.19, 475.874),
        Offset(1085.348, 479.121),
        Offset(1086.947, 505.843),
      ],
    ),
    // id 437: B7 L15
    Phase2LotAnnotation(
      id: 437,
      categoryId: 526,
      name: 'B7 L15',
      bbox: Rect.fromLTWH(1083.01, 446.61, 25.25, 31.02),
      points: [
        Offset(1084.578, 477.632),
        Offset(1108.263, 473.501),
        Offset(1105.685, 446.608),
        Offset(1083.013, 451.177),
        Offset(1084.578, 477.632),
      ],
    ),
    // id 440: B7 L16
    Phase2LotAnnotation(
      id: 440,
      categoryId: 527,
      name: 'B7 L16',
      bbox: Rect.fromLTWH(1061.65, 479.4, 24.65, 30.36),
      points: [
        Offset(1062.139, 509.761),
        Offset(1086.305, 505.235),
        Offset(1085.677, 479.401),
        Offset(1061.651, 483.306),
        Offset(1062.139, 509.761),
      ],
    ),
    // id 439: B7 L17
    Phase2LotAnnotation(
      id: 439,
      categoryId: 528,
      name: 'B7 L17',
      bbox: Rect.fromLTWH(1060.34, 451.5, 24.03, 29.46),
      points: [
        Offset(1060.971, 480.959),
        Offset(1084.367, 477.323),
        Offset(1083.385, 451.503),
        Offset(1070.637, 453.206),
        Offset(1060.338, 454.729),
        Offset(1060.971, 480.959),
      ],
    ),
    // id 442: B7 L18
    Phase2LotAnnotation(
      id: 442,
      categoryId: 529,
      name: 'B7 L18',
      bbox: Rect.fromLTWH(1036.91, 484.03, 25.25, 27.96),
      points: [
        Offset(1037.575, 511.991),
        Offset(1062.153, 509.565),
        Offset(1061.187, 484.028),
        Offset(1036.907, 486.462),
        Offset(1037.575, 511.991),
      ],
    ),
    // id 441: B7 L19
    Phase2LotAnnotation(
      id: 441,
      categoryId: 530,
      name: 'B7 L19',
      bbox: Rect.fromLTWH(1037.14, 454.63, 24.2, 29.26),
      points: [
        Offset(1037.296, 483.886),
        Offset(1061.347, 480.959),
        Offset(1060.341, 454.631),
        Offset(1037.142, 457.293),
        Offset(1037.296, 483.886),
      ],
    ),
    // id 444: B7 L20
    Phase2LotAnnotation(
      id: 444,
      categoryId: 532,
      name: 'B7 L20',
      bbox: Rect.fromLTWH(1012.12, 486.21, 25.29, 27.83),
      points: [
        Offset(1012.118, 514.039),
        Offset(1037.39, 512.174),
        Offset(1037.406, 486.213),
        Offset(1012.913, 487.638),
        Offset(1012.118, 514.039),
      ],
    ),
    // id 443: B7 L21
    Phase2LotAnnotation(
      id: 443,
      categoryId: 533,
      name: 'B7 L21',
      bbox: Rect.fromLTWH(1012.96, 457.71, 23.8, 28.4),
      points: [
        Offset(1012.962, 486.11),
        Offset(1036.764, 484.456),
        Offset(1036.576, 457.714),
        Offset(1013.384, 459.175),
        Offset(1012.962, 486.11),
      ],
    ),
    // id 445: B7 L22
    Phase2LotAnnotation(
      id: 445,
      categoryId: 534,
      name: 'B7 L22',
      bbox: Rect.fromLTWH(987.64, 488.37, 25.24, 27.46),
      points: [
        Offset(987.637, 515.83),
        Offset(1012.228, 514.061),
        Offset(1012.875, 488.371),
        Offset(988.684, 489.52),
        Offset(987.637, 515.83),
      ],
    ),
    // id 446: B7 L23
    Phase2LotAnnotation(
      id: 446,
      categoryId: 535,
      name: 'B7 L23',
      bbox: Rect.fromLTWH(989.39, 459.52, 24.36, 27.19),
      points: [
        Offset(989.39, 486.709),
        Offset(1013.322, 486.165),
        Offset(1013.746, 459.515),
        Offset(990.566, 460.586),
        Offset(989.39, 486.709),
      ],
    ),
    // id 448: B7 L24
    Phase2LotAnnotation(
      id: 448,
      categoryId: 536,
      name: 'B7 L24',
      bbox: Rect.fromLTWH(963.22, 489.11, 26.34, 27.13),
      points: [
        Offset(963.217, 516.244),
        Offset(987.306, 515.521),
        Offset(989.561, 489.111),
        Offset(964.749, 490.121),
        Offset(963.217, 516.244),
      ],
    ),
    // id 447: B7 L25
    Phase2LotAnnotation(
      id: 447,
      categoryId: 537,
      name: 'B7 L25',
      bbox: Rect.fromLTWH(965.83, 461.05, 24.06, 26.32),
      points: [
        Offset(965.834, 487.375),
        Offset(989.083, 486.613),
        Offset(989.89, 461.053),
        Offset(967.815, 461.53),
        Offset(965.834, 487.375),
      ],
    ),
    // id 401: B8 L1
    Phase2LotAnnotation(
      id: 401,
      categoryId: 545,
      name: 'B8 L1',
      bbox: Rect.fromLTWH(937.71, 461.41, 25.89, 26.03),
      points: [
        Offset(940.159, 461.412),
        Offset(937.708, 487.446),
        Offset(961.149, 487.239),
        Offset(963.595, 461.859),
        Offset(940.159, 461.412),
      ],
    ),
    // id 402: B8 L2
    Phase2LotAnnotation(
      id: 402,
      categoryId: 555,
      name: 'B8 L2',
      bbox: Rect.fromLTWH(933.42, 489.72, 27.21, 26.67),
      points: [
        Offset(937.075, 489.722),
        Offset(933.416, 516.394),
        Offset(958.586, 515.386),
        Offset(960.629, 490.875),
        Offset(937.075, 489.722),
      ],
    ),
    // id 403: B8 L3
    Phase2LotAnnotation(
      id: 403,
      categoryId: 562,
      name: 'B8 L3',
      bbox: Rect.fromLTWH(913.18, 460.71, 26.26, 26.3),
      points: [
        Offset(916.95, 460.706),
        Offset(913.175, 486.21),
        Offset(937.317, 487.002),
        Offset(939.437, 461.524),
        Offset(916.95, 460.706),
      ],
    ),
    // id 404: B8 L4
    Phase2LotAnnotation(
      id: 404,
      categoryId: 563,
      name: 'B8 L4',
      bbox: Rect.fromLTWH(908.89, 488.98, 27.9, 26.13),
      points: [
        Offset(912.771, 488.979),
        Offset(908.892, 513.637),
        Offset(933.532, 515.111),
        Offset(936.792, 489.315),
        Offset(912.771, 488.979),
      ],
    ),
    // id 405: B8 L5
    Phase2LotAnnotation(
      id: 405,
      categoryId: 564,
      name: 'B8 L5',
      bbox: Rect.fromLTWH(889.86, 459.45, 26.34, 26.46),
      points: [
        Offset(894.297, 459.447),
        Offset(889.863, 484.412),
        Offset(913.328, 485.907),
        Offset(916.199, 460.551),
        Offset(894.297, 459.447),
      ],
    ),
    // id 406: B8 L6
    Phase2LotAnnotation(
      id: 406,
      categoryId: 565,
      name: 'B8 L6',
      bbox: Rect.fromLTWH(883.82, 487.41, 28.32, 25.86),
      points: [
        Offset(889.128, 487.413),
        Offset(883.819, 511.575),
        Offset(909.039, 513.268),
        Offset(912.14, 488.696),
        Offset(889.128, 487.413),
      ],
    ),
    // id 407: B8 L7
    Phase2LotAnnotation(
      id: 407,
      categoryId: 566,
      name: 'B8 L7',
      bbox: Rect.fromLTWH(865.09, 456.59, 28.56, 27.22),
      points: [
        Offset(871.238, 456.589),
        Offset(865.089, 481.366),
        Offset(888.385, 483.81),
        Offset(893.646, 458.917),
        Offset(871.238, 456.589),
      ],
    ),
    // id 408: B8 L8
    Phase2LotAnnotation(
      id: 408,
      categoryId: 567,
      name: 'B8 L8',
      bbox: Rect.fromLTWH(858.74, 484, 29.68, 27.22),
      points: [
        Offset(864.112, 483.996),
        Offset(858.735, 508.753),
        Offset(883.831, 511.216),
        Offset(888.416, 486.7),
        Offset(864.112, 483.996),
      ],
    ),
    // id 409: B8 L9
    Phase2LotAnnotation(
      id: 409,
      categoryId: 568,
      name: 'B8 L9',
      bbox: Rect.fromLTWH(841.52, 453.49, 28.6, 27.24),
      points: [
        Offset(847.715, 453.492),
        Offset(841.515, 477.677),
        Offset(865.104, 480.732),
        Offset(870.112, 456.629),
        Offset(847.715, 453.492),
      ],
    ),
    // id 410: B8 L10
    Phase2LotAnnotation(
      id: 410,
      categoryId: 546,
      name: 'B8 L10',
      bbox: Rect.fromLTWH(835.2, 480.89, 28.25, 27.3),
      points: [
        Offset(840.652, 480.893),
        Offset(835.197, 504.933),
        Offset(857.762, 508.194),
        Offset(863.444, 484.221),
        Offset(840.652, 480.893),
      ],
    ),
    // id 411: B8 L11
    Phase2LotAnnotation(
      id: 411,
      categoryId: 547,
      name: 'B8 L11',
      bbox: Rect.fromLTWH(818.13, 449.63, 29.1, 27.45),
      points: [
        Offset(824.926, 449.625),
        Offset(818.134, 473.956),
        Offset(840.755, 477.077),
        Offset(847.231, 452.706),
        Offset(824.926, 449.625),
      ],
    ),
    // id 412: B8 L12
    Phase2LotAnnotation(
      id: 412,
      categoryId: 548,
      name: 'B8 L12',
      bbox: Rect.fromLTWH(809.91, 476.89, 31.11, 27.91),
      points: [
        Offset(809.909, 500.421),
        Offset(834.206, 504.807),
        Offset(841.016, 481.501),
        Offset(816.506, 476.894),
        Offset(809.909, 500.421),
      ],
    ),
    // id 414: B8 L14
    Phase2LotAnnotation(
      id: 414,
      categoryId: 549,
      name: 'B8 L14',
      bbox: Rect.fromLTWH(785.37, 472.38, 30.63, 28.03),
      points: [
        Offset(785.371, 496.35),
        Offset(809.52, 500.408),
        Offset(816.003, 477.391),
        Offset(793.645, 472.377),
        Offset(785.371, 496.35),
      ],
    ),
    // id 413: B8 L15
    Phase2LotAnnotation(
      id: 413,
      categoryId: 550,
      name: 'B8 L15',
      bbox: Rect.fromLTWH(794, 444.2, 30.68, 29.51),
      points: [
        Offset(802.027, 444.196),
        Offset(794.002, 468.973),
        Offset(817.729, 473.707),
        Offset(824.677, 449.438),
        Offset(802.027, 444.196),
      ],
    ),
    // id 416: B8 L16
    Phase2LotAnnotation(
      id: 416,
      categoryId: 551,
      name: 'B8 L16',
      bbox: Rect.fromLTWH(761.39, 466.2, 32.17, 28.86),
      points: [
        Offset(761.393, 489.679),
        Offset(785.747, 495.062),
        Offset(793.564, 472.382),
        Offset(769.961, 466.2),
        Offset(761.393, 489.679),
      ],
    ),
    // id 415: B8 L17
    Phase2LotAnnotation(
      id: 415,
      categoryId: 552,
      name: 'B8 L17',
      bbox: Rect.fromLTWH(770.91, 439.36, 31.59, 29.23),
      points: [
        Offset(770.907, 462.477),
        Offset(793.775, 468.587),
        Offset(802.5, 444.223),
        Offset(779.182, 439.355),
        Offset(770.907, 462.477),
      ],
    ),
    // id 418: B8 L18
    Phase2LotAnnotation(
      id: 418,
      categoryId: 553,
      name: 'B8 L18',
      bbox: Rect.fromLTWH(737.64, 459.71, 31.97, 29.51),
      points: [
        Offset(737.643, 482.892),
        Offset(761.184, 489.216),
        Offset(769.615, 465.586),
        Offset(747.274, 459.708),
        Offset(737.643, 482.892),
      ],
    ),
    // id 417: B8 L19
    Phase2LotAnnotation(
      id: 417,
      categoryId: 554,
      name: 'B8 L19',
      bbox: Rect.fromLTWH(748.24, 432.98, 31.49, 29.1),
      points: [
        Offset(748.241, 456.104),
        Offset(770.701, 462.083),
        Offset(779.733, 439.082),
        Offset(757.868, 432.981),
        Offset(748.241, 456.104),
      ],
    ),
    // id 420: B8 L20
    Phase2LotAnnotation(
      id: 420,
      categoryId: 556,
      name: 'B8 L20',
      bbox: Rect.fromLTWH(712.68, 451.85, 33.52, 30.06),
      points: [
        Offset(712.68, 474.654),
        Offset(736.349, 481.907),
        Offset(746.199, 458.471),
        Offset(722.938, 451.845),
        Offset(712.68, 474.654),
      ],
    ),
    // id 419: B8 L21
    Phase2LotAnnotation(
      id: 419,
      categoryId: 557,
      name: 'B8 L21',
      bbox: Rect.fromLTWH(724.73, 425.25, 33.03, 30.95),
      points: [
        Offset(724.726, 448.598),
        Offset(747.472, 456.196),
        Offset(757.759, 433.169),
        Offset(736.084, 425.25),
        Offset(724.726, 448.598),
      ],
    ),
    // id 422: B8 L22
    Phase2LotAnnotation(
      id: 422,
      categoryId: 558,
      name: 'B8 L22',
      bbox: Rect.fromLTWH(685.25, 442.57, 38.12, 31.77),
      points: [
        Offset(685.25, 464.888),
        Offset(712.22, 474.348),
        Offset(723.368, 450.971),
        Offset(698.508, 442.574),
        Offset(685.25, 464.888),
      ],
    ),
    // id 421: B8 L23
    Phase2LotAnnotation(
      id: 421,
      categoryId: 559,
      name: 'B8 L23',
      bbox: Rect.fromLTWH(700.28, 416.75, 35.84, 32.16),
      points: [
        Offset(700.276, 439.209),
        Offset(723.891, 448.909),
        Offset(736.112, 424.669),
        Offset(722.906, 421.123),
        Offset(713.204, 416.751),
        Offset(700.276, 439.209),
      ],
    ),
    // id 424: B8 L24
    Phase2LotAnnotation(
      id: 424,
      categoryId: 560,
      name: 'B8 L24',
      bbox: Rect.fromLTWH(645.96, 424.07, 52.64, 40.77),
      points: [
        Offset(646.523, 437.944),
        Offset(645.963, 442.927),
        Offset(648.159, 448.24),
        Offset(651.851, 451.362),
        Offset(656.2, 454.632),
        Offset(685.546, 464.837),
        Offset(698.604, 442.584),
        Offset(680.677, 436.123),
        Offset(652.143, 424.07),
        Offset(646.523, 437.944),
      ],
    ),
    // id 423: B8 L25
    Phase2LotAnnotation(
      id: 423,
      categoryId: 561,
      name: 'B8 L25',
      bbox: Rect.fromLTWH(653.14, 402.38, 60.4, 37.49),
      points: [
        Offset(694.687, 408.541),
        Offset(673.373, 402.692),
        Offset(664.644, 402.381),
        Offset(658.752, 405.771),
        Offset(653.144, 421.56),
        Offset(674.877, 430.935),
        Offset(699.529, 439.868),
        Offset(713.544, 416.098),
        Offset(694.687, 408.541),
      ],
    ),
    // id 369: B9 L1
    Phase2LotAnnotation(
      id: 369,
      categoryId: 569,
      name: 'B9 L1',
      bbox: Rect.fromLTWH(1276.44, 465.27, 84.43, 55.38),
      points: [
        Offset(1289.228, 515.572),
        Offset(1331.026, 516.612),
        Offset(1360.873, 520.652),
        Offset(1303.889, 465.379),
        Offset(1293.081, 465.272),
        Offset(1276.439, 472.928),
        Offset(1289.228, 515.572),
      ],
    ),
    // id 370: B9 L2
    Phase2LotAnnotation(
      id: 370,
      categoryId: 578,
      name: 'B9 L2',
      bbox: Rect.fromLTWH(1335.33, 520.54, 42.9, 32.11),
      points: [
        Offset(1335.327, 547.826),
        Offset(1362.508, 552.101),
        Offset(1370.534, 552.646),
        Offset(1376.382, 549.78),
        Offset(1378.2, 545.49),
        Offset(1378.226, 537.59),
        Offset(1364.496, 524.108),
        Offset(1340.494, 520.54),
        Offset(1335.327, 547.826),
      ],
    ),
    // id 371: B9 L3
    Phase2LotAnnotation(
      id: 371,
      categoryId: 589,
      name: 'B9 L3',
      bbox: Rect.fromLTWH(1312.09, 518.63, 28.4, 29.07),
      points: [
        Offset(1316.103, 518.629),
        Offset(1312.089, 545.872),
        Offset(1335.538, 547.696),
        Offset(1340.494, 520.294),
        Offset(1316.103, 518.629),
      ],
    ),
    // id 372: B9 L4
    Phase2LotAnnotation(
      id: 372,
      categoryId: 594,
      name: 'B9 L4',
      bbox: Rect.fromLTWH(1287.91, 517.95, 27.55, 27.82),
      points: [
        Offset(1289.925, 517.954),
        Offset(1287.911, 545.469),
        Offset(1312.217, 545.777),
        Offset(1315.461, 518.085),
        Offset(1289.925, 517.954),
      ],
    ),
    // id 373: B9 L5
    Phase2LotAnnotation(
      id: 373,
      categoryId: 595,
      name: 'B9 L5',
      bbox: Rect.fromLTWH(1255.73, 472.93, 33.75, 43.22),
      points: [
        Offset(1255.726, 481.96),
        Offset(1265.109, 516.147),
        Offset(1289.481, 514.984),
        Offset(1276.439, 472.928),
        Offset(1255.726, 481.96),
      ],
    ),
    // id 374: B9 L6
    Phase2LotAnnotation(
      id: 374,
      categoryId: 596,
      name: 'B9 L6',
      bbox: Rect.fromLTWH(1264.31, 517.84, 25.62, 29.08),
      points: [
        Offset(1264.507, 518.472),
        Offset(1264.313, 546.916),
        Offset(1288.271, 545.376),
        Offset(1289.937, 517.84),
        Offset(1264.507, 518.472),
      ],
    ),
    // id 375: B9 L7
    Phase2LotAnnotation(
      id: 375,
      categoryId: 597,
      name: 'B9 L7',
      bbox: Rect.fromLTWH(1234.87, 481.76, 30.49, 37.77),
      points: [
        Offset(1234.874, 489.916),
        Offset(1242.324, 519.536),
        Offset(1265.367, 516.116),
        Offset(1255.823, 481.763),
        Offset(1234.874, 489.916),
      ],
    ),
    // id 376: B9 L8
    Phase2LotAnnotation(
      id: 376,
      categoryId: 598,
      name: 'B9 L8',
      bbox: Rect.fromLTWH(1239.43, 518.97, 25.57, 31.32),
      points: [
        Offset(1239.429, 522.52),
        Offset(1241.997, 550.288),
        Offset(1265.002, 546.052),
        Offset(1264.193, 518.971),
        Offset(1239.429, 522.52),
      ],
    ),
    // id 377: B9 L9
    Phase2LotAnnotation(
      id: 377,
      categoryId: 599,
      name: 'B9 L9',
      bbox: Rect.fromLTWH(1213.33, 489.86, 29.54, 34.54),
      points: [
        Offset(1213.331, 497.246),
        Offset(1219.205, 524.405),
        Offset(1242.874, 519.762),
        Offset(1234.226, 489.862),
        Offset(1213.331, 497.246),
      ],
    ),
    // id 378: B9 L10
    Phase2LotAnnotation(
      id: 378,
      categoryId: 570,
      name: 'B9 L10',
      bbox: Rect.fromLTWH(1214.6, 522.9, 27.44, 32.42),
      points: [
        Offset(1214.602, 528.061),
        Offset(1218.606, 555.32),
        Offset(1242.04, 550.14),
        Offset(1238.988, 522.896),
        Offset(1214.602, 528.061),
      ],
    ),
    // id 379: B9 L11
    Phase2LotAnnotation(
      id: 379,
      categoryId: 571,
      name: 'B9 L11',
      bbox: Rect.fromLTWH(1192.58, 497.47, 26.82, 33.26),
      points: [
        Offset(1192.575, 504.422),
        Offset(1197.357, 530.726),
        Offset(1219.39, 524.078),
        Offset(1213.12, 497.47),
        Offset(1192.575, 504.422),
      ],
    ),
    // id 380: B9 L12
    Phase2LotAnnotation(
      id: 380,
      categoryId: 572,
      name: 'B9 L12',
      bbox: Rect.fromLTWH(1191.95, 528.39, 26.94, 33.6),
      points: [
        Offset(1191.947, 534.826),
        Offset(1196.603, 561.993),
        Offset(1218.89, 554.763),
        Offset(1214.838, 528.393),
        Offset(1191.947, 534.826),
      ],
    ),
    // id 381: B9 L14
    Phase2LotAnnotation(
      id: 381,
      categoryId: 573,
      name: 'B9 L14',
      bbox: Rect.fromLTWH(1169.06, 535.27, 27.57, 32.04),
      points: [
        Offset(1169.055, 541.092),
        Offset(1173.868, 567.304),
        Offset(1196.629, 561.52),
        Offset(1191.277, 535.265),
        Offset(1169.055, 541.092),
      ],
    ),
    // id 382: B9 L15
    Phase2LotAnnotation(
      id: 382,
      categoryId: 574,
      name: 'B9 L15',
      bbox: Rect.fromLTWH(1170.49, 504.59, 27.14, 33.14),
      points: [
        Offset(1170.495, 509.987),
        Offset(1174.86, 537.728),
        Offset(1197.633, 531.197),
        Offset(1191.768, 504.587),
        Offset(1170.495, 509.987),
      ],
    ),
    // id 383: B9 L17
    Phase2LotAnnotation(
      id: 383,
      categoryId: 575,
      name: 'B9 L17',
      bbox: Rect.fromLTWH(1149.1, 510.23, 25.88, 33.3),
      points: [
        Offset(1149.097, 516.249),
        Offset(1152.688, 543.533),
        Offset(1174.973, 536.826),
        Offset(1170.171, 510.232),
        Offset(1149.097, 516.249),
      ],
    ),
    // id 384: B9 L18
    Phase2LotAnnotation(
      id: 384,
      categoryId: 576,
      name: 'B9 L18',
      bbox: Rect.fromLTWH(1148.44, 540.66, 25.66, 32.85),
      points: [
        Offset(1148.439, 546.494),
        Offset(1150.698, 573.514),
        Offset(1174.097, 567.754),
        Offset(1170.171, 540.664),
        Offset(1148.439, 546.494),
      ],
    ),
    // id 386: B9 L18
    Phase2LotAnnotation(
      id: 386,
      categoryId: 576,
      name: 'B9 L18',
      bbox: Rect.fromLTWH(1126.49, 546.81, 25.16, 31.36),
      points: [
        Offset(1128.573, 578.169),
        Offset(1151.642, 573.184),
        Offset(1148.813, 546.806),
        Offset(1126.486, 549.745),
        Offset(1128.573, 578.169),
      ],
    ),
    // id 385: B9 L19
    Phase2LotAnnotation(
      id: 385,
      categoryId: 577,
      name: 'B9 L19',
      bbox: Rect.fromLTWH(1127.69, 515.88, 24.63, 32.79),
      points: [
        Offset(1127.689, 520.768),
        Offset(1129.686, 548.67),
        Offset(1152.317, 543.07),
        Offset(1149.556, 515.877),
        Offset(1127.689, 520.768),
      ],
    ),
    // id 387: B9 L20
    Phase2LotAnnotation(
      id: 387,
      categoryId: 579,
      name: 'B9 L20',
      bbox: Rect.fromLTWH(1104.18, 550.48, 24.83, 31.38),
      points: [
        Offset(1104.175, 554.686),
        Offset(1105.605, 581.862),
        Offset(1129, 578.35),
        Offset(1126.241, 550.481),
        Offset(1104.175, 554.686),
      ],
    ),
    // id 389: B9 L21
    Phase2LotAnnotation(
      id: 389,
      categoryId: 580,
      name: 'B9 L21',
      bbox: Rect.fromLTWH(1105.95, 520.79, 23.41, 31.71),
      points: [
        Offset(1105.954, 525.56),
        Offset(1107.21, 552.493),
        Offset(1129.364, 548.317),
        Offset(1127.468, 520.785),
        Offset(1105.954, 525.56),
      ],
    ),
    // id 388: B9 L22
    Phase2LotAnnotation(
      id: 388,
      categoryId: 581,
      name: 'B9 L22',
      bbox: Rect.fromLTWH(1081.93, 554.9, 23.76, 31.56),
      points: [
        Offset(1081.933, 558.3),
        Offset(1082.641, 586.456),
        Offset(1105.691, 582.08),
        Offset(1103.907, 554.899),
        Offset(1081.933, 558.3),
      ],
    ),
    // id 390: B9 L23
    Phase2LotAnnotation(
      id: 390,
      categoryId: 582,
      name: 'B9 L23',
      bbox: Rect.fromLTWH(1083.25, 525.69, 23.7, 30.51),
      points: [
        Offset(1083.246, 529.338),
        Offset(1084.785, 556.209),
        Offset(1106.945, 552.242),
        Offset(1105.625, 525.694),
        Offset(1083.246, 529.338),
      ],
    ),
    // id 392: B9 L24
    Phase2LotAnnotation(
      id: 392,
      categoryId: 583,
      name: 'B9 L24',
      bbox: Rect.fromLTWH(1059.61, 559.57, 23.4, 28.93),
      points: [
        Offset(1059.607, 561.797),
        Offset(1060.304, 588.495),
        Offset(1083.006, 585.985),
        Offset(1081.635, 559.565),
        Offset(1059.607, 561.797),
      ],
    ),
    // id 391: B9 L25
    Phase2LotAnnotation(
      id: 391,
      categoryId: 584,
      name: 'B9 L25',
      bbox: Rect.fromLTWH(1061.15, 529.38, 22.66, 30.53),
      points: [
        Offset(1061.152, 532.245),
        Offset(1061.9, 559.91),
        Offset(1083.811, 556.429),
        Offset(1083.046, 529.375),
        Offset(1061.152, 532.245),
      ],
    ),
    // id 394: B9 L26
    Phase2LotAnnotation(
      id: 394,
      categoryId: 585,
      name: 'B9 L26',
      bbox: Rect.fromLTWH(1036.89, 561.53, 23.05, 28.66),
      points: [
        Offset(1036.89, 564.392),
        Offset(1036.988, 590.189),
        Offset(1059.944, 588.36),
        Offset(1059.731, 561.525),
        Offset(1036.89, 564.392),
      ],
    ),
    // id 393: B9 L27
    Phase2LotAnnotation(
      id: 393,
      categoryId: 586,
      name: 'B9 L27',
      bbox: Rect.fromLTWH(1039.08, 532.32, 22.96, 30.42),
      points: [
        Offset(1039.075, 534.728),
        Offset(1039.315, 562.745),
        Offset(1062.034, 560.138),
        Offset(1060.958, 532.32),
        Offset(1039.075, 534.728),
      ],
    ),
    // id 395: B9 L28
    Phase2LotAnnotation(
      id: 395,
      categoryId: 587,
      name: 'B9 L28',
      bbox: Rect.fromLTWH(1014.18, 564.47, 23.21, 27.81),
      points: [
        Offset(1014.762, 565.264),
        Offset(1014.184, 592.28),
        Offset(1036.955, 590.988),
        Offset(1037.398, 564.47),
        Offset(1014.762, 565.264),
      ],
    ),
    // id 396: B9 L29
    Phase2LotAnnotation(
      id: 396,
      categoryId: 588,
      name: 'B9 L29',
      bbox: Rect.fromLTWH(1015.64, 534.83, 23.26, 28.54),
      points: [
        Offset(1038.904, 534.833),
        Offset(1016.778, 536.275),
        Offset(1015.642, 563.377),
        Offset(1038.378, 562.224),
        Offset(1038.904, 534.833),
      ],
    ),
    // id 398: B9 L30
    Phase2LotAnnotation(
      id: 398,
      categoryId: 590,
      name: 'B9 L30',
      bbox: Rect.fromLTWH(991.02, 565.7, 23.31, 28.52),
      points: [
        Offset(991.863, 566.712),
        Offset(991.021, 594.213),
        Offset(1013.539, 592.75),
        Offset(1014.328, 565.697),
        Offset(991.863, 566.712),
      ],
    ),
    // id 397: B9 L31
    Phase2LotAnnotation(
      id: 397,
      categoryId: 591,
      name: 'B9 L31',
      bbox: Rect.fromLTWH(993.21, 536.74, 23.33, 28),
      points: [
        Offset(994.224, 537.357),
        Offset(993.209, 564.734),
        Offset(1015.746, 563.548),
        Offset(1016.537, 536.737),
        Offset(994.224, 537.357),
      ],
    ),
    // id 400: B9 L32
    Phase2LotAnnotation(
      id: 400,
      categoryId: 592,
      name: 'B9 L32',
      bbox: Rect.fromLTWH(968.04, 567.08, 24.12, 27.62),
      points: [
        Offset(968.04, 594.698),
        Offset(990.693, 593.995),
        Offset(992.157, 567.083),
        Offset(969.416, 567.415),
        Offset(968.04, 594.698),
      ],
    ),
    // id 399: B9 L33
    Phase2LotAnnotation(
      id: 399,
      categoryId: 593,
      name: 'B9 L33',
      bbox: Rect.fromLTWH(970.51, 537.87, 23.27, 27.45),
      points: [
        Offset(971.738, 538.684),
        Offset(970.505, 565.319),
        Offset(993.326, 564.601),
        Offset(993.776, 537.865),
        Offset(971.738, 538.684),
      ],
    ),
    // id 339: B10 L1
    Phase2LotAnnotation(
      id: 339,
      categoryId: 2,
      name: 'B10 L1',
      bbox: Rect.fromLTWH(943.05, 537.83, 25.54, 27.51),
      points: [
        Offset(943.05, 565.346),
        Offset(966.092, 565.327),
        Offset(968.587, 537.982),
        Offset(946.718, 537.831),
        Offset(943.05, 565.346),
      ],
    ),
    // id 340: B10 L2
    Phase2LotAnnotation(
      id: 340,
      categoryId: 12,
      name: 'B10 L2',
      bbox: Rect.fromLTWH(940.1, 567.73, 25.64, 26.12),
      points: [
        Offset(940.102, 593.654),
        Offset(964.118, 593.857),
        Offset(965.741, 567.75),
        Offset(942.911, 567.734),
        Offset(940.102, 593.654),
      ],
    ),
    // id 341: B10 L3
    Phase2LotAnnotation(
      id: 341,
      categoryId: 23,
      name: 'B10 L3',
      bbox: Rect.fromLTWH(920.47, 537.55, 25.39, 27.82),
      points: [
        Offset(920.471, 564.971),
        Offset(943.634, 565.363),
        Offset(945.857, 538.276),
        Offset(923.531, 537.548),
        Offset(920.471, 564.971),
      ],
    ),
    // id 342: B10 L4
    Phase2LotAnnotation(
      id: 342,
      categoryId: 26,
      name: 'B10 L4',
      bbox: Rect.fromLTWH(916.06, 566.67, 26.68, 27.36),
      points: [
        Offset(916.064, 592.929),
        Offset(939.723, 594.034),
        Offset(942.747, 567.222),
        Offset(920.138, 566.674),
        Offset(916.064, 592.929),
      ],
    ),
    // id 343: B10 L5
    Phase2LotAnnotation(
      id: 343,
      categoryId: 27,
      name: 'B10 L5',
      bbox: Rect.fromLTWH(897.65, 536.5, 25.83, 27.37),
      points: [
        Offset(901.685, 536.497),
        Offset(897.65, 563.043),
        Offset(920.215, 563.87),
        Offset(923.476, 537.422),
        Offset(901.685, 536.497),
      ],
    ),
    // id 344: B10 L6
    Phase2LotAnnotation(
      id: 344,
      categoryId: 28,
      name: 'B10 L6',
      bbox: Rect.fromLTWH(891.94, 565.68, 27.91, 27.36),
      points: [
        Offset(891.937, 591.896),
        Offset(916.202, 593.034),
        Offset(919.845, 565.889),
        Offset(897.222, 565.677),
        Offset(891.937, 591.896),
      ],
    ),
    // id 345: B10 L7
    Phase2LotAnnotation(
      id: 345,
      categoryId: 29,
      name: 'B10 L7',
      bbox: Rect.fromLTWH(874.72, 534.72, 26.83, 27.68),
      points: [
        Offset(874.718, 561.22),
        Offset(897.234, 562.396),
        Offset(901.544, 536.297),
        Offset(879.984, 534.72),
        Offset(874.718, 561.22),
      ],
    ),
    // id 346: B10 L8
    Phase2LotAnnotation(
      id: 346,
      categoryId: 30,
      name: 'B10 L8',
      bbox: Rect.fromLTWH(867.96, 563.56, 28.6, 27.92),
      points: [
        Offset(867.958, 588.974),
        Offset(892.17, 591.479),
        Offset(896.558, 565.358),
        Offset(873.198, 563.563),
        Offset(867.958, 588.974),
      ],
    ),
    // id 347: B10 L9
    Phase2LotAnnotation(
      id: 347,
      categoryId: 31,
      name: 'B10 L9',
      bbox: Rect.fromLTWH(851.43, 532.18, 27.89, 27.97),
      points: [
        Offset(851.425, 558.14),
        Offset(874.214, 560.143),
        Offset(879.318, 533.994),
        Offset(857.363, 532.176),
        Offset(851.425, 558.14),
      ],
    ),
    // id 348: B10 L10
    Phase2LotAnnotation(
      id: 348,
      categoryId: 3,
      name: 'B10 L10',
      bbox: Rect.fromLTWH(844.68, 560.88, 28.88, 27.94),
      points: [
        Offset(844.679, 586.067),
        Offset(868.285, 588.823),
        Offset(873.554, 562.916),
        Offset(850.54, 560.878),
        Offset(844.679, 586.067),
      ],
    ),
    // id 349: B10 L11
    Phase2LotAnnotation(
      id: 349,
      categoryId: 4,
      name: 'B10 L11',
      bbox: Rect.fromLTWH(828.9, 529.12, 28.32, 28.7),
      points: [
        Offset(828.899, 554.602),
        Offset(851.057, 557.824),
        Offset(857.223, 531.622),
        Offset(835.556, 529.119),
        Offset(828.899, 554.602),
      ],
    ),
    // id 350: B10 L12
    Phase2LotAnnotation(
      id: 350,
      categoryId: 5,
      name: 'B10 L12',
      bbox: Rect.fromLTWH(821.06, 556.78, 29.19, 29),
      points: [
        Offset(821.056, 582.724),
        Offset(843.998, 585.773),
        Offset(850.245, 560.258),
        Offset(828.237, 556.777),
        Offset(821.056, 582.724),
      ],
    ),
    // id 351: B10 L14
    Phase2LotAnnotation(
      id: 351,
      categoryId: 6,
      name: 'B10 L14',
      bbox: Rect.fromLTWH(797.93, 552.82, 29.6, 29.58),
      points: [
        Offset(797.931, 578.376),
        Offset(821.215, 582.398),
        Offset(827.53, 556.874),
        Offset(804.767, 552.818),
        Offset(797.931, 578.376),
      ],
    ),
    // id 352: B10 L15
    Phase2LotAnnotation(
      id: 352,
      categoryId: 7,
      name: 'B10 L15',
      bbox: Rect.fromLTWH(805.71, 525.11, 29.19, 28.76),
      points: [
        Offset(805.709, 550.064),
        Offset(828.935, 553.869),
        Offset(834.9, 528.675),
        Offset(813.816, 525.106),
        Offset(805.709, 550.064),
      ],
    ),
    // id 354: B10 L16
    Phase2LotAnnotation(
      id: 354,
      categoryId: 8,
      name: 'B10 L16',
      bbox: Rect.fromLTWH(774.02, 548.58, 30.55, 29.19),
      points: [
        Offset(774.019, 573.523),
        Offset(797.133, 577.77),
        Offset(804.572, 552.869),
        Offset(782.145, 548.576),
        Offset(774.019, 573.523),
      ],
    ),
    // id 353: B10 L17
    Phase2LotAnnotation(
      id: 353,
      categoryId: 9,
      name: 'B10 L17',
      bbox: Rect.fromLTWH(783.45, 520.58, 29.55, 29.2),
      points: [
        Offset(783.449, 545.952),
        Offset(805.175, 549.785),
        Offset(813.001, 524.482),
        Offset(791.76, 520.582),
        Offset(783.449, 545.952),
      ],
    ),
    // id 356: B10 L18
    Phase2LotAnnotation(
      id: 356,
      categoryId: 10,
      name: 'B10 L18',
      bbox: Rect.fromLTWH(751.5, 541.79, 30.91, 30.9),
      points: [
        Offset(751.498, 568.122),
        Offset(774.199, 572.688),
        Offset(782.41, 548.115),
        Offset(760.372, 541.79),
        Offset(751.498, 568.122),
      ],
    ),
    // id 355: B10 L19
    Phase2LotAnnotation(
      id: 355,
      categoryId: 11,
      name: 'B10 L19',
      bbox: Rect.fromLTWH(761, 515.49, 30.85, 30.07),
      points: [
        Offset(760.998, 540.686),
        Offset(783.693, 545.562),
        Offset(791.853, 520.362),
        Offset(769.986, 515.492),
        Offset(760.998, 540.686),
      ],
    ),
    // id 358: B10 L20
    Phase2LotAnnotation(
      id: 358,
      categoryId: 13,
      name: 'B10 L20',
      bbox: Rect.fromLTWH(727.81, 536.98, 31.93, 30.66),
      points: [
        Offset(727.812, 561.745),
        Offset(750.986, 567.646),
        Offset(759.747, 542.567),
        Offset(737.467, 536.983),
        Offset(727.812, 561.745),
      ],
    ),
    // id 357: B10 L21
    Phase2LotAnnotation(
      id: 357,
      categoryId: 14,
      name: 'B10 L21',
      bbox: Rect.fromLTWH(738.91, 510.21, 30.46, 30.1),
      points: [
        Offset(738.914, 534.163),
        Offset(761.037, 540.307),
        Offset(769.378, 515.521),
        Offset(747.98, 510.212),
        Offset(738.914, 534.163),
      ],
    ),
    // id 360: B10 L22
    Phase2LotAnnotation(
      id: 360,
      categoryId: 15,
      name: 'B10 L22',
      bbox: Rect.fromLTWH(704.93, 529.91, 31.89, 30.88),
      points: [
        Offset(704.933, 554.688),
        Offset(727.665, 560.791),
        Offset(736.821, 536.651),
        Offset(715.694, 529.913),
        Offset(704.933, 554.688),
      ],
    ),
    // id 359: B10 L23
    Phase2LotAnnotation(
      id: 359,
      categoryId: 16,
      name: 'B10 L23',
      bbox: Rect.fromLTWH(716.77, 503.05, 31.51, 31.39),
      points: [
        Offset(716.771, 527.193),
        Offset(738.001, 534.438),
        Offset(748.279, 509.991),
        Offset(727.005, 503.05),
        Offset(716.771, 527.193),
      ],
    ),
    // id 362: B10 L24
    Phase2LotAnnotation(
      id: 362,
      categoryId: 17,
      name: 'B10 L24',
      bbox: Rect.fromLTWH(682.7, 523.27, 32.61, 31.42),
      points: [
        Offset(682.696, 547.282),
        Offset(705.152, 554.695),
        Offset(715.304, 530.282),
        Offset(693.661, 523.273),
        Offset(682.696, 547.282),
      ],
    ),
    // id 361: B10 L25
    Phase2LotAnnotation(
      id: 361,
      categoryId: 18,
      name: 'B10 L25',
      bbox: Rect.fromLTWH(694.68, 496.66, 31.83, 30.94),
      points: [
        Offset(694.677, 520.8),
        Offset(716.451, 527.606),
        Offset(726.508, 503.719),
        Offset(705.71, 496.663),
        Offset(694.677, 520.8),
      ],
    ),
    // id 364: B10 L26
    Phase2LotAnnotation(
      id: 364,
      categoryId: 19,
      name: 'B10 L26',
      bbox: Rect.fromLTWH(659.99, 515.34, 33.44, 31.77),
      points: [
        Offset(659.991, 539.519),
        Offset(682.478, 547.112),
        Offset(693.435, 523.279),
        Offset(672.118, 515.339),
        Offset(659.991, 539.519),
      ],
    ),
    // id 363: B10 L27
    Phase2LotAnnotation(
      id: 363,
      categoryId: 20,
      name: 'B10 L27',
      bbox: Rect.fromLTWH(672.94, 488.91, 32.64, 31.74),
      points: [
        Offset(672.939, 512.91),
        Offset(694.463, 520.65),
        Offset(705.582, 496.578),
        Offset(684.589, 488.912),
        Offset(672.939, 512.91),
      ],
    ),
    // id 365: B10 L28
    Phase2LotAnnotation(
      id: 365,
      categoryId: 21,
      name: 'B10 L28',
      bbox: Rect.fromLTWH(637.88, 506.92, 34.13, 32.76),
      points: [
        Offset(650.272, 506.917),
        Offset(637.875, 530.341),
        Offset(659.947, 539.673),
        Offset(672.004, 515.504),
        Offset(650.272, 506.917),
      ],
    ),
    // id 366: B10 L29
    Phase2LotAnnotation(
      id: 366,
      categoryId: 22,
      name: 'B10 L29',
      bbox: Rect.fromLTWH(651.58, 480.43, 32.89, 32.53),
      points: [
        Offset(651.581, 504.063),
        Offset(672.259, 512.955),
        Offset(684.475, 489.321),
        Offset(663.664, 480.428),
        Offset(651.581, 504.063),
      ],
    ),
    // id 367: B10 L30
    Phase2LotAnnotation(
      id: 367,
      categoryId: 24,
      name: 'B10 L30',
      bbox: Rect.fromLTWH(620.22, 497.12, 29.49, 32.95),
      points: [
        Offset(625.42, 497.121),
        Offset(620.22, 512.146),
        Offset(620.849, 519.907),
        Offset(624.892, 524.818),
        Offset(637.476, 530.068),
        Offset(649.707, 507.147),
        Offset(625.42, 497.121),
      ],
    ),
    // id 368: B10 L31
    Phase2LotAnnotation(
      id: 368,
      categoryId: 25,
      name: 'B10 L31',
      bbox: Rect.fromLTWH(626.94, 473.18, 37.45, 31),
      points: [
        Offset(664.39, 481.161),
        Offset(646.077, 473.777),
        Offset(637.725, 473.177),
        Offset(633.329, 477.096),
        Offset(626.943, 494.411),
        Offset(651.222, 504.181),
        Offset(664.39, 481.161),
      ],
    ),
    // id 242: B11 L1
    Phase2LotAnnotation(
      id: 242,
      categoryId: 32,
      name: 'B11 L1',
      bbox: Rect.fromLTWH(586.46, 547.27, 54.08, 60.01),
      points: [
        Offset(640.538, 555.8),
        Offset(618.515, 547.295),
        Offset(611.172, 547.274),
        Offset(607.511, 549.038),
        Offset(605.028, 553.586),
        Offset(586.461, 603.296),
        Offset(622.103, 607.284),
        Offset(640.538, 555.8),
      ],
    ),
    // id 243: B11 L2
    Phase2LotAnnotation(
      id: 243,
      categoryId: 42,
      name: 'B11 L2',
      bbox: Rect.fromLTWH(567.12, 606, 54.54, 64.61),
      points: [
        Offset(567.116, 656.063),
        Offset(567.264, 661.472),
        Offset(569.72, 665.844),
        Offset(576.554, 670.609),
        Offset(600.037, 670.414),
        Offset(621.655, 609.926),
        Offset(584.732, 605.995),
        Offset(567.116, 656.063),
      ],
    ),
    // id 244: B11 L3
    Phase2LotAnnotation(
      id: 244,
      categoryId: 45,
      name: 'B11 L3',
      bbox: Rect.fromLTWH(622.42, 556.24, 39.29, 54.26),
      points: [
        Offset(646.183, 610.495),
        Offset(661.717, 564.113),
        Offset(640.746, 556.235),
        Offset(622.425, 607.284),
        Offset(646.183, 610.495),
      ],
    ),
    // id 246: B11 L4
    Phase2LotAnnotation(
      id: 246,
      categoryId: 46,
      name: 'B11 L4',
      bbox: Rect.fromLTWH(598.95, 610.83, 46.49, 60.16),
      points: [
        Offset(598.945, 670.854),
        Offset(626.368, 670.987),
        Offset(645.435, 613.363),
        Offset(621.459, 610.827),
        Offset(598.945, 670.854),
      ],
    ),
    // id 245: B11 L5
    Phase2LotAnnotation(
      id: 245,
      categoryId: 47,
      name: 'B11 L5',
      bbox: Rect.fromLTWH(646.88, 564.16, 35.91, 49.67),
      points: [
        Offset(646.881, 610.695),
        Offset(670.267, 613.826),
        Offset(682.795, 570.752),
        Offset(662.09, 564.16),
        Offset(646.881, 610.695),
      ],
    ),
    // id 247: B11 L6
    Phase2LotAnnotation(
      id: 247,
      categoryId: 48,
      name: 'B11 L6',
      bbox: Rect.fromLTWH(627.04, 613.99, 42.39, 56.94),
      points: [
        Offset(627.044, 670.928),
        Offset(652.734, 670.845),
        Offset(669.433, 616.318),
        Offset(645.789, 613.992),
        Offset(627.044, 670.928),
      ],
    ),
    // id 248: B11 L7
    Phase2LotAnnotation(
      id: 248,
      categoryId: 49,
      name: 'B11 L7',
      bbox: Rect.fromLTWH(669.97, 571.85, 34.73, 45.02),
      points: [
        Offset(669.965, 614.451),
        Offset(693.473, 616.869),
        Offset(704.697, 577.581),
        Offset(683.959, 571.845),
        Offset(669.965, 614.451),
      ],
    ),
    // id 249: B11 L8
    Phase2LotAnnotation(
      id: 249,
      categoryId: 50,
      name: 'B11 L8',
      bbox: Rect.fromLTWH(652.69, 616.83, 40.27, 53.81),
      points: [
        Offset(652.69, 670.307),
        Offset(678.866, 670.638),
        Offset(692.958, 619.445),
        Offset(669.567, 616.833),
        Offset(652.69, 670.307),
      ],
    ),
    // id 250: B11 L9
    Phase2LotAnnotation(
      id: 250,
      categoryId: 51,
      name: 'B11 L9',
      bbox: Rect.fromLTWH(693.47, 577.97, 31.68, 41.51),
      points: [
        Offset(693.471, 616.915),
        Offset(716.493, 619.479),
        Offset(725.156, 584.396),
        Offset(704.9, 577.966),
        Offset(693.471, 616.915),
      ],
    ),
    // id 251: B11 L10
    Phase2LotAnnotation(
      id: 251,
      categoryId: 33,
      name: 'B11 L10',
      bbox: Rect.fromLTWH(678.14, 619.97, 37.75, 50.84),
      points: [
        Offset(678.135, 670.792),
        Offset(704.412, 670.811),
        Offset(715.88, 622.077),
        Offset(692.952, 619.973),
        Offset(678.135, 670.792),
      ],
    ),
    // id 252: B11 L11
    Phase2LotAnnotation(
      id: 252,
      categoryId: 34,
      name: 'B11 L11',
      bbox: Rect.fromLTWH(716.82, 584.73, 30.32, 37.49),
      points: [
        Offset(716.823, 620.16),
        Offset(739.917, 622.222),
        Offset(747.143, 589.838),
        Offset(725.519, 584.732),
        Offset(716.823, 620.16),
      ],
    ),
    // id 253: B11 L12
    Phase2LotAnnotation(
      id: 253,
      categoryId: 35,
      name: 'B11 L12',
      bbox: Rect.fromLTWH(704.24, 622.42, 34.9, 48.02),
      points: [
        Offset(704.244, 670.447),
        Offset(729.02, 670.385),
        Offset(739.141, 625.168),
        Offset(715.854, 622.425),
        Offset(704.244, 670.447),
      ],
    ),
    // id 254: B11 L14
    Phase2LotAnnotation(
      id: 254,
      categoryId: 36,
      name: 'B11 L14',
      bbox: Rect.fromLTWH(728.94, 625.33, 34.02, 45.38),
      points: [
        Offset(728.938, 670.703),
        Offset(754.355, 670.331),
        Offset(762.962, 627.939),
        Offset(739.372, 625.325),
        Offset(728.938, 670.703),
      ],
    ),
    // id 255: B11 L15
    Phase2LotAnnotation(
      id: 255,
      categoryId: 37,
      name: 'B11 L15',
      bbox: Rect.fromLTWH(740.43, 589.56, 27.93, 35.5),
      points: [
        Offset(740.434, 622.96),
        Offset(763.086, 625.068),
        Offset(768.368, 594.826),
        Offset(747.426, 589.564),
        Offset(740.434, 622.96),
      ],
    ),
    // id 256: B11 L16
    Phase2LotAnnotation(
      id: 256,
      categoryId: 38,
      name: 'B11 L16',
      bbox: Rect.fromLTWH(754.14, 628.26, 31.3, 42.13),
      points: [
        Offset(761.667, 628.258),
        Offset(754.144, 670.387),
        Offset(779.177, 670.321),
        Offset(785.442, 631.124),
        Offset(761.667, 628.258),
      ],
    ),
    // id 257: B11 L17
    Phase2LotAnnotation(
      id: 257,
      categoryId: 39,
      name: 'B11 L17',
      bbox: Rect.fromLTWH(763.79, 595.69, 26.8, 32.22),
      points: [
        Offset(763.786, 625.225),
        Offset(786.536, 627.905),
        Offset(790.586, 599.881),
        Offset(768.689, 595.686),
        Offset(763.786, 625.225),
      ],
    ),
    // id 258: B11 L18
    Phase2LotAnnotation(
      id: 258,
      categoryId: 40,
      name: 'B11 L18',
      bbox: Rect.fromLTWH(777.85, 631.12, 30.36, 39.79),
      points: [
        Offset(777.849, 670.913),
        Offset(803.826, 670.813),
        Offset(808.205, 633.408),
        Offset(785.764, 631.124),
        Offset(777.849, 670.913),
      ],
    ),
    // id 259: B11 L19
    Phase2LotAnnotation(
      id: 259,
      categoryId: 41,
      name: 'B11 L19',
      bbox: Rect.fromLTWH(786.13, 600.2, 25.97, 30.78),
      points: [
        Offset(786.132, 628.204),
        Offset(809.036, 630.975),
        Offset(812.103, 603.576),
        Offset(790.596, 600.196),
        Offset(786.132, 628.204),
      ],
    ),
    // id 260: B11 L20
    Phase2LotAnnotation(
      id: 260,
      categoryId: 43,
      name: 'B11 L20',
      bbox: Rect.fromLTWH(803.85, 634.02, 28.01, 36.66),
      points: [
        Offset(803.845, 670.681),
        Offset(829.002, 670.601),
        Offset(831.855, 636.733),
        Offset(808.315, 634.023),
        Offset(803.845, 670.681),
      ],
    ),
    // id 261: B11 L21
    Phase2LotAnnotation(
      id: 261,
      categoryId: 44,
      name: 'B11 L21',
      bbox: Rect.fromLTWH(808.77, 604.68, 26.41, 29.78),
      points: [
        Offset(808.77, 631.704),
        Offset(833.04, 634.456),
        Offset(835.185, 607.301),
        Offset(812.597, 604.679),
        Offset(808.77, 631.704),
      ],
    ),
    // id 262: B12 L1
    Phase2LotAnnotation(
      id: 262,
      categoryId: 52,
      name: 'B12 L1',
      bbox: Rect.fromLTWH(836.85, 607.93, 21.22, 29.02),
      points: [
        Offset(836.849, 635.232),
        Offset(856.415, 636.948),
        Offset(858.071, 610.571),
        Offset(838.277, 607.928),
        Offset(836.849, 635.232),
      ],
    ),
    // id 263: B12 L2
    Phase2LotAnnotation(
      id: 263,
      categoryId: 62,
      name: 'B12 L2',
      bbox: Rect.fromLTWH(832.62, 637.25, 23.16, 33.8),
      points: [
        Offset(832.621, 671.042),
        Offset(853.124, 670.733),
        Offset(855.782, 639.172),
        Offset(836.666, 637.245),
        Offset(832.621, 671.042),
      ],
    ),
    // id 264: B12 L3
    Phase2LotAnnotation(
      id: 264,
      categoryId: 67,
      name: 'B12 L3',
      bbox: Rect.fromLTWH(856.36, 611.15, 22.08, 28.89),
      points: [
        Offset(856.362, 637.285),
        Offset(877.136, 640.044),
        Offset(878.438, 613.329),
        Offset(858.573, 611.15),
        Offset(856.362, 637.285),
      ],
    ),
    // id 265: B12 L4
    Phase2LotAnnotation(
      id: 265,
      categoryId: 68,
      name: 'B12 L4',
      bbox: Rect.fromLTWH(853.63, 640.11, 23.56, 30.59),
      points: [
        Offset(853.633, 670.596),
        Offset(875.238, 670.704),
        Offset(877.194, 641.739),
        Offset(855.976, 640.109),
        Offset(853.633, 670.596),
      ],
    ),
    // id 266: B12 L5
    Phase2LotAnnotation(
      id: 266,
      categoryId: 69,
      name: 'B12 L5',
      bbox: Rect.fromLTWH(876.99, 613.08, 24.15, 28.51),
      points: [
        Offset(876.986, 639.702),
        Offset(900.033, 641.593),
        Offset(901.141, 614.727),
        Offset(878.548, 613.083),
        Offset(876.986, 639.702),
      ],
    ),
    // id 267: B12 L6
    Phase2LotAnnotation(
      id: 267,
      categoryId: 70,
      name: 'B12 L6',
      bbox: Rect.fromLTWH(874.68, 642.65, 25.76, 28.53),
      points: [
        Offset(874.675, 671.178),
        Offset(899.033, 671.059),
        Offset(900.437, 643.627),
        Offset(877.623, 642.648),
        Offset(874.675, 671.178),
      ],
    ),
    // id 268: B12 L7
    Phase2LotAnnotation(
      id: 268,
      categoryId: 71,
      name: 'B12 L7',
      bbox: Rect.fromLTWH(900.21, 615.18, 22.74, 27.57),
      points: [
        Offset(900.21, 641.533),
        Offset(922.93, 642.752),
        Offset(922.945, 616.394),
        Offset(901.296, 615.179),
        Offset(900.21, 641.533),
      ],
    ),
    // id 269: B12 L8
    Phase2LotAnnotation(
      id: 269,
      categoryId: 72,
      name: 'B12 L8',
      bbox: Rect.fromLTWH(898.82, 644.01, 24.26, 27.75),
      points: [
        Offset(898.815, 671.405),
        Offset(922.595, 671.763),
        Offset(923.078, 644.82),
        Offset(900.455, 644.011),
        Offset(898.815, 671.405),
      ],
    ),
    // id 270: B12 L9
    Phase2LotAnnotation(
      id: 270,
      categoryId: 73,
      name: 'B12 L9',
      bbox: Rect.fromLTWH(922.62, 616.46, 23.29, 27.86),
      points: [
        Offset(922.623, 643.32),
        Offset(945.81, 644.324),
        Offset(945.917, 616.614),
        Offset(923.272, 616.463),
        Offset(922.623, 643.32),
      ],
    ),
    // id 271: B12 L10
    Phase2LotAnnotation(
      id: 271,
      categoryId: 53,
      name: 'B12 L10',
      bbox: Rect.fromLTWH(922.81, 645.3, 23.19, 26.4),
      points: [
        Offset(922.809, 671.704),
        Offset(945.896, 671.347),
        Offset(945.997, 645.435),
        Offset(923.651, 645.299),
        Offset(922.809, 671.704),
      ],
    ),
    // id 272: B12 L11
    Phase2LotAnnotation(
      id: 272,
      categoryId: 54,
      name: 'B12 L11',
      bbox: Rect.fromLTWH(946.01, 616.63, 23.01, 26.69),
      points: [
        Offset(946.009, 643.317),
        Offset(969.019, 642.87),
        Offset(968.07, 616.983),
        Offset(946.203, 616.626),
        Offset(946.009, 643.317),
      ],
    ),
    // id 273: B12 L12
    Phase2LotAnnotation(
      id: 273,
      categoryId: 55,
      name: 'B12 L12',
      bbox: Rect.fromLTWH(945.88, 645.34, 24.14, 26.11),
      points: [
        Offset(946.176, 671.419),
        Offset(970.02, 671.45),
        Offset(968.938, 645.342),
        Offset(945.88, 645.621),
        Offset(946.176, 671.419),
      ],
    ),
    // id 275: B12 L14
    Phase2LotAnnotation(
      id: 275,
      categoryId: 56,
      name: 'B12 L14',
      bbox: Rect.fromLTWH(969.88, 645.38, 23.12, 26.42),
      points: [
        Offset(969.946, 671.794),
        Offset(993.006, 671.245),
        Offset(992.082, 645.378),
        Offset(969.882, 645.845),
        Offset(969.946, 671.794),
      ],
    ),
    // id 274: B12 L15
    Phase2LotAnnotation(
      id: 274,
      categoryId: 57,
      name: 'B12 L15',
      bbox: Rect.fromLTWH(968.11, 616.54, 24.23, 26.71),
      points: [
        Offset(969.741, 643.257),
        Offset(992.338, 643.145),
        Offset(989.958, 616.542),
        Offset(968.11, 617.271),
        Offset(969.741, 643.257),
      ],
    ),
    // id 277: B12 L16
    Phase2LotAnnotation(
      id: 277,
      categoryId: 58,
      name: 'B12 L16',
      bbox: Rect.fromLTWH(992.27, 644.17, 24.73, 26.12),
      points: [
        Offset(993.673, 670.291),
        Offset(1017.006, 669.908),
        Offset(1014.94, 644.175),
        Offset(992.272, 645.621),
        Offset(993.673, 670.291),
      ],
    ),
    // id 276: B12 L17
    Phase2LotAnnotation(
      id: 276,
      categoryId: 59,
      name: 'B12 L17',
      bbox: Rect.fromLTWH(990.02, 615.52, 25.36, 27.46),
      points: [
        Offset(991.608, 642.982),
        Offset(1015.382, 641.64),
        Offset(1012.746, 615.52),
        Offset(990.017, 616.304),
        Offset(991.608, 642.982),
      ],
    ),
    // id 279: B12 L18
    Phase2LotAnnotation(
      id: 279,
      categoryId: 60,
      name: 'B12 L18',
      bbox: Rect.fromLTWH(1015.47, 642.95, 25.03, 25.96),
      points: [
        Offset(1017.613, 668.904),
        Offset(1040.499, 668.343),
        Offset(1038.064, 642.947),
        Offset(1015.468, 644.011),
        Offset(1017.613, 668.904),
      ],
    ),
    // id 278: B12 L19
    Phase2LotAnnotation(
      id: 278,
      categoryId: 61,
      name: 'B12 L19',
      bbox: Rect.fromLTWH(1012.57, 614.09, 25.41, 27.68),
      points: [
        Offset(1015.103, 641.772),
        Offset(1037.981, 640.58),
        Offset(1034.942, 614.088),
        Offset(1012.569, 615.338),
        Offset(1015.103, 641.772),
      ],
    ),
    // id 281: B12 L20
    Phase2LotAnnotation(
      id: 281,
      categoryId: 63,
      name: 'B12 L20',
      bbox: Rect.fromLTWH(1037.39, 640.79, 27.07, 27.06),
      points: [
        Offset(1037.391, 642.68),
        Offset(1040.736, 667.85),
        Offset(1064.462, 665.729),
        Offset(1060.894, 640.789),
        Offset(1037.391, 642.68),
      ],
    ),
    // id 280: B12 L21
    Phase2LotAnnotation(
      id: 280,
      categoryId: 64,
      name: 'B12 L21',
      bbox: Rect.fromLTWH(1035.44, 611.53, 25.39, 29.4),
      points: [
        Offset(1038.151, 640.931),
        Offset(1060.832, 638.383),
        Offset(1057.415, 611.532),
        Offset(1035.443, 613.727),
        Offset(1038.151, 640.931),
      ],
    ),
    // id 283: B12 L22
    Phase2LotAnnotation(
      id: 283,
      categoryId: 65,
      name: 'B12 L22',
      bbox: Rect.fromLTWH(1061.3, 637.57, 27.06, 28.4),
      points: [
        Offset(1061.299, 640.069),
        Offset(1064.523, 665.964),
        Offset(1088.362, 662.72),
        Offset(1083.768, 637.567),
        Offset(1061.299, 640.069),
      ],
    ),
    // id 282: B12 L23
    Phase2LotAnnotation(
      id: 282,
      categoryId: 66,
      name: 'B12 L23',
      bbox: Rect.fromLTWH(1057.04, 608.89, 26.86, 29.81),
      points: [
        Offset(1057.038, 611.661),
        Offset(1061.057, 638.707),
        Offset(1083.901, 635.615),
        Offset(1078.613, 608.894),
        Offset(1057.038, 611.661),
      ],
    ),
    // id 284: B14 L1
    Phase2LotAnnotation(
      id: 284,
      categoryId: 74,
      name: 'B14 L1',
      bbox: Rect.fromLTWH(1082.59, 605.36, 27.88, 29.49),
      points: [
        Offset(1082.591, 607.966),
        Offset(1087.187, 634.845),
        Offset(1110.471, 631.329),
        Offset(1105.165, 605.359),
        Offset(1082.591, 607.966),
      ],
    ),
    // id 285: B14 L2
    Phase2LotAnnotation(
      id: 285,
      categoryId: 84,
      name: 'B14 L2',
      bbox: Rect.fromLTWH(1088.44, 634.04, 26.27, 27.73),
      points: [
        Offset(1091.482, 661.775),
        Offset(1114.711, 658.984),
        Offset(1110.099, 634.044),
        Offset(1088.442, 637.056),
        Offset(1091.482, 661.775),
      ],
    ),
    // id 286: B14 L3
    Phase2LotAnnotation(
      id: 286,
      categoryId: 95,
      name: 'B14 L3',
      bbox: Rect.fromLTWH(1105.74, 601.38, 27.11, 29.81),
      points: [
        Offset(1109.796, 631.194),
        Offset(1132.854, 626.554),
        Offset(1127.003, 601.379),
        Offset(1105.742, 604.949),
        Offset(1109.796, 631.194),
      ],
    ),
    // id 287: B14 L4
    Phase2LotAnnotation(
      id: 287,
      categoryId: 106,
      name: 'B14 L4',
      bbox: Rect.fromLTWH(1110.49, 629.05, 27.83, 29.92),
      points: [
        Offset(1114.827, 658.974),
        Offset(1138.321, 654.644),
        Offset(1133.004, 629.054),
        Offset(1110.488, 633.423),
        Offset(1114.827, 658.974),
      ],
    ),
    // id 288: B14 L5
    Phase2LotAnnotation(
      id: 288,
      categoryId: 117,
      name: 'B14 L5',
      bbox: Rect.fromLTWH(1127.39, 597.16, 28.14, 29.73),
      points: [
        Offset(1132.466, 626.891),
        Offset(1155.534, 622.626),
        Offset(1148.989, 597.164),
        Offset(1127.39, 601.036),
        Offset(1132.466, 626.891),
      ],
    ),
    // id 289: B14 L6
    Phase2LotAnnotation(
      id: 289,
      categoryId: 125,
      name: 'B14 L6',
      bbox: Rect.fromLTWH(1133.47, 625.4, 27.22, 28.71),
      points: [
        Offset(1137.72, 654.106),
        Offset(1160.692, 649.806),
        Offset(1155.489, 625.401),
        Offset(1133.467, 628.927),
        Offset(1137.72, 654.106),
      ],
    ),
    // id 290: B14 L7
    Phase2LotAnnotation(
      id: 290,
      categoryId: 126,
      name: 'B14 L7',
      bbox: Rect.fromLTWH(1149.22, 591.78, 28.31, 30.77),
      points: [
        Offset(1154.761, 622.552),
        Offset(1177.532, 617.12),
        Offset(1170.662, 591.777),
        Offset(1149.219, 596.957),
        Offset(1154.761, 622.552),
      ],
    ),
    // id 291: B14 L8
    Phase2LotAnnotation(
      id: 291,
      categoryId: 127,
      name: 'B14 L8',
      bbox: Rect.fromLTWH(1155.7, 619.64, 29.11, 30.48),
      points: [
        Offset(1161.31, 650.12),
        Offset(1184.807, 644.131),
        Offset(1177.8, 619.644),
        Offset(1155.696, 624.681),
        Offset(1161.31, 650.12),
      ],
    ),
    // id 292: B14 L9
    Phase2LotAnnotation(
      id: 292,
      categoryId: 128,
      name: 'B14 L9',
      bbox: Rect.fromLTWH(1171.03, 586.81, 28.38, 30.21),
      points: [
        Offset(1176.698, 617.019),
        Offset(1199.408, 611.454),
        Offset(1191.891, 586.81),
        Offset(1171.029, 591.752),
        Offset(1176.698, 617.019),
      ],
    ),
    // id 293: B14 L10
    Phase2LotAnnotation(
      id: 293,
      categoryId: 75,
      name: 'B14 L10',
      bbox: Rect.fromLTWH(1177.93, 613.72, 29.89, 30.42),
      points: [
        Offset(1184.584, 644.143),
        Offset(1207.812, 638.072),
        Offset(1200.349, 613.722),
        Offset(1177.926, 619.435),
        Offset(1184.584, 644.143),
      ],
    ),
    // id 294: B14 L11
    Phase2LotAnnotation(
      id: 294,
      categoryId: 76,
      name: 'B14 L11',
      bbox: Rect.fromLTWH(1191.55, 580.47, 29.9, 30.99),
      points: [
        Offset(1191.551, 586.244),
        Offset(1198.893, 611.463),
        Offset(1221.452, 605.423),
        Offset(1213.394, 580.471),
        Offset(1191.551, 586.244),
      ],
    ),
    // id 295: B14 L12
    Phase2LotAnnotation(
      id: 295,
      categoryId: 77,
      name: 'B14 L12',
      bbox: Rect.fromLTWH(1200.41, 607.79, 29.85, 30.61),
      points: [
        Offset(1207.584, 638.399),
        Offset(1230.258, 632.172),
        Offset(1222.489, 607.794),
        Offset(1200.406, 613.691),
        Offset(1207.584, 638.399),
      ],
    ),
    // id 297: B14 L14
    Phase2LotAnnotation(
      id: 297,
      categoryId: 78,
      name: 'B14 L14',
      bbox: Rect.fromLTWH(1222.39, 602.39, 25.47, 28.74),
      points: [
        Offset(1230.308, 631.132),
        Offset(1247.854, 627.043),
        Offset(1242.11, 602.394),
        Offset(1222.386, 607.946),
        Offset(1230.308, 631.132),
      ],
    ),
    // id 296: B14 L15
    Phase2LotAnnotation(
      id: 296,
      categoryId: 79,
      name: 'B14 L15',
      bbox: Rect.fromLTWH(1213.14, 574.54, 28.61, 30.68),
      points: [
        Offset(1221.201, 605.22),
        Offset(1241.757, 600.799),
        Offset(1235.513, 574.54),
        Offset(1213.144, 579.971),
        Offset(1221.201, 605.22),
      ],
    ),
    // id 299: B14 L16
    Phase2LotAnnotation(
      id: 299,
      categoryId: 80,
      name: 'B14 L16',
      bbox: Rect.fromLTWH(1242.37, 599.14, 22.91, 27.85),
      points: [
        Offset(1248.287, 626.994),
        Offset(1265.281, 624.264),
        Offset(1261.457, 599.144),
        Offset(1242.367, 602.201),
        Offset(1248.287, 626.994),
      ],
    ),
    // id 298: B14 L17
    Phase2LotAnnotation(
      id: 298,
      categoryId: 81,
      name: 'B14 L17',
      bbox: Rect.fromLTWH(1235.62, 570.83, 25.59, 29.84),
      points: [
        Offset(1240.816, 600.667),
        Offset(1261.209, 596.904),
        Offset(1257.71, 570.828),
        Offset(1246.946, 572.226),
        Offset(1235.624, 574.726),
        Offset(1240.816, 600.667),
      ],
    ),
    // id 301: B14 L18
    Phase2LotAnnotation(
      id: 301,
      categoryId: 82,
      name: 'B14 L18',
      bbox: Rect.fromLTWH(1262.06, 597.57, 21.51, 26.01),
      points: [
        Offset(1265.655, 623.574),
        Offset(1283.57, 622.464),
        Offset(1282.367, 597.566),
        Offset(1262.059, 598.481),
        Offset(1265.655, 623.574),
      ],
    ),
    // id 300: B14 L19
    Phase2LotAnnotation(
      id: 300,
      categoryId: 83,
      name: 'B14 L19',
      bbox: Rect.fromLTWH(1257.35, 568.68, 23.98, 27.7),
      points: [
        Offset(1261.333, 596.373),
        Offset(1281.338, 595.482),
        Offset(1279.684, 568.678),
        Offset(1257.354, 570.48),
        Offset(1261.333, 596.373),
      ],
    ),
    // id 303: B14 L20
    Phase2LotAnnotation(
      id: 303,
      categoryId: 85,
      name: 'B14 L20',
      bbox: Rect.fromLTWH(1282.58, 596.87, 20.16, 25.48),
      points: [
        Offset(1283.849, 622.356),
        Offset(1302.741, 621.974),
        Offset(1302.658, 596.873),
        Offset(1282.581, 597.455),
        Offset(1283.849, 622.356),
      ],
    ),
    // id 302: B14 L21
    Phase2LotAnnotation(
      id: 302,
      categoryId: 86,
      name: 'B14 L21',
      bbox: Rect.fromLTWH(1280.33, 567.94, 21.97, 26.8),
      points: [
        Offset(1281.939, 594.744),
        Offset(1302.015, 594.04),
        Offset(1302.303, 567.942),
        Offset(1280.333, 568.732),
        Offset(1281.939, 594.744),
      ],
    ),
    // id 305: B14 L22
    Phase2LotAnnotation(
      id: 305,
      categoryId: 87,
      name: 'B14 L22',
      bbox: Rect.fromLTWH(1302.19, 596.71, 20.07, 26.07),
      points: [
        Offset(1302.194, 622.275),
        Offset(1320.634, 622.778),
        Offset(1322.267, 597.523),
        Offset(1302.563, 596.706),
        Offset(1302.194, 622.275),
      ],
    ),
    // id 304: B14 L23
    Phase2LotAnnotation(
      id: 304,
      categoryId: 88,
      name: 'B14 L23',
      bbox: Rect.fromLTWH(1302.17, 567.73, 22.35, 27.64),
      points: [
        Offset(1302.172, 594.471),
        Offset(1322.87, 595.373),
        Offset(1324.523, 569.165),
        Offset(1302.313, 567.732),
        Offset(1302.172, 594.471),
      ],
    ),
    // id 307: B14 L24
    Phase2LotAnnotation(
      id: 307,
      categoryId: 89,
      name: 'B14 L24',
      bbox: Rect.fromLTWH(1320.91, 598.45, 21.3, 27.63),
      points: [
        Offset(1320.909, 623.312),
        Offset(1338.492, 626.08),
        Offset(1342.213, 600.701),
        Offset(1322.544, 598.454),
        Offset(1320.909, 623.312),
      ],
    ),
    // id 306: B14 L25
    Phase2LotAnnotation(
      id: 306,
      categoryId: 90,
      name: 'B14 L25',
      bbox: Rect.fromLTWH(1322.97, 569.48, 23.25, 28.76),
      points: [
        Offset(1322.969, 595.981),
        Offset(1343.253, 598.241),
        Offset(1346.216, 572.382),
        Offset(1324.543, 569.481),
        Offset(1322.969, 595.981),
      ],
    ),
    // id 309: B14 L26
    Phase2LotAnnotation(
      id: 309,
      categoryId: 91,
      name: 'B14 L26',
      bbox: Rect.fromLTWH(1338.99, 601.2, 22.98, 28.41),
      points: [
        Offset(1338.988, 626.266),
        Offset(1356.314, 629.616),
        Offset(1361.972, 605.283),
        Offset(1342.776, 601.202),
        Offset(1338.988, 626.266),
      ],
    ),
    // id 308: B14 L27
    Phase2LotAnnotation(
      id: 308,
      categoryId: 92,
      name: 'B14 L27',
      bbox: Rect.fromLTWH(1343.29, 572.77, 25.54, 29.35),
      points: [
        Offset(1343.289, 598.411),
        Offset(1362.924, 602.125),
        Offset(1368.829, 576.749),
        Offset(1346.715, 572.774),
        Offset(1343.289, 598.411),
      ],
    ),
    // id 311: B14 L28
    Phase2LotAnnotation(
      id: 311,
      categoryId: 93,
      name: 'B14 L28',
      bbox: Rect.fromLTWH(1356.55, 605.72, 24.59, 29.63),
      points: [
        Offset(1356.545, 630.105),
        Offset(1373.413, 635.344),
        Offset(1381.139, 611.245),
        Offset(1362.173, 605.718),
        Offset(1356.545, 630.105),
      ],
    ),
    // id 310: B14 L29
    Phase2LotAnnotation(
      id: 310,
      categoryId: 94,
      name: 'B14 L29',
      bbox: Rect.fromLTWH(1362.98, 576.97, 27.79, 31.28),
      points: [
        Offset(1362.981, 602.778),
        Offset(1382.222, 608.25),
        Offset(1390.77, 584.235),
        Offset(1368.752, 576.974),
        Offset(1362.981, 602.778),
      ],
    ),
    // id 313: B14 L30
    Phase2LotAnnotation(
      id: 313,
      categoryId: 96,
      name: 'B14 L30',
      bbox: Rect.fromLTWH(1373.66, 611.94, 26.78, 30.53),
      points: [
        Offset(1373.661, 635.667),
        Offset(1390.048, 642.476),
        Offset(1400.443, 619.287),
        Offset(1381.491, 611.942),
        Offset(1373.661, 635.667),
      ],
    ),
    // id 312: B14 L31
    Phase2LotAnnotation(
      id: 312,
      categoryId: 97,
      name: 'B14 L31',
      bbox: Rect.fromLTWH(1382.41, 584.22, 28.7, 32.24),
      points: [
        Offset(1382.407, 608.653),
        Offset(1400.956, 616.458),
        Offset(1411.107, 592.013),
        Offset(1390.732, 584.217),
        Offset(1382.407, 608.653),
      ],
    ),
    // id 315: B14 L32
    Phase2LotAnnotation(
      id: 315,
      categoryId: 98,
      name: 'B14 L32',
      bbox: Rect.fromLTWH(1390.51, 619.68, 27.74, 30.2),
      points: [
        Offset(1390.507, 642.359),
        Offset(1406.381, 649.887),
        Offset(1418.247, 627.36),
        Offset(1399.974, 619.685),
        Offset(1390.507, 642.359),
      ],
    ),
    // id 314: B14 L33
    Phase2LotAnnotation(
      id: 314,
      categoryId: 99,
      name: 'B14 L33',
      bbox: Rect.fromLTWH(1401.15, 592.21, 30.17, 33.35),
      points: [
        Offset(1401.152, 616.603),
        Offset(1419.212, 625.557),
        Offset(1431.322, 602.267),
        Offset(1411.214, 592.21),
        Offset(1401.152, 616.603),
      ],
    ),
    // id 317: B14 L34
    Phase2LotAnnotation(
      id: 317,
      categoryId: 100,
      name: 'B14 L34',
      bbox: Rect.fromLTWH(1406.53, 627.93, 29.01, 32.33),
      points: [
        Offset(1406.532, 650.777),
        Offset(1422.177, 660.256),
        Offset(1435.541, 638.547),
        Offset(1418.457, 627.928),
        Offset(1406.532, 650.777),
      ],
    ),
    // id 316: B14 L35
    Phase2LotAnnotation(
      id: 316,
      categoryId: 101,
      name: 'B14 L35',
      bbox: Rect.fromLTWH(1419.5, 602.7, 30.87, 33.34),
      points: [
        Offset(1419.504, 625.737),
        Offset(1435.835, 636.039),
        Offset(1450.369, 613.478),
        Offset(1431.445, 602.701),
        Offset(1419.504, 625.737),
      ],
    ),
    // id 318: B14 L36
    Phase2LotAnnotation(
      id: 318,
      categoryId: 102,
      name: 'B14 L36',
      bbox: Rect.fromLTWH(1422.09, 638.92, 29.58, 31.04),
      points: [
        Offset(1422.085, 659.362),
        Offset(1436.522, 669.956),
        Offset(1451.662, 650.172),
        Offset(1435.441, 638.918),
        Offset(1422.085, 659.362),
      ],
    ),
    // id 319: B14 L37
    Phase2LotAnnotation(
      id: 319,
      categoryId: 103,
      name: 'B14 L37',
      bbox: Rect.fromLTWH(1436.78, 614.36, 32.25, 33.75),
      points: [
        Offset(1436.776, 636.092),
        Offset(1452.765, 648.101),
        Offset(1469.027, 626.739),
        Offset(1451.144, 614.356),
        Offset(1436.776, 636.092),
      ],
    ),
    // id 320: B14 L38
    Phase2LotAnnotation(
      id: 320,
      categoryId: 104,
      name: 'B14 L38',
      bbox: Rect.fromLTWH(1453.6, 627.18, 32.15, 34.47),
      points: [
        Offset(1453.595, 648.073),
        Offset(1468.768, 661.647),
        Offset(1485.747, 641.299),
        Offset(1469.411, 627.178),
        Offset(1453.595, 648.073),
      ],
    ),
    // id 321: B14 L39
    Phase2LotAnnotation(
      id: 321,
      categoryId: 105,
      name: 'B14 L39',
      bbox: Rect.fromLTWH(1469.22, 641.92, 33.28, 34.85),
      points: [
        Offset(1469.222, 661.269),
        Offset(1484.766, 676.765),
        Offset(1502.503, 657.651),
        Offset(1486.395, 641.915),
        Offset(1469.222, 661.269),
      ],
    ),
    // id 322: B14 L40
    Phase2LotAnnotation(
      id: 322,
      categoryId: 107,
      name: 'B14 L40',
      bbox: Rect.fromLTWH(1485.24, 657.9, 43.24, 42.46),
      points: [
        Offset(1485.241, 676.669),
        Offset(1509.133, 700.363),
        Offset(1528.483, 681.439),
        Offset(1502.38, 657.9),
        Offset(1485.241, 676.669),
      ],
    ),
    // id 323: B14 L41
    Phase2LotAnnotation(
      id: 323,
      categoryId: 108,
      name: 'B14 L41',
      bbox: Rect.fromLTWH(1507.91, 681.63, 34.63, 39.27),
      points: [
        Offset(1507.908, 702.54),
        Offset(1527.109, 720.901),
        Offset(1542.364, 704.329),
        Offset(1542.54, 695.012),
        Offset(1528.357, 681.629),
        Offset(1507.908, 702.54),
      ],
    ),
    // id 324: B14 L42
    Phase2LotAnnotation(
      id: 324,
      categoryId: 109,
      name: 'B14 L42',
      bbox: Rect.fromLTWH(1492.42, 702.61, 35.02, 33.94),
      points: [
        Offset(1492.416, 717.938),
        Offset(1512.126, 736.547),
        Offset(1527.439, 721.304),
        Offset(1507.376, 702.61),
        Offset(1492.416, 717.938),
      ],
    ),
    // id 325: B14 L43
    Phase2LotAnnotation(
      id: 325,
      categoryId: 110,
      name: 'B14 L43',
      bbox: Rect.fromLTWH(1476.65, 718.1, 35.06, 34.25),
      points: [
        Offset(1476.653, 733.379),
        Offset(1495.7, 752.344),
        Offset(1511.712, 736.498),
        Offset(1492.39, 718.095),
        Offset(1476.653, 733.379),
      ],
    ),
    // id 326: B14 L44
    Phase2LotAnnotation(
      id: 326,
      categoryId: 111,
      name: 'B14 L44',
      bbox: Rect.fromLTWH(1461.07, 733.83, 34.83, 34.27),
      points: [
        Offset(1461.068, 749.072),
        Offset(1480.051, 768.099),
        Offset(1495.9, 752.272),
        Offset(1476.154, 733.831),
        Offset(1461.068, 749.072),
      ],
    ),
    // id 327: B14 L45
    Phase2LotAnnotation(
      id: 327,
      categoryId: 112,
      name: 'B14 L45',
      bbox: Rect.fromLTWH(1441.59, 748.82, 38.39, 34.95),
      points: [
        Offset(1453.444, 756.922),
        Offset(1441.59, 760.875),
        Offset(1464.451, 783.764),
        Offset(1479.979, 767.911),
        Offset(1460.668, 748.817),
        Offset(1453.444, 756.922),
      ],
    ),
    // id 328: B14 L46
    Phase2LotAnnotation(
      id: 328,
      categoryId: 113,
      name: 'B14 L46',
      bbox: Rect.fromLTWH(1419.38, 761.54, 45.08, 38.14),
      points: [
        Offset(1419.38, 770.516),
        Offset(1448.122, 799.676),
        Offset(1464.456, 783.666),
        Offset(1441.579, 761.536),
        Offset(1419.38, 770.516),
      ],
    ),
    // id 329: B14 L47
    Phase2LotAnnotation(
      id: 329,
      categoryId: 114,
      name: 'B14 L47',
      bbox: Rect.fromLTWH(1381.54, 770.8, 66.62, 55.23),
      points: [
        Offset(1399.895, 772.825),
        Offset(1381.537, 811.846),
        Offset(1411.206, 826.022),
        Offset(1422.54, 825.476),
        Offset(1448.154, 799.638),
        Offset(1419.206, 770.797),
        Offset(1399.895, 772.825),
      ],
    ),
    // id 330: B14 L48
    Phase2LotAnnotation(
      id: 330,
      categoryId: 115,
      name: 'B14 L48',
      bbox: Rect.fromLTWH(1361.32, 767.05, 37.99, 44.82),
      points: [
        Offset(1361.315, 802.929),
        Offset(1381.474, 811.867),
        Offset(1399.302, 772.225),
        Offset(1391.997, 771.938),
        Offset(1377.245, 767.051),
        Offset(1361.315, 802.929),
      ],
    ),
    // id 331: B14 L49
    Phase2LotAnnotation(
      id: 331,
      categoryId: 116,
      name: 'B14 L49',
      bbox: Rect.fromLTWH(1340.9, 761.81, 36.32, 40.45),
      points: [
        Offset(1340.903, 793.705),
        Offset(1361.683, 802.254),
        Offset(1377.222, 767.118),
        Offset(1355.265, 761.806),
        Offset(1340.903, 793.705),
      ],
    ),
    // id 332: B14 L50
    Phase2LotAnnotation(
      id: 332,
      categoryId: 118,
      name: 'B14 L50',
      bbox: Rect.fromLTWH(1319.81, 751.32, 35.74, 41.82),
      points: [
        Offset(1319.814, 783.499),
        Offset(1341.213, 793.135),
        Offset(1355.552, 761.477),
        Offset(1333.285, 751.315),
        Offset(1319.814, 783.499),
      ],
    ),
    // id 333: B14 L51
    Phase2LotAnnotation(
      id: 333,
      categoryId: 119,
      name: 'B14 L51',
      bbox: Rect.fromLTWH(1300.54, 730.44, 32.99, 53.06),
      points: [
        Offset(1330.299, 735.01),
        Offset(1321.751, 730.441),
        Offset(1300.543, 774.553),
        Offset(1319.401, 783.5),
        Offset(1333.534, 751.065),
        Offset(1330.299, 735.01),
      ],
    ),
    // id 334: B14 L52
    Phase2LotAnnotation(
      id: 334,
      categoryId: 120,
      name: 'B14 L52',
      bbox: Rect.fromLTWH(1280.51, 723.94, 40.03, 50.4),
      points: [
        Offset(1299.358, 723.942),
        Offset(1280.513, 765.536),
        Offset(1300.232, 774.345),
        Offset(1320.546, 730.584),
        Offset(1299.358, 723.942),
      ],
    ),
    // id 335: B14 L53
    Phase2LotAnnotation(
      id: 335,
      categoryId: 121,
      name: 'B14 L53',
      bbox: Rect.fromLTWH(1260.58, 715.72, 38.49, 50.01),
      points: [
        Offset(1288.261, 723.44),
        Offset(1279.142, 715.723),
        Offset(1260.579, 756.727),
        Offset(1280.078, 765.729),
        Offset(1299.066, 724.09),
        Offset(1288.261, 723.44),
      ],
    ),
    // id 336: B14 L54
    Phase2LotAnnotation(
      id: 336,
      categoryId: 122,
      name: 'B14 L54',
      bbox: Rect.fromLTWH(1239.75, 702.11, 38.55, 53.65),
      points: [
        Offset(1239.75, 746.54),
        Offset(1260.315, 755.765),
        Offset(1278.304, 715.49),
        Offset(1259.602, 702.11),
        Offset(1239.75, 746.54),
      ],
    ),
    // id 337: B14 L55
    Phase2LotAnnotation(
      id: 337,
      categoryId: 123,
      name: 'B14 L55',
      bbox: Rect.fromLTWH(1214.35, 697.01, 44.82, 50.32),
      points: [
        Offset(1249.856, 697.014),
        Offset(1229.273, 705.46),
        Offset(1214.354, 706.488),
        Offset(1225.032, 747.336),
        Offset(1234.749, 745.268),
        Offset(1239.562, 746.628),
        Offset(1259.17, 702.174),
        Offset(1249.856, 697.014),
      ],
    ),
    // id 338: B14 L56
    Phase2LotAnnotation(
      id: 338,
      categoryId: 124,
      name: 'B14 L56',
      bbox: Rect.fromLTWH(1188.03, 706.63, 36.6, 43.98),
      points: [
        Offset(1214.568, 706.631),
        Offset(1196.714, 715.449),
        Offset(1188.034, 714.679),
        Offset(1192.689, 750.611),
        Offset(1224.634, 747.319),
        Offset(1214.568, 706.631),
      ],
    ),
    // id 209: B15 L1
    Phase2LotAnnotation(
      id: 209,
      categoryId: 129,
      name: 'B15 L1',
      bbox: Rect.fromLTWH(469.36, 689.19, 64.37, 92.12),
      points: [
        Offset(487.45, 723.337),
        Offset(469.362, 781.307),
        Offset(516.476, 776.456),
        Offset(533.734, 689.19),
        Offset(487.45, 723.337),
      ],
    ),
    // id 210: B15 L2
    Phase2LotAnnotation(
      id: 210,
      categoryId: 130,
      name: 'B15 L2',
      bbox: Rect.fromLTWH(516.66, 688.76, 59.14, 86.87),
      points: [
        Offset(516.658, 775.628),
        Offset(559.345, 772.354),
        Offset(575.801, 689.519),
        Offset(534.166, 688.759),
        Offset(516.658, 775.628),
      ],
    ),
    // id 211: B15 L3
    Phase2LotAnnotation(
      id: 211,
      categoryId: 131,
      name: 'B15 L3',
      bbox: Rect.fromLTWH(559.21, 688.76, 58.94, 83.51),
      points: [
        Offset(559.212, 772.271),
        Offset(601.429, 768.96),
        Offset(618.155, 689.253),
        Offset(576.053, 688.759),
        Offset(559.212, 772.271),
      ],
    ),
    // id 212: B15 L4
    Phase2LotAnnotation(
      id: 212,
      categoryId: 132,
      name: 'B15 L4',
      bbox: Rect.fromLTWH(601.27, 689.17, 58.2, 78.96),
      points: [
        Offset(601.274, 768.131),
        Offset(644.088, 764.326),
        Offset(659.47, 689.174),
        Offset(618.371, 689.19),
        Offset(601.274, 768.131),
      ],
    ),
    // id 213: B15 L5
    Phase2LotAnnotation(
      id: 213,
      categoryId: 133,
      name: 'B15 L5',
      bbox: Rect.fromLTWH(643.83, 689.62, 57.23, 74.38),
      points: [
        Offset(643.825, 763.999),
        Offset(686.517, 760.015),
        Offset(701.059, 689.933),
        Offset(659.395, 689.622),
        Offset(643.825, 763.999),
      ],
    ),
    // id 214: B15 L6
    Phase2LotAnnotation(
      id: 214,
      categoryId: 134,
      name: 'B15 L6',
      bbox: Rect.fromLTWH(686.39, 689.75, 55.93, 69.88),
      points: [
        Offset(686.389, 759.632),
        Offset(729.021, 756.083),
        Offset(742.315, 689.749),
        Offset(701.745, 690.089),
        Offset(686.389, 759.632),
      ],
    ),
    // id 215: B15 L7
    Phase2LotAnnotation(
      id: 215,
      categoryId: 135,
      name: 'B15 L7',
      bbox: Rect.fromLTWH(729.12, 688.97, 48.58, 67.18),
      points: [
        Offset(729.117, 756.15),
        Offset(765.345, 752.63),
        Offset(777.699, 688.969),
        Offset(743.6, 689.19),
        Offset(729.117, 756.15),
      ],
    ),
    // id 216: B15 L8
    Phase2LotAnnotation(
      id: 216,
      categoryId: 136,
      name: 'B15 L8',
      bbox: Rect.fromLTWH(765.51, 689.19, 46.05, 63.2),
      points: [
        Offset(765.512, 752.388),
        Offset(803.153, 747.586),
        Offset(811.565, 690.034),
        Offset(778.146, 689.19),
        Offset(765.512, 752.388),
      ],
    ),
    // id 217: B16 L1
    Phase2LotAnnotation(
      id: 217,
      categoryId: 137,
      name: 'B16 L1',
      bbox: Rect.fromLTWH(807.46, 690.07, 35.16, 58.48),
      points: [
        Offset(807.456, 748.548),
        Offset(834.035, 744.921),
        Offset(842.616, 690.069),
        Offset(816.486, 690.369),
        Offset(807.456, 748.548),
      ],
    ),
    // id 218: B16 L2
    Phase2LotAnnotation(
      id: 218,
      categoryId: 140,
      name: 'B16 L2',
      bbox: Rect.fromLTWH(834.6, 689.27, 35.78, 54.93),
      points: [
        Offset(834.595, 744.204),
        Offset(862.428, 740.144),
        Offset(870.374, 689.275),
        Offset(843.572, 690.302),
        Offset(834.595, 744.204),
      ],
    ),
    // id 219: B16 L3
    Phase2LotAnnotation(
      id: 219,
      categoryId: 141,
      name: 'B16 L3',
      bbox: Rect.fromLTWH(862.95, 689.62, 36.84, 51.18),
      points: [
        Offset(862.952, 740.8),
        Offset(896.724, 736.286),
        Offset(899.789, 690.02),
        Offset(870.556, 689.622),
        Offset(862.952, 740.8),
      ],
    ),
    // id 220: B16 L4
    Phase2LotAnnotation(
      id: 220,
      categoryId: 142,
      name: 'B16 L4',
      bbox: Rect.fromLTWH(896.96, 689.62, 27.5, 47.6),
      points: [
        Offset(896.955, 737.219),
        Offset(922.326, 733.574),
        Offset(924.453, 689.929),
        Offset(899.92, 689.622),
        Offset(896.955, 737.219),
      ],
    ),
    // id 221: B16 L5
    Phase2LotAnnotation(
      id: 221,
      categoryId: 143,
      name: 'B16 L5',
      bbox: Rect.fromLTWH(924.69, 690.68, 24.23, 41.41),
      points: [
        Offset(924.688, 732.093),
        Offset(933.316, 731.379),
        Offset(948.637, 727.658),
        Offset(948.915, 690.872),
        Offset(925.228, 690.682),
        Offset(924.688, 732.093),
      ],
    ),
    // id 222: B16 L6
    Phase2LotAnnotation(
      id: 222,
      categoryId: 144,
      name: 'B16 L6',
      bbox: Rect.fromLTWH(948.93, 689.96, 28.11, 37.25),
      points: [
        Offset(948.932, 727.206),
        Offset(977.038, 720.794),
        Offset(976.859, 689.96),
        Offset(949.496, 690.132),
        Offset(948.932, 727.206),
      ],
    ),
    // id 223: B16 L7
    Phase2LotAnnotation(
      id: 223,
      categoryId: 145,
      name: 'B16 L7',
      bbox: Rect.fromLTWH(976.61, 690.44, 22.57, 31.03),
      points: [
        Offset(976.608, 721.473),
        Offset(988.213, 718.151),
        Offset(999.177, 718.966),
        Offset(998.72, 690.439),
        Offset(977.217, 690.486),
        Offset(976.608, 721.473),
      ],
    ),
    // id 224: B16 L8
    Phase2LotAnnotation(
      id: 224,
      categoryId: 146,
      name: 'B16 L8',
      bbox: Rect.fromLTWH(998.73, 688.33, 24.45, 30.45),
      points: [
        Offset(998.729, 689.934),
        Offset(999.467, 718.484),
        Offset(1023.182, 718.775),
        Offset(1020.831, 688.327),
        Offset(998.729, 689.934),
      ],
    ),
    // id 225: B16 L9
    Phase2LotAnnotation(
      id: 225,
      categoryId: 147,
      name: 'B16 L9',
      bbox: Rect.fromLTWH(1020.94, 687.03, 24.55, 32.19),
      points: [
        Offset(1020.939, 688.689),
        Offset(1023.051, 718.866),
        Offset(1038.342, 719.219),
        Offset(1045.487, 717.625),
        Offset(1043.286, 687.031),
        Offset(1020.939, 688.689),
      ],
    ),
    // id 226: B16 L10
    Phase2LotAnnotation(
      id: 226,
      categoryId: 138,
      name: 'B16 L10',
      bbox: Rect.fromLTWH(1044.15, 685.16, 24.28, 32.61),
      points: [
        Offset(1046.914, 717.495),
        Offset(1052.324, 717.773),
        Offset(1068.428, 712.615),
        Offset(1065.963, 685.159),
        Offset(1044.149, 687.031),
        Offset(1046.914, 717.495),
      ],
    ),
    // id 227: B16 L11
    Phase2LotAnnotation(
      id: 227,
      categoryId: 139,
      name: 'B16 L11',
      bbox: Rect.fromLTWH(1066.17, 682.09, 28.14, 30.07),
      points: [
        Offset(1068.88, 712.16),
        Offset(1094.313, 706.21),
        Offset(1090.923, 682.092),
        Offset(1066.172, 684.44),
        Offset(1068.88, 712.16),
      ],
    ),
    // id 228: B17 L1
    Phase2LotAnnotation(
      id: 228,
      categoryId: 148,
      name: 'B17 L1',
      bbox: Rect.fromLTWH(1094.79, 676.82, 34.35, 29.18),
      points: [
        Offset(1099.585, 705.998),
        Offset(1129.141, 701.614),
        Offset(1124.593, 676.816),
        Offset(1094.787, 681.36),
        Offset(1099.585, 705.998),
      ],
    ),
    // id 229: B17 L2
    Phase2LotAnnotation(
      id: 229,
      categoryId: 153,
      name: 'B17 L2',
      bbox: Rect.fromLTWH(1125.33, 670.98, 36.3, 30.38),
      points: [
        Offset(1130.123, 701.356),
        Offset(1156.056, 697.437),
        Offset(1161.634, 697.565),
        Offset(1156.214, 670.976),
        Offset(1125.332, 677.099),
        Offset(1130.123, 701.356),
      ],
    ),
    // id 230: B17 L3
    Phase2LotAnnotation(
      id: 230,
      categoryId: 154,
      name: 'B17 L3',
      bbox: Rect.fromLTWH(1156.49, 666, 27.74, 31.88),
      points: [
        Offset(1162.639, 697.078),
        Offset(1172.546, 697.877),
        Offset(1184.236, 692.525),
        Offset(1178.42, 665.998),
        Offset(1156.494, 670.315),
        Offset(1162.639, 697.078),
      ],
    ),
    // id 231: B17 L4
    Phase2LotAnnotation(
      id: 231,
      categoryId: 155,
      name: 'B17 L4',
      bbox: Rect.fromLTWH(1178.3, 659.4, 28.96, 33.66),
      points: [
        Offset(1178.305, 665.108),
        Offset(1184.494, 693.052),
        Offset(1194.949, 687.718),
        Offset(1207.266, 688.075),
        Offset(1200.038, 659.395),
        Offset(1178.305, 665.108),
      ],
    ),
    // id 232: B17 L5
    Phase2LotAnnotation(
      id: 232,
      categoryId: 156,
      name: 'B17 L5',
      bbox: Rect.fromLTWH(1200.04, 652.87, 34.98, 34.02),
      points: [
        Offset(1206.814, 686.682),
        Offset(1223.749, 686.895),
        Offset(1235.017, 682.158),
        Offset(1226.47, 652.87),
        Offset(1200.038, 659.826),
        Offset(1206.814, 686.682),
      ],
    ),
    // id 233: B17 L6
    Phase2LotAnnotation(
      id: 233,
      categoryId: 157,
      name: 'B17 L6',
      bbox: Rect.fromLTWH(1226.78, 646.03, 31.11, 36.51),
      points: [
        Offset(1235.059, 682.543),
        Offset(1257.883, 675.139),
        Offset(1253.688, 646.028),
        Offset(1226.775, 652.873),
        Offset(1235.059, 682.543),
      ],
    ),
    // id 234: B17 L7
    Phase2LotAnnotation(
      id: 234,
      categoryId: 158,
      name: 'B17 L7',
      bbox: Rect.fromLTWH(1253.89, 642.75, 24.76, 45.26),
      points: [
        Offset(1258.33, 675.553),
        Offset(1278.653, 688.01),
        Offset(1277.305, 642.747),
        Offset(1266.444, 643.724),
        Offset(1253.889, 645.542),
        Offset(1258.33, 675.553),
      ],
    ),
    // id 235: B17 L8
    Phase2LotAnnotation(
      id: 235,
      categoryId: 159,
      name: 'B17 L8',
      bbox: Rect.fromLTWH(1277.33, 641.62, 26.02, 54.63),
      points: [
        Offset(1278.463, 687.709),
        Offset(1298.016, 696.248),
        Offset(1303.35, 641.737),
        Offset(1288.322, 641.619),
        Offset(1277.334, 642.553),
        Offset(1278.463, 687.709),
      ],
    ),
    // id 236: B17 L9
    Phase2LotAnnotation(
      id: 236,
      categoryId: 160,
      name: 'B17 L9',
      bbox: Rect.fromLTWH(1298.26, 641.26, 30.34, 62.88),
      points: [
        Offset(1298.256, 696.572),
        Offset(1315.431, 704.137),
        Offset(1328.593, 644.52),
        Offset(1316.949, 642.289),
        Offset(1302.812, 641.258),
        Offset(1298.256, 696.572),
      ],
    ),
    // id 237: B17 L10
    Phase2LotAnnotation(
      id: 237,
      categoryId: 149,
      name: 'B17 L10',
      bbox: Rect.fromLTWH(1315.67, 644.28, 38.51, 68.29),
      points: [
        Offset(1315.667, 703.985),
        Offset(1331.656, 712.571),
        Offset(1354.18, 649.581),
        Offset(1328.721, 644.281),
        Offset(1315.667, 703.985),
      ],
    ),
    // id 239: B17 L12
    Phase2LotAnnotation(
      id: 239,
      categoryId: 150,
      name: 'B17 L12',
      bbox: Rect.fromLTWH(1347.21, 658.5, 54.57, 71.34),
      points: [
        Offset(1347.209, 720.766),
        Offset(1361.336, 729.839),
        Offset(1401.775, 669.812),
        Offset(1378.663, 658.497),
        Offset(1347.209, 720.766),
      ],
    ),
    // id 240: B17 L14
    Phase2LotAnnotation(
      id: 240,
      categoryId: 151,
      name: 'B17 L14',
      bbox: Rect.fromLTWH(1361.65, 670.62, 59.97, 69.3),
      points: [
        Offset(1361.653, 730.229),
        Offset(1378.568, 739.923),
        Offset(1421.622, 682.767),
        Offset(1401.699, 670.622),
        Offset(1361.653, 730.229),
      ],
    ),
    // id 238: B17 L17
    Phase2LotAnnotation(
      id: 238,
      categoryId: 152,
      name: 'B17 L17',
      bbox: Rect.fromLTWH(1332.14, 649.46, 46.18, 71.15),
      points: [
        Offset(1332.142, 712.005),
        Offset(1346.131, 720.612),
        Offset(1378.323, 658.361),
        Offset(1354.631, 649.463),
        Offset(1332.142, 712.005),
      ],
    ),
    // id 241: B18 L1
    Phase2LotAnnotation(
      id: 241,
      categoryId: 161,
      name: 'B18 L1',
      bbox: Rect.fromLTWH(1383.7, 686.6, 72.45, 69.22),
      points: [
        Offset(1383.701, 742.91),
        Offset(1403.791, 755.818),
        Offset(1428.273, 744.442),
        Offset(1456.151, 705.412),
        Offset(1450.453, 708.197),
        Offset(1443.718, 708.678),
        Offset(1437.692, 706.123),
        Offset(1433.388, 701.717),
        Offset(1430.345, 696.641),
        Offset(1430.502, 689.131),
        Offset(1426.313, 686.599),
        Offset(1383.701, 742.91),
      ],
    ),
    // id 198: B19 L1
    Phase2LotAnnotation(
      id: 198,
      categoryId: 162,
      name: 'B19 L1',
      bbox: Rect.fromLTWH(576.41, 904.34, 92.12, 86.15),
      points: [
        Offset(616.392, 904.337),
        Offset(577.84, 943.697),
        Offset(576.567, 946.853),
        Offset(576.407, 951.922),
        Offset(578.642, 957.168),
        Offset(582.916, 961.366),
        Offset(631.513, 990.49),
        Offset(668.528, 955.041),
        Offset(616.392, 904.337),
      ],
    ),
    // id 199: B19 L2
    Phase2LotAnnotation(
      id: 199,
      categoryId: 165,
      name: 'B19 L2',
      bbox: Rect.fromLTWH(633.8, 956.31, 86.74, 76.78),
      points: [
        Offset(633.804, 992.297),
        Offset(669.658, 1014.627),
        Offset(679.965, 1028.237),
        Offset(684.602, 1032.063),
        Offset(690.287, 1033.083),
        Offset(696.11, 1030.454),
        Offset(720.548, 1005.723),
        Offset(669.796, 956.308),
        Offset(633.804, 992.297),
      ],
    ),
    // id 200: B19 L3
    Phase2LotAnnotation(
      id: 200,
      categoryId: 166,
      name: 'B19 L3',
      bbox: Rect.fromLTWH(617.4, 880.89, 74.11, 73.63),
      points: [
        Offset(668.007, 954.526),
        Offset(691.502, 930.189),
        Offset(641.027, 880.894),
        Offset(617.396, 903.908),
        Offset(668.007, 954.526),
      ],
    ),
    // id 201: B19 L4
    Phase2LotAnnotation(
      id: 201,
      categoryId: 167,
      name: 'B19 L4',
      bbox: Rect.fromLTWH(670.48, 933.07, 73.5, 71.87),
      points: [
        Offset(670.481, 955.645),
        Offset(720.942, 1004.934),
        Offset(743.976, 981.853),
        Offset(693.884, 933.066),
        Offset(670.481, 955.645),
      ],
    ),
    // id 202: B19 L5
    Phase2LotAnnotation(
      id: 202,
      categoryId: 168,
      name: 'B19 L5',
      bbox: Rect.fromLTWH(640.54, 857.42, 74.16, 73.03),
      points: [
        Offset(640.541, 880.864),
        Offset(691.191, 930.452),
        Offset(714.697, 906.66),
        Offset(663.88, 857.424),
        Offset(640.541, 880.864),
      ],
    ),
    // id 203: B19 L6
    Phase2LotAnnotation(
      id: 203,
      categoryId: 169,
      name: 'B19 L6',
      bbox: Rect.fromLTWH(693.71, 908.12, 74.26, 74.05),
      points: [
        Offset(693.707, 932.188),
        Offset(744.217, 982.165),
        Offset(767.962, 958.34),
        Offset(716.983, 908.117),
        Offset(693.707, 932.188),
      ],
    ),
    // id 204: B19 L7
    Phase2LotAnnotation(
      id: 204,
      categoryId: 170,
      name: 'B19 L7',
      bbox: Rect.fromLTWH(664.25, 838.64, 93.66, 68.49),
      points: [
        Offset(680.967, 839.748),
        Offset(664.245, 857.442),
        Offset(715.753, 907.136),
        Offset(757.91, 864.561),
        Offset(744.291, 856.134),
        Offset(696.399, 843.523),
        Offset(693.516, 838.642),
        Offset(680.967, 839.748),
      ],
    ),
    // id 205: B19 L8
    Phase2LotAnnotation(
      id: 205,
      categoryId: 171,
      name: 'B19 L8',
      bbox: Rect.fromLTWH(716.66, 884.65, 74.64, 73.34),
      points: [
        Offset(716.657, 908.135),
        Offset(767.889, 957.994),
        Offset(791.3, 934.344),
        Offset(741.068, 884.65),
        Offset(716.657, 908.135),
      ],
    ),
    // id 206: B19 L9
    Phase2LotAnnotation(
      id: 206,
      categoryId: 172,
      name: 'B19 L9',
      bbox: Rect.fromLTWH(741.06, 866.12, 80.04, 68.27),
      points: [
        Offset(741.059, 884.714),
        Offset(791.256, 934.396),
        Offset(821.098, 904.126),
        Offset(784.47, 884.839),
        Offset(759.595, 866.123),
        Offset(741.059, 884.714),
      ],
    ),
    // id 207: B19 L10
    Phase2LotAnnotation(
      id: 207,
      categoryId: 163,
      name: 'B19 L10',
      bbox: Rect.fromLTWH(727.48, 823.07, 125.22, 67.82),
      points: [
        Offset(749.851, 840.435),
        Offset(771.361, 852.303),
        Offset(792.22, 869.908),
        Offset(834.129, 890.886),
        Offset(852.698, 871.837),
        Offset(803.732, 823.065),
        Offset(727.482, 833.393),
        Offset(749.851, 840.435),
      ],
    ),
    // id 208: B19 L11
    Phase2LotAnnotation(
      id: 208,
      categoryId: 164,
      name: 'B19 L11',
      bbox: Rect.fromLTWH(802.29, 809.41, 98.31, 62.32),
      points: [
        Offset(900.382, 825.321),
        Offset(900.608, 816.281),
        Offset(897.127, 812.728),
        Offset(891.782, 809.414),
        Offset(802.294, 822.929),
        Offset(853.502, 871.737),
        Offset(900.382, 825.321),
      ],
    ),
    // id 175: B20 L1
    Phase2LotAnnotation(
      id: 175,
      categoryId: 191,
      name: 'B20 L1',
      bbox: Rect.fromLTWH(703.52, 1018.38, 82.09, 93.87),
      points: [
        Offset(733.455, 1018.382),
        Offset(703.522, 1049.857),
        Offset(703.694, 1059.492),
        Offset(744.517, 1112.252),
        Offset(785.613, 1070.311),
        Offset(733.455, 1018.382),
      ],
    ),
    // id 176: B20 L2
    Phase2LotAnnotation(
      id: 176,
      categoryId: 197,
      name: 'B20 L2',
      bbox: Rect.fromLTWH(745.77, 1072.21, 94.02, 90.8),
      points: [
        Offset(745.767, 1114.484),
        Offset(788.035, 1162.327),
        Offset(794.718, 1163.016),
        Offset(802.063, 1160.232),
        Offset(839.786, 1122.151),
        Offset(788.466, 1072.213),
        Offset(745.767, 1114.484),
      ],
    ),
    // id 177: B20 L3
    Phase2LotAnnotation(
      id: 177,
      categoryId: 198,
      name: 'B20 L3',
      bbox: Rect.fromLTWH(734.05, 981.86, 89.05, 88.13),
      points: [
        Offset(734.051, 1018.193),
        Offset(786.746, 1069.991),
        Offset(823.099, 1033.018),
        Offset(770.395, 981.858),
        Offset(734.051, 1018.193),
      ],
    ),
    // id 178: B20 L4
    Phase2LotAnnotation(
      id: 178,
      categoryId: 199,
      name: 'B20 L4',
      bbox: Rect.fromLTWH(788, 1035.12, 88.27, 87.18),
      points: [
        Offset(787.996, 1071.847),
        Offset(839.736, 1122.303),
        Offset(876.271, 1085.18),
        Offset(824.925, 1035.12),
        Offset(787.996, 1071.847),
      ],
    ),
    // id 179: B20 L5
    Phase2LotAnnotation(
      id: 179,
      categoryId: 200,
      name: 'B20 L5',
      bbox: Rect.fromLTWH(770.89, 944.77, 89.23, 87.92),
      points: [
        Offset(770.887, 981.946),
        Offset(823.761, 1032.686),
        Offset(860.115, 996.34),
        Offset(807.488, 944.765),
        Offset(770.887, 981.946),
      ],
    ),
    // id 180: B20 L6
    Phase2LotAnnotation(
      id: 180,
      categoryId: 201,
      name: 'B20 L6',
      bbox: Rect.fromLTWH(825.68, 998.66, 87.29, 86.6),
      points: [
        Offset(825.683, 1034.952),
        Offset(876.514, 1085.264),
        Offset(912.974, 1048.47),
        Offset(861.701, 998.661),
        Offset(825.683, 1034.952),
      ],
    ),
    // id 181: B20 L7
    Phase2LotAnnotation(
      id: 181,
      categoryId: 202,
      name: 'B20 L7',
      bbox: Rect.fromLTWH(808.12, 910.92, 104.09, 85.5),
      points: [
        Offset(859.621, 996.42),
        Offset(912.216, 943.295),
        Offset(901.305, 935.34),
        Offset(871.06, 926.235),
        Offset(858.864, 918.658),
        Offset(851.191, 913.175),
        Offset(841.405, 910.922),
        Offset(808.122, 944.448),
        Offset(859.621, 996.42),
      ],
    ),
    // id 182: B20 L8
    Phase2LotAnnotation(
      id: 182,
      categoryId: 203,
      name: 'B20 L8',
      bbox: Rect.fromLTWH(861.96, 945.4, 83.55, 102.97),
      points: [
        Offset(861.957, 998.449),
        Offset(913.02, 1048.372),
        Offset(945.504, 1015.861),
        Offset(939.943, 1002.669),
        Offset(944.476, 980.993),
        Offset(937.371, 963.592),
        Offset(914.012, 945.399),
        Offset(861.957, 998.449),
      ],
    ),
    // id 183: B20 L9
    Phase2LotAnnotation(
      id: 183,
      categoryId: 204,
      name: 'B20 L9',
      bbox: Rect.fromLTWH(855.02, 838.4, 111.47, 93.62),
      points: [
        Offset(880.998, 912.052),
        Offset(908.443, 920.222),
        Offset(924.82, 932.026),
        Offset(966.494, 890.758),
        Offset(913.418, 838.404),
        Offset(855.023, 897.598),
        Offset(880.998, 912.052),
      ],
    ),
    // id 184: B20 L10
    Phase2LotAnnotation(
      id: 184,
      categoryId: 192,
      name: 'B20 L10',
      bbox: Rect.fromLTWH(927.33, 892.38, 91.8, 111.31),
      points: [
        Offset(951.669, 954.095),
        Offset(962.263, 980.479),
        Offset(957.893, 1003.682),
        Offset(1019.124, 942.658),
        Offset(968.017, 892.376),
        Offset(927.328, 933.351),
        Offset(951.669, 954.095),
      ],
    ),
    // id 185: B20 L11
    Phase2LotAnnotation(
      id: 185,
      categoryId: 193,
      name: 'B20 L11',
      bbox: Rect.fromLTWH(913.7, 800.27, 96.25, 90.67),
      points: [
        Offset(966.173, 890.934),
        Offset(1009.943, 847.136),
        Offset(963.253, 800.265),
        Offset(954.7, 800.577),
        Offset(948.984, 803.083),
        Offset(913.695, 838.558),
        Offset(966.173, 890.934),
      ],
    ),
    // id 186: B20 L12
    Phase2LotAnnotation(
      id: 186,
      categoryId: 194,
      name: 'B20 L12',
      bbox: Rect.fromLTWH(967.91, 853.14, 90.89, 89.13),
      points: [
        Offset(967.911, 892.086),
        Offset(1019.405, 942.268),
        Offset(1058.803, 902.776),
        Offset(1007.538, 853.141),
        Offset(967.911, 892.086),
      ],
    ),
    // id 187: B20 L14
    Phase2LotAnnotation(
      id: 187,
      categoryId: 195,
      name: 'B20 L14',
      bbox: Rect.fromLTWH(1008.17, 821.9, 92.78, 81.33),
      points: [
        Offset(1058.752, 903.234),
        Offset(1100.488, 861.211),
        Offset(1100.956, 851.657),
        Offset(1076.275, 821.901),
        Offset(1012.52, 848.227),
        Offset(1008.172, 852.19),
        Offset(1058.752, 903.234),
      ],
    ),
    // id 188: B20 L15
    Phase2LotAnnotation(
      id: 188,
      categoryId: 196,
      name: 'B20 L15',
      bbox: Rect.fromLTWH(963.47, 789.35, 110.91, 57.8),
      points: [
        Offset(1009.673, 847.157),
        Offset(1074.379, 819.38),
        Offset(1050.205, 790.614),
        Offset(1044.819, 789.354),
        Offset(963.47, 799.88),
        Offset(1009.673, 847.157),
      ],
    ),
    // id 149: B21 L1
    Phase2LotAnnotation(
      id: 149,
      categoryId: 205,
      name: 'B21 L1',
      bbox: Rect.fromLTWH(810.67, 1151.35, 49.06, 55.9),
      points: [
        Offset(836.778, 1151.346),
        Offset(812.002, 1176.488),
        Offset(810.673, 1181.068),
        Offset(811.425, 1189.144),
        Offset(813.353, 1192.491),
        Offset(827.142, 1207.243),
        Offset(859.737, 1173.53),
        Offset(836.778, 1151.346),
      ],
    ),
    // id 150: B21 L2
    Phase2LotAnnotation(
      id: 150,
      categoryId: 215,
      name: 'B21 L2',
      bbox: Rect.fromLTWH(827.81, 1176.17, 56.99, 51.35),
      points: [
        Offset(827.814, 1208.963),
        Offset(846.57, 1227.517),
        Offset(855.591, 1226.566),
        Offset(884.802, 1198.199),
        Offset(861.469, 1176.17),
        Offset(827.814, 1208.963),
      ],
    ),
    // id 151: B21 L3
    Phase2LotAnnotation(
      id: 151,
      categoryId: 224,
      name: 'B21 L3',
      bbox: Rect.fromLTWH(837.3, 1132.27, 43.16, 41.35),
      points: [
        Offset(837.297, 1150.483),
        Offset(860.423, 1173.625),
        Offset(880.453, 1154.086),
        Offset(855.959, 1132.272),
        Offset(837.297, 1150.483),
      ],
    ),
    // id 152: B21 L4
    Phase2LotAnnotation(
      id: 152,
      categoryId: 225,
      name: 'B21 L4',
      bbox: Rect.fromLTWH(862.16, 1156.39, 41.87, 41.51),
      points: [
        Offset(862.155, 1175.148),
        Offset(884.508, 1197.9),
        Offset(904.026, 1178.171),
        Offset(882.144, 1156.573),
        Offset(881.528, 1156.388),
        Offset(862.155, 1175.148),
      ],
    ),
    // id 153: B21 L5
    Phase2LotAnnotation(
      id: 153,
      categoryId: 226,
      name: 'B21 L5',
      bbox: Rect.fromLTWH(856.84, 1112.7, 42.99, 40.79),
      points: [
        Offset(856.838, 1131.919),
        Offset(880.073, 1153.491),
        Offset(899.831, 1134.123),
        Offset(875.772, 1112.7),
        Offset(856.838, 1131.919),
      ],
    ),
    // id 154: B21 L6
    Phase2LotAnnotation(
      id: 154,
      categoryId: 227,
      name: 'B21 L6',
      bbox: Rect.fromLTWH(881.6, 1136.34, 43.01, 42.21),
      points: [
        Offset(881.597, 1156.322),
        Offset(903.977, 1178.551),
        Offset(924.606, 1158.808),
        Offset(900.995, 1136.34),
        Offset(881.597, 1156.322),
      ],
    ),
    // id 155: B21 L7
    Phase2LotAnnotation(
      id: 155,
      categoryId: 228,
      name: 'B21 L7',
      bbox: Rect.fromLTWH(876.98, 1092.38, 42.85, 41.67),
      points: [
        Offset(876.982, 1111.809),
        Offset(899.38, 1134.047),
        Offset(919.829, 1114.453),
        Offset(896.243, 1092.381),
        Offset(876.982, 1111.809),
      ],
    ),
    // id 156: B21 L8
    Phase2LotAnnotation(
      id: 156,
      categoryId: 229,
      name: 'B21 L8',
      bbox: Rect.fromLTWH(901.03, 1116.26, 43.26, 42.1),
      points: [
        Offset(901.029, 1136.55),
        Offset(924.185, 1158.357),
        Offset(944.287, 1138.461),
        Offset(921.145, 1116.259),
        Offset(901.029, 1136.55),
      ],
    ),
    // id 157: B21 L9
    Phase2LotAnnotation(
      id: 157,
      categoryId: 230,
      name: 'B21 L9',
      bbox: Rect.fromLTWH(896.49, 1072.07, 42.55, 41.97),
      points: [
        Offset(896.485, 1092.003),
        Offset(919.455, 1114.043),
        Offset(939.032, 1094.643),
        Offset(916.089, 1072.071),
        Offset(896.485, 1092.003),
      ],
    ),
    // id 159: B21 L10
    Phase2LotAnnotation(
      id: 159,
      categoryId: 206,
      name: 'B21 L10',
      bbox: Rect.fromLTWH(921.28, 1090.9, 48.54, 47.72),
      points: [
        Offset(921.277, 1115.886),
        Offset(944.208, 1138.617),
        Offset(969.82, 1113.131),
        Offset(945.9, 1090.895),
        Offset(921.277, 1115.886),
      ],
    ),
    // id 158: B21 L11
    Phase2LotAnnotation(
      id: 158,
      categoryId: 207,
      name: 'B21 L11',
      bbox: Rect.fromLTWH(916.52, 1052.8, 41.94, 42.37),
      points: [
        Offset(916.516, 1071.994),
        Offset(939.025, 1095.169),
        Offset(958.456, 1075.286),
        Offset(935.803, 1052.795),
        Offset(916.516, 1071.994),
      ],
    ),
    // id 160: B21 L12
    Phase2LotAnnotation(
      id: 160,
      categoryId: 208,
      name: 'B21 L12',
      bbox: Rect.fromLTWH(946.21, 1062.89, 45, 50.49),
      points: [
        Offset(946.207, 1090.846),
        Offset(969.382, 1113.382),
        Offset(991.203, 1091.049),
        Offset(985.222, 1084.919),
        Offset(981.402, 1069.913),
        Offset(974.441, 1062.892),
        Offset(946.207, 1090.846),
      ],
    ),
    // id 161: B21 L14
    Phase2LotAnnotation(
      id: 161,
      categoryId: 209,
      name: 'B21 L14',
      bbox: Rect.fromLTWH(935.69, 1035.43, 37.23, 39.78),
      points: [
        Offset(935.685, 1052.601),
        Offset(958.714, 1075.206),
        Offset(972.91, 1060.8),
        Offset(957.557, 1044.248),
        Offset(952.901, 1035.428),
        Offset(935.685, 1052.601),
      ],
    ),
    // id 162: B21 L15
    Phase2LotAnnotation(
      id: 162,
      categoryId: 210,
      name: 'B21 L15',
      bbox: Rect.fromLTWH(966.82, 999, 45.11, 50.12),
      points: [
        Offset(972.553, 1035.822),
        Offset(985.001, 1049.128),
        Offset(1011.93, 1022.124),
        Offset(988.671, 999.003),
        Offset(966.817, 1021.51),
        Offset(972.553, 1035.822),
      ],
    ),
    // id 163: B21 L16
    Phase2LotAnnotation(
      id: 163,
      categoryId: 211,
      name: 'B21 L16',
      bbox: Rect.fromLTWH(986.52, 1035.11, 38.85, 43.81),
      points: [
        Offset(986.523, 1050.973),
        Offset(995.92, 1060.85),
        Offset(1001.139, 1076.872),
        Offset(1003.545, 1078.919),
        Offset(1025.376, 1056.629),
        Offset(1002.411, 1035.111),
        Offset(986.523, 1050.973),
      ],
    ),
    // id 164: B21 L17
    Phase2LotAnnotation(
      id: 164,
      categoryId: 212,
      name: 'B21 L17',
      bbox: Rect.fromLTWH(988.81, 970.85, 51.11, 51.63),
      points: [
        Offset(1011.811, 1022.488),
        Offset(1039.924, 992.945),
        Offset(1017.207, 970.854),
        Offset(988.81, 998.649),
        Offset(1011.811, 1022.488),
      ],
    ),
    // id 165: B21 L18
    Phase2LotAnnotation(
      id: 165,
      categoryId: 213,
      name: 'B21 L18',
      bbox: Rect.fromLTWH(1002.3, 1015.06, 43.07, 42.3),
      points: [
        Offset(1002.3, 1034.697),
        Offset(1025.542, 1057.358),
        Offset(1045.365, 1037.299),
        Offset(1022.526, 1015.061),
        Offset(1002.3, 1034.697),
      ],
    ),
    // id 166: B21 L19
    Phase2LotAnnotation(
      id: 166,
      categoryId: 214,
      name: 'B21 L19',
      bbox: Rect.fromLTWH(1017.31, 951.19, 43.14, 41.69),
      points: [
        Offset(1017.307, 970.525),
        Offset(1040.148, 992.877),
        Offset(1060.445, 973.704),
        Offset(1037.426, 951.191),
        Offset(1017.307, 970.525),
      ],
    ),
    // id 167: B21 L20
    Phase2LotAnnotation(
      id: 167,
      categoryId: 216,
      name: 'B21 L20',
      bbox: Rect.fromLTWH(1022.61, 994.89, 42.36, 42.4),
      points: [
        Offset(1022.611, 1015.405),
        Offset(1045.712, 1037.286),
        Offset(1064.969, 1017.634),
        Offset(1042.056, 994.887),
        Offset(1022.611, 1015.405),
      ],
    ),
    // id 168: B21 L21
    Phase2LotAnnotation(
      id: 168,
      categoryId: 217,
      name: 'B21 L21',
      bbox: Rect.fromLTWH(1037.38, 931.8, 41.86, 41.48),
      points: [
        Offset(1037.377, 950.76),
        Offset(1060.88, 973.285),
        Offset(1079.237, 954.075),
        Offset(1056.525, 931.802),
        Offset(1037.377, 950.76),
      ],
    ),
    // id 169: B21 L22
    Phase2LotAnnotation(
      id: 169,
      categoryId: 218,
      name: 'B21 L22',
      bbox: Rect.fromLTWH(1042.44, 975.79, 42.42, 42.02),
      points: [
        Offset(1042.442, 995.764),
        Offset(1065.064, 1017.812),
        Offset(1084.866, 997.678),
        Offset(1062.023, 975.788),
        Offset(1042.442, 995.764),
      ],
    ),
    // id 170: B21 L23
    Phase2LotAnnotation(
      id: 170,
      categoryId: 219,
      name: 'B21 L23',
      bbox: Rect.fromLTWH(1056.95, 912.41, 42.19, 41.35),
      points: [
        Offset(1056.946, 931.392),
        Offset(1079.911, 953.763),
        Offset(1099.136, 934.554),
        Offset(1075.624, 912.414),
        Offset(1056.946, 931.392),
      ],
    ),
    // id 171: B21 L24
    Phase2LotAnnotation(
      id: 171,
      categoryId: 220,
      name: 'B21 L24',
      bbox: Rect.fromLTWH(1062.05, 955.82, 42.28, 41.53),
      points: [
        Offset(1062.053, 975.339),
        Offset(1085.097, 997.354),
        Offset(1104.337, 977.827),
        Offset(1081.701, 955.821),
        Offset(1062.053, 975.339),
      ],
    ),
    // id 173: B21 L25
    Phase2LotAnnotation(
      id: 173,
      categoryId: 221,
      name: 'B21 L25',
      bbox: Rect.fromLTWH(1076.06, 875.57, 62.07, 58.11),
      points: [
        Offset(1138.13, 895.489),
        Offset(1122.03, 876.29),
        Offset(1112.392, 875.571),
        Offset(1076.059, 911.781),
        Offset(1099.342, 933.678),
        Offset(1138.13, 895.489),
      ],
    ),
    // id 172: B21 L26
    Phase2LotAnnotation(
      id: 172,
      categoryId: 222,
      name: 'B21 L26',
      bbox: Rect.fromLTWH(1081.66, 935.85, 42.21, 42.28),
      points: [
        Offset(1081.657, 955.471),
        Offset(1104.894, 978.138),
        Offset(1123.869, 958.219),
        Offset(1101.09, 935.854),
        Offset(1081.657, 955.471),
      ],
    ),
    // id 174: B21 L27
    Phase2LotAnnotation(
      id: 174,
      categoryId: 223,
      name: 'B21 L27',
      bbox: Rect.fromLTWH(1101.65, 897.03, 54.77, 61.63),
      points: [
        Offset(1123.526, 958.659),
        Offset(1156.42, 926.31),
        Offset(1156.361, 916.816),
        Offset(1139.306, 897.031),
        Offset(1101.655, 936.186),
        Offset(1123.526, 958.659),
      ],
    ),
    // id 189: B22 L1
    Phase2LotAnnotation(
      id: 189,
      categoryId: 231,
      name: 'B22 L1',
      bbox: Rect.fromLTWH(1081.76, 773.08, 93.15, 68.9),
      points: [
        Offset(1167.429, 773.08),
        Offset(1087.319, 783.164),
        Offset(1083.696, 786.752),
        Offset(1081.756, 791.358),
        Offset(1082.139, 796.646),
        Offset(1084.057, 802.304),
        Offset(1117.734, 841.98),
        Offset(1174.91, 834.845),
        Offset(1167.429, 773.08),
      ],
    ),
    // id 190: B22 L2
    Phase2LotAnnotation(
      id: 190,
      categoryId: 232,
      name: 'B22 L2',
      bbox: Rect.fromLTWH(1117.47, 828.99, 106.13, 72.6),
      points: [
        Offset(1163.07, 896.26),
        Offset(1166.325, 898.899),
        Offset(1171.244, 901.591),
        Offset(1212.402, 897.469),
        Offset(1223.592, 828.993),
        Offset(1117.467, 842.504),
        Offset(1163.07, 896.26),
      ],
    ),
    // id 191: B22 L3
    Phase2LotAnnotation(
      id: 191,
      categoryId: 233,
      name: 'B22 L3',
      bbox: Rect.fromLTWH(1167.56, 764.75, 65.58, 69.33),
      points: [
        Offset(1223.008, 828.803),
        Offset(1233.142, 764.746),
        Offset(1167.564, 772.87),
        Offset(1175.293, 834.079),
        Offset(1223.008, 828.803),
      ],
    ),
    // id 193: B22 L4
    Phase2LotAnnotation(
      id: 193,
      categoryId: 234,
      name: 'B22 L4',
      bbox: Rect.fromLTWH(1212.39, 829.13, 57.47, 80.01),
      points: [
        Offset(1269.859, 849.625),
        Offset(1223.29, 829.13),
        Offset(1212.39, 896.288),
        Offset(1242.31, 909.138),
        Offset(1269.859, 849.625),
      ],
    ),
    // id 192: B22 L5
    Phase2LotAnnotation(
      id: 192,
      categoryId: 235,
      name: 'B22 L5',
      bbox: Rect.fromLTWH(1222.64, 764.76, 73.01, 85.02),
      points: [
        Offset(1222.636, 828.936),
        Offset(1269.645, 849.783),
        Offset(1295.643, 793.779),
        Offset(1233.119, 764.764),
        Offset(1222.636, 828.936),
      ],
    ),
    // id 194: B22 L6
    Phase2LotAnnotation(
      id: 194,
      categoryId: 236,
      name: 'B22 L6',
      bbox: Rect.fromLTWH(1242.69, 850.25, 74.07, 80.26),
      points: [
        Offset(1289.812, 930.505),
        Offset(1316.764, 871.781),
        Offset(1270.802, 850.247),
        Offset(1242.693, 909.138),
        Offset(1289.812, 930.505),
      ],
    ),
    // id 195: B22 L7
    Phase2LotAnnotation(
      id: 195,
      categoryId: 237,
      name: 'B22 L7',
      bbox: Rect.fromLTWH(1269.98, 793.96, 72.65, 77),
      points: [
        Offset(1342.63, 814.219),
        Offset(1295.514, 793.958),
        Offset(1269.982, 849.11),
        Offset(1317.006, 870.962),
        Offset(1342.63, 814.219),
      ],
    ),
    // id 196: B22 L8
    Phase2LotAnnotation(
      id: 196,
      categoryId: 238,
      name: 'B22 L8',
      bbox: Rect.fromLTWH(1289.26, 871.23, 68.46, 65.96),
      points: [
        Offset(1289.263, 930.443),
        Offset(1301.731, 937.181),
        Offset(1305.968, 937.003),
        Offset(1310.213, 936.219),
        Offset(1314.186, 933.57),
        Offset(1357.724, 889.801),
        Offset(1316.987, 871.226),
        Offset(1289.263, 930.443),
      ],
    ),
    // id 197: B22 L9
    Phase2LotAnnotation(
      id: 197,
      categoryId: 239,
      name: 'B22 L9',
      bbox: Rect.fromLTWH(1316.71, 814.55, 79.86, 75.21),
      points: [
        Offset(1316.713, 871.254),
        Offset(1357.426, 889.762),
        Offset(1394.802, 852.631),
        Offset(1396.568, 849.719),
        Offset(1396.373, 845.677),
        Offset(1395.631, 841.035),
        Offset(1394.366, 837.982),
        Offset(1390.357, 835.246),
        Offset(1386.187, 834.335),
        Offset(1343.794, 814.548),
        Offset(1316.713, 871.254),
      ],
    ),
    // id 118: B23 L1
    Phase2LotAnnotation(
      id: 118,
      categoryId: 240,
      name: 'B23 L1',
      bbox: Rect.fromLTWH(867.4, 1219.97, 55.51, 61.96),
      points: [
        Offset(888.863, 1219.975),
        Offset(867.48, 1242.407),
        Offset(867.401, 1251.047),
        Offset(871.963, 1257.792),
        Offset(894, 1281.931),
        Offset(922.912, 1253.819),
        Offset(888.863, 1219.975),
      ],
    ),
    // id 119: B23 L2
    Phase2LotAnnotation(
      id: 119,
      categoryId: 246,
      name: 'B23 L2',
      bbox: Rect.fromLTWH(896.46, 1255.36, 62.79, 58.82),
      points: [
        Offset(896.46, 1284.417),
        Offset(922.984, 1314.002),
        Offset(932.54, 1314.18),
        Offset(959.25, 1288.433),
        Offset(925.065, 1255.357),
        Offset(896.46, 1284.417),
      ],
    ),
    // id 120: B23 L3
    Phase2LotAnnotation(
      id: 120,
      categoryId: 247,
      name: 'B23 L3',
      bbox: Rect.fromLTWH(889.42, 1201.23, 54.23, 51.71),
      points: [
        Offset(889.419, 1220.114),
        Offset(923.354, 1252.939),
        Offset(943.648, 1233.218),
        Offset(908.458, 1201.231),
        Offset(889.419, 1220.114),
      ],
    ),
    // id 121: B23 L4
    Phase2LotAnnotation(
      id: 121,
      categoryId: 248,
      name: 'B23 L4',
      bbox: Rect.fromLTWH(924.97, 1235.67, 54.15, 52.73),
      points: [
        Offset(924.972, 1255.47),
        Offset(958.965, 1288.409),
        Offset(979.127, 1268.694),
        Offset(944.439, 1235.675),
        Offset(924.972, 1255.47),
      ],
    ),
    // id 122: B23 L5
    Phase2LotAnnotation(
      id: 122,
      categoryId: 249,
      name: 'B23 L5',
      bbox: Rect.fromLTWH(909.14, 1180.81, 53.39, 52.41),
      points: [
        Offset(962.529, 1214.792),
        Offset(928.566, 1180.806),
        Offset(909.142, 1200.362),
        Offset(943.517, 1233.214),
        Offset(962.529, 1214.792),
      ],
    ),
    // id 123: B23 L6
    Phase2LotAnnotation(
      id: 123,
      categoryId: 250,
      name: 'B23 L6',
      bbox: Rect.fromLTWH(945.27, 1216.3, 52.94, 52.58),
      points: [
        Offset(945.269, 1235.38),
        Offset(978.615, 1268.882),
        Offset(998.213, 1248.619),
        Offset(964.429, 1216.3),
        Offset(945.269, 1235.38),
      ],
    ),
    // id 124: B23 L7
    Phase2LotAnnotation(
      id: 124,
      categoryId: 251,
      name: 'B23 L7',
      bbox: Rect.fromLTWH(929.35, 1161.25, 52.99, 53.15),
      points: [
        Offset(929.348, 1180.795),
        Offset(962.944, 1214.398),
        Offset(982.338, 1194.416),
        Offset(947.901, 1161.55),
        Offset(947.822, 1161.251),
        Offset(929.348, 1180.795),
      ],
    ),
    // id 125: B23 L8
    Phase2LotAnnotation(
      id: 125,
      categoryId: 252,
      name: 'B23 L8',
      bbox: Rect.fromLTWH(964.95, 1196, 52.71, 52.8),
      points: [
        Offset(964.952, 1215.931),
        Offset(999.225, 1248.803),
        Offset(1017.659, 1229.198),
        Offset(984.419, 1196.003),
        Offset(964.952, 1215.931),
      ],
    ),
    // id 126: B23 L9
    Phase2LotAnnotation(
      id: 126,
      categoryId: 253,
      name: 'B23 L9',
      bbox: Rect.fromLTWH(948.37, 1141.88, 54.34, 52.48),
      points: [
        Offset(948.37, 1161.207),
        Offset(982.616, 1194.356),
        Offset(1002.71, 1174.032),
        Offset(968.427, 1141.877),
        Offset(948.37, 1161.207),
      ],
    ),
    // id 127: B23 L10
    Phase2LotAnnotation(
      id: 127,
      categoryId: 241,
      name: 'B23 L10',
      bbox: Rect.fromLTWH(984.8, 1176.63, 52.96, 52.72),
      points: [
        Offset(984.798, 1195.811),
        Offset(1018.404, 1229.351),
        Offset(1037.756, 1209.31),
        Offset(1004.101, 1176.628),
        Offset(984.798, 1195.811),
      ],
    ),
    // id 128: B23 L11
    Phase2LotAnnotation(
      id: 128,
      categoryId: 242,
      name: 'B23 L11',
      bbox: Rect.fromLTWH(968.67, 1122.41, 53.51, 52.03),
      points: [
        Offset(968.67, 1140.637),
        Offset(1002.276, 1174.438),
        Offset(1022.181, 1155.077),
        Offset(987.57, 1122.409),
        Offset(968.67, 1140.637),
      ],
    ),
    // id 129: B23 L12
    Phase2LotAnnotation(
      id: 129,
      categoryId: 243,
      name: 'B23 L12',
      bbox: Rect.fromLTWH(1004.42, 1156.33, 53.26, 53.15),
      points: [
        Offset(1004.419, 1176.282),
        Offset(1037.766, 1209.483),
        Offset(1057.675, 1189.824),
        Offset(1023.476, 1156.331),
        Offset(1004.419, 1176.282),
      ],
    ),
    // id 131: B23 L14
    Phase2LotAnnotation(
      id: 131,
      categoryId: 244,
      name: 'B23 L14',
      bbox: Rect.fromLTWH(1023.76, 1125.89, 58.68, 64.36),
      points: [
        Offset(1023.756, 1156.797),
        Offset(1057.721, 1190.241),
        Offset(1082.438, 1166.263),
        Offset(1069.116, 1157.161),
        Offset(1054.914, 1126.584),
        Offset(1054.844, 1125.885),
        Offset(1023.756, 1156.797),
      ],
    ),
    // id 130: B23 L15
    Phase2LotAnnotation(
      id: 130,
      categoryId: 245,
      name: 'B23 L15',
      bbox: Rect.fromLTWH(988.09, 1104.49, 66.8, 50.62),
      points: [
        Offset(988.09, 1121.737),
        Offset(1022.058, 1155.115),
        Offset(1054.89, 1122.997),
        Offset(1039.852, 1109.402),
        Offset(1006.523, 1104.491),
        Offset(988.09, 1121.737),
      ],
    ),
    // id 132: B24 L1
    Phase2LotAnnotation(
      id: 132,
      categoryId: 262,
      name: 'B24 L1',
      bbox: Rect.fromLTWH(1019.03, 1058.79, 65.07, 50.48),
      points: [
        Offset(1084.107, 1092.819),
        Offset(1050.423, 1058.794),
        Offset(1019.034, 1090.145),
        Offset(1044.362, 1092.173),
        Offset(1058.616, 1101.63),
        Offset(1067.453, 1109.278),
        Offset(1084.107, 1092.819),
      ],
    ),
    // id 133: B24 L2
    Phase2LotAnnotation(
      id: 133,
      categoryId: 263,
      name: 'B24 L2',
      bbox: Rect.fromLTWH(1068.99, 1094.91, 50.11, 58.61),
      points: [
        Offset(1073.192, 1127.016),
        Offset(1082.628, 1145.113),
        Offset(1093.8, 1153.516),
        Offset(1119.103, 1128.027),
        Offset(1085.788, 1094.907),
        Offset(1068.991, 1111.123),
        Offset(1073.192, 1127.016),
      ],
    ),
    // id 134: B24 L3
    Phase2LotAnnotation(
      id: 134,
      categoryId: 264,
      name: 'B24 L3',
      bbox: Rect.fromLTWH(1050.72, 1039.58, 52.93, 53.09),
      points: [
        Offset(1103.656, 1073.198),
        Offset(1070.066, 1039.578),
        Offset(1050.725, 1059.233),
        Offset(1084.06, 1092.671),
        Offset(1103.656, 1073.198),
      ],
    ),
    // id 135: B24 L4
    Phase2LotAnnotation(
      id: 135,
      categoryId: 265,
      name: 'B24 L4',
      bbox: Rect.fromLTWH(1085.61, 1075.39, 53.3, 52.47),
      points: [
        Offset(1085.612, 1094.426),
        Offset(1119.275, 1127.856),
        Offset(1138.915, 1108.489),
        Offset(1105.455, 1075.387),
        Offset(1085.612, 1094.426),
      ],
    ),
    // id 136: B24 L5
    Phase2LotAnnotation(
      id: 136,
      categoryId: 266,
      name: 'B24 L5',
      bbox: Rect.fromLTWH(1070.2, 1018.86, 53.19, 54.08),
      points: [
        Offset(1070.202, 1038.827),
        Offset(1104.486, 1072.944),
        Offset(1123.39, 1053.191),
        Offset(1089.596, 1018.863),
        Offset(1070.202, 1038.827),
      ],
    ),
    // id 137: B24 L6
    Phase2LotAnnotation(
      id: 137,
      categoryId: 267,
      name: 'B24 L6',
      bbox: Rect.fromLTWH(1105.88, 1054.84, 52.85, 52.97),
      points: [
        Offset(1105.881, 1074.591),
        Offset(1138.758, 1107.814),
        Offset(1158.726, 1088.848),
        Offset(1125.577, 1054.844),
        Offset(1105.881, 1074.591),
      ],
    ),
    // id 138: B24 L7
    Phase2LotAnnotation(
      id: 138,
      categoryId: 268,
      name: 'B24 L7',
      bbox: Rect.fromLTWH(1090.43, 999.78, 52.99, 53.57),
      points: [
        Offset(1090.429, 1019.546),
        Offset(1123.518, 1053.349),
        Offset(1143.415, 1033.981),
        Offset(1110.199, 999.779),
        Offset(1109.278, 999.796),
        Offset(1090.429, 1019.546),
      ],
    ),
    // id 139: B24 L8
    Phase2LotAnnotation(
      id: 139,
      categoryId: 269,
      name: 'B24 L8',
      bbox: Rect.fromLTWH(1125.58, 1035.78, 52.65, 52.4),
      points: [
        Offset(1125.576, 1055.248),
        Offset(1158.92, 1088.182),
        Offset(1178.228, 1069.141),
        Offset(1145.259, 1035.777),
        Offset(1125.576, 1055.248),
      ],
    ),
    // id 140: B24 L9
    Phase2LotAnnotation(
      id: 140,
      categoryId: 270,
      name: 'B24 L9',
      bbox: Rect.fromLTWH(1110.15, 980.42, 53.32, 52.94),
      points: [
        Offset(1110.148, 999.741),
        Offset(1143.325, 1033.365),
        Offset(1163.47, 1013.655),
        Offset(1129.268, 980.421),
        Offset(1110.148, 999.741),
      ],
    ),
    // id 141: B24 10
    Phase2LotAnnotation(
      id: 141,
      categoryId: 254,
      name: 'B24 10',
      bbox: Rect.fromLTWH(1145.22, 1015.48, 53.31, 53.28),
      points: [
        Offset(1145.22, 1035.876),
        Offset(1178.645, 1068.758),
        Offset(1198.534, 1049.279),
        Offset(1164.019, 1015.48),
        Offset(1145.22, 1035.876),
      ],
    ),
    // id 142: B24 11
    Phase2LotAnnotation(
      id: 142,
      categoryId: 255,
      name: 'B24 11',
      bbox: Rect.fromLTWH(1130, 960.57, 52.89, 52.65),
      points: [
        Offset(1182.892, 994.054),
        Offset(1148.791, 960.569),
        Offset(1130.002, 979.943),
        Offset(1162.692, 1013.19),
        Offset(1163.16, 1012.736),
        Offset(1163.498, 1013.219),
        Offset(1182.892, 994.054),
      ],
    ),
    // id 143: B24 12
    Phase2LotAnnotation(
      id: 143,
      categoryId: 256,
      name: 'B24 12',
      bbox: Rect.fromLTWH(1164.36, 995.8, 53.67, 53.24),
      points: [
        Offset(1164.357, 1015.278),
        Offset(1197.978, 1049.042),
        Offset(1218.032, 1029.453),
        Offset(1184.009, 995.798),
        Offset(1164.357, 1015.278),
      ],
    ),
    // id 144: B24 13
    Phase2LotAnnotation(
      id: 144,
      categoryId: 257,
      name: 'B24 13',
      bbox: Rect.fromLTWH(1149.11, 941.36, 53.92, 52.49),
      points: [
        Offset(1149.114, 960.348),
        Offset(1183.051, 993.856),
        Offset(1203.038, 974.79),
        Offset(1168.325, 941.364),
        Offset(1149.114, 960.348),
      ],
    ),
    // id 145: B24 14
    Phase2LotAnnotation(
      id: 145,
      categoryId: 258,
      name: 'B24 14',
      bbox: Rect.fromLTWH(1184.22, 976.42, 53.45, 52.66),
      points: [
        Offset(1184.222, 995.921),
        Offset(1217.891, 1029.087),
        Offset(1237.672, 1009.567),
        Offset(1203.691, 976.423),
        Offset(1184.222, 995.921),
      ],
    ),
    // id 147: B24 16
    Phase2LotAnnotation(
      id: 147,
      categoryId: 259,
      name: 'B24 16',
      bbox: Rect.fromLTWH(1204.1, 956.43, 53.17, 53.62),
      points: [
        Offset(1204.102, 976.28),
        Offset(1237.909, 1010.056),
        Offset(1257.271, 990.394),
        Offset(1223.681, 956.433),
        Offset(1204.102, 976.28),
      ],
    ),
    // id 146: B24 17
    Phase2LotAnnotation(
      id: 146,
      categoryId: 260,
      name: 'B24 17',
      bbox: Rect.fromLTWH(1169.06, 915.62, 76.37, 59.65),
      points: [
        Offset(1201.388, 975.272),
        Offset(1245.433, 931.589),
        Offset(1211.293, 915.62),
        Offset(1191.273, 918.15),
        Offset(1169.061, 940.773),
        Offset(1201.388, 975.272),
      ],
    ),
    // id 148: B24 18
    Phase2LotAnnotation(
      id: 148,
      categoryId: 261,
      name: 'B24 18',
      bbox: Rect.fromLTWH(1224.57, 933.06, 60.9, 56.82),
      points: [
        Offset(1224.57, 956.001),
        Offset(1257.79, 989.878),
        Offset(1280.195, 968.192),
        Offset(1285.374, 961.177),
        Offset(1285.471, 953.235),
        Offset(1282.45, 948.759),
        Offset(1275.494, 945.249),
        Offset(1246.955, 933.063),
        Offset(1224.57, 956.001),
      ],
    ),
    // id 14: B25 L1
    Phase2LotAnnotation(
      id: 14,
      categoryId: 271,
      name: 'B25 L1',
      bbox: Rect.fromLTWH(947.45, 1307.76, 39.66, 45.76),
      points: [
        Offset(971.106, 1307.762),
        Offset(947.813, 1331.574),
        Offset(947.45, 1338.163),
        Offset(948.493, 1344.035),
        Offset(958.202, 1353.52),
        Offset(987.109, 1324.385),
        Offset(971.106, 1307.762),
      ],
    ),
    // id 15: B25 L2
    Phase2LotAnnotation(
      id: 15,
      categoryId: 281,
      name: 'B25 L2',
      bbox: Rect.fromLTWH(959.77, 1325.48, 46.09, 41.28),
      points: [
        Offset(970.754, 1366.535),
        Offset(976.076, 1366.76),
        Offset(982.024, 1364.842),
        Offset(1005.86, 1342.845),
        Offset(990.039, 1325.482),
        Offset(959.77, 1356.178),
        Offset(970.754, 1366.535),
      ],
    ),
    // id 16: B25 L3
    Phase2LotAnnotation(
      id: 16,
      categoryId: 292,
      name: 'B25 L3',
      bbox: Rect.fromLTWH(971.48, 1291.21, 32.82, 33.08),
      points: [
        Offset(971.478, 1307.697),
        Offset(987.739, 1324.287),
        Offset(1004.293, 1307.562),
        Offset(988.085, 1291.21),
        Offset(971.478, 1307.697),
      ],
    ),
    // id 17: B25 L4
    Phase2LotAnnotation(
      id: 17,
      categoryId: 298,
      name: 'B25 L4',
      bbox: Rect.fromLTWH(989.21, 1309.75, 32.3, 31.91),
      points: [
        Offset(989.212, 1325.05),
        Offset(1005.443, 1341.662),
        Offset(1021.512, 1325.802),
        Offset(1007.185, 1309.887),
        Offset(1005.973, 1309.749),
        Offset(989.212, 1325.05),
      ],
    ),
    // id 18: B25 L5
    Phase2LotAnnotation(
      id: 18,
      categoryId: 299,
      name: 'B25 L5',
      bbox: Rect.fromLTWH(988.33, 1274.62, 32.85, 33.12),
      points: [
        Offset(988.327, 1290.769),
        Offset(1004.898, 1307.744),
        Offset(1021.174, 1290.941),
        Offset(1004.021, 1274.623),
        Offset(988.327, 1290.769),
      ],
    ),
    // id 19: B25 L6
    Phase2LotAnnotation(
      id: 19,
      categoryId: 300,
      name: 'B25 L6',
      bbox: Rect.fromLTWH(1006.44, 1293.48, 32.46, 31.75),
      points: [
        Offset(1006.435, 1308.865),
        Offset(1022.513, 1325.236),
        Offset(1038.893, 1308.508),
        Offset(1022.37, 1293.484),
        Offset(1006.435, 1308.865),
      ],
    ),
    // id 20: B25 L7
    Phase2LotAnnotation(
      id: 20,
      categoryId: 301,
      name: 'B25 L7',
      bbox: Rect.fromLTWH(1004.91, 1259.34, 32.19, 31.32),
      points: [
        Offset(1004.908, 1274.59),
        Offset(1020.782, 1290.654),
        Offset(1037.097, 1274.99),
        Offset(1020.609, 1259.336),
        Offset(1004.908, 1274.59),
      ],
    ),
    // id 21: B25 L8
    Phase2LotAnnotation(
      id: 21,
      categoryId: 302,
      name: 'B25 L8',
      bbox: Rect.fromLTWH(1022.95, 1276.25, 31.88, 32.21),
      points: [
        Offset(1022.95, 1292.315),
        Offset(1038.947, 1308.462),
        Offset(1054.829, 1292.554),
        Offset(1038.497, 1276.249),
        Offset(1022.95, 1292.315),
      ],
    ),
    // id 22: B25 L9
    Phase2LotAnnotation(
      id: 22,
      categoryId: 303,
      name: 'B25 L9',
      bbox: Rect.fromLTWH(1020.67, 1242.28, 33.4, 31.99),
      points: [
        Offset(1020.671, 1258.563),
        Offset(1036.716, 1274.264),
        Offset(1054.072, 1258.124),
        Offset(1036.777, 1242.276),
        Offset(1020.671, 1258.563),
      ],
    ),
    // id 23: B25 L10
    Phase2LotAnnotation(
      id: 23,
      categoryId: 272,
      name: 'B25 L10',
      bbox: Rect.fromLTWH(1039.17, 1259.34, 31.9, 32.62),
      points: [
        Offset(1039.167, 1275.725),
        Offset(1055.392, 1291.952),
        Offset(1071.066, 1276.33),
        Offset(1055.41, 1259.336),
        Offset(1039.167, 1275.725),
      ],
    ),
    // id 25: B25 L11
    Phase2LotAnnotation(
      id: 25,
      categoryId: 273,
      name: 'B25 L11',
      bbox: Rect.fromLTWH(1037.18, 1225.89, 33, 32.12),
      points: [
        Offset(1037.184, 1242.077),
        Offset(1053.94, 1258.011),
        Offset(1070.188, 1241.388),
        Offset(1053.466, 1225.888),
        Offset(1037.184, 1242.077),
      ],
    ),
    // id 26: B25 L12
    Phase2LotAnnotation(
      id: 26,
      categoryId: 274,
      name: 'B25 L12',
      bbox: Rect.fromLTWH(1055.76, 1243.78, 32.01, 31.79),
      points: [
        Offset(1055.758, 1260.268),
        Offset(1072.115, 1275.576),
        Offset(1087.766, 1260.016),
        Offset(1071.943, 1243.783),
        Offset(1055.758, 1260.268),
      ],
    ),
    // id 28: B25 L14
    Phase2LotAnnotation(
      id: 28,
      categoryId: 275,
      name: 'B25 L14',
      bbox: Rect.fromLTWH(1072.41, 1227.64, 31.34, 31.87),
      points: [
        Offset(1072.414, 1243.725),
        Offset(1087.639, 1259.508),
        Offset(1103.754, 1243.68),
        Offset(1088.171, 1227.641),
        Offset(1072.414, 1243.725),
      ],
    ),
    // id 27: B25 L15
    Phase2LotAnnotation(
      id: 27,
      categoryId: 276,
      name: 'B25 L15',
      bbox: Rect.fromLTWH(1054.19, 1209.05, 32.18, 32.69),
      points: [
        Offset(1054.19, 1225.216),
        Offset(1070.202, 1241.738),
        Offset(1086.368, 1225.72),
        Offset(1070.115, 1209.049),
        Offset(1054.19, 1225.216),
      ],
    ),
    // id 30: B25 L16
    Phase2LotAnnotation(
      id: 30,
      categoryId: 277,
      name: 'B25 L16',
      bbox: Rect.fromLTWH(1088.43, 1211.29, 32.65, 31.78),
      points: [
        Offset(1088.427, 1226.998),
        Offset(1104.748, 1243.067),
        Offset(1121.074, 1226.688),
        Offset(1104.163, 1211.289),
        Offset(1088.427, 1226.998),
      ],
    ),
    // id 29: B25 L17
    Phase2LotAnnotation(
      id: 29,
      categoryId: 278,
      name: 'B25 L17',
      bbox: Rect.fromLTWH(1070.53, 1192.83, 31.67, 32.03),
      points: [
        Offset(1070.527, 1208.665),
        Offset(1086.388, 1224.856),
        Offset(1102.202, 1209.105),
        Offset(1086.111, 1192.825),
        Offset(1070.527, 1208.665),
      ],
    ),
    // id 31: B25 L18
    Phase2LotAnnotation(
      id: 31,
      categoryId: 279,
      name: 'B25 L18',
      bbox: Rect.fromLTWH(1103.9, 1194.36, 32.85, 31.95),
      points: [
        Offset(1103.9, 1210.954),
        Offset(1120.211, 1226.307),
        Offset(1136.747, 1210.872),
        Offset(1120.718, 1194.361),
        Offset(1103.9, 1210.954),
      ],
    ),
    // id 32: B25 L19
    Phase2LotAnnotation(
      id: 32,
      categoryId: 280,
      name: 'B25 L19',
      bbox: Rect.fromLTWH(1086.67, 1179.27, 45.23, 29.2),
      points: [
        Offset(1102.489, 1208.47),
        Offset(1131.904, 1179.344),
        Offset(1100.154, 1179.268),
        Offset(1086.675, 1192.331),
        Offset(1102.489, 1208.47),
      ],
    ),
    // id 33: B25 L20
    Phase2LotAnnotation(
      id: 33,
      categoryId: 282,
      name: 'B25 L20',
      bbox: Rect.fromLTWH(1121.26, 1180.26, 39.22, 30.41),
      points: [
        Offset(1121.264, 1193.951),
        Offset(1136.747, 1210.669),
        Offset(1160.481, 1186.842),
        Offset(1153.41, 1182.561),
        Offset(1134.784, 1180.257),
        Offset(1121.264, 1193.951),
      ],
    ),
    // id 34: B25 L21
    Phase2LotAnnotation(
      id: 34,
      categoryId: 283,
      name: 'B25 L21',
      bbox: Rect.fromLTWH(1117.2, 1133.64, 44.42, 30.56),
      points: [
        Offset(1117.197, 1161.67),
        Offset(1146.952, 1164.203),
        Offset(1161.614, 1149.946),
        Offset(1145.524, 1133.641),
        Offset(1117.197, 1161.67),
      ],
    ),
    // id 35: B25 L22
    Phase2LotAnnotation(
      id: 35,
      categoryId: 284,
      name: 'B25 L22',
      bbox: Rect.fromLTWH(1149.8, 1145.07, 36.2, 28.46),
      points: [
        Offset(1149.799, 1164.828),
        Offset(1158.411, 1165.532),
        Offset(1172.934, 1173.531),
        Offset(1186.004, 1160.623),
        Offset(1169.746, 1145.067),
        Offset(1149.799, 1164.828),
      ],
    ),
    // id 36: B25 L23
    Phase2LotAnnotation(
      id: 36,
      categoryId: 285,
      name: 'B25 L23',
      bbox: Rect.fromLTWH(1146.46, 1110.79, 38.41, 38.12),
      points: [
        Offset(1146.462, 1133.149),
        Offset(1161.759, 1148.909),
        Offset(1184.872, 1127.077),
        Offset(1168.146, 1110.79),
        Offset(1146.462, 1133.149),
      ],
    ),
    // id 37: B25 L24
    Phase2LotAnnotation(
      id: 37,
      categoryId: 286,
      name: 'B25 L24',
      bbox: Rect.fromLTWH(1170.03, 1128.15, 32.72, 32.46),
      points: [
        Offset(1170.026, 1144.328),
        Offset(1187.091, 1160.615),
        Offset(1202.748, 1144.585),
        Offset(1186.356, 1128.151),
        Offset(1170.026, 1144.328),
      ],
    ),
    // id 38: B25 L25
    Phase2LotAnnotation(
      id: 38,
      categoryId: 287,
      name: 'B25 L25',
      bbox: Rect.fromLTWH(1169.26, 1094.39, 32.33, 32.01),
      points: [
        Offset(1169.263, 1110.498),
        Offset(1185.082, 1126.396),
        Offset(1201.589, 1109.997),
        Offset(1184.951, 1094.386),
        Offset(1169.263, 1110.498),
      ],
    ),
    // id 39: B25 L26
    Phase2LotAnnotation(
      id: 39,
      categoryId: 288,
      name: 'B25 L26',
      bbox: Rect.fromLTWH(1187.02, 1111.93, 32.27, 31.81),
      points: [
        Offset(1187.021, 1128.041),
        Offset(1202.517, 1143.737),
        Offset(1219.291, 1127.521),
        Offset(1202.651, 1111.932),
        Offset(1187.021, 1128.041),
      ],
    ),
    // id 40: B25 L27
    Phase2LotAnnotation(
      id: 40,
      categoryId: 289,
      name: 'B25 L27',
      bbox: Rect.fromLTWH(1185.77, 1078.11, 32.76, 31.5),
      points: [
        Offset(1185.77, 1094.188),
        Offset(1202.6, 1109.614),
        Offset(1218.532, 1093.762),
        Offset(1201.737, 1078.113),
        Offset(1185.77, 1094.188),
      ],
    ),
    // id 41: B25 L28
    Phase2LotAnnotation(
      id: 41,
      categoryId: 290,
      name: 'B25 L28',
      bbox: Rect.fromLTWH(1203.38, 1095.94, 32.41, 31.63),
      points: [
        Offset(1203.383, 1111.803),
        Offset(1219.465, 1127.568),
        Offset(1235.794, 1110.95),
        Offset(1219.561, 1095.937),
        Offset(1203.383, 1111.803),
      ],
    ),
    // id 42: B25 L29
    Phase2LotAnnotation(
      id: 42,
      categoryId: 291,
      name: 'B25 L29',
      bbox: Rect.fromLTWH(1202.03, 1061.13, 32.1, 31.97),
      points: [
        Offset(1202.031, 1077.839),
        Offset(1218.569, 1093.098),
        Offset(1234.133, 1077.292),
        Offset(1218.197, 1061.171),
        Offset(1218.434, 1061.82),
        Offset(1218.033, 1061.128),
        Offset(1202.031, 1077.839),
      ],
    ),
    // id 43: B25 L30
    Phase2LotAnnotation(
      id: 43,
      categoryId: 293,
      name: 'B25 L30',
      bbox: Rect.fromLTWH(1220.21, 1079.49, 31.83, 31.64),
      points: [
        Offset(1220.208, 1095.089),
        Offset(1235.785, 1111.136),
        Offset(1252.034, 1095.08),
        Offset(1235.12, 1079.495),
        Offset(1220.208, 1095.089),
      ],
    ),
    // id 44: B25 L31
    Phase2LotAnnotation(
      id: 44,
      categoryId: 294,
      name: 'B25 L31',
      bbox: Rect.fromLTWH(1219.24, 1044.75, 31.61, 32.2),
      points: [
        Offset(1219.235, 1060.516),
        Offset(1234.435, 1076.95),
        Offset(1250.846, 1060.928),
        Offset(1233.5, 1044.75),
        Offset(1219.235, 1060.516),
      ],
    ),
    // id 45: B25 L32
    Phase2LotAnnotation(
      id: 45,
      categoryId: 295,
      name: 'B25 L32',
      bbox: Rect.fromLTWH(1236.44, 1062.99, 31.81, 31.42),
      points: [
        Offset(1236.438, 1079.422),
        Offset(1252.013, 1094.416),
        Offset(1268.246, 1078.861),
        Offset(1252.984, 1062.994),
        Offset(1252.466, 1063.031),
        Offset(1236.438, 1079.422),
      ],
    ),
    // id 46: B25 L33
    Phase2LotAnnotation(
      id: 46,
      categoryId: 296,
      name: 'B25 L33',
      bbox: Rect.fromLTWH(1235.02, 1028.3, 31.91, 32.12),
      points: [
        Offset(1235.018, 1044.638),
        Offset(1251.056, 1060.416),
        Offset(1266.928, 1044.606),
        Offset(1250.638, 1028.298),
        Offset(1235.018, 1044.638),
      ],
    ),
    // id 47: B25 L34
    Phase2LotAnnotation(
      id: 47,
      categoryId: 297,
      name: 'B25 L34',
      bbox: Rect.fromLTWH(1252.7, 1046.52, 32.21, 31.93),
      points: [
        Offset(1252.698, 1062.603),
        Offset(1268.636, 1078.454),
        Offset(1284.908, 1062.309),
        Offset(1268.901, 1046.523),
        Offset(1252.698, 1062.603),
      ],
    ),
    // id 82: B26 L1
    Phase2LotAnnotation(
      id: 82,
      categoryId: 304,
      name: 'B26 L1',
      bbox: Rect.fromLTWH(1254.16, 1010.23, 32.1, 31.27),
      points: [
        Offset(1254.16, 1025.244),
        Offset(1270.163, 1041.501),
        Offset(1286.259, 1025.868),
        Offset(1270.51, 1010.686),
        Offset(1269.11, 1010.234),
        Offset(1254.16, 1025.244),
      ],
    ),
    // id 83: B26 L2
    Phase2LotAnnotation(
      id: 83,
      categoryId: 314,
      name: 'B26 L2',
      bbox: Rect.fromLTWH(1271.95, 1027.87, 32.29, 31.36),
      points: [
        Offset(1271.945, 1043.103),
        Offset(1287.867, 1059.237),
        Offset(1304.231, 1042.767),
        Offset(1288.21, 1027.873),
        Offset(1271.945, 1043.103),
      ],
    ),
    // id 84: B26 L3
    Phase2LotAnnotation(
      id: 84,
      categoryId: 325,
      name: 'B26 L3',
      bbox: Rect.fromLTWH(1270.1, 993.84, 32.3, 31.2),
      points: [
        Offset(1270.099, 1009.024),
        Offset(1286.62, 1025.046),
        Offset(1302.4, 1008.879),
        Offset(1286.408, 993.843),
        Offset(1270.099, 1009.024),
      ],
    ),
    // id 85: B26 L4
    Phase2LotAnnotation(
      id: 85,
      categoryId: 334,
      name: 'B26 L4',
      bbox: Rect.fromLTWH(1288.42, 1011.43, 32.35, 31.62),
      points: [
        Offset(1288.421, 1027.017),
        Offset(1304.32, 1043.051),
        Offset(1320.769, 1027.125),
        Offset(1304.36, 1011.427),
        Offset(1288.421, 1027.017),
      ],
    ),
    // id 86: B26 L5
    Phase2LotAnnotation(
      id: 86,
      categoryId: 335,
      name: 'B26 L5',
      bbox: Rect.fromLTWH(1287.08, 976.58, 31.42, 32.67),
      points: [
        Offset(1287.081, 993.124),
        Offset(1302.922, 1009.252),
        Offset(1318.5, 993.103),
        Offset(1302.829, 976.582),
        Offset(1287.081, 993.124),
      ],
    ),
    // id 87: B26 L6
    Phase2LotAnnotation(
      id: 87,
      categoryId: 336,
      name: 'B26 L6',
      bbox: Rect.fromLTWH(1304.72, 994.76, 31.68, 31.56),
      points: [
        Offset(1304.722, 1011.037),
        Offset(1320.02, 1026.319),
        Offset(1336.398, 1010.468),
        Offset(1320.404, 994.76),
        Offset(1304.722, 1011.037),
      ],
    ),
    // id 88: B26 L7
    Phase2LotAnnotation(
      id: 88,
      categoryId: 337,
      name: 'B26 L7',
      bbox: Rect.fromLTWH(1302.88, 960.6, 32.77, 31.88),
      points: [
        Offset(1302.881, 976.099),
        Offset(1319.216, 992.478),
        Offset(1335.652, 976.38),
        Offset(1318.919, 960.596),
        Offset(1302.881, 976.099),
      ],
    ),
    // id 89: B26 L8
    Phase2LotAnnotation(
      id: 89,
      categoryId: 338,
      name: 'B26 L8',
      bbox: Rect.fromLTWH(1320.77, 979.21, 32.73, 31.38),
      points: [
        Offset(1320.766, 994.267),
        Offset(1337.409, 1010.591),
        Offset(1353.498, 993.923),
        Offset(1337.124, 979.238),
        Offset(1336.698, 979.206),
        Offset(1320.766, 994.267),
      ],
    ),
    // id 90: B26 L9
    Phase2LotAnnotation(
      id: 90,
      categoryId: 339,
      name: 'B26 L9',
      bbox: Rect.fromLTWH(1319.98, 944.09, 31.81, 32.18),
      points: [
        Offset(1319.978, 960.207),
        Offset(1335.573, 976.27),
        Offset(1351.789, 960.442),
        Offset(1335.619, 944.094),
        Offset(1319.978, 960.207),
      ],
    ),
    // id 91: B26 L10
    Phase2LotAnnotation(
      id: 91,
      categoryId: 305,
      name: 'B26 L10',
      bbox: Rect.fromLTWH(1337.95, 962.46, 31.84, 31.25),
      points: [
        Offset(1337.946, 977.778),
        Offset(1353.232, 993.707),
        Offset(1369.787, 976.977),
        Offset(1353.151, 962.461),
        Offset(1337.946, 977.778),
      ],
    ),
    // id 92: B26 L11
    Phase2LotAnnotation(
      id: 92,
      categoryId: 306,
      name: 'B26 L11',
      bbox: Rect.fromLTWH(1336.19, 927.45, 32.82, 32.49),
      points: [
        Offset(1336.191, 944.033),
        Offset(1352.349, 959.941),
        Offset(1369.012, 942.984),
        Offset(1352.064, 927.449),
        Offset(1336.191, 944.033),
      ],
    ),
    // id 93: B26 L12
    Phase2LotAnnotation(
      id: 93,
      categoryId: 307,
      name: 'B26 L12',
      bbox: Rect.fromLTWH(1353.85, 945.26, 32.03, 31.77),
      points: [
        Offset(1353.847, 961.387),
        Offset(1370.084, 977.038),
        Offset(1385.873, 960.689),
        Offset(1371.035, 945.773),
        Offset(1370.505, 945.265),
        Offset(1353.847, 961.387),
      ],
    ),
    // id 94: B26 L14
    Phase2LotAnnotation(
      id: 94,
      categoryId: 308,
      name: 'B26 L14',
      bbox: Rect.fromLTWH(1371.1, 929.28, 31.17, 31.31),
      points: [
        Offset(1371.095, 944.978),
        Offset(1386.754, 960.593),
        Offset(1402.263, 944.351),
        Offset(1386.155, 929.279),
        Offset(1385.969, 930.015),
        Offset(1371.095, 944.978),
      ],
    ),
    // id 95: B26 L15
    Phase2LotAnnotation(
      id: 95,
      categoryId: 309,
      name: 'B26 L15',
      bbox: Rect.fromLTWH(1352.64, 911.72, 32.05, 31.05),
      points: [
        Offset(1352.638, 926.94),
        Offset(1369.064, 942.768),
        Offset(1384.692, 927.427),
        Offset(1368.798, 911.856),
        Offset(1368.079, 911.72),
        Offset(1352.638, 926.94),
      ],
    ),
    // id 97: B26 L16
    Phase2LotAnnotation(
      id: 97,
      categoryId: 310,
      name: 'B26 L16',
      bbox: Rect.fromLTWH(1386.59, 912.29, 32.29, 31.97),
      points: [
        Offset(1386.59, 928.573),
        Offset(1402.297, 944.263),
        Offset(1418.883, 928.367),
        Offset(1403.136, 912.289),
        Offset(1403.501, 913.517),
        Offset(1402.918, 912.335),
        Offset(1386.59, 928.573),
      ],
    ),
    // id 96: B26 L17
    Phase2LotAnnotation(
      id: 96,
      categoryId: 311,
      name: 'B26 L17',
      bbox: Rect.fromLTWH(1368.99, 894.93, 32.42, 31.74),
      points: [
        Offset(1368.991, 910.404),
        Offset(1384.856, 926.671),
        Offset(1401.407, 910.441),
        Offset(1384.93, 894.93),
        Offset(1368.991, 910.404),
      ],
    ),
    // id 99: B26 L18
    Phase2LotAnnotation(
      id: 99,
      categoryId: 312,
      name: 'B26 L18',
      bbox: Rect.fromLTWH(1403.18, 896.27, 31.85, 31.46),
      points: [
        Offset(1403.182, 911.888),
        Offset(1419.029, 927.727),
        Offset(1435.029, 911.8),
        Offset(1420.042, 896.711),
        Offset(1419.138, 896.267),
        Offset(1403.182, 911.888),
      ],
    ),
    // id 98: B26 L19
    Phase2LotAnnotation(
      id: 98,
      categoryId: 313,
      name: 'B26 L19',
      bbox: Rect.fromLTWH(1384.91, 878.58, 32.66, 31.55),
      points: [
        Offset(1384.914, 894.031),
        Offset(1401.763, 910.13),
        Offset(1417.571, 894.501),
        Offset(1401.271, 878.582),
        Offset(1384.914, 894.031),
      ],
    ),
    // id 101: B26 L20
    Phase2LotAnnotation(
      id: 101,
      categoryId: 315,
      name: 'B26 L20',
      bbox: Rect.fromLTWH(1422.73, 877.31, 31.3, 31.24),
      points: [
        Offset(1422.725, 892.238),
        Offset(1438.229, 908.55),
        Offset(1454.023, 893.027),
        Offset(1438.586, 877.308),
        Offset(1422.725, 892.238),
      ],
    ),
    // id 100: B26 L21
    Phase2LotAnnotation(
      id: 100,
      categoryId: 316,
      name: 'B26 L21',
      bbox: Rect.fromLTWH(1404.34, 858.66, 32.73, 32.61),
      points: [
        Offset(1404.337, 874.923),
        Offset(1420.849, 891.263),
        Offset(1437.067, 874.562),
        Offset(1420.064, 858.655),
        Offset(1404.337, 874.923),
      ],
    ),
    // id 103: B26 L22
    Phase2LotAnnotation(
      id: 103,
      categoryId: 317,
      name: 'B26 L22',
      bbox: Rect.fromLTWH(1438.55, 859.79, 32.64, 32.52),
      points: [
        Offset(1438.55, 876.78),
        Offset(1454.708, 892.306),
        Offset(1471.193, 876.114),
        Offset(1455.689, 860.464),
        Offset(1455.12, 859.789),
        Offset(1438.55, 876.78),
      ],
    ),
    // id 102: B26 L23
    Phase2LotAnnotation(
      id: 102,
      categoryId: 318,
      name: 'B26 L23',
      bbox: Rect.fromLTWH(1420.96, 842.18, 32.46, 32.47),
      points: [
        Offset(1420.955, 858.546),
        Offset(1437.148, 874.641),
        Offset(1453.412, 859.037),
        Offset(1436.553, 842.175),
        Offset(1420.955, 858.546),
      ],
    ),
    // id 105: B26 L24
    Phase2LotAnnotation(
      id: 105,
      categoryId: 319,
      name: 'B26 L24',
      bbox: Rect.fromLTWH(1455.42, 844.25, 32.28, 31.72),
      points: [
        Offset(1455.416, 860.193),
        Offset(1471.131, 875.975),
        Offset(1487.694, 859.679),
        Offset(1471.306, 844.252),
        Offset(1455.416, 860.193),
      ],
    ),
    // id 104: B26 L25
    Phase2LotAnnotation(
      id: 104,
      categoryId: 320,
      name: 'B26 L25',
      bbox: Rect.fromLTWH(1437.65, 825.75, 32.44, 33.01),
      points: [
        Offset(1437.65, 842.458),
        Offset(1453.678, 858.758),
        Offset(1470.094, 842.446),
        Offset(1452.739, 825.75),
        Offset(1437.65, 842.458),
      ],
    ),
    // id 107: B26 L26
    Phase2LotAnnotation(
      id: 107,
      categoryId: 321,
      name: 'B26 L26',
      bbox: Rect.fromLTWH(1471.14, 827.18, 32.68, 32.41),
      points: [
        Offset(1471.142, 844.195),
        Offset(1487.065, 859.593),
        Offset(1503.826, 842.843),
        Offset(1488.207, 827.178),
        Offset(1471.142, 844.195),
      ],
    ),
    // id 106: B26 L27
    Phase2LotAnnotation(
      id: 106,
      categoryId: 322,
      name: 'B26 L27',
      bbox: Rect.fromLTWH(1452.99, 809.09, 33.19, 32.99),
      points: [
        Offset(1452.99, 825.496),
        Offset(1470.128, 842.081),
        Offset(1486.185, 825.526),
        Offset(1470.491, 810.097),
        Offset(1469.878, 809.088),
        Offset(1452.99, 825.496),
      ],
    ),
    // id 109: B26 L28
    Phase2LotAnnotation(
      id: 109,
      categoryId: 323,
      name: 'B26 L28',
      bbox: Rect.fromLTWH(1487.69, 810.75, 32.8, 32.35),
      points: [
        Offset(1487.686, 826.616),
        Offset(1504.133, 843.107),
        Offset(1520.481, 826.666),
        Offset(1503.917, 810.754),
        Offset(1487.686, 826.616),
      ],
    ),
    // id 108: B26 L29
    Phase2LotAnnotation(
      id: 108,
      categoryId: 324,
      name: 'B26 L29',
      bbox: Rect.fromLTWH(1469.98, 793.44, 32.66, 32.09),
      points: [
        Offset(1469.976, 808.826),
        Offset(1486.586, 825.527),
        Offset(1502.636, 808.807),
        Offset(1486.023, 793.44),
        Offset(1469.976, 808.826),
      ],
    ),
    // id 110: B26 L30
    Phase2LotAnnotation(
      id: 110,
      categoryId: 326,
      name: 'B26 L30',
      bbox: Rect.fromLTWH(1504.22, 793.85, 32.63, 33.1),
      points: [
        Offset(1504.221, 810.27),
        Offset(1520.199, 826.953),
        Offset(1536.85, 809.803),
        Offset(1520.58, 793.853),
        Offset(1504.221, 810.27),
      ],
    ),
    // id 111: B26 L31
    Phase2LotAnnotation(
      id: 111,
      categoryId: 327,
      name: 'B26 L31',
      bbox: Rect.fromLTWH(1486.51, 776.67, 32.4, 32.92),
      points: [
        Offset(1503.133, 776.671),
        Offset(1486.509, 793.475),
        Offset(1502.399, 809.591),
        Offset(1518.914, 792.901),
        Offset(1503.133, 776.671),
      ],
    ),
    // id 113: B26 L32
    Phase2LotAnnotation(
      id: 113,
      categoryId: 328,
      name: 'B26 L32',
      bbox: Rect.fromLTWH(1520.11, 777.67, 33.28, 32.48),
      points: [
        Offset(1520.106, 794.021),
        Offset(1537.218, 810.149),
        Offset(1553.386, 793.944),
        Offset(1537.243, 777.667),
        Offset(1520.106, 794.021),
      ],
    ),
    // id 112: B26 L33
    Phase2LotAnnotation(
      id: 112,
      categoryId: 329,
      name: 'B26 L33',
      bbox: Rect.fromLTWH(1503.35, 760.18, 32.44, 33.23),
      points: [
        Offset(1503.346, 776.678),
        Offset(1519.362, 793.418),
        Offset(1535.789, 776.357),
        Offset(1519.199, 760.184),
        Offset(1503.346, 776.678),
      ],
    ),
    // id 115: B26 L34
    Phase2LotAnnotation(
      id: 115,
      categoryId: 330,
      name: 'B26 L34',
      bbox: Rect.fromLTWH(1536.73, 761.5, 32.95, 32.27),
      points: [
        Offset(1536.727, 777.805),
        Offset(1553.594, 793.772),
        Offset(1569.68, 777.837),
        Offset(1554.022, 761.812),
        Offset(1553.327, 761.502),
        Offset(1536.727, 777.805),
      ],
    ),
    // id 114: B26 L35
    Phase2LotAnnotation(
      id: 114,
      categoryId: 331,
      name: 'B26 L35',
      bbox: Rect.fromLTWH(1519.51, 743.59, 32.51, 32.92),
      points: [
        Offset(1519.505, 760.549),
        Offset(1535.36, 776.512),
        Offset(1552.017, 759.643),
        Offset(1535.508, 743.587),
        Offset(1519.505, 760.549),
      ],
    ),
    // id 117: B26 L36
    Phase2LotAnnotation(
      id: 117,
      categoryId: 332,
      name: 'B26 L36',
      bbox: Rect.fromLTWH(1553.67, 734.89, 38.37, 42.94),
      points: [
        Offset(1569.501, 777.827),
        Offset(1591.493, 756.489),
        Offset(1592.032, 746.392),
        Offset(1580.535, 734.889),
        Offset(1553.667, 761.004),
        Offset(1569.501, 777.827),
      ],
    ),
    // id 116: B26 L37
    Phase2LotAnnotation(
      id: 116,
      categoryId: 333,
      name: 'B26 L37',
      bbox: Rect.fromLTWH(1535.82, 721.63, 42.92, 37.95),
      points: [
        Offset(1578.744, 732.982),
        Offset(1566.509, 721.625),
        Offset(1557.433, 722.354),
        Offset(1535.824, 743.691),
        Offset(1552.001, 759.576),
        Offset(1578.744, 732.982),
      ],
    ),
    // id 1: B27 L1
    Phase2LotAnnotation(
      id: 1,
      categoryId: 340,
      name: 'B27 L1',
      bbox: Rect.fromLTWH(993.83, 1370.26, 35.69, 40.3),
      points: [
        Offset(995.185, 1384.199),
        Offset(993.825, 1389.821),
        Offset(994.841, 1395.68),
        Offset(1009.394, 1410.558),
        Offset(1029.516, 1391.113),
        Offset(1009.681, 1370.257),
        Offset(995.185, 1384.199),
      ],
    ),
    // id 2: B27 L2
    Phase2LotAnnotation(
      id: 2,
      categoryId: 345,
      name: 'B27 L2',
      bbox: Rect.fromLTWH(1009.21, 1353.68, 36.52, 36.7),
      points: [
        Offset(1009.208, 1369.911),
        Offset(1030.142, 1390.383),
        Offset(1045.732, 1374.115),
        Offset(1025.917, 1353.682),
        Offset(1009.208, 1369.911),
      ],
    ),
    // id 3: B27 L3
    Phase2LotAnnotation(
      id: 3,
      categoryId: 346,
      name: 'B27 L3',
      bbox: Rect.fromLTWH(1025.54, 1338.12, 35.91, 36.06),
      points: [
        Offset(1025.544, 1353.714),
        Offset(1045.856, 1374.186),
        Offset(1061.457, 1359.162),
        Offset(1040.123, 1338.123),
        Offset(1025.544, 1353.714),
      ],
    ),
    // id 4: B27 L4
    Phase2LotAnnotation(
      id: 4,
      categoryId: 347,
      name: 'B27 L4',
      bbox: Rect.fromLTWH(1040.93, 1322.56, 35.69, 36.37),
      points: [
        Offset(1040.933, 1338.132),
        Offset(1061.614, 1358.937),
        Offset(1076.625, 1342.824),
        Offset(1056.359, 1322.563),
        Offset(1040.933, 1338.132),
      ],
    ),
    // id 5: B27 L5
    Phase2LotAnnotation(
      id: 5,
      categoryId: 348,
      name: 'B27 L5',
      bbox: Rect.fromLTWH(1057.09, 1306.95, 36.01, 36.38),
      points: [
        Offset(1057.085, 1321.928),
        Offset(1077.71, 1343.334),
        Offset(1093.098, 1327.72),
        Offset(1071.85, 1306.952),
        Offset(1057.085, 1321.928),
      ],
    ),
    // id 6: B27 L6
    Phase2LotAnnotation(
      id: 6,
      categoryId: 349,
      name: 'B27 L6',
      bbox: Rect.fromLTWH(1072.68, 1291.11, 35.89, 35.96),
      points: [
        Offset(1072.68, 1306.369),
        Offset(1093.411, 1327.066),
        Offset(1108.568, 1311.97),
        Offset(1087.817, 1291.106),
        Offset(1072.68, 1306.369),
      ],
    ),
    // id 7: B27 L7
    Phase2LotAnnotation(
      id: 7,
      categoryId: 350,
      name: 'B27 L7',
      bbox: Rect.fromLTWH(1088.07, 1275.21, 36.75, 36.84),
      points: [
        Offset(1088.065, 1290.402),
        Offset(1109.486, 1312.046),
        Offset(1124.82, 1296.044),
        Offset(1103.038, 1275.208),
        Offset(1088.065, 1290.402),
      ],
    ),
    // id 8: B27 L8
    Phase2LotAnnotation(
      id: 8,
      categoryId: 351,
      name: 'B27 L8',
      bbox: Rect.fromLTWH(1103.91, 1259.31, 36.18, 36.67),
      points: [
        Offset(1103.91, 1274.594),
        Offset(1124.966, 1295.978),
        Offset(1140.089, 1280.113),
        Offset(1118.936, 1259.31),
        Offset(1103.91, 1274.594),
      ],
    ),
    // id 9: B27 L9
    Phase2LotAnnotation(
      id: 9,
      categoryId: 352,
      name: 'B27 L9',
      bbox: Rect.fromLTWH(1119.52, 1243.75, 36.46, 36.19),
      points: [
        Offset(1119.521, 1258.927),
        Offset(1140.939, 1279.945),
        Offset(1155.984, 1264.551),
        Offset(1134.834, 1243.751),
        Offset(1119.521, 1258.927),
      ],
    ),
    // id 10: B27 L10
    Phase2LotAnnotation(
      id: 10,
      categoryId: 341,
      name: 'B27 L10',
      bbox: Rect.fromLTWH(1136.2, 1228.53, 34.98, 35.26),
      points: [
        Offset(1136.204, 1242.4),
        Offset(1156.451, 1263.784),
        Offset(1171.18, 1248.411),
        Offset(1150.393, 1228.529),
        Offset(1136.204, 1242.4),
      ],
    ),
    // id 11: B27 L11
    Phase2LotAnnotation(
      id: 11,
      categoryId: 342,
      name: 'B27 L11',
      bbox: Rect.fromLTWH(1151.59, 1212.29, 35.79, 36.18),
      points: [
        Offset(1151.593, 1227.665),
        Offset(1172.159, 1248.473),
        Offset(1187.387, 1232.8),
        Offset(1166.291, 1212.293),
        Offset(1151.593, 1227.665),
      ],
    ),
    // id 12: B27 L12
    Phase2LotAnnotation(
      id: 12,
      categoryId: 343,
      name: 'B27 L12',
      bbox: Rect.fromLTWH(1167.07, 1199.17, 36.65, 33.22),
      points: [
        Offset(1167.073, 1211.93),
        Offset(1187.765, 1232.39),
        Offset(1203.723, 1216.812),
        Offset(1187.852, 1207.397),
        Offset(1180.181, 1199.172),
        Offset(1167.073, 1211.93),
      ],
    ),
    // id 13: B27 L14
    Phase2LotAnnotation(
      id: 13,
      categoryId: 344,
      name: 'B27 L14',
      bbox: Rect.fromLTWH(1192.96, 1164.25, 46.62, 39.69),
      points: [
        Offset(1201.069, 1194.92),
        Offset(1215.945, 1203.941),
        Offset(1239.577, 1180.422),
        Offset(1225.021, 1165.295),
        Offset(1220.262, 1164.252),
        Offset(1213.983, 1165.296),
        Offset(1192.956, 1186.355),
        Offset(1201.069, 1194.92),
      ],
    ),
    // id 74: B28 L1
    Phase2LotAnnotation(
      id: 74,
      categoryId: 353,
      name: 'B28 L1',
      bbox: Rect.fromLTWH(1386.19, 976.57, 45.75, 49.85),
      points: [
        Offset(1431.937, 1005.514),
        Offset(1402.193, 976.565),
        Offset(1386.19, 993.609),
        Offset(1386.637, 1001.422),
        Offset(1389.106, 1005.644),
        Offset(1410.595, 1026.419),
        Offset(1431.937, 1005.514),
      ],
    ),
    // id 75: B28 L2
    Phase2LotAnnotation(
      id: 75,
      categoryId: 354,
      name: 'B28 L2',
      bbox: Rect.fromLTWH(1410.7, 1005.96, 50.55, 45.73),
      points: [
        Offset(1410.698, 1026.977),
        Offset(1434.359, 1050.251),
        Offset(1436.535, 1051.689),
        Offset(1444.836, 1051.503),
        Offset(1461.251, 1035.276),
        Offset(1432.312, 1005.955),
        Offset(1410.698, 1026.977),
      ],
    ),
    // id 76: B28 L3
    Phase2LotAnnotation(
      id: 76,
      categoryId: 355,
      name: 'B28 L3',
      bbox: Rect.fromLTWH(1402.88, 955.54, 50.73, 50.06),
      points: [
        Offset(1453.609, 985.149),
        Offset(1423.421, 955.544),
        Offset(1402.877, 976.459),
        Offset(1432.432, 1005.492),
        Offset(1432.326, 1005.604),
        Offset(1453.609, 985.149),
      ],
    ),
    // id 77: B28 L4
    Phase2LotAnnotation(
      id: 77,
      categoryId: 356,
      name: 'B28 L4',
      bbox: Rect.fromLTWH(1432.18, 985.68, 50.48, 49.45),
      points: [
        Offset(1432.182, 1006.518),
        Offset(1461.757, 1035.131),
        Offset(1482.667, 1014.501),
        Offset(1453.723, 985.684),
        Offset(1432.182, 1006.518),
      ],
    ),
    // id 78: B28 L5
    Phase2LotAnnotation(
      id: 78,
      categoryId: 357,
      name: 'B28 L5',
      bbox: Rect.fromLTWH(1423.86, 933.92, 51.3, 50.73),
      points: [
        Offset(1475.158, 963.682),
        Offset(1444.681, 933.922),
        Offset(1423.86, 955.414),
        Offset(1453.961, 984.65),
        Offset(1475.158, 963.682),
      ],
    ),
    // id 79: B28 L6
    Phase2LotAnnotation(
      id: 79,
      categoryId: 358,
      name: 'B28 L6',
      bbox: Rect.fromLTWH(1453.28, 964.11, 50.48, 49.97),
      points: [
        Offset(1453.283, 985.038),
        Offset(1483.022, 1014.077),
        Offset(1503.762, 993.067),
        Offset(1475.309, 964.112),
        Offset(1453.283, 985.038),
      ],
    ),
    // id 80: B28 L7
    Phase2LotAnnotation(
      id: 80,
      categoryId: 359,
      name: 'B28 L7',
      bbox: Rect.fromLTWH(1445.43, 917.27, 49.75, 46.16),
      points: [
        Offset(1495.187, 942.324),
        Offset(1471.634, 918.495),
        Offset(1468.562, 917.274),
        Offset(1462.293, 917.697),
        Offset(1445.433, 933.521),
        Offset(1475.321, 963.436),
        Offset(1495.187, 942.324),
      ],
    ),
    // id 81: B28 L8
    Phase2LotAnnotation(
      id: 81,
      categoryId: 360,
      name: 'B28 L8',
      bbox: Rect.fromLTWH(1475.51, 942.69, 44.85, 50.55),
      points: [
        Offset(1504.234, 993.235),
        Offset(1519.893, 977.335),
        Offset(1520.365, 967.079),
        Offset(1495.569, 942.687),
        Offset(1475.511, 963.898),
        Offset(1504.234, 993.235),
      ],
    ),
    // id 24: B29 L1
    Phase2LotAnnotation(
      id: 24,
      categoryId: 361,
      name: 'B29 L1',
      bbox: Rect.fromLTWH(1240.63, 1122.69, 35.89, 41.72),
      points: [
        Offset(1255.657, 1122.686),
        Offset(1240.827, 1139.493),
        Offset(1240.629, 1145.622),
        Offset(1241.519, 1149.972),
        Offset(1255.657, 1164.406),
        Offset(1276.517, 1143.447),
        Offset(1255.657, 1122.686),
      ],
    ),
    // id 48: B29 L2
    Phase2LotAnnotation(
      id: 48,
      categoryId: 371,
      name: 'B29 L2',
      bbox: Rect.fromLTWH(1255.58, 1107.03, 35.91, 35.88),
      points: [
        Offset(1255.58, 1122.884),
        Offset(1277.379, 1142.918),
        Offset(1291.488, 1127.675),
        Offset(1271.185, 1107.033),
        Offset(1255.58, 1122.884),
      ],
    ),
    // id 49: B29 L3
    Phase2LotAnnotation(
      id: 49,
      categoryId: 381,
      name: 'B29 L3',
      bbox: Rect.fromLTWH(1272.13, 1091.4, 36.38, 36.24),
      points: [
        Offset(1272.132, 1106.598),
        Offset(1293.132, 1127.646),
        Offset(1308.508, 1112.134),
        Offset(1288.16, 1091.401),
        Offset(1272.132, 1106.598),
      ],
    ),
    // id 50: B29 L4
    Phase2LotAnnotation(
      id: 50,
      categoryId: 382,
      name: 'B29 L4',
      bbox: Rect.fromLTWH(1287.84, 1076.02, 36.53, 35.63),
      points: [
        Offset(1287.836, 1090.865),
        Offset(1308.987, 1111.647),
        Offset(1324.369, 1096.668),
        Offset(1303.321, 1076.02),
        Offset(1303.213, 1076.035),
        Offset(1287.836, 1090.865),
      ],
    ),
    // id 51: B29 L5
    Phase2LotAnnotation(
      id: 51,
      categoryId: 383,
      name: 'B29 L5',
      bbox: Rect.fromLTWH(1304.04, 1059.94, 35.92, 35.78),
      points: [
        Offset(1304.044, 1075.244),
        Offset(1324.597, 1095.72),
        Offset(1339.968, 1080.461),
        Offset(1318.542, 1059.942),
        Offset(1304.044, 1075.244),
      ],
    ),
    // id 52: B29 L6
    Phase2LotAnnotation(
      id: 52,
      categoryId: 384,
      name: 'B29 L6',
      bbox: Rect.fromLTWH(1319.19, 1043.45, 36.91, 36.83),
      points: [
        Offset(1319.193, 1059.273),
        Offset(1340.032, 1080.274),
        Offset(1356.104, 1064.38),
        Offset(1334.505, 1043.447),
        Offset(1319.193, 1059.273),
      ],
    ),
    // id 53: B29 L7
    Phase2LotAnnotation(
      id: 53,
      categoryId: 385,
      name: 'B29 L7',
      bbox: Rect.fromLTWH(1335.32, 1028.02, 36.51, 37.06),
      points: [
        Offset(1335.323, 1043.339),
        Offset(1356.429, 1065.081),
        Offset(1371.833, 1049.083),
        Offset(1351.266, 1028.016),
        Offset(1335.323, 1043.339),
      ],
    ),
    // id 54: B29 L8
    Phase2LotAnnotation(
      id: 54,
      categoryId: 386,
      name: 'B29 L8',
      bbox: Rect.fromLTWH(1351.31, 1015.48, 37.75, 33.25),
      points: [
        Offset(1372.538, 1048.729),
        Offset(1389.065, 1031.586),
        Offset(1372.624, 1015.481),
        Offset(1364.702, 1015.483),
        Offset(1351.311, 1027.361),
        Offset(1372.538, 1048.729),
      ],
    ),
    // id 55: B29 L9
    Phase2LotAnnotation(
      id: 55,
      categoryId: 387,
      name: 'B29 L9',
      bbox: Rect.fromLTWH(1339.03, 1032.13, 69.31, 55.87),
      points: [
        Offset(1373.048, 1088),
        Offset(1408.342, 1051.131),
        Offset(1389.521, 1032.131),
        Offset(1339.028, 1082.024),
        Offset(1373.048, 1088),
      ],
    ),
    // id 56: B29 L10
    Phase2LotAnnotation(
      id: 56,
      categoryId: 362,
      name: 'B29 L10',
      bbox: Rect.fromLTWH(1372.19, 1052.26, 54.77, 46.49),
      points: [
        Offset(1372.188, 1088.281),
        Offset(1420.677, 1098.749),
        Offset(1426.959, 1067.332),
        Offset(1408.253, 1052.264),
        Offset(1372.188, 1088.281),
      ],
    ),
    // id 57: B29 L11
    Phase2LotAnnotation(
      id: 57,
      categoryId: 363,
      name: 'B29 L11',
      bbox: Rect.fromLTWH(1420.91, 1068.04, 49.38, 36.81),
      points: [
        Offset(1420.91, 1099.289),
        Offset(1444.885, 1104.847),
        Offset(1470.29, 1089.742),
        Offset(1450.12, 1069.156),
        Offset(1441.598, 1071.221),
        Offset(1435.67, 1071.278),
        Offset(1427.179, 1068.042),
        Offset(1420.91, 1099.289),
      ],
    ),
    // id 58: B29 L12
    Phase2LotAnnotation(
      id: 58,
      categoryId: 364,
      name: 'B29 L12',
      bbox: Rect.fromLTWH(1450.46, 1052.08, 44.11, 36.25),
      points: [
        Offset(1471.058, 1088.33),
        Offset(1494.566, 1074.422),
        Offset(1472.027, 1052.689),
        Offset(1471.667, 1052.081),
        Offset(1457.871, 1065.952),
        Offset(1450.456, 1068.972),
        Offset(1471.058, 1088.33),
      ],
    ),
    // id 59: B29 L14
    Phase2LotAnnotation(
      id: 59,
      categoryId: 365,
      name: 'B29 L14',
      bbox: Rect.fromLTWH(1473.05, 1032.57, 47.11, 42.4),
      points: [
        Offset(1473.047, 1051.506),
        Offset(1495.538, 1074.968),
        Offset(1520.156, 1060.807),
        Offset(1491.384, 1032.567),
        Offset(1473.047, 1051.506),
      ],
    ),
    // id 60: B29 L15
    Phase2LotAnnotation(
      id: 60,
      categoryId: 366,
      name: 'B29 L15',
      bbox: Rect.fromLTWH(1491.47, 1012.45, 53.72, 47.51),
      points: [
        Offset(1520.333, 1059.961),
        Offset(1545.193, 1045.72),
        Offset(1511.705, 1012.449),
        Offset(1491.474, 1032.273),
        Offset(1520.333, 1059.961),
      ],
    ),
    // id 61: B29 L16
    Phase2LotAnnotation(
      id: 61,
      categoryId: 367,
      name: 'B29 L16',
      bbox: Rect.fromLTWH(1512.23, 993.2, 56.79, 52.22),
      points: [
        Offset(1544.593, 1045.427),
        Offset(1569.014, 1030.758),
        Offset(1531.227, 993.204),
        Offset(1512.226, 1012.053),
        Offset(1544.593, 1045.427),
      ],
    ),
    // id 62: B29 L17
    Phase2LotAnnotation(
      id: 62,
      categoryId: 368,
      name: 'B29 L17',
      bbox: Rect.fromLTWH(1531.46, 958.36, 74.7, 72.5),
      points: [
        Offset(1569.554, 1030.862),
        Offset(1606.162, 1010.009),
        Offset(1576.901, 958.363),
        Offset(1551.192, 971.826),
        Offset(1531.461, 992.769),
        Offset(1569.554, 1030.862),
      ],
    ),
    // id 63: B29 L18
    Phase2LotAnnotation(
      id: 63,
      categoryId: 369,
      name: 'B29 L18',
      bbox: Rect.fromLTWH(1534.69, 938.18, 42.22, 33.55),
      points: [
        Offset(1566.059, 938.176),
        Offset(1534.691, 955.822),
        Offset(1551.442, 971.728),
        Offset(1576.913, 958.061),
        Offset(1566.059, 938.176),
      ],
    ),
    // id 64: B29 L19
    Phase2LotAnnotation(
      id: 64,
      categoryId: 370,
      name: 'B29 L19',
      bbox: Rect.fromLTWH(1514.48, 914.41, 50.93, 40.91),
      points: [
        Offset(1514.479, 935.489),
        Offset(1534.317, 955.32),
        Offset(1565.41, 937.956),
        Offset(1552.4, 914.413),
        Offset(1514.479, 935.489),
      ],
    ),
    // id 65: B29 L20
    Phase2LotAnnotation(
      id: 65,
      categoryId: 372,
      name: 'B29 L20',
      bbox: Rect.fromLTWH(1500.44, 885.41, 51.4, 49.83),
      points: [
        Offset(1500.436, 920.577),
        Offset(1514.427, 935.244),
        Offset(1551.837, 914.179),
        Offset(1536.171, 885.413),
        Offset(1500.436, 920.577),
      ],
    ),
    // id 66: B29 L21
    Phase2LotAnnotation(
      id: 66,
      categoryId: 373,
      name: 'B29 L21',
      bbox: Rect.fromLTWH(1484.26, 879.61, 35.7, 40.82),
      points: [
        Offset(1498.98, 879.613),
        Offset(1487.179, 891.125),
        Offset(1484.459, 895.789),
        Offset(1484.256, 903.075),
        Offset(1486.337, 907.199),
        Offset(1499.886, 920.43),
        Offset(1519.961, 900.593),
        Offset(1498.98, 879.613),
      ],
    ),
    // id 67: B29 L22
    Phase2LotAnnotation(
      id: 67,
      categoryId: 374,
      name: 'B29 L22',
      bbox: Rect.fromLTWH(1498.83, 864.14, 36.74, 36.37),
      points: [
        Offset(1498.83, 879.653),
        Offset(1520.328, 900.515),
        Offset(1535.568, 884.749),
        Offset(1514.784, 864.143),
        Offset(1498.83, 879.653),
      ],
    ),
    // id 68: B29 L23
    Phase2LotAnnotation(
      id: 68,
      categoryId: 375,
      name: 'B29 L23',
      bbox: Rect.fromLTWH(1514.99, 848.94, 35.71, 35.49),
      points: [
        Offset(1514.986, 863.826),
        Offset(1535.767, 884.435),
        Offset(1550.695, 869.123),
        Offset(1530.231, 848.943),
        Offset(1514.986, 863.826),
      ],
    ),
    // id 69: B29 L24
    Phase2LotAnnotation(
      id: 69,
      categoryId: 376,
      name: 'B29 L24',
      bbox: Rect.fromLTWH(1530.75, 833.29, 36.54, 35.69),
      points: [
        Offset(1530.753, 848.321),
        Offset(1551.671, 868.977),
        Offset(1566.475, 853.821),
        Offset(1567.293, 853.195),
        Offset(1546.143, 833.285),
        Offset(1530.753, 848.321),
      ],
    ),
    // id 70: B29 L25
    Phase2LotAnnotation(
      id: 70,
      categoryId: 377,
      name: 'B29 L25',
      bbox: Rect.fromLTWH(1546.9, 817.24, 36.05, 35.27),
      points: [
        Offset(1546.9, 832.262),
        Offset(1567.463, 852.502),
        Offset(1582.95, 837.368),
        Offset(1562.12, 817.235),
        Offset(1546.9, 832.262),
      ],
    ),
    // id 71: B29 L26
    Phase2LotAnnotation(
      id: 71,
      categoryId: 378,
      name: 'B29 L26',
      bbox: Rect.fromLTWH(1562.3, 801.71, 36.13, 35.08),
      points: [
        Offset(1562.301, 816.758),
        Offset(1583.335, 836.784),
        Offset(1598.427, 821.573),
        Offset(1578.535, 802.065),
        Offset(1577.939, 801.705),
        Offset(1562.301, 816.758),
      ],
    ),
    // id 72: B29 L27
    Phase2LotAnnotation(
      id: 72,
      categoryId: 379,
      name: 'B29 L27',
      bbox: Rect.fromLTWH(1578.54, 784.9, 34.89, 35.72),
      points: [
        Offset(1578.539, 801.034),
        Offset(1598.777, 820.621),
        Offset(1613.432, 805.647),
        Offset(1594.002, 784.904),
        Offset(1594.169, 785.112),
        Offset(1578.539, 801.034),
      ],
    ),
    // id 73: B29 L28
    Phase2LotAnnotation(
      id: 73,
      categoryId: 380,
      name: 'B29 L28',
      bbox: Rect.fromLTWH(1594.84, 771.21, 38.13, 33.74),
      points: [
        Offset(1614.042, 804.943),
        Offset(1632.973, 786.158),
        Offset(1617.631, 771.205),
        Offset(1607.286, 771.32),
        Offset(1594.839, 784.076),
        Offset(1614.042, 804.943),
      ],
    ),
    // id 530: B30 L1
    Phase2LotAnnotation(
      id: 530,
      categoryId: 406,
      name: 'B30 L1',
      bbox: Rect.fromLTWH(1637.71, 726.17, 35.35, 40.83),
      points: [
        Offset(1653.062, 726.171),
        Offset(1639.725, 738.589),
        Offset(1637.712, 744.213),
        Offset(1638.056, 748.451),
        Offset(1638.821, 752.985),
        Offset(1652.759, 767),
        Offset(1673.062, 746.409),
        Offset(1653.062, 726.171),
      ],
    ),
    // id 531: B30 L2
    Phase2LotAnnotation(
      id: 531,
      categoryId: 415,
      name: 'B30 L2',
      bbox: Rect.fromLTWH(1653.19, 710.23, 35.65, 35.08),
      points: [
        Offset(1688.831, 730.384),
        Offset(1668.267, 710.226),
        Offset(1653.185, 725.615),
        Offset(1673.799, 745.303),
        Offset(1688.831, 730.384),
      ],
    ),
    // id 532: B30 L3
    Phase2LotAnnotation(
      id: 532,
      categoryId: 416,
      name: 'B30 L3',
      bbox: Rect.fromLTWH(1668.91, 694.59, 36.61, 35.63),
      points: [
        Offset(1689.841, 730.224),
        Offset(1705.52, 715.296),
        Offset(1684.068, 694.589),
        Offset(1668.912, 710.104),
        Offset(1689.841, 730.224),
      ],
    ),
    // id 533: B30 L4
    Phase2LotAnnotation(
      id: 533,
      categoryId: 417,
      name: 'B30 L4',
      bbox: Rect.fromLTWH(1684.49, 678.53, 36.43, 35.99),
      points: [
        Offset(1705.094, 714.522),
        Offset(1720.922, 699.141),
        Offset(1700.408, 678.528),
        Offset(1684.488, 694.437),
        Offset(1705.094, 714.522),
      ],
    ),
    // id 534: B30 L5
    Phase2LotAnnotation(
      id: 534,
      categoryId: 418,
      name: 'B30 L5',
      bbox: Rect.fromLTWH(1701.5, 663.46, 35.18, 35.39),
      points: [
        Offset(1721.129, 698.843),
        Offset(1736.679, 683.277),
        Offset(1715.302, 663.456),
        Offset(1701.5, 678.459),
        Offset(1721.129, 698.843),
      ],
    ),
    // id 535: B30 L6
    Phase2LotAnnotation(
      id: 535,
      categoryId: 419,
      name: 'B30 L6',
      bbox: Rect.fromLTWH(1716.23, 647.03, 35.56, 35.28),
      points: [
        Offset(1737.15, 682.312),
        Offset(1751.795, 667.12),
        Offset(1730.563, 647.03),
        Offset(1716.235, 662.408),
        Offset(1737.15, 682.312),
      ],
    ),
    // id 536: B30 L7
    Phase2LotAnnotation(
      id: 536,
      categoryId: 420,
      name: 'B30 L7',
      bbox: Rect.fromLTWH(1732.41, 631.4, 35.6, 35.35),
      points: [
        Offset(1752.637, 666.752),
        Offset(1768.01, 651.702),
        Offset(1747.813, 631.397),
        Offset(1732.406, 646.519),
        Offset(1752.637, 666.752),
      ],
    ),
    // id 537: B30 L8
    Phase2LotAnnotation(
      id: 537,
      categoryId: 421,
      name: 'B30 L8',
      bbox: Rect.fromLTWH(1748.62, 615.43, 35.49, 35.86),
      points: [
        Offset(1769.087, 651.288),
        Offset(1784.113, 635.933),
        Offset(1763.221, 615.432),
        Offset(1748.624, 630.301),
        Offset(1769.087, 651.288),
      ],
    ),
    // id 538: B30 L9
    Phase2LotAnnotation(
      id: 538,
      categoryId: 422,
      name: 'B30 L9',
      bbox: Rect.fromLTWH(1763.41, 600.48, 36.91, 35.34),
      points: [
        Offset(1784.104, 635.813),
        Offset(1800.321, 620.598),
        Offset(1778.774, 600.475),
        Offset(1763.41, 615.259),
        Offset(1784.104, 635.813),
      ],
    ),
    // id 539: B30 L10
    Phase2LotAnnotation(
      id: 539,
      categoryId: 407,
      name: 'B30 L10',
      bbox: Rect.fromLTWH(1779.61, 584.28, 35.96, 36.12),
      points: [
        Offset(1799.138, 620.402),
        Offset(1815.565, 604.909),
        Offset(1794.235, 584.281),
        Offset(1779.609, 599.513),
        Offset(1799.138, 620.402),
      ],
    ),
    // id 540: B30 L11
    Phase2LotAnnotation(
      id: 540,
      categoryId: 408,
      name: 'B30 L11',
      bbox: Rect.fromLTWH(1795, 568.24, 36.12, 35.78),
      points: [
        Offset(1815.15, 604.017),
        Offset(1831.113, 588.389),
        Offset(1810.521, 568.241),
        Offset(1794.997, 584.022),
        Offset(1815.15, 604.017),
      ],
    ),
    // id 541: B30 L12
    Phase2LotAnnotation(
      id: 541,
      categoryId: 409,
      name: 'B30 L12',
      bbox: Rect.fromLTWH(1810.92, 552.89, 35.89, 34.86),
      points: [
        Offset(1831.687, 587.754),
        Offset(1846.811, 572.529),
        Offset(1825.93, 552.891),
        Offset(1810.917, 567.271),
        Offset(1831.687, 587.754),
      ],
    ),
    // id 542: B30 L14
    Phase2LotAnnotation(
      id: 542,
      categoryId: 410,
      name: 'B30 L14',
      bbox: Rect.fromLTWH(1826.4, 536.91, 35.95, 34.8),
      points: [
        Offset(1847.168, 571.711),
        Offset(1862.346, 556.484),
        Offset(1841.777, 536.91),
        Offset(1826.398, 551.79),
        Offset(1847.168, 571.711),
      ],
    ),
    // id 543: B30 L15
    Phase2LotAnnotation(
      id: 543,
      categoryId: 411,
      name: 'B30 L15',
      bbox: Rect.fromLTWH(1841.88, 520.8, 37.04, 36.1),
      points: [
        Offset(1862.896, 556.895),
        Offset(1878.914, 540.968),
        Offset(1857.513, 520.8),
        Offset(1841.879, 536.677),
        Offset(1862.896, 556.895),
      ],
    ),
    // id 544: B30 L16
    Phase2LotAnnotation(
      id: 544,
      categoryId: 412,
      name: 'B30 L16',
      bbox: Rect.fromLTWH(1859.22, 505.54, 34.73, 34.45),
      points: [
        Offset(1877.721, 539.993),
        Offset(1893.952, 525.252),
        Offset(1873.833, 505.545),
        Offset(1859.223, 520.273),
        Offset(1877.721, 539.993),
      ],
    ),
    // id 545: B30 L17
    Phase2LotAnnotation(
      id: 545,
      categoryId: 413,
      name: 'B30 L17',
      bbox: Rect.fromLTWH(1874.53, 490.55, 34.64, 33.51),
      points: [
        Offset(1894.126, 524.053),
        Offset(1909.17, 509.116),
        Offset(1889.546, 490.546),
        Offset(1874.527, 504.776),
        Offset(1894.126, 524.053),
      ],
    ),
    // id 546: B30 L18
    Phase2LotAnnotation(
      id: 546,
      categoryId: 414,
      name: 'B30 L18',
      bbox: Rect.fromLTWH(1890.11, 473.8, 38.15, 34.62),
      points: [
        Offset(1909.496, 508.415),
        Offset(1928.256, 490.66),
        Offset(1905.642, 473.795),
        Offset(1890.106, 489.934),
        Offset(1909.496, 508.415),
      ],
    ),
    // id 547: B31 L1
    Phase2LotAnnotation(
      id: 547,
      categoryId: 423,
      name: 'B31 L1',
      bbox: Rect.fromLTWH(1597.57, 674.1, 45.42, 47.56),
      points: [
        Offset(1617.346, 674.098),
        Offset(1597.571, 705.826),
        Offset(1598.099, 710.96),
        Offset(1601.151, 716.172),
        Offset(1604.897, 719.392),
        Offset(1609.488, 721.653),
        Offset(1615.719, 721.543),
        Offset(1620.201, 718.592),
        Offset(1642.995, 695.807),
        Offset(1617.346, 674.098),
      ],
    ),
    // id 548: B31 L2
    Phase2LotAnnotation(
      id: 548,
      categoryId: 433,
      name: 'B31 L2',
      bbox: Rect.fromLTWH(1617.86, 636.49, 57.69, 58.72),
      points: [
        Offset(1643.451, 695.214),
        Offset(1675.548, 664.052),
        Offset(1641.276, 636.492),
        Offset(1617.857, 673.04),
        Offset(1643.451, 695.214),
      ],
    ),
    // id 549: B31 L3
    Phase2LotAnnotation(
      id: 549,
      categoryId: 440,
      name: 'B31 L3',
      bbox: Rect.fromLTWH(1642.16, 617.94, 29.46, 30.96),
      points: [
        Offset(1671.626, 632.605),
        Offset(1654.377, 617.939),
        Offset(1642.164, 636.185),
        Offset(1657.664, 648.902),
        Offset(1671.626, 632.605),
      ],
    ),
    // id 550: B31 L4
    Phase2LotAnnotation(
      id: 550,
      categoryId: 441,
      name: 'B31 L4',
      bbox: Rect.fromLTWH(1659.25, 634.47, 32.24, 29.44),
      points: [
        Offset(1659.251, 650.521),
        Offset(1675.185, 663.911),
        Offset(1691.486, 648.48),
        Offset(1672.867, 634.469),
        Offset(1659.251, 650.521),
      ],
    ),
    // id 551: B31 L5
    Phase2LotAnnotation(
      id: 551,
      categoryId: 442,
      name: 'B31 L5',
      bbox: Rect.fromLTWH(1654.39, 599.62, 31, 32.63),
      points: [
        Offset(1671.445, 632.249),
        Offset(1685.395, 615.009),
        Offset(1666.012, 599.62),
        Offset(1654.393, 617.535),
        Offset(1671.445, 632.249),
      ],
    ),
    // id 552: B31 L6
    Phase2LotAnnotation(
      id: 552,
      categoryId: 443,
      name: 'B31 L6',
      bbox: Rect.fromLTWH(1673.12, 616.25, 34, 31.47),
      points: [
        Offset(1673.115, 633.317),
        Offset(1690.997, 647.719),
        Offset(1707.117, 631.975),
        Offset(1687.405, 616.251),
        Offset(1673.115, 633.317),
      ],
    ),
    // id 553: B31 L7
    Phase2LotAnnotation(
      id: 553,
      categoryId: 444,
      name: 'B31 L7',
      bbox: Rect.fromLTWH(1666.03, 580.39, 34.11, 34.65),
      points: [
        Offset(1666.029, 599.315),
        Offset(1685.725, 615.048),
        Offset(1700.137, 597.554),
        Offset(1677.678, 580.394),
        Offset(1666.029, 599.315),
      ],
    ),
    // id 554: B31 L8
    Phase2LotAnnotation(
      id: 554,
      categoryId: 445,
      name: 'B31 L8',
      bbox: Rect.fromLTWH(1687.1, 599.06, 35.85, 32.86),
      points: [
        Offset(1687.101, 616.42),
        Offset(1706.812, 631.922),
        Offset(1722.95, 616.473),
        Offset(1701.54, 599.061),
        Offset(1687.101, 616.42),
      ],
    ),
    // id 555: B31 L9
    Phase2LotAnnotation(
      id: 555,
      categoryId: 446,
      name: 'B31 L9',
      bbox: Rect.fromLTWH(1677.87, 561.14, 35.99, 36.55),
      points: [
        Offset(1700.215, 597.694),
        Offset(1713.856, 580.696),
        Offset(1690.246, 561.141),
        Offset(1677.87, 580.009),
        Offset(1700.215, 597.694),
      ],
    ),
    // id 556: B31 L10
    Phase2LotAnnotation(
      id: 556,
      categoryId: 424,
      name: 'B31 L10',
      bbox: Rect.fromLTWH(1701.15, 582.13, 37.65, 34.16),
      points: [
        Offset(1701.151, 598.939),
        Offset(1722.532, 616.288),
        Offset(1738.801, 600.72),
        Offset(1715.588, 582.126),
        Offset(1701.151, 598.939),
      ],
    ),
    // id 557: B31 L11
    Phase2LotAnnotation(
      id: 557,
      categoryId: 425,
      name: 'B31 L11',
      bbox: Rect.fromLTWH(1691, 538.57, 39.83, 41.54),
      points: [
        Offset(1691.002, 561.764),
        Offset(1714.379, 580.114),
        Offset(1730.835, 558.104),
        Offset(1706.04, 538.573),
        Offset(1691.002, 561.764),
      ],
    ),
    // id 558: B31 L12
    Phase2LotAnnotation(
      id: 558,
      categoryId: 426,
      name: 'B31 L12',
      bbox: Rect.fromLTWH(1715.97, 560.61, 42.58, 39.63),
      points: [
        Offset(1738.463, 600.241),
        Offset(1758.557, 580.796),
        Offset(1733.658, 560.611),
        Offset(1715.973, 581.549),
        Offset(1738.463, 600.241),
      ],
    ),
    // id 559: B31 L14
    Phase2LotAnnotation(
      id: 559,
      categoryId: 427,
      name: 'B31 L14',
      bbox: Rect.fromLTWH(1733.23, 538.76, 45.07, 41.93),
      points: [
        Offset(1733.227, 560.032),
        Offset(1758.132, 580.689),
        Offset(1778.299, 560.718),
        Offset(1751.85, 538.763),
        Offset(1733.227, 560.032),
      ],
    ),
    // id 560: B31 L15
    Phase2LotAnnotation(
      id: 560,
      categoryId: 428,
      name: 'B31 L15',
      bbox: Rect.fromLTWH(1706.16, 514.2, 43.23, 43.77),
      points: [
        Offset(1731.189, 557.973),
        Offset(1749.385, 536.552),
        Offset(1721.006, 514.203),
        Offset(1706.158, 537.48),
        Offset(1731.189, 557.973),
      ],
    ),
    // id 561: B31 L16
    Phase2LotAnnotation(
      id: 561,
      categoryId: 429,
      name: 'B31 L16',
      bbox: Rect.fromLTWH(1751.38, 516.25, 47.22, 44.69),
      points: [
        Offset(1778.805, 560.942),
        Offset(1798.603, 540.985),
        Offset(1768.242, 516.25),
        Offset(1751.381, 538.635),
        Offset(1778.805, 560.942),
      ],
    ),
    // id 562: B31 L17
    Phase2LotAnnotation(
      id: 562,
      categoryId: 430,
      name: 'B31 L17',
      bbox: Rect.fromLTWH(1721.75, 491.05, 45.02, 45.81),
      points: [
        Offset(1749.136, 536.864),
        Offset(1766.77, 515.608),
        Offset(1736.327, 491.053),
        Offset(1721.746, 514.003),
        Offset(1749.136, 536.864),
      ],
    ),
    // id 563: B31 L18
    Phase2LotAnnotation(
      id: 563,
      categoryId: 431,
      name: 'B31 L18',
      bbox: Rect.fromLTWH(1768.3, 494.76, 49.86, 45.68),
      points: [
        Offset(1768.303, 516.787),
        Offset(1797.821, 540.435),
        Offset(1818.168, 521.128),
        Offset(1786.02, 494.759),
        Offset(1768.303, 516.787),
      ],
    ),
    // id 564: B31 L19
    Phase2LotAnnotation(
      id: 564,
      categoryId: 432,
      name: 'B31 L19',
      bbox: Rect.fromLTWH(1736.76, 467.46, 47.17, 47.41),
      points: [
        Offset(1736.757, 490.458),
        Offset(1766.318, 514.864),
        Offset(1783.931, 493.952),
        Offset(1751.443, 467.459),
        Offset(1736.757, 490.458),
      ],
    ),
    // id 565: B31 L20
    Phase2LotAnnotation(
      id: 565,
      categoryId: 434,
      name: 'B31 L20',
      bbox: Rect.fromLTWH(1785.91, 473.34, 51.72, 47.54),
      points: [
        Offset(1785.908, 494.533),
        Offset(1817.598, 520.883),
        Offset(1837.631, 501.054),
        Offset(1803.545, 473.341),
        Offset(1785.908, 494.533),
      ],
    ),
    // id 566: B31 L21
    Phase2LotAnnotation(
      id: 566,
      categoryId: 435,
      name: 'B31 L21',
      bbox: Rect.fromLTWH(1751.93, 443.93, 50.01, 49.9),
      points: [
        Offset(1751.928, 467.315),
        Offset(1784.378, 493.834),
        Offset(1801.935, 472.028),
        Offset(1767.408, 443.933),
        Offset(1751.928, 467.315),
      ],
    ),
    // id 567: B31 L22
    Phase2LotAnnotation(
      id: 567,
      categoryId: 436,
      name: 'B31 L22',
      bbox: Rect.fromLTWH(1803.17, 452.23, 54.51, 48.89),
      points: [
        Offset(1803.167, 473.382),
        Offset(1837.818, 501.117),
        Offset(1857.676, 481.348),
        Offset(1821.237, 452.23),
        Offset(1803.167, 473.382),
      ],
    ),
    // id 568: B31 L23
    Phase2LotAnnotation(
      id: 568,
      categoryId: 437,
      name: 'B31 L23',
      bbox: Rect.fromLTWH(1766.96, 420.48, 52.69, 51.56),
      points: [
        Offset(1766.964, 443.264),
        Offset(1801.78, 472.035),
        Offset(1819.655, 450.27),
        Offset(1782.172, 420.478),
        Offset(1766.964, 443.264),
      ],
    ),
    // id 569: B31 L24
    Phase2LotAnnotation(
      id: 569,
      categoryId: 438,
      name: 'B31 L24',
      bbox: Rect.fromLTWH(1820.8, 424.52, 62.28, 56.75),
      points: [
        Offset(1820.8, 451.917),
        Offset(1856.956, 481.269),
        Offset(1883.081, 455.628),
        Offset(1843.367, 424.519),
        Offset(1820.8, 451.917),
      ],
    ),
    // id 570: B31 L25
    Phase2LotAnnotation(
      id: 570,
      categoryId: 439,
      name: 'B31 L25',
      bbox: Rect.fromLTWH(1782.05, 392, 58.92, 57.63),
      points: [
        Offset(1782.052, 420.266),
        Offset(1818.944, 449.623),
        Offset(1840.969, 422.209),
        Offset(1800.838, 391.997),
        Offset(1782.052, 420.266),
      ],
    ),
  ];
}
