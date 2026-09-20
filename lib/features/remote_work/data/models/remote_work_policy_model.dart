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

  String get effectivePolicyType {
    if (policyType.toLowerCase() == 'hybrid') return 'hybrid';
    final normalizedName = name.toLowerCase();
    return normalizedName.contains('hybrid') || normalizedName.contains('هجين')
        ? 'hybrid'
        : 'remote';
  }

  factory RemoteWorkPolicyModel.fromJson(Map<String, dynamic> json) =>
      _$RemoteWorkPolicyModelFromJson(json);
}
