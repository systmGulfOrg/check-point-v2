// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRequestModel _$CustomerRequestModelFromJson(
  Map<String, dynamic> json,
) => CustomerRequestModel(
  name: json['name'] as String,
  location: json['location'] as String,
  customerType: json['customerType'] as String,
  workesAs: json['workesAs'] as String? ?? '',
  coordinates:
      (json['coordinates'] as List<dynamic>?)
          ?.map(
            (e) => CustomerCoordinateModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$CustomerRequestModelToJson(
  CustomerRequestModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'workesAs': instance.workesAs,
  'location': instance.location,
  'customerType': instance.customerType,
  'coordinates': instance.coordinates.map((e) => e.toJson()).toList(),
};

CustomerCoordinateModel _$CustomerCoordinateModelFromJson(
  Map<String, dynamic> json,
) => CustomerCoordinateModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$CustomerCoordinateModelToJson(
  CustomerCoordinateModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
