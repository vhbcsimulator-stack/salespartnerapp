enum DevelopmentPhotoType {
  actual,
  perspective,
}

/// Represents an actual site development photo or future architectural perspective.
/// - Actual photos are fetched from Supabase table `project_dev`
/// - Perspectives are fetched from Supabase table `future_dev`
class DevelopmentPhotoModel {
  final int id;
  final DateTime? createdAt;
  final String imageLink;
  final String? userId;
  final String projectName;
  final DevelopmentPhotoType type;

  const DevelopmentPhotoModel({
    required this.id,
    this.createdAt,
    required this.imageLink,
    this.userId,
    required this.projectName,
    required this.type,
  });

  factory DevelopmentPhotoModel.fromProjectDev(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['created_at'] != null) {
      parsedDate = DateTime.tryParse(json['created_at'].toString());
    }

    return DevelopmentPhotoModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      createdAt: parsedDate,
      imageLink: (json['image_link'] ?? '').toString().trim(),
      userId: json['user_id']?.toString(),
      projectName: (json['project_name'] ?? 'Other').toString().trim(),
      type: DevelopmentPhotoType.actual,
    );
  }

  factory DevelopmentPhotoModel.fromFutureDev(Map<String, dynamic> json) {
    DateTime? parsedDate;
    if (json['created_at'] != null) {
      parsedDate = DateTime.tryParse(json['created_at'].toString());
    }

    return DevelopmentPhotoModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      createdAt: parsedDate,
      imageLink: (json['image_link'] ?? '').toString().trim(),
      userId: json['user_id']?.toString(),
      projectName: (json['project_name'] ?? 'Other').toString().trim(),
      type: DevelopmentPhotoType.perspective,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'image_link': imageLink,
        'user_id': userId,
        'project_name': projectName,
        'type': type == DevelopmentPhotoType.actual ? 'actual' : 'perspective',
      };

  /// Normalizes project names like 'MSCC - paused' -> 'MSCC'
  String get normalizedProjectName {
    final clean = projectName.trim();
    if (clean.toUpperCase().contains('MSCC')) return 'MSCC';
    if (clean.toUpperCase().contains('MVLC')) return 'MVLC';
    if (clean.toUpperCase().contains('ERHD')) return 'ERHD';
    if (clean.toUpperCase().contains('GLS')) return 'GLS';
    if (clean.toUpperCase().contains('EBLF')) return 'EBLF';
    return clean;
  }

  /// Checks if this photo matches a target project query filter
  bool matchesProject(String targetProject) {
    if (targetProject.isEmpty || targetProject.toLowerCase() == 'all') {
      return true;
    }
    final target = targetProject.trim().toLowerCase();
    final norm = normalizedProjectName.toLowerCase();
    final raw = projectName.trim().toLowerCase();

    return norm == target ||
        raw == target ||
        raw.contains(target) ||
        target.contains(norm);
  }

  bool get isActual => type == DevelopmentPhotoType.actual;
  bool get isPerspective => type == DevelopmentPhotoType.perspective;
}
