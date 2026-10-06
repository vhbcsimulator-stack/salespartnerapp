enum InventoryStatus {
  available,
  reserved,
  soldOut,
}

enum InventoryViewMode {
  list,
  map,
}

class InventoryProjectOption {
  final String id;
  final String label;
  final String? code;
  final String? name;
  final int? count;
  final bool paused;

  const InventoryProjectOption({
    required this.id,
    required this.label,
    this.code,
    this.name,
    this.count,
    this.paused = false,
  });

  bool get isSoonToRise => paused;
}

class AppliedFilterTag {
  final String id;
  final String label;
  final bool hasStatusDot;

  const AppliedFilterTag({
    required this.id,
    required this.label,
    this.hasStatusDot = false,
  });
}
