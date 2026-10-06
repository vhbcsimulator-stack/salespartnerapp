import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

/// Universal image widget for VHBC Broker App.
/// Automatically detects and renders SVG files (.svg) as vector graphics
/// using [SvgPicture], and raster images (.png, .jpg, .webp, etc.) using
/// [CachedNetworkImage] or [Image.asset].
class AppImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Widget Function(BuildContext context)? placeholder;
  final Widget Function(BuildContext context, Object? error)? errorWidget;
  final ColorFilter? colorFilter;
  final BorderRadius? borderRadius;
  final Map<String, String>? httpHeaders;
  final bool disableCache;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.placeholder,
    this.errorWidget,
    this.colorFilter,
    this.borderRadius,
    this.httpHeaders,
    this.disableCache = false,
  });

  /// Check whether a given path or URL points to an SVG vector file.
  static bool isSvg(String? pathOrUrl) {
    if (pathOrUrl == null || pathOrUrl.trim().isEmpty) return false;
    final trimmed = pathOrUrl.trim();

    if (trimmed.startsWith('<svg') || trimmed.startsWith('data:image/svg+xml')) {
      return true;
    }

    try {
      final uri = Uri.parse(trimmed);
      final path = uri.path.toLowerCase();
      if (path.endsWith('.svg')) return true;
    } catch (_) {}

    final cleanUrl = trimmed.split('?').first.split('#').first.toLowerCase();
    return cleanUrl.endsWith('.svg');
  }

  /// Clear SVG image cache (for a specific URL or all cached SVGs).
  static void clearSvgCache([String? url]) {
    _NetworkSvgWidgetState.clearSvgCache(url);
  }

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();

    Widget content;
    if (url == null || url.isEmpty) {
      content = errorWidget?.call(context, 'Empty or null image URL') ??
          _defaultFallback(context);
    } else if (isSvg(url)) {
      content = _buildSvgImage(context, url);
    } else {
      content = _buildRasterImage(context, url);
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: content,
      );
    }

    return content;
  }

  Widget _buildSvgImage(BuildContext context, String pathOrUrl) {
    final isNetwork = pathOrUrl.startsWith('http://') || pathOrUrl.startsWith('https://');
    final isAsset = pathOrUrl.startsWith('asset') || pathOrUrl.startsWith('assets/');

    if (pathOrUrl.startsWith('<svg')) {
      return SvgPicture.string(
        pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: colorFilter,
        placeholderBuilder: placeholder != null ? (ctx) => placeholder!(ctx) : null,
      );
    }

    if (isNetwork) {
      return _NetworkSvgWidget(
        url: pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        headers: httpHeaders,
        colorFilter: colorFilter,
        placeholder: placeholder,
        errorWidget: errorWidget,
        disableCache: disableCache,
      );
    }

    if (isAsset) {
      return SvgPicture.asset(
        pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter: colorFilter,
        placeholderBuilder: placeholder != null ? (ctx) => placeholder!(ctx) : null,
        errorBuilder: (ctx, err, stack) =>
            errorWidget?.call(ctx, err) ?? _defaultFallback(ctx),
      );
    }

    return _NetworkSvgWidget(
      url: pathOrUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      headers: httpHeaders,
      colorFilter: colorFilter,
      placeholder: placeholder,
      errorWidget: errorWidget,
      disableCache: disableCache,
    );
  }

  Widget _buildRasterImage(BuildContext context, String pathOrUrl) {
    final isAsset = pathOrUrl.startsWith('asset') || pathOrUrl.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        pathOrUrl,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (ctx, err, stack) =>
            errorWidget?.call(ctx, err) ?? _defaultFallback(ctx),
      );
    }

    return _NetworkRasterWidget(
      url: pathOrUrl,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      headers: httpHeaders,
      placeholder: placeholder,
      errorWidget: errorWidget,
      disableCache: disableCache,
    );
  }

  Widget _defaultFallback(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.black12,
      child: const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white54,
          size: 24,
        ),
      ),
    );
  }
}

class _NetworkRasterWidget extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final ColorFilter? colorFilter;
  final Map<String, String>? headers;
  final Widget Function(BuildContext context)? placeholder;
  final Widget Function(BuildContext context, Object? error)? errorWidget;
  final bool disableCache;

  const _NetworkRasterWidget({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.colorFilter,
    this.headers,
    this.placeholder,
    this.errorWidget,
    this.disableCache = false,
  });

  @override
  State<_NetworkRasterWidget> createState() => _NetworkRasterWidgetState();
}

class _NetworkRasterWidgetState extends State<_NetworkRasterWidget> {
  late String _requestUrl;

  @override
  void initState() {
    super.initState();
    _initUrl();
  }

