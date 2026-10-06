import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../core/theme/app_colors.dart';
import '../models/youtube_link_model.dart';
import '../services/video_stream_service.dart';

class InAppVideoPlayerScreen extends StatefulWidget {
  final YoutubeLinkModel video;

  const InAppVideoPlayerScreen({
    super.key,
    required this.video,
  });

  @override
  State<InAppVideoPlayerScreen> createState() => _InAppVideoPlayerScreenState();
}

class _InAppVideoPlayerScreenState extends State<InAppVideoPlayerScreen> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  String? _errorMessage;
  bool _isChannelError = false;
  bool _showControls = true;
  bool _isMuted = false;
  bool _isFullscreen = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _isChannelError = false;
    });

    try {
      final directStreamUrl = await VideoStreamService.getDirectStreamUrl(
        widget.video.link,
      );

      if (directStreamUrl == null || directStreamUrl.isEmpty) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Unable to resolve video stream. Please check your network connection.';
          });
        }
        return;
      }

      final controller = VideoPlayerController.networkUrl(
        Uri.parse(directStreamUrl),
      );

      await controller.initialize();
      controller.addListener(_videoListener);

      if (mounted) {
        setState(() {
          _controller = controller;
          _isLoading = false;
        });
        controller.play();
        _startHideControlsTimer();
      }
    } on PlatformException catch (pe) {
      if (mounted) {
        final errText = pe.toString();
        final isChannel = pe.code == 'channel-error' ||
            errText.contains('channel-error') ||
            errText.contains('Unable to establish connection');
        setState(() {
          _isLoading = false;
          _isChannelError = isChannel;
          _errorMessage = isChannel
              ? 'New native video plugin installed.\n\nPlease stop and restart "flutter run" in your terminal so Xcode/Flutter can compile the native video player plugin.'
              : 'Error loading walkthrough video: ${pe.message ?? pe.toString()}';
        });
      }
    } catch (e) {
      if (mounted) {
        final errText = e.toString();
        final isChannel = errText.contains('channel-error') ||
            errText.contains('createForTextureView') ||
            errText.contains('Unable to establish connection');
        setState(() {
          _isLoading = false;
          _isChannelError = isChannel;
          _errorMessage = isChannel
              ? 'New native video plugin installed.\n\nPlease stop and restart "flutter run" in your terminal so Xcode/Flutter can compile the native video player plugin.'
              : 'Error loading walkthrough video: $e';
        });
      }
    }
  }

  Future<void> _launchExternalFallback() async {
    final uri = Uri.tryParse(widget.video.link.trim());
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && (_controller?.value.isPlaying ?? false)) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _togglePlayPause() {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
        _showControls = true;
        _hideControlsTimer?.cancel();
      } else {
        _controller!.play();
        _startHideControlsTimer();
      }
    });
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _toggleFullscreen([bool? enterFullscreen]) {
    final target = enterFullscreen ?? !_isFullscreen;
    setState(() {
      _isFullscreen = target;
    });

    if (_isFullscreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    _startHideControlsTimer();
  }

  void _seekRelative(int seconds) {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final current = _controller!.value.position;
    final target = current + Duration(seconds: seconds);
    final clamped = target < Duration.zero
        ? Duration.zero
        : target > _controller!.value.duration
            ? _controller!.value.duration
            : target;
    _controller!.seekTo(clamped);
    _startHideControlsTimer();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    if (duration.inHours > 0) {
      final hours = duration.inHours.toString();
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final isInitialized = controller != null && controller.value.isInitialized;
    final orientation = MediaQuery.of(context).orientation;
    final isFullscreenOrLandscape = _isFullscreen || orientation == Orientation.landscape;

    return PopScope(
      canPop: !isFullscreenOrLandscape,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isFullscreenOrLandscape) {
          _toggleFullscreen(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: isFullscreenOrLandscape
            ? null
            : AppBar(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  widget.video.projectName,
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                      color: Colors.white,
                    ),
                    tooltip: _isMuted ? 'Unmute' : 'Mute',
                    onPressed: isInitialized ? _toggleMute : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 26),
                    tooltip: 'Fullscreen',
                    onPressed: isInitialized ? () => _toggleFullscreen(true) : null,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
        body: SafeArea(
          top: !isFullscreenOrLandscape,
          bottom: !isFullscreenOrLandscape,
          left: false,
          right: false,
          child: Column(
            children: [
              // Video Player Container
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _showControls = !_showControls;
                    });
                    if (_showControls) {
                      _startHideControlsTimer();
                    }
                  },
                  onDoubleTap: isInitialized ? () => _toggleFullscreen() : null,
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Video Render Surface
                        if (isInitialized)
                          Center(
                            child: AspectRatio(
                              aspectRatio: controller.value.aspectRatio,
                              child: VideoPlayer(controller),
                            ),
                          )
                        else if (_isLoading)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.primaryFixedDim,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                'Loading project walkthrough...',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        else if (_errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isChannelError
                                      ? Icons.published_with_changes_rounded
                                      : Icons.error_outline_rounded,
                                  color: _isChannelError
                                      ? AppColors.primaryFixedDim
                                      : AppColors.error,
                                  size: 52,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  _isChannelError
                                      ? 'Native Player Engine Ready'
                                      : 'Error Loading Video',
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white70,
                                    fontSize: 12.5,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _initializePlayer,
                                      icon: const Icon(Icons.refresh_rounded, size: 18),
                                      label: const Text('Retry'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primaryContainer,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 10,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    if (_isChannelError) ...[
                                      const SizedBox(width: 12),
                                      OutlinedButton.icon(
                                        onPressed: _launchExternalFallback,
                                        icon: const Icon(Icons.open_in_browser_rounded, size: 18),
                                        label: const Text('Open External'),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: AppColors.primaryFixedDim,
                                          side: const BorderSide(
                                            color: AppColors.primaryFixedDim,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),

                        // Overlay Controls
                        if (isInitialized && _showControls)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Top Bar in Fullscreen / Landscape
                                  if (isFullscreenOrLandscape)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.arrow_back_ios_new_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            onPressed: () => _toggleFullscreen(false),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              '${widget.video.projectName} • ${widget.video.title}',
                                              style: GoogleFonts.manrope(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              _isMuted
                                                  ? Icons.volume_off_rounded
                                                  : Icons.volume_up_rounded,
                                              color: Colors.white,
                                            ),
                                            tooltip: _isMuted ? 'Unmute' : 'Mute',
                                            onPressed: _toggleMute,
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.fullscreen_exit_rounded,
                                              color: Colors.white,
                                              size: 26,
                                            ),
                                            tooltip: 'Exit Fullscreen',
                                            onPressed: () => _toggleFullscreen(false),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    const SizedBox(height: 20),

                                  // Center Playback Controls (10s back, Play/Pause, 10s forward)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        iconSize: isFullscreenOrLandscape ? 44 : 38,
                                        icon: const Icon(
                                          Icons.replay_10_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => _seekRelative(-10),
                                      ),
                                      SizedBox(width: isFullscreenOrLandscape ? 32 : 24),
                                      GestureDetector(
                                        onTap: _togglePlayPause,
                                        child: Container(
                                          width: isFullscreenOrLandscape ? 72 : 64,
                                          height: isFullscreenOrLandscape ? 72 : 64,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryContainer,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppColors.primaryFixedDim,
                                              width: 2,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withValues(alpha: 0.5),
                                                blurRadius: 16,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            controller.value.isPlaying
                                                ? Icons.pause_rounded
                                                : Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: isFullscreenOrLandscape ? 44 : 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: isFullscreenOrLandscape ? 32 : 24),
                                      IconButton(
                                        iconSize: isFullscreenOrLandscape ? 44 : 38,
                                        icon: const Icon(
                                          Icons.forward_10_rounded,
                                          color: Colors.white,
                                        ),
                                        onPressed: () => _seekRelative(10),
                                      ),
                                    ],
                                  ),

                                  // Bottom Scrub Bar, Timers, and Fullscreen Button
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isFullscreenOrLandscape ? 24 : 16,
                                      vertical: isFullscreenOrLandscape ? 12 : 8,
                                    ),
                                    child: Column(
                                      children: [
                                        // Progress Slider
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            thumbColor: AppColors.primaryFixedDim,
                                            activeTrackColor: AppColors.primaryFixedDim,
                                            inactiveTrackColor: Colors.white24,
                                            trackHeight: 3.5,
                                            thumbShape: const RoundSliderThumbShape(
                                              enabledThumbRadius: 6.5,
                                            ),
                                            overlayShape: const RoundSliderOverlayShape(
                                              overlayRadius: 14,
                                            ),
                                          ),
                                          child: Slider(
                                            value: controller.value.position.inMilliseconds
                                                .toDouble()
                                                .clamp(
                                                  0.0,
                                                  controller.value.duration.inMilliseconds
                                                      .toDouble(),
                                                ),
                                            max: controller.value.duration.inMilliseconds
                                                .toDouble(),
                                            onChanged: (val) {
                                              controller.seekTo(
                                                Duration(milliseconds: val.toInt()),
                                              );
                                              _startHideControlsTimer();
                                            },
                                          ),
                                        ),

                                        // Time Display & Fullscreen Toggle
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12),
                                          child: Row(
                                            children: [
                                              Text(
                                                _formatDuration(
                                                  controller.value.position,
                                                ),
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '/',
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: Colors.white38,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                _formatDuration(
                                                  controller.value.duration,
                                                ),
                                                style: GoogleFonts.plusJakartaSans(
                                                  color: Colors.white70,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Spacer(),
                                              // Fullscreen toggle button
                                              IconButton(
                                                icon: Icon(
                                                  isFullscreenOrLandscape
                                                      ? Icons.fullscreen_exit_rounded
                                                      : Icons.fullscreen_rounded,
                                                  color: Colors.white,
                                                  size: 26,
                                                ),
                                                tooltip: isFullscreenOrLandscape
                                                    ? 'Exit Fullscreen'
                                                    : 'Fullscreen',
                                                onPressed: () => _toggleFullscreen(
                                                  !isFullscreenOrLandscape,
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
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              // Video Details Section Below Player (portrait mode only)
              if (!isFullscreenOrLandscape)
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F1E17),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primaryFixedDim.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              widget.video.projectName,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryFixedDim,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'VHBC Media Walkthrough',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.video.title,
                        style: GoogleFonts.manrope(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Exclusive broker walkthrough presentation. Double-tap video or tap the fullscreen button to view in theater landscape mode.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: Colors.white60,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
