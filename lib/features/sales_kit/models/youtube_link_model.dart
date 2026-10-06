class YoutubeLinkModel {
  final int id;
  final DateTime? createdAt;
  final String link;
  final String title;
  final String projectName;

  const YoutubeLinkModel({
    required this.id,
    this.createdAt,
    required this.link,
    required this.title,
    required this.projectName,
  });

  factory YoutubeLinkModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['created_at'] != null) {
      parsedDate = DateTime.tryParse(json['created_at'].toString());
    }

    return YoutubeLinkModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      createdAt: parsedDate,
      link: (json['link'] ?? '').toString().trim(),
      title: (json['title'] ?? 'Untitled Video').toString().trim(),
      projectName: (json['project_name'] ?? 'Other').toString().trim(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt?.toIso8601String(),
    'link': link,
    'title': title,
    'project_name': projectName,
  };

  /// Extracts the YouTube video ID from various link formats:
  /// - https://youtu.be/VIDEO_ID
  /// - https://www.youtube.com/watch?v=VIDEO_ID
  /// - https://www.youtube.com/embed/VIDEO_ID
  /// - https://www.youtube.com/shorts/VIDEO_ID
  String? get videoId {
    if (link.isEmpty) return null;
    final trimmed = link.trim();

    try {
      final uri = Uri.tryParse(trimmed);
      if (uri != null) {
        if (uri.host.contains('youtu.be')) {
          if (uri.pathSegments.isNotEmpty) {
            return uri.pathSegments.first;
          }
        }
        if (uri.host.contains('youtube.com')) {
          if (uri.queryParameters.containsKey('v')) {
            return uri.queryParameters['v'];
          }
          if (uri.pathSegments.contains('embed') && uri.pathSegments.length > 1) {
            return uri.pathSegments[uri.pathSegments.indexOf('embed') + 1];
          }
          if (uri.pathSegments.contains('shorts') && uri.pathSegments.length > 1) {
            return uri.pathSegments[uri.pathSegments.indexOf('shorts') + 1];
          }
        }
      }
    } catch (_) {}

    // Fallback regex matcher
    final regExp = RegExp(
      r'(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=|shorts\/))([\w-]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(trimmed);
    return match?.group(1);
  }

  /// High quality thumbnail image provided by YouTube
  String? get thumbnailUrl {
    final id = videoId;
    if (id == null || id.isEmpty) return null;
    return 'https://img.youtube.com/vi/$id/hqdefault.jpg';
  }

  /// Max resolution thumbnail
  String? get maxResThumbnailUrl {
    final id = videoId;
    if (id == null || id.isEmpty) return null;
    return 'https://img.youtube.com/vi/$id/maxresdefault.jpg';
  }
}
