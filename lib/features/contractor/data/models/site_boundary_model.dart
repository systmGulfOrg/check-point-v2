import 'package:freezed_annotation/freezed_annotation.dart';
import 'lat_lng_point_model.dart';

part 'site_boundary_model.freezed.dart';
part 'site_boundary_model.g.dart';

@freezed
abstract class SiteBoundaryModel with _$SiteBoundaryModel {
  const factory SiteBoundaryModel({
    required String siteId,
    required String siteName,
    @Default('circle') String boundaryType,
    double? centerLat,
    double? centerLng,
    @Default(150.0) double radiusMeters,
    @Default([]) List<LatLngPointModel> boundaryCoordinates,
    String? projectId,
    String? projectName,
    @Default('active') String status,
    @Default(0) int workerCount,
    @Default(0) int assignmentCount,
  }) = _SiteBoundaryModel;

  factory SiteBoundaryModel.fromJson(Map<String, dynamic> json) =>
      _$SiteBoundaryModelFromJson(json);
}
