// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveTypeModelImpl _$$LeaveTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$LeaveTypeModelImpl(
      id: json['id'] as String,
      typeName: json['typeName'] as String,
      isPaid: json['isPaid'] as bool,
      requiresAttachment: json['requiresAttachment'] as bool,
      maxDaysPerYear: (json['maxDaysPerYear'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$LeaveTypeModelImplToJson(
  _$LeaveTypeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'typeName': instance.typeName,
  'isPaid': instance.isPaid,
  'requiresAttachment': instance.requiresAttachment,
  'maxDaysPerYear': instance.maxDaysPerYear,
};
