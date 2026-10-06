/// Model representing a record from Supabase `featured_projects` table.
class FeaturedProjectModel {
  final String projectCode;
  final String? location;
  final String? imageUrl;
  final String? storagePath;
  final String? userId;
  final DateTime? updatedAt;

  const FeaturedProjectModel({
    required this.projectCode,
    this.location,
    this.imageUrl,
    this.storagePath,
    this.userId,
    this.updatedAt,
  });

  factory FeaturedProjectModel.fromJson(Map<String, dynamic> json) {
    return FeaturedProjectModel(
      projectCode: json['project_code']?.toString().toUpperCase() ?? 'MVLC',
      location: json['location'] as String?,
      imageUrl: json['image_url'] as String?,
      storagePath: json['storage_path'] as String?,
      userId: json['user_id'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_code': projectCode,
      'location': location,
      'image_url': imageUrl,
      'storage_path': storagePath,
      'user_id': userId,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
