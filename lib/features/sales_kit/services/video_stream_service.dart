import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Service that resolves clean, direct MP4 video streams from links
/// so videos can be played natively inside the app without any third-party branding.
class VideoStreamService {
  VideoStreamService._();

  static final Map<String, String> _streamCache = {};
  static YoutubeExplode? _ytExplode;

  static YoutubeExplode get _yt => _ytExplode ??= YoutubeExplode();

  /// Mock setter for unit and widget testing
  @visibleForTesting
  static void setMockStream(String videoIdOrUrl, String directMp4Url) {
    _streamCache[videoIdOrUrl] = directMp4Url;
  }

  /// Extracts the direct MP4 streaming URL from a video link or video ID.
  static Future<String?> getDirectStreamUrl(String linkOrId) async {
    final trimmed = linkOrId.trim();
    if (trimmed.isEmpty) return null;

    if (_streamCache.containsKey(trimmed)) {
      return _streamCache[trimmed];
    }

    // Extract ID if full URL was passed
    String videoId = trimmed;
    final uri = Uri.tryParse(trimmed);
    if (uri != null) {
      if (uri.host.contains('youtu.be') && uri.pathSegments.isNotEmpty) {
        videoId = uri.pathSegments.first;
      } else if (uri.queryParameters.containsKey('v')) {
        videoId = uri.queryParameters['v']!;
      }
    }

    try {
      StreamManifest? manifest;
      try {
        manifest = await _yt.videos.streamsClient.getManifest(
          videoId,
          ytClients: [YoutubeApiClient.android],
        );
      } catch (_) {
        manifest = await _yt.videos.streamsClient.getManifest(
          videoId,
          ytClients: [YoutubeApiClient.tv, YoutubeApiClient.mweb],
        );
      }

      // Prefer highest bitrate muxed mp4 stream
      final muxedStream = manifest.muxed.withHighestBitrate();
      final streamUrl = muxedStream.url.toString();

      _streamCache[trimmed] = streamUrl;
      _streamCache[videoId] = streamUrl;
      return streamUrl;
    } catch (e, stack) {
      developer.log('Error resolving direct stream URL for $videoId: $e',
          name: 'VideoStreamService', error: e, stackTrace: stack);
      return null;
    }
  }

  /// Clean up resources
  static void dispose() {
    _ytExplode?.close();
    _ytExplode = null;
  }
}
