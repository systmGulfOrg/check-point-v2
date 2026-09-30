// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsSummaryModelImpl _$$PointsSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsSummaryModelImpl(
  green: (json['green'] as num?)?.toInt() ?? 0,
  red: (json['red'] as num?)?.toInt() ?? 0,
  black: (json['black'] as num?)?.toInt() ?? 0,
  availableGreen: (json['availableGreen'] as num?)?.toInt() ?? 0,
  availableRed: (json['availableRed'] as num?)?.toInt() ?? 0,
  availableBlack: (json['availableBlack'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PointsSummaryModelImplToJson(
  _$PointsSummaryModelImpl instance,
) => <String, dynamic>{
  'green': instance.green,
  'red': instance.red,
  'black': instance.black,
  'availableGreen': instance.availableGreen,
  'availableRed': instance.availableRed,
  'availableBlack': instance.availableBlack,
};
