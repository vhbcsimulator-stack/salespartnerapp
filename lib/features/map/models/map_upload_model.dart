/// Model representing a map upload record from public.uploads table.
class MapUploadModel {
  final int id;
  final int? projectId;
  final int? phaseId;
  final String? kind;
  final String? name;
  final String? storagePath;
  final bool isCurrent;
  final String? userId;
  final String? project;
  final String imageUrl;
  final int? phase;
  final String? type;
  final String? mapSection;

  /// Explicit getter matching the exact column name `image_URL` on table `uploads`.
  // ignore: non_constant_identifier_names
  String get image_URL => imageUrl;

  const MapUploadModel({
    required this.id,
    this.projectId,
    this.phaseId,
    this.kind,
    this.name,
    this.storagePath,
    this.isCurrent = true,
    this.userId,
    this.project,
    required this.imageUrl,
    this.phase,
    this.type,
    this.mapSection,
  });

  factory MapUploadModel.fromJson(Map<String, dynamic> json) {
    int? parsedPhase;
    if (json['Phase'] != null) {
      parsedPhase = int.tryParse(json['Phase'].toString());
    } else if (json['phase'] != null) {
      parsedPhase = int.tryParse(json['phase'].toString());
    }

    // Must get the image URL strictly from the `image_URL` column on the uploads table
    final rawImageUrl = (json['image_URL'] ?? json['image_url'] ?? '')
        .toString()
        .trim();

    final rawMapSection = (json['map_section'] ??
            json['mapSection'] ??
            json['Map_Section'])
        ?.toString()
        .trim();
    final parsedMapSection = (rawMapSection != null &&
            rawMapSection.isNotEmpty &&
            rawMapSection.toLowerCase() != 'null')
        ? rawMapSection
        : null;

    return MapUploadModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      projectId: json['project_id'] is int
          ? json['project_id'] as int
          : int.tryParse(json['project_id']?.toString() ?? ''),
      phaseId: json['phase_id'] is int
          ? json['phase_id'] as int
          : int.tryParse(json['phase_id']?.toString() ?? ''),
      kind: json['kind'] as String?,
      name: json['name'] as String?,
      storagePath: json['storage_path'] as String?,
      isCurrent: json['current'] == true,
      userId: json['user_id'] as String?,
      project: json['project'] as String?,
      imageUrl: rawImageUrl,
      phase: parsedPhase,
      type: json['type'] as String?,
      mapSection: parsedMapSection,
    );
  }
}
