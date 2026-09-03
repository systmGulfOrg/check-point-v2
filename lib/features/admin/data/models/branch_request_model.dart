import 'package:json_annotation/json_annotation.dart';

part 'branch_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BranchRequestModel {
  const BranchRequestModel({
    required this.name,
    required this.location,
    required this.description,
    required this.coordinates,
  });
  final String name;
  final String location;
  final String description;
  final List<BranchCoordinateModel> coordinates;
  factory BranchRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BranchRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchRequestModelToJson(this);
}

@JsonSerializable()
class BranchCoordinateModel {
  const BranchCoordinateModel({
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;
  factory BranchCoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$BranchCoordinateModelFromJson(json);
  Map<String, dynamic> toJson() => _$BranchCoordinateModelToJson(this);
}
