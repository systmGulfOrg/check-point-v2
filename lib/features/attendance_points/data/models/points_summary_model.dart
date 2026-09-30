import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_summary_model.freezed.dart';
part 'points_summary_model.g.dart';

@freezed
class PointsSummaryModel with _$PointsSummaryModel {
  const factory PointsSummaryModel({
    @Default(0) int green,
    @Default(0) int red,
    @Default(0) int black,
    @Default(0) int availableGreen,
    @Default(0) int availableRed,
    @Default(0) int availableBlack,
  }) = _PointsSummaryModel;

  factory PointsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$PointsSummaryModelFromJson(json);
}
