import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_record_model.freezed.dart';
part 'employee_record_model.g.dart';

/// GET /api/v2/employees/:id/record — one employee's days with attendance,
/// leave, holidays, weekly days off and permits.
@freezed
class EmployeeRecordResponseModel with _$EmployeeRecordResponseModel {
  const factory EmployeeRecordResponseModel({EmployeeRecordModel? value}) =
      _EmployeeRecordResponseModel;

  factory EmployeeRecordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRecordResponseModelFromJson(json);
}

@freezed
class EmployeeRecordModel with _$EmployeeRecordModel {
  const factory EmployeeRecordModel({
    required RecordEmployeeModel employee,
    @Default(RecordTotalsModel()) RecordTotalsModel totals,
    @Default(<RecordDayModel>[]) List<RecordDayModel> days,
  }) = _EmployeeRecordModel;

  factory EmployeeRecordModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRecordModelFromJson(json);
}

@freezed
class RecordEmployeeModel with _$RecordEmployeeModel {
  const factory RecordEmployeeModel({
    required String id,
    @Default('') String name,
    String? employeeCode,
    String? imageUrl,
  }) = _RecordEmployeeModel;

  factory RecordEmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$RecordEmployeeModelFromJson(json);
}

@freezed
class RecordTotalsModel with _$RecordTotalsModel {
  const factory RecordTotalsModel({
    @Default(0) int workingDays,
    @Default(0) int presentDays,
    @Default(0) int lateDays,
    @Default(0) int coveredDays,
    @Default(0) int earlyLeaveDays,
    @Default(0) int absentDays,
    @Default(0) int leaveDays,
    @Default(0) int holidayDays,
    @Default(0) int weeklyOffDays,
    @Default(0) int permits,
  }) = _RecordTotalsModel;

  factory RecordTotalsModel.fromJson(Map<String, dynamic> json) =>
      _$RecordTotalsModelFromJson(json);
}

@freezed
class RecordDayModel with _$RecordDayModel {
  const RecordDayModel._();

  const factory RecordDayModel({
    /// `YYYY-MM-DD`, parsed once in the data layer (§28).
    @RecordDayDateConverter() required DateTime date,
    /// working | weeklyOff | holiday | leave
    @Default('working') String dayType,
    /// present | late | lateCovered | earlyLeave | earlyCovered |
    /// lateAndEarly | absent | upcoming | none
    @Default('none') String status,
    DateTime? clockIn,
    DateTime? clockOut,
    int? workedMinutes,
    @Default(0) int lateMinutes,
    @Default(0) int earlyLeaveMinutes,
    String? holidayName,
    RecordLeaveModel? leave,
    @Default(<RecordPermitModel>[]) List<RecordPermitModel> permits,
  }) = _RecordDayModel;

  factory RecordDayModel.fromJson(Map<String, dynamic> json) =>
      _$RecordDayModelFromJson(json);

  /// Covered by an approved permit: shown as permitted, never as late.
  bool get isCovered => status == 'lateCovered' || status == 'earlyCovered';
}

/// `YYYY-MM-DD` <-> a UTC midnight [DateTime].
class RecordDayDateConverter implements JsonConverter<DateTime, String> {
  const RecordDayDateConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse('${json}T00:00:00Z');

  @override
  String toJson(DateTime object) => object.toIso8601String().substring(0, 10);
}

@freezed
class RecordLeaveModel with _$RecordLeaveModel {
  const factory RecordLeaveModel({required String id, @Default('') String typeName}) =
      _RecordLeaveModel;

  factory RecordLeaveModel.fromJson(Map<String, dynamic> json) =>
      _$RecordLeaveModelFromJson(json);
}

@freezed
class RecordPermitModel with _$RecordPermitModel {
  const factory RecordPermitModel({
    required String id,
    /// LateArrival | EarlyDeparture | Temporary
    @Default('') String permitType,
    @Default('') String status,
    int? durationMinutes,
    @Default('') String startTime,
    @Default('') String endTime,
  }) = _RecordPermitModel;

  factory RecordPermitModel.fromJson(Map<String, dynamic> json) =>
      _$RecordPermitModelFromJson(json);
}
