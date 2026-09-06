// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchRequestModel _$BranchRequestModelFromJson(Map<String, dynamic> json) =>
    BranchRequestModel(
      name: json['name'] as String,
      location: json['location'] as String,
      description: json['description'] as String,
      coordinates:
          (json['coordinates'] as List<dynamic>?)
              ?.map(
                (e) =>
                    BranchCoordinateModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BranchRequestModelToJson(BranchRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'location': instance.location,
      'description': instance.description,
      'coordinates': instance.coordinates.map((e) => e.toJson()).toList(),
    };

BranchCoordinateModel _$BranchCoordinateModelFromJson(
  Map<String, dynamic> json,
) => BranchCoordinateModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$BranchCoordinateModelToJson(
  BranchCoordinateModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
