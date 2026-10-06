class ProjectModel {
  final String id;
  final String? code;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;
  final bool paused;

  const ProjectModel({
    required this.id,
    this.code,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.paused = false,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id']?.toString() ?? json['description']?.toString() ?? '',
      code: json['code'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
      userId: json['user_id'] as String?,
      paused: json['paused'] == true,
    );
  }

  /// Whether this project is paused / marked as soon-to-rise
  bool get isSoonToRise => paused;

  /// The project name to display on choice chips and cards.
  /// Prioritizes `description` (which holds the project title in the schema) or `name`.
  String get displayName {
    if (description != null && description!.trim().isNotEmpty) {
      return description!.trim();
    }
    if (name != null && name!.trim().isNotEmpty) {
      return name!.trim();
    }
    if (code != null && code!.trim().isNotEmpty) {
      return code!.trim();
    }
    return id.isNotEmpty ? 'Project #$id' : 'Development';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user_id': userId,
      'paused': paused,
    };
  }
}
