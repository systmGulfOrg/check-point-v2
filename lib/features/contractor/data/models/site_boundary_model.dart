// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';
import 'lat_lng_point_model.dart';

part 'site_boundary_model.freezed.dart';
part 'site_boundary_model.g.dart';

@freezed
class SiteBoundaryModel with _$SiteBoundaryModel {
  const SiteBoundaryModel._();

  const factory SiteBoundaryModel({
    @JsonKey(name: 'site_id') String? siteIdUnderscore,
    @JsonKey(name: 'siteId') String? siteIdCamel,
    @JsonKey(name: 'site_name') String? siteNameUnderscore,
    @JsonKey(name: 'siteName') String? siteNameCamel,
    @JsonKey(name: 'boundary_type') @Default('polygon') String boundaryType,
    @JsonKey(name: 'center_lat') double? centerLat,
    @JsonKey(name: 'center_lng') double? centerLng,
    @JsonKey(name: 'radius_meters') @Default(250.0) double radiusMeters,
    @JsonKey(name: 'boundary_coordinates') @Default([]) List<LatLngPointModel> boundaryCoordinates,
    String? projectId,
    String? projectName,
    @Default('active') String status,
    @Default(0) int workerCount,
    @Default(0) int assignmentCount,
  }) = _SiteBoundaryModel;

  factory SiteBoundaryModel.fromJson(Map<String, dynamic> json) =>
      _$SiteBoundaryModelFromJson(json);

  String get siteId => siteIdUnderscore ?? siteIdCamel ?? '';
  String get siteName => siteNameUnderscore ?? siteNameCamel ?? '';
}
