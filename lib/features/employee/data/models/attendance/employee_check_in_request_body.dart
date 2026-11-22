import 'package:json_annotation/json_annotation.dart';

part 'employee_check_in_request_body.g.dart';

@JsonSerializable()
class EmployeeCheckInRequestBody {
  const EmployeeCheckInRequestBody({
    required this.employeeIdd,
    this.customerId,
    this.shiftId,
    this.area,
    this.location,
    this.coordinates,
    this.employeeImage,
    this.mockLocationDetected,
    this.deviceUuid,
    this.capturedWallClock,
    this.integrityVerdict,
  });

  @JsonKey(name: 'employeeId')
  final String employeeIdd;
  final String? customerId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final int? shiftId;
  final String? area;
  final String? location;
  final List<AttendanceCoordinate>? coordinates;
  final String? employeeImage;
  final bool? mockLocationDetected;
  final String? deviceUuid;
  final String? capturedWallClock;
  final String? integrityVerdict;

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
    this.provider,
    this.satellitesCount,
    this.speed,
    this.altitude,
    this.isMock,
    this.wifiFingerprint,
    this.cellTowers,
    this.elapsedRealtimeMs,
    this.capturedWallClock,
    this.deviceStatus,
    this.kind,
    this.capturedAt,
  });

  final double? latitude;
  final double? longitude;
  final double? accuracyM;
  final String? provider;
  final int? satellitesCount;
  final double? speed;
  final double? altitude;
  final bool? isMock;
  final dynamic wifiFingerprint;
  final dynamic cellTowers;
  final int? elapsedRealtimeMs;
  final String? capturedWallClock;
  final dynamic deviceStatus;
  final String? kind;
  final String? capturedAt;

  factory AttendanceCoordinate.fromJson(Map<String, dynamic> json) =>
      _$AttendanceCoordinateFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceCoordinateToJson(this);
}
