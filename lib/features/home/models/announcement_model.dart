/// Model representing a company announcement from Supabase `announcements` table.
class AnnouncementModel {
  final int id;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? createdBy;
  final String? userId;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.userId,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      title: json['title'] as String? ?? 'Announcement',
      content: json['content'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
      createdBy: json['created_by'] as String?,
      userId: json['user_id'] as String?,
    );
  }

  String get relativeTime {
    if (createdAt == null) return 'Recently';
    final now = DateTime.now();
    final diff = now.difference(createdAt!);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
  }
}
