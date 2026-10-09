// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerVisitModel _$CustomerVisitModelFromJson(
  Map<String, dynamic> json,
) => CustomerVisitModel(
  id: json['id'] as String?,
  customerId: json['customerId'] as String?,
  customerName: json['customerName'] as String?,
  title: json['title'] as String?,
  visitDate: json['visitDate'] as String?,
  visitTime: json['visitTime'] as String?,
  attendees:
      (json['attendees'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  logs:
      (json['logs'] as List<dynamic>?)
          ?.map((e) => VisitChangeLogModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  documentName: json['documentName'] as String?,
  documentUrl: json['documentUrl'] as String?,
  planDocumentName: json['planDocumentName'] as String?,
  planDocumentUrl: json['planDocumentUrl'] as String?,
  outcomeDocumentName: json['outcomeDocumentName'] as String?,
  outcomeDocumentUrl: json['outcomeDocumentUrl'] as String?,
  notes: json['notes'] as String?,
  outcome: json['outcome'] as String?,
  createdBy: json['createdBy'] as String?,
  createdByName: json['createdByName'] as String?,
  status: json['status'] as String? ?? 'scheduled',
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$CustomerVisitModelToJson(CustomerVisitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'title': instance.title,
      'visitDate': instance.visitDate,
      'visitTime': instance.visitTime,
      'attendees': instance.attendees,
      'logs': instance.logs,
      'documentName': instance.documentName,
      'documentUrl': instance.documentUrl,
      'planDocumentName': instance.planDocumentName,
      'planDocumentUrl': instance.planDocumentUrl,
      'outcomeDocumentName': instance.outcomeDocumentName,
      'outcomeDocumentUrl': instance.outcomeDocumentUrl,
      'notes': instance.notes,
      'outcome': instance.outcome,
      'createdBy': instance.createdBy,
      'createdByName': instance.createdByName,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };

VisitChangeLogModel _$VisitChangeLogModelFromJson(Map<String, dynamic> json) =>
    VisitChangeLogModel(
      action: json['action'] as String?,
      actorName: json['actorName'] as String?,
      timestamp: json['timestamp'] as String?,
      details: json['details'] as String?,
      reason: json['reason'] as String?,
      previousDate: json['previousDate'] as String?,
      newDate: json['newDate'] as String?,
      previousTime: json['previousTime'] as String?,
      newTime: json['newTime'] as String?,
    );

Map<String, dynamic> _$VisitChangeLogModelToJson(
  VisitChangeLogModel instance,
) => <String, dynamic>{
  'action': instance.action,
  'actorName': instance.actorName,
  'timestamp': instance.timestamp,
  'details': instance.details,
  'reason': instance.reason,
  'previousDate': instance.previousDate,
  'newDate': instance.newDate,
  'previousTime': instance.previousTime,
  'newTime': instance.newTime,
};

CustomerVisitsResponseModel _$CustomerVisitsResponseModelFromJson(
  Map<String, dynamic> json,
) => CustomerVisitsResponseModel(
  value: json['value'] == null
      ? null
      : CustomerVisitsPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$CustomerVisitsResponseModelToJson(
  CustomerVisitsResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'errors': instance.errors,
};

CustomerVisitsPageModel _$CustomerVisitsPageModelFromJson(
  Map<String, dynamic> json,
) => CustomerVisitsPageModel(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => CustomerVisitModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => CustomerVisitModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$CustomerVisitsPageModelToJson(
  CustomerVisitsPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'data': instance.data,
  'totalCount': instance.totalCount,
};

SingleCustomerVisitResponseModel _$SingleCustomerVisitResponseModelFromJson(
  Map<String, dynamic> json,
) => SingleCustomerVisitResponseModel(
  value: json['value'] == null
      ? null
      : CustomerVisitModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SingleCustomerVisitResponseModelToJson(
  SingleCustomerVisitResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'errors': instance.errors,
};
