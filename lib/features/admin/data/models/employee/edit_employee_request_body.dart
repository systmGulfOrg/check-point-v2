import 'package:json_annotation/json_annotation.dart';

part 'edit_employee_request_body.g.dart';

@JsonSerializable(includeIfNull: false)
class EditEmployeeRequestBody {
  const EditEmployeeRequestBody({
    this.name,
    this.userName,
    this.password,
    this.position,
    this.mobileId,
    this.role,
    this.roles,
    this.departmentId,
    this.branchId,
    this.shiftId,
    this.phone,
    this.email,
    this.employeeCode,
    this.canAddAttendance,
    this.canAddPlan,
    this.deviceToken,
    this.leaveBalance,
    this.workSystem,
    this.remoteWorkPolicyId,
    this.directManagerId,
    this.managerId,
    this.grade,
    this.division,
    this.contractType,
    this.contractStatus,
    this.contractEndDate,
    this.hireDate,
    this.joinDate,
    this.nameAr,
    this.nameEn,
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
    this.imageUrl,
    this.customPermissions,
  });

  final String? name;
  @JsonKey(name: 'username')
  final String? userName;
  final String? password;
  final String? position;
  final String? mobileId;
  final String? imageUrl;
  final List<String>? customPermissions;
  final String? role;
  final List<String>? roles;
  final int? departmentId;
  final int? branchId;
  final int? shiftId;
  final String? phone;
  final String? email;
  final String? employeeCode;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final List<String>? deviceToken;
  final int? leaveBalance;
  final String? workSystem;
  final String? remoteWorkPolicyId;
  final String? directManagerId;
  final String? managerId;
  final String? grade;
  final String? division;
  final String? contractType;
  final String? contractStatus;
  final String? contractEndDate;
  final String? hireDate;
  final String? joinDate;
  final String? nameAr;
  final String? nameEn;
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
  final List<Map<String, dynamic>>? documents;

  factory EditEmployeeRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EditEmployeeRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EditEmployeeRequestBodyToJson(this);
}
