// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaveBalanceModelImpl _$$LeaveBalanceModelImplFromJson(
  Map<String, dynamic> json,
) => _$LeaveBalanceModelImpl(
  id: json['id'] as String,
  leaveTypeId: json['leaveTypeId'] as String,
  leaveTypeName: json['leaveTypeName'] as String,
  year: (json['year'] as num).toInt(),
  totalAllocated: (json['totalAllocated'] as num).toInt(),
  usedBalance: (json['usedBalance'] as num).toInt(),
  remainingBalance: (json['remainingBalance'] as num).toInt(),
  carriedOver: (json['carriedOver'] as num).toInt(),
);

Map<String, dynamic> _$$LeaveBalanceModelImplToJson(
  _$LeaveBalanceModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'leaveTypeId': instance.leaveTypeId,
  'leaveTypeName': instance.leaveTypeName,
  'year': instance.year,
  'totalAllocated': instance.totalAllocated,
  'usedBalance': instance.usedBalance,
  'remainingBalance': instance.remainingBalance,
  'carriedOver': instance.carriedOver,
};
