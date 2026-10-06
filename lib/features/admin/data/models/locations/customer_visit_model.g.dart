// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_visit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerVisitModel _$CustomerVisitModelFromJson(Map<String, dynamic> json) =>
    CustomerVisitModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      title: json['title'] as String?,
      visitDate: json['visitDate'] as String?,
      visitTime: json['visitTime'] as String?,
      attendees:
          (json['attendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      documentName: json['documentName'] as String?,
      documentUrl: json['documentUrl'] as String?,
      notes: json['notes'] as String?,
      outcome: json['outcome'] as String?,
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
      'documentName': instance.documentName,
      'documentUrl': instance.documentUrl,
      'notes': instance.notes,
      'outcome': instance.outcome,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
