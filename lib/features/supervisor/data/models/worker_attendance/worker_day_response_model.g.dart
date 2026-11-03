// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_day_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerDayResponseModel _$WorkerDayResponseModelFromJson(
  Map<String, dynamic> json,
) => WorkerDayResponseModel(
  value: json['value'] == null
      ? null
      : WorkerDayPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

WorkerDayPageModel _$WorkerDayPageModelFromJson(Map<String, dynamic> json) =>
    WorkerDayPageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => WorkerDayItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

WorkerDayItemModel _$WorkerDayItemModelFromJson(Map<String, dynamic> json) =>
    WorkerDayItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      employeeCode: json['employeeCode'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String?,
      contractor: json['contractor'] == null
          ? null
          : WorkerContractorModel.fromJson(
              json['contractor'] as Map<String, dynamic>,
            ),
      attendance: json['attendance'] == null
          ? null
          : WorkerAttendanceSummaryModel.fromJson(
              json['attendance'] as Map<String, dynamic>,
            ),
    );

WorkerContractorModel _$WorkerContractorModelFromJson(
  Map<String, dynamic> json,
) => WorkerContractorModel(
  id: json['id'] as String,
  name: json['name'] as String,
);

WorkerAttendanceSummaryModel _$WorkerAttendanceSummaryModelFromJson(
  Map<String, dynamic> json,
) => WorkerAttendanceSummaryModel(
  id: json['id'] as String?,
  siteId: json['siteId'] as String?,
  siteName: json['siteName'] as String?,
  clockInTime: json['clockInTime'] as String?,
  clockOutTime: json['clockOutTime'] as String?,
);
