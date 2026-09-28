import 'package:freezed_annotation/freezed_annotation.dart';

part 'lat_lng_point_model.freezed.dart';
part 'lat_lng_point_model.g.dart';

@freezed
abstract class LatLngPointModel with _$LatLngPointModel {
  const factory LatLngPointModel({
    required double lat,
    required double lng,
  }) = _LatLngPointModel;

  factory LatLngPointModel.fromJson(Map<String, dynamic> json) =>
      _$LatLngPointModelFromJson(json);
}
