enum ClientStage {
  hot,
  reserved,
  warm,
  cold,
  closed,
}

extension ClientStageExtension on ClientStage {
  String get label {
    switch (this) {
      case ClientStage.hot:
        return 'Hot Leads';
      case ClientStage.reserved:
        return 'Reserved';
      case ClientStage.warm:
        return 'Warm';
      case ClientStage.cold:
        return 'Cold';
      case ClientStage.closed:
        return 'Closed Buyers';
    }
  }

  String get badgeText {
    switch (this) {
      case ClientStage.hot:
        return 'HOT LEAD';
      case ClientStage.reserved:
        return 'RESERVED';
      case ClientStage.warm:
        return 'WARM LEAD';
      case ClientStage.cold:
        return 'COLD LEAD';
      case ClientStage.closed:
        return 'CLOSED BUYER';
    }
  }
}

ClientStage clientStageFromString(String? val) {
  if (val == null) return ClientStage.hot;
  final clean = val.trim().toLowerCase();
  switch (clean) {
    case 'hot':
      return ClientStage.hot;
    case 'reserved':
      return ClientStage.reserved;
    case 'warm':
      return ClientStage.warm;
    case 'cold':
      return ClientStage.cold;
    case 'closed':
      return ClientStage.closed;
    default:
      return ClientStage.hot;
  }
}

class ClientModel {
  final String id;
  final String name;
  final String? subtitle;
  final String? avatarUrl;
  final String phone;
  final String? email;
  final ClientStage stage;
  final bool isVip;
  final String? vipTag;
  final String projectCode;
  final String unitDescription;
  final String tcpFormatted;
  final String statusNote;
  final String tagNote;
  final String lastActivityText;
  final String? holdSubtitle;
  final DateTime createdAt;
  final String? brokerName;
  final String? notes;

  const ClientModel({
    required this.id,
    required this.name,
    this.subtitle,
    this.avatarUrl,
    required this.phone,
    this.email,
    required this.stage,
    this.isVip = false,
    this.vipTag,
    required this.projectCode,
    required this.unitDescription,
    required this.tcpFormatted,
    required this.statusNote,
    required this.tagNote,
    required this.lastActivityText,
    this.holdSubtitle,
    required this.createdAt,
    this.brokerName,
    this.notes,
  });

  factory ClientModel.fromSupabase(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id']?.toString() ?? '',
      name: map['name'] as String? ?? 'Unnamed Client',
      subtitle: map['subtitle'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String?,
      stage: clientStageFromString(map['stage'] as String?),
      isVip: map['is_vip'] == true,
      vipTag: map['vip_tag'] as String?,
      projectCode: (map['project_code'] as String? ?? 'MVLC').toUpperCase(),
      unitDescription: map['unit_description'] as String? ?? '',
      tcpFormatted: map['tcp_formatted'] as String? ?? 'Price Upon Request',
      statusNote: map['status_note'] as String? ?? '',
      tagNote: map['tag_note'] as String? ?? '',
      lastActivityText: map['last_activity_text'] as String? ?? 'Created recently',
      holdSubtitle: map['hold_subtitle'] as String?,
      createdAt: DateTime.tryParse(map['created_at']?.toString() ?? '') ?? DateTime.now(),
      brokerName: map['broker_name'] as String?,
      notes: map['notes'] as String?,
    );
  }

  Map<String, dynamic> toSupabaseMap({String? brokerName, String? brokerId}) {
    final map = <String, dynamic>{
      'name': name,
      'phone': phone,
      'stage': stage.name,
      'project_code': projectCode,
      'notes': notes,
      'subtitle': subtitle,
      'email': email,
      'avatar_url': avatarUrl,
      'is_vip': isVip,
      'vip_tag': vipTag,
      'unit_description': unitDescription,
      'tcp_formatted': tcpFormatted,
      'status_note': statusNote,
      'tag_note': tagNote,
      'last_activity_text': lastActivityText,
      'hold_subtitle': holdSubtitle,
    };
    final resolvedBroker = brokerName ?? this.brokerName;
    if (resolvedBroker != null && resolvedBroker.isNotEmpty) {
      map['broker_name'] = resolvedBroker;
    }
    final isUuid = brokerId != null &&
        RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$')
            .hasMatch(brokerId);
    if (isUuid) {
      map['broker_id'] = brokerId;
    }
    return map;
  }

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return 'CL';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    final first = parts.first.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final last = parts.last.replaceAll(RegExp(r'[^a-zA-Z]'), '');
    final f = first.isNotEmpty ? first[0] : parts.first[0];
    final l = last.isNotEmpty ? last[0] : parts.last[0];
    return '$f$l'.toUpperCase();
  }

  ClientModel copyWith({
    String? id,
    String? name,
    String? subtitle,
    String? avatarUrl,
    String? phone,
    String? email,
    ClientStage? stage,
    bool? isVip,
    String? vipTag,
    String? projectCode,
    String? unitDescription,
    String? tcpFormatted,
    String? statusNote,
    String? tagNote,
    String? lastActivityText,
    String? holdSubtitle,
    DateTime? createdAt,
    String? brokerName,
    String? notes,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      stage: stage ?? this.stage,
      isVip: isVip ?? this.isVip,
      vipTag: vipTag ?? this.vipTag,
      projectCode: projectCode ?? this.projectCode,
      unitDescription: unitDescription ?? this.unitDescription,
      tcpFormatted: tcpFormatted ?? this.tcpFormatted,
      statusNote: statusNote ?? this.statusNote,
      tagNote: tagNote ?? this.tagNote,
      lastActivityText: lastActivityText ?? this.lastActivityText,
      holdSubtitle: holdSubtitle ?? this.holdSubtitle,
      createdAt: createdAt ?? this.createdAt,
      brokerName: brokerName ?? this.brokerName,
      notes: notes ?? this.notes,
    );
  }
}
