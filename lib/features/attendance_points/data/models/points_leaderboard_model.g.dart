// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_leaderboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsLeaderboardEntryModelImpl _$$PointsLeaderboardEntryModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsLeaderboardEntryModelImpl(
  rank: (json['rank'] as num).toInt(),
  employeeId: json['employeeId'] as String,
  name: json['name'] as String,
  avatar: json['avatar'] as String?,
  position: json['position'] as String?,
  departmentName: json['departmentName'] as String?,
  points: (json['points'] as num?)?.toInt() ?? 0,
  netPoints: (json['netPoints'] as num?)?.toInt(),
  greenPoints: (json['greenPoints'] as num?)?.toInt(),
  redPoints: (json['redPoints'] as num?)?.toInt(),
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  level: json['level'] as String? ?? 'Bronze',
  isCurrentUser: json['isCurrentUser'] as bool? ?? false,
);

Map<String, dynamic> _$$PointsLeaderboardEntryModelImplToJson(
  _$PointsLeaderboardEntryModelImpl instance,
) => <String, dynamic>{
  'rank': instance.rank,
  'employeeId': instance.employeeId,
  'name': instance.name,
  'avatar': instance.avatar,
  'position': instance.position,
  'departmentName': instance.departmentName,
  'points': instance.points,
  'netPoints': instance.netPoints,
  'greenPoints': instance.greenPoints,
  'redPoints': instance.redPoints,
  'currentStreak': instance.currentStreak,
  'level': instance.level,
  'isCurrentUser': instance.isCurrentUser,
};

_$PointsLeaderboardResponseModelImpl
_$$PointsLeaderboardResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsLeaderboardResponseModelImpl(
  value:
      (json['value'] as List<dynamic>?)
          ?.map(
            (e) =>
                PointsLeaderboardEntryModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <PointsLeaderboardEntryModel>[],
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$PointsLeaderboardResponseModelImplToJson(
  _$PointsLeaderboardResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
