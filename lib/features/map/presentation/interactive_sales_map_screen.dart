import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/services/contact_service.dart';
import '../../../../core/services/supabase_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../auth/services/auth_service.dart';
import '../../../../core/widgets/app_image.dart';
import '../../inventory/models/lot_model.dart';
import '../../inventory/models/mvlc_price_model.dart';
import '../../inventory/models/project_model.dart';
import '../../inventory/presentation/widgets/project_selection_sheet.dart';
import '../models/annotated_image_model.dart';
import '../models/map_lot_model.dart';
import '../models/map_upload_model.dart';
import '../models/phase1_annotations_data.dart';
import '../models/phase2_annotations_data.dart';
import '../models/phase3_annotations_data.dart';
import '../models/erhd_annotations_data.dart';
import '../models/phase1_commercial_annotations_data.dart';
import 'widgets/quick_amortization_modal.dart';
import 'widgets/sales_map_canvas.dart';
import '../../computation/presentation/computation_page.dart';

/// Full Interactive Sales Map Screen for VHBC Broker Portal.
/// Allows brokers to explore the subdivision masterplan, inspect lot specs,
/// compute real-time amortizations, and instantly reserve parcels.
class InteractiveSalesMapScreen extends StatefulWidget {
  final String? initialLotId;

  const InteractiveSalesMapScreen({
    super.key,
    this.initialLotId,
  });

  /// Formats the map download filename as: "project name - phase - latest.ext"
  /// Defaults to ".png" since downloaded maps are always converted to PNG.
  static String formatDownloadFilename({
    required String projectName,
    required String phase,
    String extension = '.png',
  }) {
    final cleanProject = projectName
        .replaceAll(RegExp(r'\([^)]*\)'), '')
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '')
        .trim();
    final cleanPhase = phase.replaceAll(RegExp(r'[\\/:*?"<>|]'), '').trim();
    final ext = extension.startsWith('.') ? extension : '.$extension';
    return '$cleanProject - $cleanPhase - latest$ext';
  }

  /// Formats the section suffix according to the specification:
  /// e.g. "East" -> "E", "West" -> "W", "North" -> "N", "South" -> "S",
  /// or single-letter subphases like "A" -> "A", "B" -> "B", "C" -> "C".
  static String? formatSectionSuffix(String? rawSection) {
    if (rawSection == null) return null;
    final s = rawSection.trim();
    if (s.isEmpty || s.toLowerCase() == 'null') return null;

    final lower = s.toLowerCase();
    if (lower == 'east' || lower == 'e') return 'E';
    if (lower == 'west' || lower == 'w') return 'W';
    if (lower == 'north' || lower == 'n') return 'N';
    if (lower == 'south' || lower == 's') return 'S';
    return s.toUpperCase();
  }

  /// Extracts the phase number from [upload], checking `phase` field, `name`, `imageUrl`, and `storagePath`.
  static int? extractPhaseNumber(MapUploadModel upload) {
    if (upload.phase != null) return upload.phase;
    if (upload.name != null && upload.name!.trim().isNotEmpty) {
      final clean =
          upload.name!.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), '').trim();
      final pMatch =
          RegExp(r'phase[-_\s]*(\d+)', caseSensitive: false).firstMatch(clean);
      if (pMatch != null) {
        return int.tryParse(pMatch.group(1)!);
      }
    }
    if (upload.imageUrl.isNotEmpty) {
      final pMatch = RegExp(r'phase[-_\s]*(\d+)', caseSensitive: false)
          .firstMatch(upload.imageUrl);
      if (pMatch != null) {
        return int.tryParse(pMatch.group(1)!);
      }
    }
    if (upload.storagePath != null && upload.storagePath!.isNotEmpty) {
      final pMatch = RegExp(r'phase[-_\s]*(\d+)', caseSensitive: false)
          .firstMatch(upload.storagePath!);
      if (pMatch != null) {
        return int.tryParse(pMatch.group(1)!);
      }
    }
    return null;
  }

  /// Extracts the map section (e.g. 'east', 'a', 'b', 'c', or null) from an upload.
  static String? extractUploadSection(MapUploadModel? upload, String chipLabel) {
    if (upload == null) return null;
    if (upload.mapSection != null &&
        upload.mapSection!.trim().isNotEmpty &&
        upload.mapSection!.trim().toLowerCase() != 'null') {
      final s = upload.mapSection!.trim().toLowerCase();
      if (s == 'east' || s == 'e') return 'east';
      if (s == 'west' || s == 'w') return 'west';
      if (s == 'north' || s == 'n') return 'north';
      if (s == 'south' || s == 's') return 'south';
      return s;
    }
    final chip = chipLabel.trim().toLowerCase();
    final name = (upload.name ?? '').toLowerCase();
    final path = (upload.storagePath ?? '').toLowerCase();
    final url = upload.imageUrl.toLowerCase();
    final combined = '$chip $name $path $url';

    // 1. Check for East / E gate section (e.g. "phase 2e", "2e", "phase 1e", "1e", "east")
    final hasEast = RegExp(r'\b(?:phase\s*)?[12]e\b', caseSensitive: false).hasMatch(chip) ||
        RegExp(r'\b(?:phase\s*)?[12]e\b', caseSensitive: false).hasMatch(name) ||
        combined.contains('phase-2-east') ||
        combined.contains('phase-1-east') ||
        combined.contains('phase-2east') ||
        combined.contains('phase-1east') ||
        combined.contains('2east') ||
        combined.contains('1east') ||
        combined.contains('east gate') ||
        chip.endsWith('e');
    if (hasEast) return 'east';

    // 2. Check for other letter sections (e.g. 1A, 1B, 1C, 2A, 2B)
    final match = RegExp(r'ph(?:ase)?[-_\s]*\d+([a-z])\b', caseSensitive: false).firstMatch(chip) ??
        RegExp(r'ph(?:ase)?[-_\s]*\d+([a-z])\b', caseSensitive: false).firstMatch(name) ??
        RegExp(r'\b\d+([a-z])\b', caseSensitive: false).firstMatch(chip);
    if (match != null) {
      final letter = match.group(1)!.toLowerCase();
      if (letter == 'e') return 'east';
      return letter;
    }

    return null;
  }

  /// Formats a floor number into an ordinal string, e.g. 0 -> "Ground Floor", 1 -> "1st Floor", 2 -> "2nd Floor", 3 -> "3rd Floor", etc.
  static String formatFloorOrdinal(int floorNum) {
    if (floorNum == 0) return 'Ground Floor';
    final mod100 = floorNum % 100;
    if (mod100 >= 11 && mod100 <= 13) {
      return '${floorNum}th Floor';
    }
    switch (floorNum % 10) {
      case 1:
        return '${floorNum}st Floor';
      case 2:
        return '${floorNum}nd Floor';
      case 3:
        return '${floorNum}rd Floor';
      default:
        return '${floorNum}th Floor';
    }
  }

  /// Extracts the floor level number from an upload (from storage_path, name, or phase).
  static int? extractFloorNumber(MapUploadModel upload) {
    // 1. Check storage_path (e.g. ".../MSCC/floor-2/...", ".../floor-3/...")
    if (upload.storagePath != null && upload.storagePath!.isNotEmpty) {
      final match = RegExp(r'floor[-_\s]*(\d+)', caseSensitive: false)
          .firstMatch(upload.storagePath!);
      if (match != null) {
        return int.tryParse(match.group(1)!);
      }
    }

    // 2. Check name (e.g. "secondfloor.jpg", "3rd floor Condo Official.png")
    final name = (upload.name ?? '').toLowerCase();
    if (name.contains('secondfloor') ||
        name.contains('2nd floor') ||
        name.contains('second floor') ||
        name.contains('2ndfloor')) {
      return 2;
    }
    if (name.contains('thirdfloor') ||
        name.contains('3rd floor') ||
        name.contains('third floor') ||
        name.contains('3rdfloor')) {
      return 3;
    }
    if (name.contains('fourthfloor') ||
        name.contains('4th floor') ||
        name.contains('fourth floor') ||
        name.contains('4thfloor')) {
      return 4;
    }
    if (name.contains('fifthfloor') ||
        name.contains('5th floor') ||
        name.contains('fifth floor') ||
        name.contains('5thfloor')) {
      return 5;
    }
    if (name.contains('sixthfloor') ||
        name.contains('6th floor') ||
        name.contains('sixth floor') ||
        name.contains('6thfloor')) {
      return 6;
    }
    if (name.contains('seventhfloor') ||
        name.contains('7th floor') ||
        name.contains('seventh floor') ||
        name.contains('7thfloor')) {
      return 7;
    }
    if (name.contains('eighthfloor') ||
        name.contains('8th floor') ||
        name.contains('eighth floor') ||
        name.contains('8thfloor')) {
      return 8;
    }
    if (name.contains('ninthfloor') ||
        name.contains('9th floor') ||
        name.contains('ninth floor') ||
        name.contains('9thfloor')) {
      return 9;
    }
    if (name.contains('tenthfloor') ||
        name.contains('10th floor') ||
        name.contains('tenth floor') ||
        name.contains('10thfloor')) {
      return 10;
    }
    if (name.contains('firstfloor') ||
        name.contains('1st floor') ||
        name.contains('first floor') ||
        name.contains('1stfloor')) {
      return 1;
    }
    if (name.contains('ground floor') || name.contains('groundfloor')) {
      return 0;
    }

    final nameMatch = RegExp(r'(\d+)(?:st|nd|rd|th)?\s*floor', caseSensitive: false)
        .firstMatch(name);
    if (nameMatch != null) {
      return int.tryParse(nameMatch.group(1)!);
    }
    final nameFloorMatch = RegExp(r'floor[-_\s]*(\d+)', caseSensitive: false)
        .firstMatch(name);
    if (nameFloorMatch != null) {
      return int.tryParse(nameFloorMatch.group(1)!);
    }

    // 3. Check upload.imageUrl
    final urlMatch = RegExp(r'floor[-_\s]*(\d+)', caseSensitive: false)
        .firstMatch(upload.imageUrl);
    if (urlMatch != null) {
      return int.tryParse(urlMatch.group(1)!);
    }

    // 4. Fallback to upload.phase (e.g. in Supabase MSCC uploads, Phase column is 2, 3, 4, 5, 6)
    if (upload.phase != null) {
      return upload.phase;
    }

    return null;
  }

  /// Formats the display label for a map upload choice chip.
  /// - For ERHD: "ERHD Masterplan"
  /// - For MSCC (Mountain Suites Country Club): Choice chip displays the floor level (e.g. "2nd Floor", "3rd Floor", etc.)
  /// - For MVLC and phase-based projects: "Phase [number][map_section]"
  ///   (e.g. for Phase 2 with map section East -> "Phase 2E").
  static String formatMapChipLabel(
    MapUploadModel upload, {
    List<AnnotatedImageModel>? annotatedImages,
    String? activeProject,
  }) {
    final isErhdUpload =
        (upload.project ?? '').toUpperCase().contains('ERHD') ||
        (upload.name ?? '').toUpperCase().contains('ERHD');
    if (isErhdUpload) {
      return 'ERHD Masterplan';
    }

    final isMsccUpload =
        (upload.project ?? '').toUpperCase().contains('MSCC') ||
        (upload.name ?? '').toUpperCase().contains('MSCC') ||
        (upload.storagePath ?? '').toUpperCase().contains('MSCC') ||
        upload.imageUrl.toUpperCase().contains('MSCC') ||
        (activeProject != null &&
            (activeProject.toUpperCase().contains('MSCC') ||
                activeProject.toUpperCase().contains('MOUNTAIN SUITES')));

    if (isMsccUpload) {
      final floorNum = extractFloorNumber(upload);
      if (floorNum != null) {
        return formatFloorOrdinal(floorNum);
      }
      final name = upload.name ?? '';
      if (name.toLowerCase().contains('floor')) {
        final clean = name.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), '').trim();
        return clean;
      }
      return 'Floor Level';
    }

    final name = upload.name ?? '';
    final cleanName = name.replaceAll(RegExp(r'\.[a-zA-Z0-9]+$'), '').trim();
    final typeLower = (upload.type ?? '').trim().toLowerCase();
    final isCommercial = typeLower.contains('commercial') ||
        cleanName.toLowerCase().contains('commercial') ||
        upload.imageUrl.toLowerCase().contains('commercial');

    if (isCommercial) {
      if (cleanName.toUpperCase().contains('PH1') ||
          cleanName.toUpperCase().contains('PHASE 1') ||
          cleanName.toUpperCase().contains('PH-1') ||
          upload.phase == 1 ||
          (upload.storagePath ?? '').toLowerCase().contains('phase-1')) {
        return 'Phase 1 Commercial';
      }
      return 'Commercial';
    }

    // Determine the phase number
    final phaseNum = upload.phase ?? extractPhaseNumber(upload);

    // Determine map_section:
    // 1. From upload.mapSection directly (e.g. 'East', 'A', 'B')
    String? section;
    if (upload.mapSection != null &&
        upload.mapSection!.trim().isNotEmpty &&
        upload.mapSection!.trim().toLowerCase() != 'null') {
      section = upload.mapSection!.trim();
    }

    // 2. From matching AnnotatedImageModel in annotatedImages
    if (section == null && annotatedImages != null && annotatedImages.isNotEmpty) {
      final uploadUrlBase = upload.imageUrl.split('?').first.trim().toLowerCase();
      for (final img in annotatedImages) {
        if (img.imageLink != null &&
            img.imageLink!.split('?').first.trim().toLowerCase() == uploadUrlBase) {
          if (img.mapSection != null &&
              img.mapSection!.trim().isNotEmpty &&
              img.mapSection!.trim().toLowerCase() != 'null') {
            section = img.mapSection!.trim();
            break;
          }
        }
      }
    }

    // 3. Look for explicit parenthesized subphase like "(Phase 1A)", "(Phase 2B)", "(Phase 1E)"
    if (section == null) {
      final parenMatch = RegExp(
        r'\(\s*Phase\s*\d*([a-zA-Z]+)\s*\)',
        caseSensitive: false,
      ).firstMatch(cleanName);
      if (parenMatch != null) {
        section = parenMatch.group(1);
      }
    }

    // 4. Look for "Ph-1A", "Ph-2B", "Phase-1A", "Phase 2A", "Phase-2East"
    if (section == null) {
      final phMatch = RegExp(
        r'ph(?:ase)?[-_\s]*\d+\s*[-_]?\s*(east|[a-zA-Z])\b',
        caseSensitive: false,
      ).firstMatch(cleanName);
      if (phMatch != null) {
        section = phMatch.group(1);
      }
    }

    // 5. Fallback to storage path or imageUrl
    if (section == null) {
      final urlMatch = RegExp(
        r'phase[-_\s]*\d+\s*[-_]?\s*(east|[a-zA-Z])\b',
        caseSensitive: false,
      ).firstMatch(upload.storagePath ?? upload.imageUrl);
      if (urlMatch != null) {
        section = urlMatch.group(1);
      }
    }

    // 6. Generic extract
    section ??= extractUploadSection(upload, cleanName);

    // Format: Phase [number][map_section] (e.g. Phase 2 + East -> Phase 2E)
    final suffix = formatSectionSuffix(section);
    if (phaseNum != null) {
      if (suffix != null && suffix.isNotEmpty) {
        return 'Phase $phaseNum$suffix';
      }
      return 'Phase $phaseNum';
    }

    // Fallback if phaseNum is null
    if (suffix != null && suffix.isNotEmpty) {
      return 'Phase $suffix';
    }

    if (upload.type != null && upload.type!.trim().isNotEmpty) {
      final rawType = upload.type!.trim();
      return rawType[0].toUpperCase() + rawType.substring(1).toLowerCase();
    }

    return cleanName.isNotEmpty ? cleanName : 'Phase 2';
  }

  /// Converts any image bytes (SVG, JPEG, WEBP, PNG) into standard, uncompressed, high-quality PNG bytes.
  ///
  /// For SVG vector blueprints: supersamples at ultra-high resolution (up to 4096px)
  /// so fine architectural lot boundaries, lot numbers, measurements, and texts remain razor-sharp.
  ///
  /// For raster formats (JPEG, WEBP, BMP, etc.): decodes at 100% full native resolution
  /// without downsampling, and encodes to PNG with compression level 0 (NO COMPRESSION)
  /// and no filtering for lossless, pristine quality.
  static Future<Uint8List> convertImageToPng(
    Uint8List sourceBytes, {
    String? contentType,
    String? url,
  }) async {
    // 1. If already PNG (magic bytes 0x89, P, N, G), return as-is to preserve original lossless data
    if (sourceBytes.length >= 8 &&
        sourceBytes[0] == 0x89 &&
        sourceBytes[1] == 0x50 &&
        sourceBytes[2] == 0x4E &&
        sourceBytes[3] == 0x47) {
      return sourceBytes;
    }

    // 2. Detect if SVG (by URL, content-type, or XML/SVG markup headers)
    final isSvg = (url?.toLowerCase().contains('.svg') ?? false) ||
        (contentType?.toLowerCase().contains('svg') ?? false) ||
        (sourceBytes.length >= 5 &&
            String.fromCharCodes(sourceBytes.take(120)).toLowerCase().contains('<svg'));

    if (isSvg) {
      try {
        final pictureInfo = await vg.loadPicture(SvgBytesLoader(sourceBytes), null);
        double targetWidth = pictureInfo.size.width;
        double targetHeight = pictureInfo.size.height;
        if (targetWidth <= 0 || targetHeight <= 0) {
          targetWidth = 4096;
          targetHeight = 4096;
        }

        // Render at ultra-high resolution (up to 4096px) for crisp blueprint reading
        final maxDim = math.max(targetWidth, targetHeight);
        if (maxDim > 0) {
          final scale = 4096.0 / maxDim;
          targetWidth = (targetWidth * scale).roundToDouble();
          targetHeight = (targetHeight * scale).roundToDouble();
        }

        final recorder = ui.PictureRecorder();
        final canvas = ui.Canvas(recorder);
        final scaleX = targetWidth / (pictureInfo.size.width > 0 ? pictureInfo.size.width : 1);
        final scaleY = targetHeight / (pictureInfo.size.height > 0 ? pictureInfo.size.height : 1);
        canvas.scale(scaleX, scaleY);
        canvas.drawPicture(pictureInfo.picture);
        final scaledPicture = recorder.endRecording();

        final image = await scaledPicture.toImage(
          targetWidth.toInt(),
          targetHeight.toInt(),
        );

        // Extract raw uncompressed 32-bit RGBA pixel data
        final rawByteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        if (rawByteData != null) {
          final imgImage = img.Image.fromBytes(
            width: targetWidth.toInt(),
            height: targetHeight.toInt(),
            bytes: rawByteData.buffer,
            order: img.ChannelOrder.rgba,
            numChannels: 4,
          );
          // Encode with level 0: completely uncompressed PNG for pristine quality
          final uncompressedPng = img.encodePng(
            imgImage,
            level: 0,
            filter: img.PngFilter.none,
          );
          return Uint8List.fromList(uncompressedPng);
        }

        final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        if (byteData != null) {
          return byteData.buffer.asUint8List();
        }
      } catch (e) {
        debugPrint('[InteractiveSalesMapScreen] Error converting SVG to uncompressed PNG: $e');
      }
    }

    // 3. Raster formats (JPEG, WEBP, GIF, etc.) decoded at native resolution via Flutter's image codec
    try {
      final codec = await ui.instantiateImageCodec(sourceBytes);
      final frame = await codec.getNextFrame();
      final width = frame.image.width;
      final height = frame.image.height;

      // Extract raw uncompressed 32-bit RGBA pixels from native GPU/engine surface
      final rawByteData = await frame.image.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (rawByteData != null) {
        final imgImage = img.Image.fromBytes(
          width: width,
          height: height,
          bytes: rawByteData.buffer,
          order: img.ChannelOrder.rgba,
          numChannels: 4,
        );
        // Encode with level 0: uncompressed PNG, zero compression artifacts, maximum pixel fidelity
        final uncompressedPng = img.encodePng(
          imgImage,
          level: 0,
          filter: img.PngFilter.none,
        );
        return Uint8List.fromList(uncompressedPng);
      }

      final byteData = await frame.image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        return byteData.buffer.asUint8List();
      }
    } catch (e) {
      debugPrint('[InteractiveSalesMapScreen] Error converting raster to uncompressed PNG: $e');
    }

    return sourceBytes;
  }


  /// Resolves the downloads directory across Android, iOS, and Desktop platforms.
  static Directory getDownloadsDirectory() {
    // 1. Android public Downloads directory
    if (Platform.isAndroid) {
      final androidDownload = Directory('/storage/emulated/0/Download');
      if (androidDownload.existsSync()) return androidDownload;
      try {
        androidDownload.createSync(recursive: true);
        return androidDownload;
      } catch (_) {}
    }

    // 2. Desktop (macOS, Windows, Linux) Downloads directory
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
      if (home != null) {
        final downloads = Directory('$home/Downloads');
        if (!downloads.existsSync()) {
          try {
            downloads.createSync(recursive: true);
          } catch (_) {}
        }
        if (downloads.existsSync()) return downloads;
      }
    }

    // 3. iOS sandboxed Documents/Downloads directory
    if (Platform.isIOS) {
      final home = Platform.environment['HOME'];
      if (home != null) {
        final iosDocs = Directory('$home/Documents');
        if (!iosDocs.existsSync()) {
          try {
            iosDocs.createSync(recursive: true);
          } catch (_) {}
        }
        final iosDownloads = Directory('$home/Documents/Downloads');
        if (!iosDownloads.existsSync()) {
          try {
            iosDownloads.createSync(recursive: true);
          } catch (_) {}
        }
        if (iosDownloads.existsSync()) return iosDownloads;
        if (iosDocs.existsSync()) return iosDocs;
      }
    }

    return Directory.systemTemp;
  }

  @override
  State<InteractiveSalesMapScreen> createState() =>
      _InteractiveSalesMapScreenState();
}

