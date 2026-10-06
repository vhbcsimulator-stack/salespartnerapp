import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../models/development_photo_model.dart';

/// Full-screen high-resolution photo viewer with pinch-to-zoom, pan, and direct image download.
class SalesKitPhotoViewerDialog extends StatefulWidget {
  final DevelopmentPhotoModel photo;

  const SalesKitPhotoViewerDialog({
    super.key,
    required this.photo,
  });

  static Future<void> show(BuildContext context, DevelopmentPhotoModel photo) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.95),
      builder: (context) => SalesKitPhotoViewerDialog(photo: photo),
    );
  }

  @override
  State<SalesKitPhotoViewerDialog> createState() => _SalesKitPhotoViewerDialogState();
}

class _SalesKitPhotoViewerDialogState extends State<SalesKitPhotoViewerDialog> {
  bool _isDownloading = false;

  Color _getProjectBadgeColor(String project) {
    final p = project.toUpperCase();
    if (p.contains('MVLC')) return const Color(0xFF0F3E2E);
    if (p.contains('ERHD')) return const Color(0xFF77591C);
    if (p.contains('MSCC')) return const Color(0xFF1E3A8A);
    if (p.contains('GLS') ||
        p.contains('LCN') ||
        p.contains('MCVC') ||
        p.contains('RHM') ||
        p.contains('RHN')) {
      return const Color(0xFFB45309);
    }
    if (p.contains('EBLF')) return const Color(0xFF991B1B);
    return const Color(0xFF414944);
  }

  /// Resolves the downloads directory across Android, iOS, and Desktop platforms.
  static Directory _getDownloadsDirectory() {
    if (Platform.isAndroid) {
      final androidDownload = Directory('/storage/emulated/0/Download');
      if (androidDownload.existsSync()) return androidDownload;
      try {
        androidDownload.createSync(recursive: true);
        return androidDownload;
      } catch (_) {}
    }

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

    if (Platform.isIOS) {
      final home = Platform.environment['HOME'];
      if (home != null) {
        final iosDownloads = Directory('$home/Documents/Downloads');
        if (!iosDownloads.existsSync()) {
          try {
            iosDownloads.createSync(recursive: true);
          } catch (_) {}
        }
        if (iosDownloads.existsSync()) return iosDownloads;
      }
    }

    return Directory.systemTemp;
  }

  Future<File?> _saveDownloadedFile({
    required List<int> bytes,
    required String filename,
  }) async {
    File? localFile;
    bool platformSaved = false;

    // 1. Native platform channel first (Android MediaStore + iOS Photos Album)
    try {
      const channel = MethodChannel('com.vhbc.broker/gallery');
      final result = await channel.invokeMethod('saveImageToGallery', {
        'bytes': bytes,
        'filename': filename,
      });
      if (result != null && result != false) {
        platformSaved = true;
      }
    } catch (e) {
      debugPrint('[PhotoViewer] Native gallery channel error: $e');
    }

    // 2. Direct filesystem save to public Downloads directory
    try {
      final targetDir = _getDownloadsDirectory();
      final file = File('${targetDir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      localFile = file;
    } catch (e) {
      debugPrint('[PhotoViewer] Direct filesystem write error: $e');
    }

    // 3. Desktop ~/Downloads
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

    // 4. iOS Simulator convenience
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

  Future<void> _downloadPhoto() async {
    if (_isDownloading) return;

    setState(() {
      _isDownloading = true;
    });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Downloading photo...',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 2000),
      ),
    );

    try {
      final uri = Uri.parse(widget.photo.imageLink);
      final response = await http.get(uri).timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 || response.bodyBytes.isEmpty) {
        throw Exception('Server returned HTTP ${response.statusCode}');
      }

      String ext = '.jpg';
      final pathLower = uri.path.toLowerCase();
      if (pathLower.endsWith('.png')) {
        ext = '.png';
      } else if (pathLower.endsWith('.webp')) {
        ext = '.webp';
      } else if (pathLower.endsWith('.jpeg')) {
        ext = '.jpeg';
      }

      final project = widget.photo.normalizedProjectName.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
      final typeName = widget.photo.isActual ? 'actual' : 'perspective';
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filename = 'VHBC_${project}_${typeName}_$timestamp$ext';

      final savedFile = await _saveDownloadedFile(
        bytes: response.bodyBytes,
        filename: filename,
      );

      if (savedFile == null) {
        // Fallback: try opening/downloading in external browser
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF34D399),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Photo saved to Downloads & Photos Gallery',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.primaryContainer,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to download photo: $e',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final photo = widget.photo;
    final projectColor = _getProjectBadgeColor(photo.projectName);
    final isActual = photo.isActual;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Interactive Zoomable Image
          Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: CachedNetworkImage(
                imageUrl: photo.imageLink,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white70,
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white54,
                        size: 48,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Unable to load high-res image',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Top Header Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Project Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: projectColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        photo.normalizedProjectName,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Type Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isActual
                            ? const Color(0xFF059669).withValues(alpha: 0.25)
                            : const Color(0xFF7C3AED).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isActual
                              ? const Color(0xFF10B981)
                              : const Color(0xFFA855F7),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isActual
                                ? Icons.photo_camera_rounded
                                : Icons.architecture_rounded,
                            size: 13,
                            color: isActual
                                ? const Color(0xFF34D399)
                                : const Color(0xFFC084FC),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isActual ? 'Actual Site Photo' : 'Future Perspective',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Close Button
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white, size: 26),
                      tooltip: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.85),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    // Upload Date Info
                    if (photo.createdAt != null)
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 13,
                            color: Colors.white70,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${photo.createdAt!.year}-${photo.createdAt!.month.toString().padLeft(2, '0')}-${photo.createdAt!.day.toString().padLeft(2, '0')}',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    const Spacer(),

                    // Download Photo Button
                    ElevatedButton.icon(
                      onPressed: _isDownloading ? null : _downloadPhoto,
                      icon: _isDownloading
                          ? const SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.download_rounded, size: 16, color: Colors.white),
                      label: Text(
                        _isDownloading ? 'Downloading...' : 'Download',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: AppColors.primaryContainer.withValues(alpha: 0.6),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
