import 'package:json_annotation/json_annotation.dart';

import 'customer_request_model.dart';

part 'customer_response_model.g.dart';

@JsonSerializable(createToJson: false)
class CustomerResponseModel {
  const CustomerResponseModel({this.value, this.isSuccess, this.errors});

  final CustomerPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory CustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class CustomerPageModel {
  const CustomerPageModel({this.items, this.data, this.totalCount});

  final List<CustomerModel>? items;
  final List<CustomerModel>? data;
  final int? totalCount;

  List<CustomerModel> get list => items ?? data ?? const [];

  factory CustomerPageModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerPageModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class CustomerModel {
  const CustomerModel({
    this.id,
    this.name,
    this.workesAs,
    this.location,
    this.customerType,
    this.coordinates,
  });

  final String? id;
  final String? name;
  final String? workesAs;
  final String? location;
  final String? customerType;
  final List<CustomerCoordinateModel>? coordinates;

  factory CustomerModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerModelFromJson(json);
}
