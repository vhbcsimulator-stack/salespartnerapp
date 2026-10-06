/// Model representing a discount scheme from Supabase table `project_discounts`.
class ProjectDiscountModel {
  final String projectCode;
  final String option;
  final double discount;
  final double interest;
  final DateTime? updatedAt;

  const ProjectDiscountModel({
    required this.projectCode,
    required this.option,
    required this.discount,
    this.interest = 0.0,
    this.updatedAt,
  });

  factory ProjectDiscountModel.fromJson(Map<String, dynamic> json) {
    return ProjectDiscountModel(
      projectCode: json['project_code']?.toString().trim() ?? '*',
      option: json['option']?.toString().toLowerCase().trim() ?? '',
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      interest: (json['interest'] as num?)?.toDouble() ?? 0.0,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_code': projectCode,
      'option': option,
      'discount': discount,
      'interest': interest,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  String toString() =>
      'ProjectDiscountModel(project: $projectCode, option: $option, discount: $discount%, interest: $interest%)';
}