  @override
  void didUpdateWidget(covariant _NetworkRasterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url ||
        oldWidget.disableCache != widget.disableCache) {
      _initUrl();
    }
  }

  void _initUrl() {
    if (widget.disableCache) {
      final sep = widget.url.contains('?') ? '&' : '?';
      _requestUrl =
          '${widget.url}${sep}_t=${DateTime.now().millisecondsSinceEpoch}';
    } else {
      _requestUrl = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.disableCache) {
      final headers = Map<String, String>.from(widget.headers ?? {});
      headers['Cache-Control'] = 'no-cache, no-store, must-revalidate';
      headers['Pragma'] = 'no-cache';
      headers['Expires'] = '0';

      Widget image = Image.network(
        _requestUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        headers: headers,
        loadingBuilder: widget.placeholder != null
            ? (ctx, child, progress) {
                if (progress == null) return child;
                return widget.placeholder!(ctx);
              }
            : null,
        errorBuilder: (ctx, err, stack) =>
            widget.errorWidget?.call(ctx, err) ??
            Container(
              width: widget.width,
              height: widget.height,
              color: Colors.black12,
              child: const Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.white54,
                  size: 24,
                ),
              ),
            ),
      );

      if (widget.colorFilter != null) {
        return ColorFiltered(
          colorFilter: widget.colorFilter!,
          child: image,
        );
      }

      return image;
    }

    Widget image = CachedNetworkImage(
      imageUrl: widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      httpHeaders: widget.headers,
      placeholder: widget.placeholder != null
          ? (ctx, url) => widget.placeholder!(ctx)
          : (ctx, url) => Container(
                width: widget.width,
                height: widget.height,
                color: Colors.black12,
              ),
      errorWidget: (ctx, url, err) =>
          widget.errorWidget?.call(ctx, err) ??
          Container(
            width: widget.width,
            height: widget.height,
            color: Colors.black12,
            child: const Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.white54,
                size: 24,
              ),
            ),
          ),
    );

    if (widget.colorFilter != null) {
      return ColorFiltered(
        colorFilter: widget.colorFilter!,
        child: image,
      );
    }

    return image;
  }
}

class _NetworkSvgWidget extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final ColorFilter? colorFilter;
  final Map<String, String>? headers;
  final Widget Function(BuildContext context)? placeholder;
  final Widget Function(BuildContext context, Object? error)? errorWidget;
  final bool disableCache;

  const _NetworkSvgWidget({
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.colorFilter,
    this.headers,
    this.placeholder,
    this.errorWidget,
    this.disableCache = false,
  });

  @override
  State<_NetworkSvgWidget> createState() => _NetworkSvgWidgetState();
}

class _NetworkSvgWidgetState extends State<_NetworkSvgWidget> {
  static final Map<String, String> _svgCache = {};
  String? _svgData;
  bool _isLoading = false;

  static void clearSvgCache([String? url]) {
    if (url != null) {
      _svgCache.remove(url);
    } else {
      _svgCache.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  @override
  void didUpdateWidget(covariant _NetworkSvgWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url ||
        oldWidget.disableCache != widget.disableCache) {
      _loadSvg();
    }
  }

  Future<void> _loadSvg() async {
    if (!widget.disableCache) {
      final cached = _svgCache[widget.url];
      if (cached != null) {
        setState(() {
          _svgData = cached;
          _isLoading = false;
        });
        return;
      }
    } else {
      _svgCache.remove(widget.url);
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var requestUrl = widget.url;
      final headers = Map<String, String>.from(widget.headers ?? {});
      if (widget.disableCache) {
        final separator = requestUrl.contains('?') ? '&' : '?';
        requestUrl =
            '$requestUrl${separator}_t=${DateTime.now().millisecondsSinceEpoch}';
        headers['Cache-Control'] = 'no-cache, no-store, must-revalidate';
        headers['Pragma'] = 'no-cache';
        headers['Expires'] = '0';
      }

      final res = await http
          .get(
            Uri.parse(requestUrl),
            headers: headers,
          )
          .timeout(const Duration(seconds: 15));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        var rawSvg = res.body;

        // Auto-correct embedded raster image scale/transform mismatch
        // (e.g. MAP phase 2e.svg with scale(.29) in 2048x1448 viewBox)
        rawSvg = rawSvg.replaceAll(
          RegExp(
              r'<image\s+width="7016"\s+height="4961"\s+transform="[^"]*"',
              caseSensitive: false),
          '<image width="2048" height="1448" preserveAspectRatio="none"',
        );

        if (!widget.disableCache) {
          _svgCache[widget.url] = rawSvg;
        }
        if (mounted) {
          setState(() {
            _svgData = rawSvg;
            _isLoading = false;
          });
        }
      } else {
        throw Exception('HTTP ${res.statusCode}');
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_svgData != null) {
      return SvgPicture.string(
        _svgData!,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        colorFilter: widget.colorFilter,
      );
    }

    if (_isLoading) {
      return widget.placeholder?.call(context) ??
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
    }

    // If fetch failed, fallback to SvgPicture.network
    return SvgPicture.network(
      widget.url,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      headers: widget.headers,
      colorFilter: widget.colorFilter,
      placeholderBuilder:
          widget.placeholder != null ? (ctx) => widget.placeholder!(ctx) : null,
      errorBuilder: (ctx, err, stack) =>
          widget.errorWidget?.call(ctx, err) ??
          Container(
            width: widget.width,
            height: widget.height,
            color: Colors.black12,
            child: const Center(
              child: Icon(Icons.image_not_supported_outlined,
                  color: Colors.white54),
            ),
          ),
    );
  }
}


