import 'package:json_annotation/json_annotation.dart';

part 'admin_attendance_model.g.dart';

@JsonSerializable()
class AdminAttendanceModel {
  const AdminAttendanceModel({
    this.id,
    this.employeeId,
    this.employeeName,
    this.clockInTime,
    this.clockOutTime,
    this.dayHours,
    this.totalHours,
    this.attendanceDate,
    this.area,
    this.customerId,
    this.customerName,
    this.employeeImage,
    this.isEarly,
    this.isLate,
  });

  final int? id;
  final String? employeeId;
  final String? employeeName;
  final String? clockInTime;
  final String? clockOutTime;
  final String? dayHours;
  final dynamic totalHours;
  final String? attendanceDate;
  final String? area;
  final String? customerId;
  final String? customerName;
  final String? employeeImage;
  final bool? isEarly;
  final bool? isLate;

  factory AdminAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AdminAttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminAttendanceModelToJson(this);
}

@JsonSerializable()
class AttendanceResponseModel {
  const AttendanceResponseModel({
    this.value,
    this.isSuccess,
    this.successMessage,
  });

  final AttendancePageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory AttendanceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceResponseModelToJson(this);
}

@JsonSerializable()
class AttendancePageModel {
  const AttendancePageModel({
    this.items,
    this.data,
    this.totalCount,
  });

  final List<AdminAttendanceModel>? items;
  final List<AdminAttendanceModel>? data;
  final int? totalCount;

  List<AdminAttendanceModel> get list => items ?? data ?? const [];

  factory AttendancePageModel.fromJson(Map<String, dynamic> json) =>
      _$AttendancePageModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendancePageModelToJson(this);
}