class _InteractiveSalesMapScreenState extends State<InteractiveSalesMapScreen>
    with TickerProviderStateMixin {
  late TransformationController _transformController;
  late AnimationController _compassAnimController;
  late AnimationController _zoomAnimController;
  Animation<Matrix4>? _zoomAnimation;
  double? _targetScale;
  Size _lastViewportSize = Size.zero;

  final ValueNotifier<bool> _isMapInteracting = ValueNotifier<bool>(false);
  int _mapActivePointers = 0;

  late List<MapLotModel> _lots;
  MapLotModel? _selectedLot;
  bool _isFullscreen = false;
  bool _isLoading = true;
  Map<String, int> _liveSummary = {};
  List<ProjectModel> _projects = [];
  ProjectModel? _selectedProject;
  String _selectedProjectName = 'Mountain View Leisure (MVLC)';

  List<MapUploadModel> _projectUploads = [];
  MapUploadModel? _activeMapUpload;
  int? _selectedPhaseNumber;
  int _mapReloadCounter = 0;

  List<AnnotatedImageModel> _annotatedImages = [];
  AnnotatedImageModel? _activeAnnotatedImage;

  PhaseLotAnnotation? _selectedAnnotation;
  String? _selectedAnnotationName;
  String? _lastSavedMediaUri;

  List<MvlcPriceModel> _mvlcPrices = [];
  final Map<String, LotModel> _lotsByAnnotationName = {};
  final Map<String, String> _lotStatuses = {};

  int? get _activePhaseNumber {
    if (_selectedPhaseNumber != null) return _selectedPhaseNumber;
    if (_activeMapUpload?.phase != null) return _activeMapUpload!.phase;
    final name = (_activeMapUpload?.name ?? '').toLowerCase();
    final type = (_activeMapUpload?.type ?? '').toLowerCase();
    final url = (_activeMapUpload?.imageUrl ?? '').toLowerCase();
    final proj = (_activeMapUpload?.project ?? '').toLowerCase();

    if (name.contains('phase-3') ||
        name.contains('phase 3') ||
        name.contains('phase3') ||
        name.contains('p3') ||
        type.contains('phase-3') ||
        type.contains('phase 3') ||
        type.contains('phase3') ||
        url.contains('phase3') ||
        url.contains('phase-3') ||
        url.contains('carnation') ||
        name.contains('carnation') ||
        proj.contains('phase 3')) {
      return 3;
    }

    if (name.contains('phase-2') ||
        name.contains('phase 2') ||
        name.contains('phase2') ||
        name.contains('p2') ||
        type.contains('phase-2') ||
        type.contains('phase 2') ||
        type.contains('phase2') ||
        url.contains('phase2') ||
        url.contains('phase-2') ||
        proj.contains('phase 2')) {
      return 2;
    }

    if (name.contains('phase-1') ||
        name.contains('phase 1') ||
        name.contains('phase1') ||
        name.contains('p1') ||
        type.contains('phase-1') ||
        type.contains('phase 1') ||
        type.contains('phase1') ||
        url.contains('phase1') ||
        url.contains('phase-1') ||
        proj.contains('phase 1')) {
      return 1;
    }
    return null;
  }

  bool get _isSoonToRiseActive {
    if (_selectedProject != null) {
      return _selectedProject!.paused;
    }
    final p = (_activeMapUpload?.project ??
            _selectedProjectName)
        .toUpperCase();
    final n = (_activeMapUpload?.name ?? '').toUpperCase();
    return SupabaseService.isProjectPaused(p, n);
  }

  bool get _isGlsActive => _isSoonToRiseActive;

  String get _soonToRiseProjectCode {
    if (_selectedProject?.code != null && _selectedProject!.code!.trim().isNotEmpty) {
      return _selectedProject!.code!.trim().toUpperCase();
    }
    final p = (_activeMapUpload?.project ??
            _selectedProject?.displayName ??
            _selectedProjectName)
        .toUpperCase();
    if (p.contains('LCN') || p.contains('LAKESHORE')) return 'LCN';
    if (p.contains('MCVC')) return 'MCVC';
    if (p.contains('RHM')) return 'RHM';
    if (p.contains('RHN')) return 'RHN';
    if (p.contains('GLS') || p.contains('LANDSCAPE')) return 'GLS';
    return p;
  }

  String get _soonToRiseProjectTitle {
    if (_selectedProject != null) {
      final code = _selectedProject!.code?.trim().toUpperCase();
      if (code != null && code.isNotEmpty && !_selectedProject!.displayName.contains(code)) {
        return '${_selectedProject!.displayName} ($code)';
      }
      return _selectedProject!.displayName;
    }
    final code = _soonToRiseProjectCode;
    switch (code) {
      case 'LCN':
        return 'Lakeshore Community North (LCN)';
      case 'MCVC':
        return 'Mini Complete Vacation Community (MCVC)';
      case 'RHM':
        return 'Resort Hub Muños (RHM)';
      case 'RHN':
        return 'Resort Hub Nasugbu (RHN)';
      case 'GLS':
      default:
        return 'Green Landscape Sanctuary (GLS)';
    }
  }

  bool get _isErhdActive {
    final p = (_activeMapUpload?.project ??
            _selectedProject?.code ??
            _selectedProject?.displayName ??
            '')
        .toUpperCase();
    final n = (_activeMapUpload?.name ?? '').toUpperCase();
    return p.contains('ERHD') ||
        n.contains('ERHD') ||
        p.contains('RESORT HUB') ||
        p.contains('EASTWEST RESORT');
  }

  bool get _isMsccActive {
    final p = (_activeMapUpload?.project ??
            _selectedProject?.code ??
            _selectedProject?.displayName ??
            _selectedProjectName)
        .toUpperCase();
    final n = (_activeMapUpload?.name ?? '').toUpperCase();
    return p.contains('MSCC') ||
        n.contains('MSCC') ||
        p.contains('MOUNTAIN SUITES') ||
        p.contains('SUITES');
  }

  int? get _activeFloorNumber =>
      _activeMapUpload != null
          ? InteractiveSalesMapScreen.extractFloorNumber(_activeMapUpload!)
          : null;

  bool get _isCommercialActive {
    final t = (_activeMapUpload?.type ?? '').toLowerCase();
    final n = (_activeMapUpload?.name ?? '').toLowerCase();
    return t.contains('commercial') || n.contains('commercial');
  }

  bool get _isPhase1Active =>
      _activePhaseNumber == 1 && !_isCommercialActive && !_isErhdActive && !_isMsccActive;
  bool get _isPhase2Active =>
      _activePhaseNumber == 2 && !_isErhdActive && !_isMsccActive;
  bool get _isPhase3Active =>
      _activePhaseNumber == 3 && !_isErhdActive && !_isMsccActive;

  /// Extracts the map section (e.g. 'east', 'a', 'b', 'c', or null) from an upload.
  static String? _extractUploadSection(MapUploadModel? upload, String chipLabel) =>
      InteractiveSalesMapScreen.extractUploadSection(upload, chipLabel);

  List<PhaseLotAnnotation> get _activeAnnotations {
    // When an annotated image matches from the annotated_images table, apply its annotations
    if (_activeAnnotatedImage != null &&
        _activeAnnotatedImage!.annotations.isNotEmpty) {
      return _activeAnnotatedImage!.annotations;
    }

    // Once annotated_images has been fetched from the database, strictly respect the match.
    // Maps without a matching row in annotated_images (e.g. Phase 2A, Phase 2B, Phase 1A-1C) have no annotations.
    if (_annotatedImages.isNotEmpty) {
      return const [];
    }

    // Fallback only if database table has not loaded yet (e.g. offline/initialization)
    if (_isCommercialActive) {
      return Phase1CommercialAnnotationsData.annotations;
    }
    if (_isErhdActive) {
      return ErhdAnnotationsData.annotations;
    }
    if (_isMsccActive) {
      return const [];
    }
    final chipLabel =
        _activeMapUpload != null ? _getMapChipLabel(_activeMapUpload!) : '';
    final section = _extractUploadSection(_activeMapUpload, chipLabel);
    if (_isPhase3Active && section == null) {
      return Phase3AnnotationsData.annotations;
    }
    if (_isPhase2Active && section == 'east') {
      return Phase2AnnotationsData.annotations;
    }
    if (_isPhase1Active && section == 'east') {
      return Phase1AnnotationsData.annotations;
    }
    return const [];
  }

  String? get _normalizedActiveMapSection {
    final upload = _activeMapUpload;
    if (upload == null) return null;
    final chipLabel = _getMapChipLabel(upload);
    final raw = upload.mapSection ??
        _activeAnnotatedImage?.mapSection ??
        _extractUploadSection(upload, chipLabel);
    if (raw == null || raw.trim().isEmpty || raw.trim().toLowerCase() == 'null') {
      return null;
    }
    final s = raw.trim().toLowerCase();
    if (s == 'east' || s == 'e') return 'East';
    if (s == 'west' || s == 'w') return 'West';
    if (s == 'north' || s == 'n') return 'North';
    if (s == 'south' || s == 's') return 'South';
    return raw.trim();
  }

  Size? get _activeNativeImageSize {
    if (_activeAnnotatedImage != null &&
        _activeAnnotatedImage!.imageWidth > 0 &&
        _activeAnnotatedImage!.imageHeight > 0) {
      return Size(
        _activeAnnotatedImage!.imageWidth,
        _activeAnnotatedImage!.imageHeight,
      );
    }
    return null;
  }

  /// Effective canvas size for the currently active map phase
  Size get _currentCanvasSize => SalesMapCanvas.effectiveSize(
        activePhase: _isCommercialActive ? null : _activePhaseNumber,
        isPhase1: _isPhase1Active,
        isPhase2: _isPhase2Active,
        isPhase3: _isPhase3Active,
        isCommercial: _isCommercialActive,
        isErhd: _isErhdActive,
        isMscc: _isMsccActive,
        imageSize: _activeNativeImageSize,
        annotations: _activeAnnotations,
      );

  /// Helper to match an active map upload to its corresponding AnnotatedImageModel.
  /// Looks at the `map_section` column in annotated_images:
  /// - If map_section is 'East', it overlays on Phase 2E only (or Phase 1E only).
  /// - If map_section is null, it refers only to the phase number (e.g. Phase 3).
  AnnotatedImageModel? _matchAnnotatedImage(MapUploadModel? upload) {
    if (upload == null || _annotatedImages.isEmpty) return null;

    final uploadLabel = _getMapChipLabel(upload);
    final uploadSection = _extractUploadSection(upload, uploadLabel);
    final isCommercial =
        (upload.type ?? '').toLowerCase().contains('commercial') ||
            (upload.name ?? '').toLowerCase().contains('commercial') ||
            uploadLabel.toLowerCase().contains('commercial');
    final isErhd = (upload.project ?? '').toUpperCase().contains('ERHD') ||
        (upload.name ?? '').toUpperCase().contains('ERHD') ||
        uploadLabel.toUpperCase().contains('ERHD');
    final phaseNum = upload.phase ?? _extractPhaseNumber(upload);

    // 1. Special projects: Commercial / ERHD
    if (isCommercial) {
      return _annotatedImages.where((img) => img.isCommercial).firstOrNull;
    }
    if (isErhd) {
      return _annotatedImages.where((img) => img.isErhd).firstOrNull;
    }

    // 2. Exact imageLink match (ignoring query parameters), provided map_section matches
    final uploadUrlBase = upload.imageUrl.split('?').first.trim().toLowerCase();
    if (uploadUrlBase.isNotEmpty) {
      for (final img in _annotatedImages) {
        if (img.imageLink != null) {
          final imgUrlBase = img.imageLink!.split('?').first.trim().toLowerCase();
          if (imgUrlBase == uploadUrlBase) {
            if (img.hasMapSection) {
              if (img.normalizedMapSection == uploadSection) {
                return img;
              }
            } else if (uploadSection == null) {
              return img;
            }
          }
        }
      }
    }

    // 3. Match by phase number and map_section column:
    // Look at map_section column to accurately apply it on the right map.
    // Example: phase 2 and map_section is East -> overlayed on Phase 2E only.
    // If map_section is null, only refer on the phase number.
    if (phaseNum != null) {
      // If upload belongs to a specific section (e.g. Phase 2E -> 'east', Phase 2A -> 'a'):
      if (uploadSection != null) {
        for (final img in _annotatedImages) {
          if (!img.isCommercial &&
              !img.isErhd &&
              img.phaseNumber == phaseNum &&
              img.hasMapSection &&
              img.normalizedMapSection == uploadSection) {
            return img;
          }
        }
        // If upload has a specific section (e.g. Phase 2A or 2B) and no matching map_section exists,
        // it MUST NOT match Phase 2 East's annotations!
        return null;
      }

      // If upload has no sub-section (e.g. Phase 3):
      // If map_section is null, only refer on the phase number
      for (final img in _annotatedImages) {
        if (!img.isCommercial &&
            !img.isErhd &&
            img.phaseNumber == phaseNum &&
            !img.hasMapSection) {
          return img;
        }
      }
    }

    return null;
  }

  /// Resolves the active map upload from `uploads` table for the currently selected phase/project,
  /// strictly using the image URL from the `image_URL` column.
  MapUploadModel? get _currentMapUpload {
    if (_activeMapUpload != null && _activeMapUpload!.image_URL.isNotEmpty) {
      return _activeMapUpload;
    }
    if (_projectUploads.isNotEmpty) {
      if (_isCommercialActive) {
        final comm = _projectUploads.where((u) {
          final t = (u.type ?? '').toLowerCase();
          final n = (u.name ?? '').toLowerCase();
          final url = u.imageUrl.toLowerCase();
          return t.contains('commercial') ||
              n.contains('commercial') ||
              url.contains('commercial');
        }).firstOrNull;
        if (comm != null && comm.image_URL.isNotEmpty) return comm;
      }
      final phase = _activePhaseNumber;
      if (phase != null) {
        final match = _projectUploads
            .where((u) => _extractPhaseNumber(u) == phase)
            .firstOrNull;
        if (match != null && match.image_URL.isNotEmpty) return match;
      }
      return _projectUploads.where((u) => u.image_URL.isNotEmpty).firstOrNull;
    }
    return null;
  }

  static const String logoUrl = 'asset/bhrilogo.jpg';


  bool _isDownloadingMap = false;

  /// Resolves the URL of the currently rendered map image blueprint
  String? get _currentMapImageUrl {
    final uploadUrl = (_currentMapUpload ?? _activeMapUpload)?.image_URL;
    if (uploadUrl != null && uploadUrl.isNotEmpty) {
      return uploadUrl;
    }
    final annotatedUrl = _activeAnnotatedImage?.imageLink;
    if (annotatedUrl != null && annotatedUrl.isNotEmpty) {
      return annotatedUrl;
    }
    return null;
  }

  String get _downloadProjectName {
    if (_selectedProject != null) {
      if (_selectedProject!.code != null && _selectedProject!.code!.trim().isNotEmpty) {
        return _selectedProject!.code!.trim();
      }
      if (_selectedProject!.name != null && _selectedProject!.name!.trim().isNotEmpty) {
        return _selectedProject!.name!.trim();
      }
      return _selectedProject!.displayName;
    }
    if (_activeAnnotatedImage?.project != null && _activeAnnotatedImage!.project!.isNotEmpty) {
      return _activeAnnotatedImage!.project!;
    }
    if (_activeMapUpload?.project != null && _activeMapUpload!.project!.isNotEmpty) {
      return _activeMapUpload!.project!;
    }
    return _selectedProjectName;
  }

  String get _downloadPhaseName {
    if (_isCommercialActive) {
      return 'Commercial';
    }
    final upload = _currentMapUpload ?? _activeMapUpload;
    final uploadLabel = upload != null ? _getMapChipLabel(upload) : '';
    final section = _activeAnnotatedImage?.mapSection ?? _extractUploadSection(upload, uploadLabel);
    final phaseNum = _activePhaseNumber ?? _activeAnnotatedImage?.phaseNumber ?? 1;

    if (section != null && section.isNotEmpty) {
      final sectionClean = section.toUpperCase().startsWith('E') ? 'East' : section;
      return 'Phase $phaseNum $sectionClean';
    }
    return 'Phase $phaseNum';
  }

  String _buildDownloadFilename(String extension) {
    return InteractiveSalesMapScreen.formatDownloadFilename(
      projectName: _downloadProjectName,
      phase: _downloadPhaseName,
      extension: extension,
    );
  }



  Future<File?> _saveDownloadedFile({
    required List<int> bytes,
    required String filename,
  }) async {
    File? localFile;
    bool platformSaved = false;

    // 1. Call native platform channel FIRST so Android MediaStore & iOS Photos Album handle it directly
    try {
      const channel = MethodChannel('com.vhbc.broker/gallery');
      final result = await channel.invokeMethod('saveImageToGallery', {
        'bytes': bytes,
        'filename': filename,
      });
      if (result != null) {
        platformSaved = true;
        _lastSavedMediaUri = result.toString();
        debugPrint('[SaveMap] Platform saved successfully: $_lastSavedMediaUri');
      }
    } catch (e) {
      debugPrint('[SaveMap] Platform channel save error: $e');
    }

    // 2. Try writing to public Downloads directory
    try {
      final targetDir = InteractiveSalesMapScreen.getDownloadsDirectory();
      final file = File('${targetDir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      localFile = file;
    } catch (e) {
      debugPrint('[SaveMap] Direct filesystem write to downloads failed: $e');
    }

    // 3. Fallback writing to app-safe internal temp if direct public filesystem write was restricted
    if (localFile == null) {
      try {
        final tempDir = Directory.systemTemp;
        final file = File('${tempDir.path}/$filename');
        await file.writeAsBytes(bytes, flush: true);
        localFile = file;
      } catch (e) {
        debugPrint('[SaveMap] Fallback temp write failed: $e');
      }
    }

    // 4. On macOS / Windows / Linux desktop: ensure it is saved in ~/Downloads
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      try {
        final home = Platform.environment['HOME'] ?? Platform.environment['USERPROFILE'];
        if (home != null) {
          final downloads = Directory('$home/Downloads');
          if (!downloads.existsSync()) downloads.createSync(recursive: true);
          final desktopFile = File('${downloads.path}/$filename');
          await desktopFile.writeAsBytes(bytes, flush: true);
          localFile = desktopFile;
        }
      } catch (_) {}
    }

    // 5. On iOS simulator: if running on macOS host, also save directly into ~/Downloads on the host
    // and into the simulator Photos DCIM directory so it shows up in the Photos gallery!
    if (Platform.isIOS) {
      final hostHome = Platform.environment['SIMULATOR_HOST_HOME'];
      if (hostHome != null && hostHome.isNotEmpty) {
        try {
          final hostDownloads = Directory('$hostHome/Downloads');
          if (hostDownloads.existsSync()) {
            final hostFile = File('${hostDownloads.path}/$filename');
            await hostFile.writeAsBytes(bytes, flush: true);
          }
        } catch (_) {}
      }

      final simShared = Platform.environment['SIMULATOR_SHARED_RESOURCES_DIRECTORY'] ??
          Platform.environment['CFFIXED_USER_HOME'];
      if (simShared != null && simShared.isNotEmpty) {
        try {
          final dcimDir = Directory('$simShared/Media/DCIM/100APPLE');
          if (dcimDir.existsSync()) {
            final dcimFile = File('${dcimDir.path}/$filename');
            await dcimFile.writeAsBytes(bytes, flush: true);
          }
        } catch (_) {}
      }
    }

    if (platformSaved || localFile != null) {
      return localFile ?? File(filename);
    }
    return null;
  }

  /// Downloads the current map blueprint image with filename: "project name - phase - latest.ext"
  Future<void> _downloadMapImage() async {
    final mapUrl = _currentMapImageUrl;
    if (mapUrl == null || mapUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No map blueprint available to download for this phase.',
            style: AppTextStyles.bodySm.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isDownloadingMap) return;

    setState(() {
      _isDownloadingMap = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Converting map to uncompressed high-quality PNG...',
                style: AppTextStyles.bodySm.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(milliseconds: 2500),
      ),
    );

    try {
      Uint8List imageBytes;
      String? contentType;

      if (mapUrl.startsWith('http://') || mapUrl.startsWith('https://')) {
        final uri = Uri.parse(mapUrl);
        final response = await http.get(uri).timeout(const Duration(seconds: 35));
        if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
          throw Exception('Server returned HTTP ${response.statusCode}');
        }
        imageBytes = response.bodyBytes;
        contentType = response.headers['content-type'];
      } else if (mapUrl.startsWith('asset') || mapUrl.startsWith('/asset')) {
        final cleanAsset = mapUrl.startsWith('/') ? mapUrl.substring(1) : mapUrl;
        final byteData = await rootBundle.load(cleanAsset);
        imageBytes = byteData.buffer.asUint8List();
      } else if (mapUrl.startsWith('file://')) {
        final file = File(Uri.parse(mapUrl).toFilePath());
        imageBytes = await file.readAsBytes();
      } else {
        final file = File(mapUrl);
        if (await file.exists()) {
          imageBytes = await file.readAsBytes();
        } else {
          final byteData = await rootBundle.load(mapUrl);
          imageBytes = byteData.buffer.asUint8List();
        }
      }

      // Convert image (SVG, JPEG, WEBP, etc.) to uncompressed, high-quality PNG format
      final pngBytes = await InteractiveSalesMapScreen.convertImageToPng(
        imageBytes,
        contentType: contentType,
        url: mapUrl,
      );

      final filename = _buildDownloadFilename('.png');
      final savedFile = await _saveDownloadedFile(
        bytes: pngBytes,
        filename: filename,
      );

      if (savedFile == null) {
        throw Exception('Could not save map image to device storage.');
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primaryFixedDim,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Downloaded: $filename',
                      style: AppTextStyles.bodySm.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                'Saved to Downloads folder & Photos Gallery',
                style: AppTextStyles.labelSm.copyWith(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          backgroundColor: AppColors.primaryContainer,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'Open',
            textColor: AppColors.secondaryFixed,
            onPressed: () {
              _openDownloadedFileInGallery(savedFile, filename);
            },
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to download map: $e',
            style: AppTextStyles.bodySm.copyWith(color: Colors.white),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloadingMap = false;
        });
      }
    }
  }

  /// Opens the downloaded map image directly in the phone's gallery app.
  Future<void> _openDownloadedFileInGallery(File file, String filename) async {
    // 1. Try native platform channel first (handles Android Gallery intent & iOS Photos natively!)
    try {
      const channel = MethodChannel('com.vhbc.broker/gallery');
      final ok = await channel.invokeMethod('openGallery', {
        'path': file.path,
        'uri': _lastSavedMediaUri,
      });
      if (ok == true) return;
    } catch (_) {}

    // 2. On iOS: Open the phone's Photos gallery application directly
    if (Platform.isIOS) {
      try {
        final photosUri = Uri.parse('photos-redirect://');
        if (await canLaunchUrl(photosUri)) {
          await launchUrl(photosUri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (_) {}
    }

    // 3. On Android: Try deep linking to Photos or external image view
    if (Platform.isAndroid) {
      try {
        final photosUri = Uri.parse('content://media/external/images/media');
        if (await canLaunchUrl(photosUri)) {
          await launchUrl(photosUri, mode: LaunchMode.externalApplication);
          return;
        }
      } catch (_) {}
    }

    // 3. On desktop (macOS, Windows, Linux): Open in system image viewer (Preview / Photos)
    if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      try {
        if (Platform.isMacOS) {
          await Process.run('open', [file.path]);
          return;
        } else if (Platform.isWindows) {
          await Process.run('explorer.exe', [file.path]);
          return;
        } else if (Platform.isLinux) {
          await Process.run('xdg-open', [file.path]);
          return;
        }
      } catch (_) {}
    }

    // Fallback if system gallery could not be opened
    if (mounted) {
      _showInAppGallery(file, filename);
    }
  }

  /// Displays an in-app interactive gallery preview modal for the downloaded map.
  void _showInAppGallery(File file, String filename) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: const Color(0xFF14181F),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C222B),
                    border: Border(
                      bottom: BorderSide(color: AppColors.outlineVariant.withValues(alpha: 0.3), width: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.photo_library_rounded, color: AppColors.secondaryFixedDim, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          filename,
                          style: AppTextStyles.labelMd.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, color: Colors.white70),
                        onPressed: () => Navigator.of(ctx).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 5.0,
                    child: Center(
                      child: Image.file(
                        file,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  color: const Color(0xFF1C222B),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saved in Downloads',
                        style: AppTextStyles.labelSm.copyWith(color: Colors.white70),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.photo_library_outlined, size: 16, color: AppColors.secondaryFixedDim),
                        label: Text('Open Photos', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondaryFixedDim)),
                        onPressed: () {
                          launchUrl(Uri.parse('photos-redirect://'), mode: LaunchMode.externalApplication);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _lots = MapLotModel.buildFromLiveLots([]);
    _transformController = TransformationController();
    _compassAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _zoomAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..addListener(() {
        if (_zoomAnimation != null) {
          _transformController.value = _zoomAnimation!.value;
        }
      });
    _loadLiveMapData(reloadProjects: true);
  }

  @override
  void dispose() {
    _transformController.dispose();
    _compassAnimController.dispose();
    _zoomAnimController.dispose();
    _isMapInteracting.dispose();
    super.dispose();
  }

  /// Extracts the phase number from [upload], checking `phase` field, `name`, `imageUrl`, and `storagePath`.
  int? _extractPhaseNumber(MapUploadModel upload) =>
      InteractiveSalesMapScreen.extractPhaseNumber(upload);

  /// Sorts uploads: residential phases ascending (1A, 1B, 1C, 1E, 2A, 2B, 2E, 3), commercial at the end, newest upload ID first.
  void _sortUploads(List<MapUploadModel> uploads) {
    uploads.sort((a, b) {
      final labelA = _getMapChipLabel(a);
      final labelB = _getMapChipLabel(b);

      final isCommA = labelA.toLowerCase().contains('commercial');
      final isCommB = labelB.toLowerCase().contains('commercial');

      if (isCommA != isCommB) {
        return isCommA ? 1 : -1; // Commercial at the end
      }

      // 1. Check for floor level (e.g. "2nd Floor", "3rd Floor")
      final floorA = int.tryParse(
          RegExp(r'(\d+)(?:st|nd|rd|th)?\s*Floor', caseSensitive: false)
                  .firstMatch(labelA)
                  ?.group(1) ??
              '');
      final floorB = int.tryParse(
          RegExp(r'(\d+)(?:st|nd|rd|th)?\s*Floor', caseSensitive: false)
                  .firstMatch(labelB)
                  ?.group(1) ??
              '');
      if (floorA != null && floorB != null && floorA != floorB) {
        return floorA.compareTo(floorB);
      }

      // 2. Extract main phase number
      final numA = int.tryParse(
          RegExp(r'Phase\s*(\d+)').firstMatch(labelA)?.group(1) ?? '999');
      final numB = int.tryParse(
          RegExp(r'Phase\s*(\d+)').firstMatch(labelB)?.group(1) ?? '999');

      if (numA != numB) {
        return numA!.compareTo(numB!);
      }

      final labelComp = labelA.compareTo(labelB);
      if (labelComp != 0) return labelComp;

      // When label matches, newest upload ID first
      return b.id.compareTo(a.id);
    });
  }

  /// Retains only the latest upload for each distinct phase/subphase category.
  List<MapUploadModel> _deduplicateUploads(List<MapUploadModel> list) {
    final seen = <String>{};
    final unique = <MapUploadModel>[];
    for (final u in list) {
      final label = _getMapChipLabel(u).trim().toLowerCase();
      final key = '${u.projectId ?? u.project}_$label';
      if (!seen.contains(key)) {
        seen.add(key);
        unique.add(u);
      }
    }
    return unique;
  }

  /// Formats the display label for a map upload choice chip.
  /// Delegates to [InteractiveSalesMapScreen.formatMapChipLabel].
  String _getMapChipLabel(MapUploadModel upload) =>
      InteractiveSalesMapScreen.formatMapChipLabel(
        upload,
        annotatedImages: _annotatedImages,
        activeProject: _selectedProject?.displayName ??
            _selectedProject?.code ??
            _selectedProjectName,
      );

  List<LotModel> _filterLotsForActiveMap(List<LotModel> lots) {
    if (_isErhdActive) {
      return lots;
    }
    if (_isMsccActive) {
      final floorNum = _activeFloorNumber ?? _activePhaseNumber;
      if (floorNum != null) {
        return lots.where((l) => l.phase == floorNum).toList();
      }
      return lots;
    }
    if (_isCommercialActive) {
      return lots
          .where((l) => LotModel.extractCommercialLotNo(l.lotNo) != null || l.isCommercial)
          .toList();
    }

    final activeSection = _normalizedActiveMapSection;
    final phaseNum = _activePhaseNumber ?? _selectedPhaseNumber;
    var filtered = lots;

    // For MVLC: always refer to the map_section because same phase number has multiple map sections.
    // If map_section is null, only use the phase number.
    if (activeSection != null && activeSection.isNotEmpty) {
      final s = activeSection.toLowerCase();
      filtered = filtered.where((l) {
        if (l.mapSection == null) return false;
        final ms = l.mapSection!.trim().toLowerCase();
        return ms == s ||
            (s == 'east' && ms == 'e') ||
            (s == 'e' && ms == 'east') ||
            (s == 'west' && ms == 'w') ||
            (s == 'w' && ms == 'west');
      }).toList();
      if (phaseNum != null) {
        filtered = filtered.where((l) => l.phase == phaseNum).toList();
      }
    } else if (phaseNum != null) {
      // If map_section is null, only use the phase number
      filtered = filtered.where((l) => l.phase == phaseNum).toList();
    }

    if (_isPhase1Active && !_isCommercialActive) {
      filtered = filtered
          .where((l) =>
              LotModel.extractCommercialLotNo(l.lotNo) == null &&
              !l.isCommercial &&
              l.lotNo.trim().toUpperCase().startsWith('B'))
          .toList();
    }
    return filtered;
  }

  Map<String, int> _computeSummaryForLots(
    List<LotModel> lots,
    Map<String, int> defaultSummary,
  ) {
    if (lots.isNotEmpty) {
      int avail = 0;
      int res = 0;
      int sld = 0;
      int hld = 0;
      for (final l in lots) {
        final st = l.status.toLowerCase();
        if (st == 'available') {
          avail++;
        } else if (st == 'reserved' || st == 'rsv' || st == 'rsv-p') {
          res++;
        } else if (st == 'hold') {
          hld++;
        } else if (st == 'sold') {
          sld++;
        }
      }
      return {
        'available': avail,
        'reserved': res,
        'hold': hld,
        'sold': sld,
        'total': lots.length,
      };
    }
    return defaultSummary;
  }

  Future<void> _loadLiveMapData({bool reloadProjects = false}) async {
    setState(() => _isLoading = true);

    try {
      if (reloadProjects || _projects.isEmpty) {
        final fetchedProjects = await SupabaseService.fetchProjects();
        _projects = fetchedProjects;
        if (_selectedProject == null && fetchedProjects.isNotEmpty) {
          final mvlc = fetchedProjects
              .where((p) =>
                  p.code?.toUpperCase() == 'MVLC' ||
                  p.displayName.toUpperCase().contains('MVLC') ||
                  p.displayName.toUpperCase().contains('MOUNTAIN VIEW'))
              .firstOrNull;
          _selectedProject = mvlc ?? fetchedProjects.first;
          _selectedProjectName = _selectedProject!.displayName;
        }
      }

      final projectKey =
          _selectedProject?.code ?? _selectedProject?.name ?? 'MVLC';
      final parsedProjectId = int.tryParse(_selectedProject?.id ?? '');

      // Query map images on the table uploads referring to the project name and id
      var uploads = await SupabaseService.fetchMapUploads(
        project: projectKey,
        projectId: parsedProjectId,
        forceRefresh: true,
      );

      // Fallback query if project name has whitespace or suffix
      if (uploads.isEmpty && _selectedProject?.code != null) {
        uploads = await SupabaseService.fetchMapUploads(
          project: _selectedProject!.code,
          projectId: parsedProjectId,
          forceRefresh: true,
        );
      }
      if (uploads.isEmpty && _selectedProject?.displayName != null) {
        uploads = await SupabaseService.fetchMapUploads(
          project: _selectedProject!.displayName,
          projectId: parsedProjectId,
          forceRefresh: true,
        );
      }

      _sortUploads(uploads);
      final deduplicated = _deduplicateUploads(uploads);
      _projectUploads = deduplicated;

      if (_activeMapUpload != null) {
        final currentLabel = _getMapChipLabel(_activeMapUpload!);
        final latestMatching = deduplicated.where((u) {
          if (u.id == _activeMapUpload!.id) return true;
          return _getMapChipLabel(u) == currentLabel;
        }).firstOrNull;

        _activeMapUpload = latestMatching ??
            deduplicated
                .where((u) => u.id == _activeMapUpload!.id)
                .firstOrNull ??
            deduplicated.firstOrNull;
      } else {
        // Prioritize Phase 2E (or Phase 2) if available so annotations are immediately loaded and visible
        final p2e = deduplicated
            .where((u) => _getMapChipLabel(u).contains('2E'))
            .firstOrNull;
        final p2 = deduplicated
            .where((u) => _extractPhaseNumber(u) == 2)
            .firstOrNull;
        _activeMapUpload = p2e ?? p2 ?? deduplicated.firstOrNull;
      }
      _selectedPhaseNumber = _activeMapUpload?.phase ??
          (_activeMapUpload != null
              ? _extractPhaseNumber(_activeMapUpload!)
              : null);
      _mapReloadCounter++;
      PaintingBinding.instance.imageCache.clear();
      PaintingBinding.instance.imageCache.clearLiveImages();

      final isErhd = _isErhdActive;
      final lotTable = isErhd ? 'erhd_lots' : 'mvlc_lots';
      final activeSection = _normalizedActiveMapSection;

      final results = await Future.wait([
        SupabaseService.fetchLotsSummary(table: lotTable),
        SupabaseService.fetchLots(
          phase: isErhd ? null : (_activeMapUpload?.phase ?? _selectedPhaseNumber),
          mapSection: isErhd ? null : activeSection,
          limit: 2000,
          table: lotTable,
        ),
        SupabaseService.fetchMvlcPrices(),
        SupabaseService.fetchAnnotatedImages(
          project: projectKey,
          forceRefresh: true,
        ),
      ]);

      if (!mounted) return;

      final summary = results[0] as Map<String, int>;
      final liveLots = results[1] as List<LotModel>;
      final mvlcPrices = results[2] as List<MvlcPriceModel>;
      final annotatedImages = results[3] as List<AnnotatedImageModel>;

      _annotatedImages = annotatedImages;
      _activeAnnotatedImage = _matchAnnotatedImage(_activeMapUpload);

      final filteredLots = _filterLotsForActiveMap(liveLots);
      _populateLotsCache(filteredLots, mvlcPrices);
      final activeSummary = _computeSummaryForLots(filteredLots, summary);

      final currentPhaseLabel = _activeMapUpload != null
          ? _getMapChipLabel(_activeMapUpload!)
          : _selectedProjectName;

      final mappedLots =
          _buildMappedLots(filteredLots, isErhd, currentPhaseLabel);

      MapLotModel? selected;
      if (_selectedLot != null) {
        selected =
            mappedLots.where((l) => l.id == _selectedLot!.id).firstOrNull;
      } else if (widget.initialLotId != null) {
        selected = mappedLots
            .where((l) => l.id == widget.initialLotId)
            .firstOrNull;
      }

      setState(() {
        _liveSummary = activeSummary;
        _lots = mappedLots;
        _selectedLot = selected;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _populateLotsCache(List<LotModel> liveLots, List<MvlcPriceModel> mvlcPrices) {
    _mvlcPrices = mvlcPrices;
    _lotsByAnnotationName.clear();
    _lotStatuses.clear();

    for (final lot in liveLots) {
      final norm = LotModel.normalizeLotNo(lot.lotNo);
      _lotsByAnnotationName[norm.trim().toUpperCase()] = lot;
      _lotsByAnnotationName[norm.replaceAll(' ', '').toUpperCase()] = lot;
      _lotsByAnnotationName[lot.lotNo.trim().toUpperCase()] = lot;
      _lotsByAnnotationName[lot.lotNo.replaceAll(' ', '').toUpperCase()] = lot;

      _lotStatuses[norm.trim().toUpperCase()] = lot.status;
      _lotStatuses[norm.replaceAll(' ', '').toUpperCase()] = lot.status;
      _lotStatuses[lot.lotNo.trim().toUpperCase()] = lot.status;
      _lotStatuses[lot.lotNo.replaceAll(' ', '').toUpperCase()] = lot.status;

      // Also map commercial aliases so "C L1" and "CL1" point to "L1"
      final commLotNo = LotModel.extractCommercialLotNo(lot.lotNo);
      if (commLotNo != null) {
        final cNum = commLotNo.replaceAll(RegExp(r'^[Ll]'), '');
        final cKey = 'C L$cNum';
        final cKeyNoSpace = 'CL$cNum';
        _lotsByAnnotationName[cKey] = lot;
        _lotsByAnnotationName[cKeyNoSpace] = lot;
        _lotStatuses[cKey] = lot.status;
        _lotStatuses[cKeyNoSpace] = lot.status;
      }
    }
  }

  List<MapLotModel> _buildMappedLots(
    List<LotModel> filteredLots,
    bool isErhd,
    String currentPhaseLabel,
  ) {
    final activeAnns = _activeAnnotations;
    if (activeAnns.isNotEmpty) {
      final phaseNum = _selectedPhaseNumber ?? _activePhaseNumber;
      return filteredLots.map((l) {
        final ann = _findAnnotationForLot(l, activeAnns);
        final priceModel = isErhd
            ? null
            : _mvlcPrices
                .where((p) => p.phase == (l.phase ?? phaseNum))
                .firstOrNull;
        return MapLotModel.fromLotModelAndAnnotation(
          lot: l,
          priceModel: priceModel,
          phaseNumber: isErhd ? null : (l.phase ?? phaseNum),
          annotation: ann,
        );
      }).toList();
    }

    return MapLotModel.buildFromLiveLots(
      filteredLots,
      currentPhase: currentPhaseLabel,
    );
  }

  static PhaseLotAnnotation? _findAnnotationForLot(
    LotModel lot,
    List<PhaseLotAnnotation> annotations,
  ) {
    if (annotations.isEmpty) return null;
    final normLot =
        LotModel.normalizeLotNo(lot.lotNo).replaceAll(' ', '').toUpperCase();
    final cleanLot = lot.lotNo.replaceAll(' ', '').toUpperCase();
    final commLot = LotModel.extractCommercialLotNo(lot.lotNo);

    for (final a in annotations) {
      final aNorm =
          LotModel.normalizeLotNo(a.name).replaceAll(' ', '').toUpperCase();
      final aClean = a.name.replaceAll(' ', '').toUpperCase();
      final aComm = LotModel.extractCommercialLotNo(a.name);

      if (aNorm == normLot || aClean == cleanLot) return a;
      if (commLot != null && aComm == commLot) return a;
      if (aClean == 'C$cleanLot' || 'C$aClean' == cleanLot) return a;
      if (a.lotNumber == cleanLot ||
          a.lotNumber == cleanLot.replaceAll('L', '')) {
        if (a.blockNumber.isEmpty || a.blockNumber == normLot) {
          return a;
        }
      }
    }
    return null;
  }

  void _onMapUploadSelected(MapUploadModel upload) {
    setState(() {
      _activeMapUpload = upload;
      _selectedPhaseNumber = upload.phase ?? _extractPhaseNumber(upload);
      _activeAnnotatedImage = _matchAnnotatedImage(upload);
      _selectedAnnotation = null;
      _selectedAnnotationName = null;
      _isLoading = true;
      _mapReloadCounter++;
    });
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    _transformController.value = Matrix4.identity();
    _loadLiveLotsForSelectedMap();
  }

  Future<void> _loadLiveLotsForSelectedMap() async {
    try {
      final isErhd = _isErhdActive;
      final lotTable = isErhd ? 'erhd_lots' : 'mvlc_lots';
      final activeSection = _normalizedActiveMapSection;

      final projectKey =
          _selectedProject?.code ?? _selectedProject?.name ?? 'MVLC';
      final parsedProjectId = int.tryParse(_selectedProject?.id ?? '');

      final results = await Future.wait([
        SupabaseService.fetchLotsSummary(table: lotTable),
        SupabaseService.fetchLots(
          phase: isErhd ? null : (_activeMapUpload?.phase ?? _selectedPhaseNumber),
          mapSection: isErhd ? null : activeSection,
          limit: 2000,
          table: lotTable,
        ),
        SupabaseService.fetchMvlcPrices(),
        SupabaseService.fetchMapUploads(
          project: projectKey,
          projectId: parsedProjectId,
        ),
        SupabaseService.fetchAnnotatedImages(
          project: projectKey,
          forceRefresh: true,
        ),
      ]);

      if (!mounted) return;

      final summary = results[0] as Map<String, int>;
      final liveLots = results[1] as List<LotModel>;
      final mvlcPrices = results[2] as List<MvlcPriceModel>;
      final freshUploads = results[3] as List<MapUploadModel>;
      final freshAnnotatedImages = results[4] as List<AnnotatedImageModel>;

      if (freshUploads.isNotEmpty) {
        _sortUploads(freshUploads);
        final deduplicated = _deduplicateUploads(freshUploads);
        _projectUploads = deduplicated;

        final currentLabel = _activeMapUpload != null
            ? _getMapChipLabel(_activeMapUpload!)
            : null;
        final latestMatching = deduplicated.where((u) {
          if (_activeMapUpload != null && u.id == _activeMapUpload!.id) {
            return true;
          }
          if (currentLabel != null) {
            return _getMapChipLabel(u) == currentLabel;
          }
          return false;
        }).firstOrNull;

        _activeMapUpload = latestMatching ??
            (_activeMapUpload != null
                ? deduplicated
                    .where((u) => u.id == _activeMapUpload!.id)
                    .firstOrNull
                : null) ??
            deduplicated.firstOrNull;
      }

      _annotatedImages = freshAnnotatedImages;
      _activeAnnotatedImage = _matchAnnotatedImage(_activeMapUpload);

      final filteredLots = _filterLotsForActiveMap(liveLots);
      _populateLotsCache(filteredLots, mvlcPrices);
      final activeSummary = _computeSummaryForLots(filteredLots, summary);

      final currentPhaseLabel = _activeMapUpload != null
          ? _getMapChipLabel(_activeMapUpload!)
          : _selectedProjectName;

      final mappedLots =
          _buildMappedLots(filteredLots, isErhd, currentPhaseLabel);

      MapLotModel? selected;
      if (_selectedLot != null) {
        selected =
            mappedLots.where((l) => l.id == _selectedLot!.id).firstOrNull;
      } else if (widget.initialLotId != null) {
        selected = mappedLots
            .where((l) => l.id == widget.initialLotId)
            .firstOrNull;
      }

      setState(() {
        _liveSummary = activeSummary;
        _lots = mappedLots;
        _selectedLot = selected;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  int get _availCount =>
      _liveSummary['available'] ??
      _lots.where((l) => l.status == MapLotStatus.available).length;

  int get _resCount {
    final s =
        (_liveSummary['reserved'] ?? 0) + (_liveSummary['hold'] ?? 0);
    return s > 0
        ? s
        : _lots.where((l) => l.status == MapLotStatus.reserved).length;
  }

  int get _soldCount =>
      _liveSummary['sold'] ??
      _lots.where((l) => l.status == MapLotStatus.sold).length;

  int get _holdCount =>
      _liveSummary['hold'] ??
      _lots.where((l) => l.status == MapLotStatus.hold).length;

  void _onLotTapped(MapLotModel lot) {
    setState(() {
      _selectedLot = lot;
    });
  }

  void _onAnnotationTapped(PhaseLotAnnotation annotation) {
    final normName = LotModel.normalizeLotNo(annotation.name);
    final key = normName.trim().toUpperCase();
    final keyNoSpace = normName.replaceAll(' ', '').toUpperCase();
    final origKey = annotation.name.trim().toUpperCase();
    final origKeyNoSpace = annotation.name.replaceAll(' ', '').toUpperCase();

    // Commercial lot lookup key (e.g. "C L1" -> "L1")
    final commKey = LotModel.extractCommercialLotNo(annotation.name)?.toUpperCase();

    LotModel? dbLot = _lotsByAnnotationName[key] ??
        _lotsByAnnotationName[keyNoSpace] ??
        _lotsByAnnotationName[origKey] ??
        _lotsByAnnotationName[origKeyNoSpace] ??
        (commKey != null ? _lotsByAnnotationName[commKey] : null);

    final isErhd = _isErhdActive;
    final lotTable = isErhd ? 'erhd_lots' : 'mvlc_lots';
    final phaseNum = _selectedPhaseNumber ?? _activePhaseNumber ?? 2;
    MvlcPriceModel? priceModel = isErhd
        ? null
        : _mvlcPrices
            .where((p) => p.phase == (dbLot?.phase ?? phaseNum))
            .firstOrNull;

    setState(() {
      _selectedAnnotation = annotation;
      _selectedAnnotationName = annotation.name;

      if (dbLot != null) {
        _selectedLot = MapLotModel.fromLotModelAndAnnotation(
          lot: dbLot,
          priceModel: priceModel,
          phaseNumber: isErhd ? null : phaseNum,
          annotation: annotation,
        );
      }
    });

    // If dbLot was not found in the in-memory cache, query table directly by annotation name
    if (dbLot == null) {
      final activeSection = _normalizedActiveMapSection;
      SupabaseService.fetchLotByAnnotation(
        annotation.name,
        phase: isErhd ? null : phaseNum,
        mapSection: isErhd ? null : activeSection,
        table: lotTable,
      ).then((fetchedLot) {
        if (!mounted || fetchedLot == null) return;
        final fetchedNorm = LotModel.normalizeLotNo(fetchedLot.lotNo);
        final fKey = fetchedNorm.trim().toUpperCase();
        final fKeyNoSpace = fetchedNorm.replaceAll(' ', '').toUpperCase();
        _lotsByAnnotationName[fKey] = fetchedLot;
        _lotsByAnnotationName[fKeyNoSpace] = fetchedLot;
        _lotsByAnnotationName[origKey] = fetchedLot;
        _lotsByAnnotationName[origKeyNoSpace] = fetchedLot;
        _lotStatuses[fKey] = fetchedLot.status;
        _lotStatuses[fKeyNoSpace] = fetchedLot.status;
        _lotStatuses[origKey] = fetchedLot.status;
        _lotStatuses[origKeyNoSpace] = fetchedLot.status;

        final resolvedPhase = fetchedLot.phase ?? phaseNum;
        final pm = isErhd
            ? null
            : _mvlcPrices
                .where((p) => p.phase == resolvedPhase)
                .firstOrNull;

        if (_selectedAnnotationName == annotation.name) {
          setState(() {
            _selectedLot = MapLotModel.fromLotModelAndAnnotation(
              lot: fetchedLot,
              priceModel: pm,
              phaseNumber: isErhd ? null : resolvedPhase,
              annotation: annotation,
            );
          });
        }
      });
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.secondaryContainer,
              size: 18,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Selected: $normName • ${_selectedLot?.lotType ?? "Lot"} (${_selectedLot?.sizeSqm.toInt() ?? 0} sqm)',
                style: const TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 1800),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryContainer,
      ),
    );
  }

  /// Unselects the active lot/annotation when tapping on an unannotated part of the map
  void _onUnselectLot() {
    if (_selectedAnnotation != null ||
        _selectedAnnotationName != null ||
        _selectedLot != null) {
      setState(() {
        _selectedAnnotation = null;
        _selectedAnnotationName = null;
        _selectedLot = null;
      });
    }
  }

  void _animateTransform(Matrix4 targetMatrix) {
    _zoomAnimController.stop();
    final startMatrix = _transformController.value.clone();
    _zoomAnimation = Matrix4Tween(
      begin: startMatrix,
      end: targetMatrix,
    ).animate(CurvedAnimation(
      parent: _zoomAnimController,
      curve: Curves.easeOutCubic,
    ));

    _zoomAnimController.forward(from: 0.0).whenComplete(() {
      _targetScale = null;
    });
  }

  /// Zooms in or out anchored at the current viewport center so the user's
  /// current focal point stays in view instead of jumping to the blueprint center.
  void _zoomToCurrentCenter(double targetScale) {
    final vpSize = _lastViewportSize.width > 0 && _lastViewportSize.height > 0
        ? _lastViewportSize
        : MediaQuery.maybeSizeOf(context) ?? _currentCanvasSize;

    final currentMatrix = _transformController.value;
    final currentScale = currentMatrix.getMaxScaleOnAxis();
    final effectiveCurrentScale = currentScale > 0 ? currentScale : 1.0;
    final scaleRatio = targetScale / effectiveCurrentScale;

    final currentTranslation = currentMatrix.getTranslation();
    final currentTx = currentTranslation.x;
    final currentTy = currentTranslation.y;

    final focalX = vpSize.width / 2;
    final focalY = vpSize.height / 2;

    final tx = focalX - scaleRatio * (focalX - currentTx);
    final ty = focalY - scaleRatio * (focalY - currentTy);

    final targetMatrix = Matrix4.identity()
      ..setTranslationRaw(tx, ty, 0.0)
      ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

    _animateTransform(targetMatrix);
  }

  void _zoomIn() {
    final baseScale = (_zoomAnimController.isAnimating && _targetScale != null)
        ? _targetScale!
        : _transformController.value.getMaxScaleOnAxis();
    final targetScale = (baseScale * 1.4).clamp(0.5, 50.0);
    _targetScale = targetScale;
    _zoomToCurrentCenter(targetScale);
  }

  void _zoomOut() {
    final baseScale = (_zoomAnimController.isAnimating && _targetScale != null)
        ? _targetScale!
        : _transformController.value.getMaxScaleOnAxis();
    final targetScale = (baseScale / 1.4).clamp(0.5, 50.0);
    _targetScale = targetScale;
    _zoomToCurrentCenter(targetScale);
  }

  void _handleDoubleTap(Offset localPos) {
    _targetScale = null;
    final currentScale = _transformController.value.getMaxScaleOnAxis();
    if (currentScale > 1.8) {
      _animateTransform(Matrix4.identity());
    } else {
      const targetScale = 2.4;
      final canvasSize = _currentCanvasSize;
      final vpSize = _lastViewportSize.width > 0
          ? _lastViewportSize
          : MediaQuery.maybeSizeOf(context) ?? canvasSize;

      final childX = (vpSize.width - canvasSize.width) / 2 + localPos.dx;
      final childY = (vpSize.height - canvasSize.height) / 2 + localPos.dy;

      final tx = (vpSize.width / 2) - childX * targetScale;
      final ty = (vpSize.height / 2) - childY * targetScale;

      final targetMatrix = Matrix4.identity()
        ..setTranslationRaw(tx, ty, 0)
        ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

      _animateTransform(targetMatrix);
    }
  }

  void _centerOnAnnotation(PhaseLotAnnotation annotation) {
    _targetScale = null;
    const targetScale = 2.2;
    final canvasSize = _currentCanvasSize;
    final centroid = annotation.getCentroid(canvasSize);

    final vpSize = _lastViewportSize.width > 0
        ? _lastViewportSize
        : MediaQuery.maybeSizeOf(context) ?? canvasSize;

    final childX = (vpSize.width - canvasSize.width) / 2 + centroid.dx;
    final childY = (vpSize.height - canvasSize.height) / 2 + centroid.dy;

    final tx = (vpSize.width / 2) - childX * targetScale;
    final ty = (vpSize.height / 2) - childY * targetScale;

    final targetMatrix = Matrix4.identity()
      ..setTranslationRaw(tx, ty, 0)
      ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

    _animateTransform(targetMatrix);
  }

  void _centerOnLot(MapLotModel lot) {
    _targetScale = null;
    const targetScale = 2.2;
    final canvasSize = _currentCanvasSize;
    final lotCenterX = lot.bounds.center.dx;
    final lotCenterY = lot.bounds.center.dy;

    final vpSize = _lastViewportSize.width > 0
        ? _lastViewportSize
        : MediaQuery.maybeSizeOf(context) ?? canvasSize;

    final childX = (vpSize.width - canvasSize.width) / 2 + lotCenterX;
    final childY = (vpSize.height - canvasSize.height) / 2 + lotCenterY;

    final tx = (vpSize.width / 2) - childX * targetScale;
    final ty = (vpSize.height / 2) - childY * targetScale;

    final targetMatrix = Matrix4.identity()
      ..setTranslationRaw(tx, ty, 0)
      ..multiply(Matrix4.diagonal3Values(targetScale, targetScale, 1.0));

    _animateTransform(targetMatrix);
  }

  void _orientNorth() {
    _zoomAnimController.stop();
    _targetScale = null;
    _compassAnimController.forward(from: 0.0);
    _transformController.value = Matrix4.identity();
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Masterplan oriented North (0° Grid).'),
        duration: Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopAppBar(),

            // Scrollable Content / Fullscreen View
            Expanded(
              child: _isFullscreen
                  ? _buildFullscreenMap()
                  : ValueListenableBuilder<bool>(
                      valueListenable: _isMapInteracting,
                      builder: (context, isInteracting, child) {
                        return SingleChildScrollView(
                          physics: isInteracting
                              ? const NeverScrollableScrollPhysics()
                              : const ClampingScrollPhysics(),
                          child: child,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Control Suite
                          _buildTopControlSuite(),

                          // Interactive Map Canvas Container
                          _buildMapContainer(),

                          // Selected Lot Detail Bottom Sheet Preview
                          if (_selectedLot != null)
                            _buildLotDetailSheet(_selectedLot!),

                          // Extra padding for bottom navigation
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  /// Top Header Bar matching the VHBC design system with back button support
  Widget _buildTopAppBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              if (Navigator.canPop(context)) ...[
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 18,
                    color: AppColors.primaryContainer,
                  ),
                  tooltip: 'Back',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
                const SizedBox(width: 6),
              ],

              // BHRI Logo
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(3),
                child: ClipOval(
                  child: AppImage(
                    imageUrl: logoUrl,
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                    errorWidget: (context, error) => Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.landscape,
                        size: 16,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Title and Subtitle
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BHRI SALES PARTNER APP',
                      style: AppTextStyles.labelSm.copyWith(
                        color: AppColors.secondary,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Builder(
                      builder: (context) {
                        final user = AuthService.currentUser;
                        final name = (user != null && user.displayName.trim().isNotEmpty)
                            ? user.displayName.trim().split(' ').first
                            : 'Broker';
                        final hour = DateTime.now().hour;
                        final greeting = hour < 12
                            ? 'Good morning'
                            : hour < 17
                                ? 'Good afternoon'
                                : 'Good evening';
                        return Text(
                          '$greeting, $name',
                          style: AppTextStyles.titleMd.copyWith(
                            color: AppColors.primaryContainer,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Notifications Button with Badge
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('3 new lot reservation updates.'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.notifications_outlined,
                      size: 24,
                      color: AppColors.onSurfaceVariant,
                    ),
                    Positioned(
                      top: -2,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceContainerLowest,
                            width: 2,
                          ),
                        ),
                        child: const Text(
                          '3',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Avatar
              Builder(
                builder: (context) {
                  final user = AuthService.currentUser;
                  final avatarUrl = user?.avatarUrl;
                  return Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.secondaryContainer,
                        width: 1.5,
                      ),
                    ),
                    child: ClipOval(
                      child: (avatarUrl != null && avatarUrl.isNotEmpty)
                          ? CachedNetworkImage(
                              imageUrl: avatarUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => const Icon(
                                Icons.person,
                                size: 18,
                                color: AppColors.secondary,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 18,
                              color: AppColors.secondary,
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Top Control Suite: Project Selector, Orient North, Phase Chips, Search Bar
  Widget _buildTopControlSuite() {
    return Container(
      color: AppColors.surface.withValues(alpha: 0.95),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Project Selector & Compass Button
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: _showProjectDialog,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.landscape,
                          size: 20,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _isGlsActive
                                    ? 'SOON TO RISE • $_soonToRiseProjectCode'
                                    : (_selectedProject?.code != null
                                        ? 'MASTER PROJECT • ${_selectedProject!.code!.toUpperCase()}'
                                        : 'MASTER PROJECT'),
                                style: AppTextStyles.labelSm.copyWith(
                                  color: _isGlsActive ? const Color(0xFFD97706) : AppColors.secondary,
                                  fontSize: 8.5,
                                  letterSpacing: 0.6,
                                  height: 1.0,
                                  fontWeight: _isGlsActive ? FontWeight.w800 : FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      _selectedProject?.displayName ?? _selectedProjectName,
                                      style: AppTextStyles.titleMd.copyWith(
                                        color: AppColors.primaryContainer,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        height: 1.1,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (_isGlsActive) ...[
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF3C7),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: const Color(0xFFF59E0B), width: 0.8),
                                      ),
                                      child: const Text(
                                        'Soon to Rise',
                                        style: TextStyle(
                                          fontSize: 8.5,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFFB45309),
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.expand_more,
                          size: 20,
                          color: AppColors.outline,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Compass Orient North Button
              InkWell(
                onTap: _orientNorth,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: RotationTransition(
                    turns: _compassAnimController,
                    child: const Icon(
                      Icons.explore,
                      size: 20,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Download Map Button
              InkWell(
                onTap: _isDownloadingMap ? null : _downloadMapImage,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: _isDownloadingMap
                      ? const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.secondary,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.download_rounded,
                          size: 20,
                          color: AppColors.secondary,
                        ),
                ),
              ),
              const SizedBox(width: 8),
              // Reload Map from Supabase uploads table
              InkWell(
                onTap: () => _loadLiveMapData(),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.refresh,
                    size: 20,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          // Map Choice Chips (display all maps on that project)
          if (_isGlsActive) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFF59E0B)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, size: 14, color: Color(0xFFB45309)),
                  SizedBox(width: 6),
                  Text(
                    'Soon to Rise • Masterplan In Preparation',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB45309),
                    ),
                  ),
                ],
              ),
            ),
          ] else if (_projectUploads.isNotEmpty) ...[
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _projectUploads.map((upload) {
                  final isSelected = _activeMapUpload?.id == upload.id;
                  final chipLabel = _getMapChipLabel(upload);
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                      onTap: () => _onMapUploadSelected(upload),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryContainer
                              : AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: AppColors.primaryContainer
                                        .withValues(alpha: 0.2),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isSelected) ...[
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: AppColors.secondaryContainer,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              chipLabel,
                              style: AppTextStyles.labelMd.copyWith(
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.onSurfaceVariant,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          if (_isLoading) ...[
            const SizedBox(height: 6),
            const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              child: LinearProgressIndicator(
                minHeight: 2,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Interactive Map Canvas Container with Elevation chip, Tool dock, and Legend
  Widget _buildMapContainer() {
    return Container(
      height: _isPhase1Active ? 560 : 470,
      width: double.infinity,
      color: AppColors.surfaceContainerLow,
      child: Stack(
        children: [
          // Pinch-to-zoom / Pan interactive canvas or Soon to Rise placeholder
          if (_isGlsActive)
            Positioned.fill(
              child: _buildGlsSoonToRiseMapPlaceholder(),
            )
          else
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, viewportConstraints) {
                  final viewportSize = viewportConstraints.biggest;
                  _lastViewportSize = viewportSize;
                  return Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (_) {
                      if (_zoomAnimController.isAnimating) {
                        _zoomAnimController.stop();
                      }
                      _targetScale = null;
                      _mapActivePointers++;
                      _isMapInteracting.value = true;
                    },
                    onPointerUp: (_) {
                      _mapActivePointers = math.max(0, _mapActivePointers - 1);
                      if (_mapActivePointers == 0) {
                        _isMapInteracting.value = false;
                      }
                    },
                    onPointerCancel: (_) {
                      _mapActivePointers = math.max(0, _mapActivePointers - 1);
                      if (_mapActivePointers == 0) {
                        _isMapInteracting.value = false;
                      }
                    },
                    child: InteractiveViewer(
                      transformationController: _transformController,
                      minScale: 0.2,
                      maxScale: 50.0,
                      panAxis: PanAxis.free,
                      scaleEnabled: true,
                      panEnabled: true,
                      trackpadScrollCausesScale: true,
                      boundaryMargin: const EdgeInsets.all(1200),
                      clipBehavior: Clip.hardEdge,
                      onInteractionStart: (_) {
                        if (_zoomAnimController.isAnimating) {
                          _zoomAnimController.stop();
                        }
                        _targetScale = null;
                      },
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onDoubleTapDown: (details) =>
                              _handleDoubleTap(details.localPosition),
                          child: SalesMapCanvas(
                            key: ValueKey(
                                '${(_currentMapUpload ?? _activeMapUpload)?.image_URL}_$_mapReloadCounter'),
                            annotations: _activeAnnotations,
                            nativeImageSize: _activeNativeImageSize,
                            mapImageUrl:
                                (_currentMapUpload ?? _activeMapUpload)?.image_URL,
                            activePhase:
                                _isCommercialActive ? null : _activePhaseNumber,
                            isPhase1: _isPhase1Active,
                            isPhase2: _isPhase2Active,
                            isPhase3: _isPhase3Active,
                            isCommercial: _isCommercialActive,
                            isErhd: _isErhdActive,
                            isMscc: _isMsccActive,
                            selectedAnnotationId: _selectedAnnotation?.id,
                            selectedAnnotationName: _selectedAnnotationName,
                            onAnnotationTapped: _onAnnotationTapped,
                            onMapTapOutside: _onUnselectLot,
                            lotStatuses: _lotStatuses,
                            lots: _lots,
                            selectedLot: _selectedLot,
                            onLotTapped: _onLotTapped,
                            transformationController: _transformController,
                            viewportSize: viewportSize,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Elevation Indicator Chip (Top Left)
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isGlsActive
                        ? Icons.auto_awesome
                        : (_isMsccActive ? Icons.apartment : Icons.terrain),
                    size: 16,
                    color: _isGlsActive ? const Color(0xFFD97706) : AppColors.secondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _isGlsActive
                        ? 'Soon to Rise'
                        : (_activeMapUpload != null
                            ? _getMapChipLabel(_activeMapUpload!)
                            : (_isMsccActive ? '2nd Floor' : 'Phase 2')),
                    style: AppTextStyles.labelSm.copyWith(
                      color: _isGlsActive ? const Color(0xFFB45309) : AppColors.onSurface,
                      letterSpacing: 0.4,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Floating Tool Dock (Top Right)
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _toolBtn(icon: Icons.add, tooltip: 'Zoom In', onTap: _zoomIn),
                  _toolDivider(),
                  _toolBtn(icon: Icons.remove, tooltip: 'Zoom Out', onTap: _zoomOut),
                  _toolDivider(),
                  _toolBtn(
                    icon: Icons.download_rounded,
                    tooltip: 'Download Map',
                    isLoading: _isDownloadingMap,
                    onTap: _isDownloadingMap ? null : _downloadMapImage,
                  ),
                  _toolDivider(),
                  _toolBtn(
                    icon: Icons.refresh,
                    tooltip: 'Reload Map',
                    onTap: () => _loadLiveMapData(),
                  ),
                  _toolDivider(),
                  _toolBtn(
                    icon: _isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    tooltip: 'Toggle Fullscreen',
                    onTap: () {
                      setState(() {
                        _isFullscreen = !_isFullscreen;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // Persistent Bottom-Docked Map Legend Pill
          Positioned(
            bottom: 12,
            left: 16,
            right: 16,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest.withValues(alpha: 0.96),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_isGlsActive) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.auto_awesome, size: 13, color: Color(0xFFB45309)),
                              const SizedBox(width: 5),
                              Text(
                                '$_soonToRiseProjectCode • Soon to Rise Masterplan',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFFB45309),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        _legendItem(
                          color: AppColors.primaryFixedDim,
                          label: 'Avail ($_availCount)',
                        ),
                        _legendDivider(),
                        _legendItem(
                          color: AppColors.secondaryContainer,
                          label: 'Res ($_resCount)',
                        ),
                        _legendDivider(),
                        _legendItem(
                          color: AppColors.errorContainer,
                          label: 'Sold ($_soldCount)',
                        ),
                        _legendDivider(),
                        _legendItem(
                          color: AppColors.tertiaryFixedDim,
                          label: 'Hold ($_holdCount)',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Fullscreen Map Layout
  Widget _buildFullscreenMap() {
    return Stack(
      children: [
        Positioned.fill(
          child: _isGlsActive
              ? _buildGlsSoonToRiseMapPlaceholder()
              : LayoutBuilder(
                  builder: (context, viewportConstraints) {
                    final viewportSize = viewportConstraints.biggest;
                    _lastViewportSize = viewportSize;
                    return InteractiveViewer(
                      transformationController: _transformController,
                      minScale: 0.2,
                      maxScale: 50.0,
                      panAxis: PanAxis.free,
                      scaleEnabled: true,
                      panEnabled: true,
                      trackpadScrollCausesScale: true,
                      boundaryMargin: const EdgeInsets.all(1200),
                      clipBehavior: Clip.hardEdge,
                      onInteractionStart: (_) {
                        if (_zoomAnimController.isAnimating) {
                          _zoomAnimController.stop();
                        }
                        _targetScale = null;
                      },
                      child: Center(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onDoubleTapDown: (details) =>
                              _handleDoubleTap(details.localPosition),
                          child: SalesMapCanvas(
                            key: ValueKey(
                                '${(_currentMapUpload ?? _activeMapUpload)?.image_URL}_$_mapReloadCounter'),
                            annotations: _activeAnnotations,
                            nativeImageSize: _activeNativeImageSize,
                            mapImageUrl:
                                (_currentMapUpload ?? _activeMapUpload)?.image_URL,
                            activePhase:
                                _isCommercialActive ? null : _activePhaseNumber,
                            isPhase1: _isPhase1Active,
                            isPhase2: _isPhase2Active,
                            isPhase3: _isPhase3Active,
                            isCommercial: _isCommercialActive,
                            isErhd: _isErhdActive,
                            isMscc: _isMsccActive,
                            selectedAnnotationId: _selectedAnnotation?.id,
                            selectedAnnotationName: _selectedAnnotationName,
                            onAnnotationTapped: _onAnnotationTapped,
                            onMapTapOutside: _onUnselectLot,
                            lotStatuses: _lotStatuses,
                            lots: _lots,
                            selectedLot: _selectedLot,
                            onLotTapped: _onLotTapped,
                            transformationController: _transformController,
                            viewportSize: viewportSize,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),

        // Floating Back / Exit Fullscreen Button
        Positioned(
          left: 16,
          top: 16,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () => setState(() => _isFullscreen = false),
              icon: const Icon(Icons.fullscreen_exit, color: AppColors.primaryContainer),
              tooltip: 'Exit Fullscreen',
            ),
          ),
        ),

        // Floating Tool Dock on Right
        Positioned(
          right: 16,
          top: 16,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest.withValues(alpha: 0.94),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _toolBtn(icon: Icons.add, tooltip: 'Zoom In', onTap: _zoomIn),
                _toolDivider(),
                _toolBtn(icon: Icons.remove, tooltip: 'Zoom Out', onTap: _zoomOut),
                _toolDivider(),
                _toolBtn(
                  icon: Icons.download_rounded,
                  tooltip: 'Download Map',
                  isLoading: _isDownloadingMap,
                  onTap: _isDownloadingMap ? null : _downloadMapImage,
                ),
                _toolDivider(),
                _toolBtn(
                  icon: Icons.refresh,
                  tooltip: 'Reload Map',
                  onTap: () => _loadLiveMapData(),
                ),
              ],
            ),
          ),
        ),

        // Selected Lot Mini Pill at Bottom in Fullscreen
        if (_selectedLot != null)
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: InkWell(
              onTap: () => setState(() => _isFullscreen = false),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedLot!.blockLotText,
                            style: AppTextStyles.titleMd.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                          Text(
                            '${_selectedLot!.sizeSqm.toInt()} sqm • ${_selectedLot!.formattedTcp}',
                            style: AppTextStyles.bodySm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ComputationPage(
                              lot: _selectedLot!,
                              initialSchemeCode: 'CASH_100',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('Compute'),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildGlsSoonToRiseMapPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surfaceContainerLow,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.surfaceContainerLowest,
            AppColors.surfaceContainerLow,
            AppColors.surfaceContainer,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF59E0B)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, size: 14, color: Color(0xFFB45309)),
                      SizedBox(width: 6),
                      Text(
                        'SOON TO RISE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                          color: Color(0xFFB45309),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.map_outlined,
                    size: 32,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _soonToRiseProjectTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.headlineSm.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Interactive Subdivision Map In Preparation',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMd.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Official high-resolution blueprint uploads and coordinate lot markers for $_soonToRiseProjectTitle are being finalized. Pre-launch priority registration is now available.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final mvlc = _projects.where((p) =>
                              p.code?.toUpperCase() == 'MVLC' ||
                              p.displayName.toUpperCase().contains('MVLC')).firstOrNull;
                          if (mvlc != null) {
                            setState(() {
                              _selectedProject = mvlc;
                              _selectedProjectName = mvlc.displayName;
                              _selectedPhaseNumber = null;
                              _activeMapUpload = null;
                              _projectUploads = [];
                            });
                            _loadLiveMapData();
                          }
                        },
                        icon: const Icon(Icons.explore, size: 16),
                        label: const Text('View MVLC Map'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryContainer,
                          foregroundColor: AppColors.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
        ),
      ),
    );
  }

  /// Selected Lot Detail Bottom Sheet Preview
  Widget _buildLotDetailSheet(MapLotModel lot) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F3E2E).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle Indicator
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Header Row: Title + Status Pill
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _selectedAnnotationName != null
                                ? (_selectedAnnotationName == lot.shortLotCode ||
                                        _selectedAnnotationName!.replaceAll(' ', '').toUpperCase() ==
                                            lot.shortLotCode.replaceAll(' ', '').toUpperCase()
                                    ? _selectedAnnotationName!
                                    : '$_selectedAnnotationName (${lot.shortLotCode})')
                                : lot.blockLotText,
                            style: AppTextStyles.headlineMd.copyWith(
                              color: AppColors.primaryContainer,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (lot.hasStar) ...[
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: AppColors.secondary,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lot.phase,
                      style: AppTextStyles.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_selectedAnnotation != null) {
                    _centerOnAnnotation(_selectedAnnotation!);
                  } else {
                    _centerOnLot(lot);
                  }
                },
                icon: const Icon(Icons.zoom_in, size: 24, color: AppColors.secondary),
                tooltip: 'Zoom to Lot',
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                padding: EdgeInsets.zero,
              ),
              const SizedBox(width: 4),
              _buildStatusPill(lot),
              const SizedBox(width: 4),
              IconButton(
                onPressed: _onUnselectLot,
                icon: const Icon(Icons.close, size: 20, color: AppColors.outline),
                tooltip: 'Close',
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Specifications Bento Strip (3 cards)
          Row(
            children: [
              Expanded(
                child: _bentoCard(
                  label: 'LOT AREA',
                  value: '${lot.sizeSqm.toInt()}',
                  unit: 'sqm',
                  valueColor: AppColors.primaryContainer,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _bentoCard(
                  label: 'LOT TYPE',
                  value: lot.lotType,
                  unit: '',
                  valueColor: AppColors.primaryContainer,
                  isTruncated: true,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _bentoCard(
                  label: 'PRICE/SQM',
                  value: lot.formattedPricePerSqm,
                  unit: '',
                  valueColor: AppColors.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Pricing Summary Card (Tappable for Quick Amortization)
          Material(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            child: InkWell(
              onTap: () => QuickAmortizationModal.show(context, lot: lot),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TOTAL CONTRACT PRICE (TCP)',
                                style: AppTextStyles.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 9.5,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 6,
                                children: [
                                  Text(
                                    lot.formattedTcp,
                                    style: AppTextStyles.priceDisplay.copyWith(
                                      color: AppColors.primaryContainer,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    'VAT Inclusive',
                                    style: AppTextStyles.labelSm.copyWith(
                                      color: AppColors.outline,
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'RESERVATION FEE',
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.outline,
                                fontSize: 9,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              lot.formattedReservationFee,
                              style: AppTextStyles.labelLg.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.bolt, size: 14, color: AppColors.secondary),
                              const SizedBox(width: 4),
                              Text(
                                '60-Mo @ 0%: ${lot.formattedMonthly60Mo}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryContainer,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Quick Amort',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const Icon(Icons.chevron_right, size: 14, color: AppColors.secondary),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Quick Photo Snapshot Preview Card
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: lot.imageUrl.startsWith('asset')
                      ? Image.asset(
                          lot.imageUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 56,
                            height: 56,
                            color: AppColors.surfaceContainerHigh,
                            child: const Icon(
                              Icons.landscape,
                              color: AppColors.secondary,
                            ),
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: lot.imageUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Container(
                            width: 56,
                            height: 56,
                            color: AppColors.surfaceContainerHigh,
                            child: const Icon(
                              Icons.landscape,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.visibility,
                            size: 14,
                            color: AppColors.secondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lot.viewOrientation.toUpperCase(),
                              style: AppTextStyles.labelSm.copyWith(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.w800,
                                fontSize: 9.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        lot.description,
                        style: AppTextStyles.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 11,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.primaryContainer,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Action Buttons Row: Compute (5) + Instant Reserve (7)
          Row(
            children: [
              // Compute Button
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ComputationPage(
                          lot: lot,
                          initialSchemeCode: 'CASH_100',
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.calculate, size: 16),
                    label: const Text('Compute'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainer,
                      foregroundColor: AppColors.secondary,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Instant Reserve Primary CTA
              Expanded(
                flex: 7,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () => ContactService.callSalesDesk(
                      context: context,
                      title: 'Instant Lot Reservation',
                      subtitle: 'Direct line to lock reservation hold',
                      lotInfo: '${lot.blockLotText} • ${lot.formattedTcp}',
                    ),
                    icon: const Icon(Icons.lock, size: 18),
                    label: const Text(
                      'Instant Reserve',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: AppColors.onPrimary,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(MapLotModel lot) {
    Color bg;
    Color fg;
    String label;
    bool pulse = false;

    switch (lot.status) {
      case MapLotStatus.available:
        bg = AppColors.primaryFixed;
        fg = AppColors.primary;
        label = 'AVAILABLE';
        pulse = true;
        break;
      case MapLotStatus.reserved:
        bg = AppColors.secondaryContainer;
        fg = AppColors.onSecondaryContainer;
        label = 'RESERVED';
        break;
      case MapLotStatus.sold:
        bg = AppColors.errorContainer;
        fg = AppColors.onErrorContainer;
        label = 'SOLD';
        break;
      case MapLotStatus.hold:
        bg = AppColors.tertiaryFixedDim;
        fg = AppColors.tertiary;
        label = 'HOLD';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (pulse) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: fg,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: AppTextStyles.labelSm.copyWith(
              color: fg,
              fontWeight: FontWeight.w800,
              fontSize: 9.5,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bentoCard({
    required String label,
    required String value,
    required String unit,
    required Color valueColor,
    bool isTruncated = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.outline,
              fontSize: 8.5,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: AppTextStyles.titleMd.copyWith(
                    color: valueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  overflow:
                      isTruncated ? TextOverflow.ellipsis : TextOverflow.clip,
                  maxLines: 1,
                ),
              ),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 3),
                Text(
                  unit,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _toolBtn({
    required IconData icon,
    required String tooltip,
    VoidCallback? onTap,
    bool isLoading = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Tooltip(
        message: tooltip,
        child: Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryContainer,
                  ),
                )
              : Icon(
                  icon,
                  size: 19,
                  color: onTap != null
                      ? AppColors.primaryContainer
                      : AppColors.outline,
                ),
        ),
      ),
    );
  }

  Widget _toolDivider() {
    return Container(
      width: 20,
      height: 1,
      color: AppColors.surfaceContainerHigh,
      margin: const EdgeInsets.symmetric(vertical: 2),
    );
  }

  Widget _legendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTextStyles.labelSm.copyWith(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _legendDivider() {
    return Container(
      width: 1,
      height: 12,
      color: AppColors.surfaceContainerHigh,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  void _showProjectDialog() async {
    List<ProjectModel> availableProjects = _projects;
    if (availableProjects.isEmpty) {
      availableProjects = await SupabaseService.fetchProjects();
      if (mounted) {
        setState(() {
          _projects = availableProjects;
        });
      }
    }

    if (!mounted) return;

    ProjectSelectionSheet.show(
      context: context,
      projects: availableProjects,
      selectedProjectId: _selectedProject?.displayName ??
          _selectedProject?.code ??
          _selectedProjectName,
      onProjectSelected: (project) {
        if (project != null) {
          setState(() {
            _selectedProject = project;
            _selectedProjectName = project.displayName;
            _selectedPhaseNumber = null;
            _activeMapUpload = null;
            _projectUploads = [];
          });
          _loadLiveMapData();
        }
      },
    );
  }

}
