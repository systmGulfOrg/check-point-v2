// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disciplinary_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DisciplinaryViolationModel _$DisciplinaryViolationModelFromJson(
  Map<String, dynamic> json,
) => DisciplinaryViolationModel(
  id: json['id'] as String,
  occurrenceIndex: (json['occurrenceIndex'] as num).toInt(),
  penaltyType: json['penaltyType'] as String,
  penaltyValue: (json['penaltyValue'] as num).toDouble(),
  calculatedAmount: (json['calculatedAmount'] as num).toDouble(),
  requiresAdminReview: json['requiresAdminReview'] as bool,
  requiresWrittenWarning: json['requiresWrittenWarning'] as bool,
  status: json['status'] as String,
  violationDate: json['violationDate'] as String,
  deductedDays: (json['deductedDays'] as num?)?.toDouble(),
  notes: json['notes'] as String?,
  payrollSettlementMonth: json['payrollSettlementMonth'] as String?,
  ruleCode: json['ruleCode'] as String?,
  ruleDescriptionAr: json['ruleDescriptionAr'] as String?,
  employeeName: json['employeeName'] as String?,
  employeeCode: json['employeeCode'] as String?,
  hasPendingAppeal: json['hasPendingAppeal'] as bool? ?? false,
  appealReason: json['appealReason'] as String?,
  appealStatus: json['appealStatus'] as String?,
);

DisciplinarySummaryModel _$DisciplinarySummaryModelFromJson(
  Map<String, dynamic> json,
) => DisciplinarySummaryModel(
  month: json['month'] as String,
  violationsCount: (json['violationsCount'] as num).toInt(),
  totalDeductedDays: (json['totalDeductedDays'] as num).toDouble(),
  totalCalculatedAmount: (json['totalCalculatedAmount'] as num).toDouble(),
  violations: (json['violations'] as List<dynamic>)
      .map(
        (e) => DisciplinaryViolationModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

DisciplinaryRuleModel _$DisciplinaryRuleModelFromJson(
  Map<String, dynamic> json,
) => DisciplinaryRuleModel(
  id: json['id'] as String,
  code: json['code'] as String,
  descriptionAr: json['descriptionAr'] as String,
  triggerType: json['triggerType'] as String,
  categoryName: json['categoryName'] as String?,
);

DisciplinaryPreviewModel _$DisciplinaryPreviewModelFromJson(
  Map<String, dynamic> json,
) => DisciplinaryPreviewModel(
  occurrenceIndex: (json['occurrenceIndex'] as num).toInt(),
  penaltyType: json['penaltyType'] as String,
  penaltyValue: (json['penaltyValue'] as num).toDouble(),
  deductedDays: (json['deductedDays'] as num).toDouble(),
  calculatedAmount: (json['calculatedAmount'] as num).toDouble(),
  requiresAdminReview: json['requiresAdminReview'] as bool,
  dayWage: (json['dayWage'] as num).toDouble(),
  labelAr: json['labelAr'] as String,
);
