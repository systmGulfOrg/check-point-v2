// ignore_for_file: invalid_annotation_target
import 'package:json_annotation/json_annotation.dart';

part 'employee_check_in_request_body.g.dart';

@JsonSerializable()
class EmployeeCheckInRequestBody {
  const EmployeeCheckInRequestBody({
    required this.employeeIdd,
    this.siteId,
    this.customerId,
    this.shiftId,
    this.area,
    this.location,
    this.coordinates,
    this.employeeImage,
    this.mockLocationDetected,
  });

  @JsonKey(name: 'employeeId')
  final String employeeIdd;

  @JsonKey(name: 'siteId')
  final String? siteId;

  final String? customerId;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? shiftId;

  final String? area;
  final String? location;
  final List<AttendanceCoordinate>? coordinates;
  final String? employeeImage;
  final bool? mockLocationDetected;

  factory EmployeeCheckInRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeCheckInRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeCheckInRequestBodyToJson(this);
}

@JsonSerializable()
class AttendanceCoordinate {
  const AttendanceCoordinate({
    this.latitude,
    this.longitude,
    this.accuracyM,
  });

  @JsonKey(name: 'latitude')
  final double? latitude;

  @JsonKey(name: 'longitude')
  final double? longitude;

  @JsonKey(name: 'accuracyM')
  final double? accuracyM;

  factory AttendanceCoordinate.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceCoordinateToJson(this);
}
