import 'package:json_annotation/json_annotation.dart';

part 'customer_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerRequestModel {
  const CustomerRequestModel({
    required this.name,
    required this.location,
    required this.customerType,
    this.workesAs = '',
    this.coordinates = const [],
  });

  final String name;
  final String workesAs;
  final String location;
  final String customerType;
  final List<CustomerCoordinateModel> coordinates;

  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestModelToJson(this);
}

@JsonSerializable()
class CustomerCoordinateModel {
  const CustomerCoordinateModel({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory CustomerCoordinateModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerCoordinateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerCoordinateModelToJson(this);
}
