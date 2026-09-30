// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_employee_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditEmployeeRequestBody _$EditEmployeeRequestBodyFromJson(
  Map<String, dynamic> json,
) => EditEmployeeRequestBody(
  name: json['name'] as String?,
  userName: json['username'] as String?,
  password: json['password'] as String?,
  position: json['position'] as String?,
  mobileId: json['mobileId'] as String?,
  role: json['role'] as String?,
  roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
  departmentId: (json['departmentId'] as num?)?.toInt(),
  branchId: (json['branchId'] as num?)?.toInt(),
  siteId: json['siteId'] as String?,
  attendanceLocationType: json['attendanceLocationType'] as String?,
  branchIds: (json['branchIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  siteIds: (json['siteIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  employeeCode: json['employeeCode'] as String?,
  canAddAttendance: json['canAddAttendance'] as bool?,
  canAddPlan: json['canAddPlan'] as bool?,
  deviceToken: (json['deviceToken'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  leaveBalance: (json['leaveBalance'] as num?)?.toInt(),
  workSystem: json['workSystem'] as String?,
  remoteWorkPolicyId: json['remoteWorkPolicyId'] as String?,
  directManagerId: json['directManagerId'] as String?,
  managerId: json['managerId'] as String?,
  grade: json['grade'] as String?,
  division: json['division'] as String?,
  contractType: json['contractType'] as String?,
  contractStatus: json['contractStatus'] as String?,
  contractEndDate: json['contractEndDate'] as String?,
  hireDate: json['hireDate'] as String?,
  joinDate: json['joinDate'] as String?,
  nameAr: json['nameAr'] as String?,
  nameEn: json['nameEn'] as String?,
  personalEmail: json['personalEmail'] as String?,
  secondaryPhone: json['secondaryPhone'] as String?,
  nationalId: json['nationalId'] as String?,
  passportNumber: json['passportNumber'] as String?,
  idExpiryDate: json['idExpiryDate'] as String?,
  birthDate: json['birthDate'] as String?,
  gender: json['gender'] as String?,
  maritalStatus: json['maritalStatus'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  emergencyContactName: json['emergencyContactName'] as String?,
  emergencyContactRelation: json['emergencyContactRelation'] as String?,
  emergencyContactPhone: json['emergencyContactPhone'] as String?,
  basicSalary: json['basicSalary'] as num?,
  allowances: json['allowances'] as num?,
  currency: json['currency'] as String?,
  bankName: json['bankName'] as String?,
  bankAccountNumber: json['bankAccountNumber'] as String?,
  iban: json['iban'] as String?,
  socialInsuranceNumber: json['socialInsuranceNumber'] as String?,
  documents: (json['documents'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
);

Map<String, dynamic> _$EditEmployeeRequestBodyToJson(
  EditEmployeeRequestBody instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.userName case final value?) 'username': value,
  if (instance.password case final value?) 'password': value,
  if (instance.position case final value?) 'position': value,
  if (instance.mobileId case final value?) 'mobileId': value,
  if (instance.role case final value?) 'role': value,
  if (instance.roles case final value?) 'roles': value,
  if (instance.departmentId case final value?) 'departmentId': value,
  if (instance.branchId case final value?) 'branchId': value,
  if (instance.siteId case final value?) 'siteId': value,
  if (instance.attendanceLocationType case final value?)
    'attendanceLocationType': value,
  if (instance.branchIds case final value?) 'branchIds': value,
  if (instance.siteIds case final value?) 'siteIds': value,
  if (instance.phone case final value?) 'phone': value,
  if (instance.email case final value?) 'email': value,
  if (instance.employeeCode case final value?) 'employeeCode': value,
  if (instance.canAddAttendance case final value?) 'canAddAttendance': value,
  if (instance.canAddPlan case final value?) 'canAddPlan': value,
  if (instance.deviceToken case final value?) 'deviceToken': value,
  if (instance.leaveBalance case final value?) 'leaveBalance': value,
  if (instance.workSystem case final value?) 'workSystem': value,
  if (instance.remoteWorkPolicyId case final value?)
    'remoteWorkPolicyId': value,
  if (instance.directManagerId case final value?) 'directManagerId': value,
  if (instance.managerId case final value?) 'managerId': value,
  if (instance.grade case final value?) 'grade': value,
  if (instance.division case final value?) 'division': value,
  if (instance.contractType case final value?) 'contractType': value,
  if (instance.contractStatus case final value?) 'contractStatus': value,
  if (instance.contractEndDate case final value?) 'contractEndDate': value,
  if (instance.hireDate case final value?) 'hireDate': value,
  if (instance.joinDate case final value?) 'joinDate': value,
  if (instance.nameAr case final value?) 'nameAr': value,
  if (instance.nameEn case final value?) 'nameEn': value,
  if (instance.personalEmail case final value?) 'personalEmail': value,
  if (instance.secondaryPhone case final value?) 'secondaryPhone': value,
  if (instance.nationalId case final value?) 'nationalId': value,
  if (instance.passportNumber case final value?) 'passportNumber': value,
  if (instance.idExpiryDate case final value?) 'idExpiryDate': value,
  if (instance.birthDate case final value?) 'birthDate': value,
  if (instance.gender case final value?) 'gender': value,
  if (instance.maritalStatus case final value?) 'maritalStatus': value,
  if (instance.address case final value?) 'address': value,
  if (instance.city case final value?) 'city': value,
  if (instance.emergencyContactName case final value?)
    'emergencyContactName': value,
  if (instance.emergencyContactRelation case final value?)
    'emergencyContactRelation': value,
  if (instance.emergencyContactPhone case final value?)
    'emergencyContactPhone': value,
  if (instance.basicSalary case final value?) 'basicSalary': value,
  if (instance.allowances case final value?) 'allowances': value,
  if (instance.currency case final value?) 'currency': value,
  if (instance.bankName case final value?) 'bankName': value,
  if (instance.bankAccountNumber case final value?) 'bankAccountNumber': value,
  if (instance.iban case final value?) 'iban': value,
  if (instance.socialInsuranceNumber case final value?)
    'socialInsuranceNumber': value,
  if (instance.documents case final value?) 'documents': value,
};
