import 'package:json_annotation/json_annotation.dart';
import 'package:check_point_v2/core/utils/legacy_api_json_converters.dart';
import 'employee_holiday_models.dart';
import 'employee_work_policy_model.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  const EmployeeModel({
    this.id,
    this.userName,
    this.name,
    this.role,
    this.roles,
    this.permissions,
    this.customPermissions,
    this.position,
    this.departmentName,
    this.departmentId,
    this.branchName,
    this.branchId,
    this.imageUrl,
    this.mobileId,
    this.deviceTokens,
    this.phone,
    this.email,
    this.employeeCode,
    this.canAddAttendance,
    this.canAddPlan,
    this.shiftName,
    this.shiftId,
    this.workSystem,
    this.remoteWorkPolicyId,
    this.workPolicy,
    this.todayWorkMode,
    this.todayWorkDay,
    this.todayIsWorkingDay,
    this.todayWorkStart,
    this.todayWorkEnd,
    this.todayAllowedDelayTime,
    this.clockInTime,
    this.clockOutTime,
    this.area,
    this.leaveBalance,
    this.directManagerId,
    this.directManagerName,
    this.managerId,
    this.managerName,
    this.todayHoliday,
    this.nextHoliday,
    this.holidayMessage,
    this.upcomingHolidayMessage,
    this.nameAr,
    this.nameEn,
    this.grade,
    this.division,
    this.contractType,
    this.contractStatus,
    this.joinDate,
    this.hireDate,
    this.contractEndDate,
    this.personalEmail,
    this.secondaryPhone,
    this.nationalId,
    this.passportNumber,
    this.idExpiryDate,
    this.birthDate,
    this.gender,
    this.maritalStatus,
    this.address,
    this.city,
    this.emergencyContactName,
    this.emergencyContactRelation,
    this.emergencyContactPhone,
    this.basicSalary,
    this.allowances,
    this.currency,
    this.bankName,
    this.bankAccountNumber,
    this.iban,
    this.socialInsuranceNumber,
    this.documents,
    this.customFields,
    this.deletedAt,
  });

  final String? id;
  final String? userName;
  final String? name;
  final String? role;
  final List<String>? roles;
  final List<String>? permissions;
  final List<String>? customPermissions;
  final String? position;
  final String? departmentName;
  final int? departmentId;
  final String? branchName;
  final int? branchId;
  final String? imageUrl;
  final String? mobileId;
  final List<String>? deviceTokens;
  final String? phone;
  final String? email;
  final String? employeeCode;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final String? shiftName;
  final int? shiftId;
  final String? workSystem;
  final String? remoteWorkPolicyId;
  final EmployeeWorkPolicyModel? workPolicy;
  final String? todayWorkMode;
  final String? todayWorkDay;
  final bool? todayIsWorkingDay;
  final String? todayWorkStart;
  final String? todayWorkEnd;
  final int? todayAllowedDelayTime;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockInTime;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? clockOutTime;
  final String? area;
  final int? leaveBalance;
  final String? directManagerId;
  final String? directManagerName;
  final String? managerId;
  final String? managerName;
  final EmployeeTodayHolidayModel? todayHoliday;
  final EmployeeNextHolidayModel? nextHoliday;
  final String? holidayMessage;
  final String? upcomingHolidayMessage;
  final String? nameAr;
  final String? nameEn;
  final String? grade;
  final String? division;
  final String? contractType;
  final String? contractStatus;
  final String? joinDate;
  final String? hireDate;
  final String? contractEndDate;
  final String? personalEmail;
  final String? secondaryPhone;
  final String? nationalId;
  final String? passportNumber;
  final String? idExpiryDate;
  final String? birthDate;
  final String? gender;
  final String? maritalStatus;
  final String? address;
  final String? city;
  final String? emergencyContactName;
  final String? emergencyContactRelation;
  final String? emergencyContactPhone;
  final num? basicSalary;
  final num? allowances;
  final String? currency;
  final String? bankName;
  final String? bankAccountNumber;
  final String? iban;
  final String? socialInsuranceNumber;
  final List<dynamic>? documents;
  final Map<String, dynamic>? customFields;
  final String? deletedAt;

  String? get resolvedDirectManagerId => directManagerId ?? managerId;
  String? get resolvedDirectManagerName => directManagerName ?? managerName;
  String get resolvedNameAr => nameAr ?? name ?? '-';
  String get resolvedNameEn => nameEn ?? userName ?? name ?? '-';
  String get resolvedGrade => grade ?? 'Grade 4 (Senior)';
  String get resolvedDivision => division ?? departmentName ?? '-';
  String get resolvedContractType => contractType ?? 'Full-Time';
  String get resolvedContractStatus => contractStatus ?? (canAddAttendance == true ? 'Active' : 'Probation');
  String get resolvedJoinDate => joinDate ?? hireDate ?? '-';
  String get resolvedNationalId => nationalId ?? passportNumber ?? '-';
  String get resolvedEmergencyName => emergencyContactName ?? '-';
  String get resolvedEmergencyRelation => emergencyContactRelation ?? '-';
  String get resolvedEmergencyPhone => emergencyContactPhone ?? '-';
  String get resolvedBankName => bankName ?? 'CIB Bank';
  String get resolvedBankAccount => bankAccountNumber ?? '-';
  String get resolvedIban => iban ?? '-';
  num get resolvedBasicSalary => basicSalary ?? 0;
  num get resolvedAllowances => allowances ?? 0;
  num get resolvedTotalSalary => (basicSalary ?? 0) + (allowances ?? 0);
  String get resolvedCurrency => currency ?? 'EGP';

  List<String> get allRoles {
    final set = <String>{};
    if (role != null && role!.trim().isNotEmpty) {
      set.add(role!.trim());
    }
    if (roles != null) {
      for (final r in roles!) {
        if (r.trim().isNotEmpty) set.add(r.trim());
      }
    }
    return set.isEmpty ? const ['Employee'] : set.toList();
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
