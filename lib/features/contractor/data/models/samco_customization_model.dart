import 'package:freezed_annotation/freezed_annotation.dart';

part 'samco_customization_model.freezed.dart';
part 'samco_customization_model.g.dart';

@freezed
abstract class SamcoCustomizationModel with _$SamcoCustomizationModel {
  const factory SamcoCustomizationModel({
    @Default('Worker') String workerLabel,
    @Default('Workers') String workersLabel,
    @Default('Site') String siteLabel,
    @Default('Sites') String sitesLabel,
    @Default('Contractor') String contractorLabel,
    @Default('Contractors') String contractorsLabel,
    @Default('Project') String projectLabel,
    @Default('Projects') String projectsLabel,
    @Default(true) bool enablePolygonGeofence,
    @Default(true) bool enableDeviceBinding,
  }) = _SamcoCustomizationModel;

  factory SamcoCustomizationModel.fromJson(Map<String, dynamic> json) =>
      _$SamcoCustomizationModelFromJson(json);
}
