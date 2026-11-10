// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeRecordResponseModelImpl _$$EmployeeRecordResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeRecordResponseModelImpl(
  value: json['value'] == null
      ? null
      : EmployeeRecordModel.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$EmployeeRecordResponseModelImplToJson(
  _$EmployeeRecordResponseModelImpl instance,
) => <String, dynamic>{'value': instance.value};

_$EmployeeRecordModelImpl _$$EmployeeRecordModelImplFromJson(
  Map<String, dynamic> json,
) => _$EmployeeRecordModelImpl(
  employee: RecordEmployeeModel.fromJson(
    json['employee'] as Map<String, dynamic>,
  ),
  totals: json['totals'] == null
      ? const RecordTotalsModel()
      : RecordTotalsModel.fromJson(json['totals'] as Map<String, dynamic>),
  days:
      (json['days'] as List<dynamic>?)
          ?.map((e) => RecordDayModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RecordDayModel>[],
);

Map<String, dynamic> _$$EmployeeRecordModelImplToJson(
  _$EmployeeRecordModelImpl instance,
) => <String, dynamic>{
  'employee': instance.employee,
  'totals': instance.totals,
  'days': instance.days,
};

_$RecordEmployeeModelImpl _$$RecordEmployeeModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecordEmployeeModelImpl(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  employeeCode: json['employeeCode'] as String?,
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$$RecordEmployeeModelImplToJson(
  _$RecordEmployeeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'employeeCode': instance.employeeCode,
  'imageUrl': instance.imageUrl,
};

_$RecordTotalsModelImpl _$$RecordTotalsModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecordTotalsModelImpl(
  workingDays: (json['workingDays'] as num?)?.toInt() ?? 0,
  presentDays: (json['presentDays'] as num?)?.toInt() ?? 0,
  lateDays: (json['lateDays'] as num?)?.toInt() ?? 0,
  coveredDays: (json['coveredDays'] as num?)?.toInt() ?? 0,
  earlyLeaveDays: (json['earlyLeaveDays'] as num?)?.toInt() ?? 0,
  absentDays: (json['absentDays'] as num?)?.toInt() ?? 0,
  leaveDays: (json['leaveDays'] as num?)?.toInt() ?? 0,
  holidayDays: (json['holidayDays'] as num?)?.toInt() ?? 0,
  weeklyOffDays: (json['weeklyOffDays'] as num?)?.toInt() ?? 0,
  permits: (json['permits'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$RecordTotalsModelImplToJson(
  _$RecordTotalsModelImpl instance,
) => <String, dynamic>{
  'workingDays': instance.workingDays,
  'presentDays': instance.presentDays,
  'lateDays': instance.lateDays,
  'coveredDays': instance.coveredDays,
  'earlyLeaveDays': instance.earlyLeaveDays,
  'absentDays': instance.absentDays,
  'leaveDays': instance.leaveDays,
  'holidayDays': instance.holidayDays,
  'weeklyOffDays': instance.weeklyOffDays,
  'permits': instance.permits,
};

_$RecordDayModelImpl _$$RecordDayModelImplFromJson(Map<String, dynamic> json) =>
    _$RecordDayModelImpl(
      date: const RecordDayDateConverter().fromJson(json['date'] as String),
      dayType: json['dayType'] as String? ?? 'working',
      status: json['status'] as String? ?? 'none',
      clockIn: json['clockIn'] == null
          ? null
          : DateTime.parse(json['clockIn'] as String),
      clockOut: json['clockOut'] == null
          ? null
          : DateTime.parse(json['clockOut'] as String),
      workedMinutes: (json['workedMinutes'] as num?)?.toInt(),
      lateMinutes: (json['lateMinutes'] as num?)?.toInt() ?? 0,
      earlyLeaveMinutes: (json['earlyLeaveMinutes'] as num?)?.toInt() ?? 0,
      holidayName: json['holidayName'] as String?,
      leave: json['leave'] == null
          ? null
          : RecordLeaveModel.fromJson(json['leave'] as Map<String, dynamic>),
      permits:
          (json['permits'] as List<dynamic>?)
              ?.map(
                (e) => RecordPermitModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <RecordPermitModel>[],
    );

Map<String, dynamic> _$$RecordDayModelImplToJson(
  _$RecordDayModelImpl instance,
) => <String, dynamic>{
  'date': const RecordDayDateConverter().toJson(instance.date),
  'dayType': instance.dayType,
  'status': instance.status,
  'clockIn': instance.clockIn?.toIso8601String(),
  'clockOut': instance.clockOut?.toIso8601String(),
  'workedMinutes': instance.workedMinutes,
  'lateMinutes': instance.lateMinutes,
  'earlyLeaveMinutes': instance.earlyLeaveMinutes,
  'holidayName': instance.holidayName,
  'leave': instance.leave,
  'permits': instance.permits,
};

_$RecordLeaveModelImpl _$$RecordLeaveModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecordLeaveModelImpl(
  id: json['id'] as String,
  typeName: json['typeName'] as String? ?? '',
);

Map<String, dynamic> _$$RecordLeaveModelImplToJson(
  _$RecordLeaveModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'typeName': instance.typeName};

_$RecordPermitModelImpl _$$RecordPermitModelImplFromJson(
  Map<String, dynamic> json,
) => _$RecordPermitModelImpl(
  id: json['id'] as String,
  permitType: json['permitType'] as String? ?? '',
  status: json['status'] as String? ?? '',
  durationMinutes: (json['durationMinutes'] as num?)?.toInt(),
  startTime: json['startTime'] as String? ?? '',
  endTime: json['endTime'] as String? ?? '',
);

Map<String, dynamic> _$$RecordPermitModelImplToJson(
  _$RecordPermitModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'permitType': instance.permitType,
  'status': instance.status,
  'durationMinutes': instance.durationMinutes,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
};
