import 'package:json_annotation/json_annotation.dart';

part 'disciplinary_models.g.dart';

@JsonSerializable(createToJson: false)
class DisciplinaryViolationModel {
  const DisciplinaryViolationModel({
    required this.id,
    required this.occurrenceIndex,
    required this.penaltyType,
    required this.penaltyValue,
    required this.calculatedAmount,
    required this.requiresAdminReview,
    required this.requiresWrittenWarning,
    required this.status,
    required this.violationDate,
    this.deductedDays,
    this.notes,
    this.payrollSettlementMonth,
    this.ruleCode,
    this.ruleDescriptionAr,
    this.employeeName,
    this.employeeCode,
    this.hasPendingAppeal = false,
    this.appealReason,
    this.appealStatus,
  });

  final String id;
  final int occurrenceIndex;
  final String penaltyType;
  final double penaltyValue;
  final double? deductedDays;
  final double calculatedAmount;
  final bool requiresAdminReview;
  final bool requiresWrittenWarning;
  final String status;
  final String violationDate;
  final String? notes;
  final String? payrollSettlementMonth;
  final String? ruleCode;
  final String? ruleDescriptionAr;
  final String? employeeName;
  final String? employeeCode;
  final bool hasPendingAppeal;
  final String? appealReason;
  final String? appealStatus;

  factory DisciplinaryViolationModel.fromJson(Map<String, dynamic> json) {
    final rule = json['rule'];
    final employee = json['employee'];
    final appeals = json['appeals'];

    bool hasPending = false;
    String? reason;
    String? aStatus;
    if (appeals is List && appeals.isNotEmpty) {
      final first = appeals.first;
      if (first is Map<String, dynamic>) {
        reason = first['reason'] as String?;
        aStatus = first['status'] as String?;
        hasPending = appeals.any(
          (a) => a is Map<String, dynamic> && a['status'] == 'PENDING',
        );
      }
    }

    return DisciplinaryViolationModel(
      id: json['id'] as String? ?? '',
      occurrenceIndex: json['occurrenceIndex'] as int? ?? 1,
      penaltyType: json['penaltyType'] as String? ?? 'FRACTION_OF_DAY',
      penaltyValue: (json['penaltyValue'] as num?)?.toDouble() ?? 0.0,
      deductedDays: (json['deductedDays'] as num?)?.toDouble(),
      calculatedAmount: (json['calculatedAmount'] as num?)?.toDouble() ?? 0.0,
      requiresAdminReview: json['requiresAdminReview'] as bool? ?? false,
      requiresWrittenWarning: json['requiresWrittenWarning'] as bool? ?? false,
      status: json['status'] as String? ?? 'APPROVED',
      violationDate: json['violationDate'] as String? ?? '',
      notes: json['notes'] as String?,
      payrollSettlementMonth: json['payrollSettlementMonth'] as String?,
      ruleCode: rule is Map<String, dynamic> ? rule['code'] as String? : null,
      ruleDescriptionAr: rule is Map<String, dynamic>
          ? rule['descriptionAr'] as String?
          : null,
      employeeName: employee is Map<String, dynamic>
          ? employee['name'] as String?
          : null,
      employeeCode: employee is Map<String, dynamic>
          ? employee['employeeCode'] as String?
          : null,
      hasPendingAppeal: hasPending,
      appealReason: reason,
      appealStatus: aStatus,
    );
  }
}

@JsonSerializable(createToJson: false)
class DisciplinarySummaryModel {
  const DisciplinarySummaryModel({
    required this.month,
    required this.violationsCount,
    required this.totalDeductedDays,
    required this.totalCalculatedAmount,
    required this.violations,
  });

  final String month;
  final int violationsCount;
  final double totalDeductedDays;
  final double totalCalculatedAmount;
  final List<DisciplinaryViolationModel> violations;

  factory DisciplinarySummaryModel.fromJson(Map<String, dynamic> json) {
    final vList = json['violations'];
    final items = vList is List
        ? vList
            .whereType<Map<String, dynamic>>()
            .map(DisciplinaryViolationModel.fromJson)
            .toList()
        : <DisciplinaryViolationModel>[];

    return DisciplinarySummaryModel(
      month: json['month'] as String? ?? '',
      violationsCount: json['violationsCount'] as int? ?? 0,
      totalDeductedDays:
          (json['totalDeductedDays'] as num?)?.toDouble() ?? 0.0,
      totalCalculatedAmount:
          (json['totalCalculatedAmount'] as num?)?.toDouble() ?? 0.0,
      violations: items,
    );
  }
}

@JsonSerializable(createToJson: false)
class DisciplinaryRuleModel {
  const DisciplinaryRuleModel({
    required this.id,
    required this.code,
    required this.descriptionAr,
    required this.triggerType,
    this.categoryName,
  });

  final String id;
  final String code;
  final String descriptionAr;
  final String triggerType;
  final String? categoryName;

  factory DisciplinaryRuleModel.fromJson(
    Map<String, dynamic> json, {
    String? categoryName,
  }) {
    return DisciplinaryRuleModel(
      id: json['id'] as String? ?? '',
      code: json['code'] as String? ?? '',
      descriptionAr: json['descriptionAr'] as String? ?? '',
      triggerType: json['triggerType'] as String? ?? 'MANUAL',
      categoryName: categoryName,
    );
  }
}

@JsonSerializable(createToJson: false)
class DisciplinaryPreviewModel {
  const DisciplinaryPreviewModel({
    required this.occurrenceIndex,
    required this.penaltyType,
    required this.penaltyValue,
    required this.deductedDays,
    required this.calculatedAmount,
    required this.requiresAdminReview,
    required this.dayWage,
    required this.labelAr,
  });

  final int occurrenceIndex;
  final String penaltyType;
  final double penaltyValue;
  final double deductedDays;
  final double calculatedAmount;
  final bool requiresAdminReview;
  final double dayWage;
  final String labelAr;

  factory DisciplinaryPreviewModel.fromJson(Map<String, dynamic> json) {
    return DisciplinaryPreviewModel(
      occurrenceIndex: json['occurrenceIndex'] as int? ?? 1,
      penaltyType: json['penaltyType'] as String? ?? 'FRACTION_OF_DAY',
      penaltyValue: (json['penaltyValue'] as num?)?.toDouble() ?? 0.0,
      deductedDays: (json['deductedDays'] as num?)?.toDouble() ?? 0.0,
      calculatedAmount: (json['calculatedAmount'] as num?)?.toDouble() ?? 0.0,
      requiresAdminReview: json['requiresAdminReview'] as bool? ?? false,
      dayWage: (json['dayWage'] as num?)?.toDouble() ?? 0.0,
      labelAr: json['labelAr'] as String? ?? '',
    );
  }
}
