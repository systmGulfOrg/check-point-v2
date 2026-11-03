import 'package:json_annotation/json_annotation.dart';

part 'worker_day_response_model.g.dart';

@JsonSerializable(createToJson: false)
class WorkerDayResponseModel {
  const WorkerDayResponseModel({this.value, this.isSuccess, this.errors});

  final WorkerDayPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory WorkerDayResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerDayResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorkerDayPageModel {
  const WorkerDayPageModel({this.items, this.total});

  final List<WorkerDayItemModel>? items;
  final int? total;

  factory WorkerDayPageModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerDayPageModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorkerDayItemModel {
  const WorkerDayItemModel({
    required this.id,
    required this.name,
    this.employeeCode,
    this.isActive = true,
    this.imageUrl,
    this.contractor,
    this.attendance,
  });

  final String id;
  final String name;
  final String? employeeCode;
  final bool isActive;
  final String? imageUrl;
  final WorkerContractorModel? contractor;
  final WorkerAttendanceSummaryModel? attendance;

  factory WorkerDayItemModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerDayItemModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorkerContractorModel {
  const WorkerContractorModel({required this.id, required this.name});

  final String id;
  final String name;

  factory WorkerContractorModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerContractorModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class WorkerAttendanceSummaryModel {
  const WorkerAttendanceSummaryModel({
    this.id,
    this.siteId,
    this.siteName,
    this.clockInTime,
    this.clockOutTime,
  });

  final String? id;
  final String? siteId;
  final String? siteName;
  final String? clockInTime;
  final String? clockOutTime;

  factory WorkerAttendanceSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$WorkerAttendanceSummaryModelFromJson(json);
}
