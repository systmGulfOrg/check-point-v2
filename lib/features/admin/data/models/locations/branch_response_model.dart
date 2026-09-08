import 'package:json_annotation/json_annotation.dart';

import 'branch_request_model.dart';

part 'branch_response_model.g.dart';

@JsonSerializable(createToJson: false)
class BranchResponseModel {
  const BranchResponseModel({this.value, this.isSuccess, this.errors});

  final BranchPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory BranchResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BranchResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class BranchPageModel {
  const BranchPageModel({this.items, this.data, this.totalCount});

  final List<BranchModel>? items;
  final List<BranchModel>? data;
  final int? totalCount;

  List<BranchModel> get list => items ?? data ?? const [];

  factory BranchPageModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      return BranchPageModel(
        items: [BranchModel.fromJson(json)],
        totalCount: 1,
      );
    }
    return _$BranchPageModelFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class BranchModel {
  const BranchModel({
    this.id,
    this.name,
    this.location,
    this.description,
    this.coordinates,
  });

  final int? id;
  final String? name;
  final String? location;
  final String? description;
  final List<BranchCoordinateModel>? coordinates;

  factory BranchModel.fromJson(Map<String, dynamic> json) =>
      _$BranchModelFromJson(json);
}
