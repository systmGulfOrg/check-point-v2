import 'package:json_annotation/json_annotation.dart';

part 'remote_work_policy_model.g.dart';

@JsonSerializable(createToJson: false)
class RemoteWorkPolicyModel {
  const RemoteWorkPolicyModel({
    required this.id,
    required this.name,
    required this.allowedDays,
    this.onsiteDays = const [],
    this.policyType = 'remote',
    this.workingHoursStart,
    this.workingHoursEnd,
    this.allowedDelayTime,
    this.requiresLocation = true,
    this.allowedRadiusM,
    this.maxDaysPerWeek,
    this.isActive = true,
    this.employeeCount = 0,
  });

  final String id;
  final String name;
  final List<String> allowedDays;
  final List<String> onsiteDays;
  final String policyType;
  final String? workingHoursStart;
  final String? workingHoursEnd;
  final int? allowedDelayTime;
  final bool requiresLocation;
  final int? allowedRadiusM;
  final int? maxDaysPerWeek;
  final bool isActive;
  final int employeeCount;

  String get effectivePolicyType {
    final type = policyType.toLowerCase();
    if (type == 'hybrid' || type == 'onsite' || type == 'remote') return type;
    final normalizedName = name.toLowerCase();
    if (normalizedName.contains('hybrid') || normalizedName.contains('هجين')) {
      return 'hybrid';
    }
    if (normalizedName.contains('onsite') ||
        normalizedName.contains('موقع') ||
        normalizedName.contains('حضوري')) {
      return 'onsite';
    }
    return 'remote';
  }

  factory RemoteWorkPolicyModel.fromJson(Map<String, dynamic> json) {
    int parsedCount = 0;
    if (json['_count'] != null && json['_count']['employees'] != null) {
      parsedCount = (json['_count']['employees'] as num).toInt();
    } else if (json['employeeCount'] != null) {
      parsedCount = (json['employeeCount'] as num).toInt();
    }

    return RemoteWorkPolicyModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      allowedDays:
          (json['allowedDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      onsiteDays:
          (json['onsiteDays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      policyType: json['policyType'] as String? ?? 'remote',
      workingHoursStart: json['workingHoursStart'] as String?,
      workingHoursEnd: json['workingHoursEnd'] as String?,
      allowedDelayTime: (json['allowedDelayTime'] as num?)?.toInt(),
      requiresLocation: json['requiresLocation'] as bool? ?? true,
      allowedRadiusM: (json['allowedRadiusM'] as num?)?.toInt(),
      maxDaysPerWeek: (json['maxDaysPerWeek'] as num?)?.toInt(),
      isActive: json['isActive'] as bool? ?? true,
      employeeCount: parsedCount,
    );
  }
}
