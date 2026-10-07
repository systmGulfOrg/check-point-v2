import 'package:json_annotation/json_annotation.dart';
import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'customer_visit_model.g.dart';

@JsonSerializable()
class CustomerVisitModel {
  const CustomerVisitModel({
    this.id,
    this.customerId,
    this.customerName,
    this.title,
    this.visitDate,
    this.visitTime,
    this.attendees = const [],
    this.documentName,
    this.documentUrl,
    this.planDocumentName,
    this.planDocumentUrl,
    this.outcomeDocumentName,
    this.outcomeDocumentUrl,
    this.notes,
    this.outcome,
    this.createdBy,
    this.createdByName,
    this.status = 'scheduled',
    this.createdAt,
  });

  final String? id;
  final String? customerId;
  final String? customerName;
  final String? title;
  final String? visitDate;
  final String? visitTime;
  @JsonKey(defaultValue: [])
  final List<String> attendees;
  final String? documentName;
  final String? documentUrl;
  final String? planDocumentName;
  final String? planDocumentUrl;
  final String? outcomeDocumentName;
  final String? outcomeDocumentUrl;
  final String? notes;
  final String? outcome;
  final String? createdBy;
  final String? createdByName;
  @JsonKey(defaultValue: 'scheduled')
  final String status;
  final String? createdAt;

  factory CustomerVisitModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerVisitModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerVisitModelToJson(this);

  CustomerVisitModel copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? title,
    String? visitDate,
    String? visitTime,
    List<String>? attendees,
    String? documentName,
    String? documentUrl,
    String? planDocumentName,
    String? planDocumentUrl,
    String? outcomeDocumentName,
    String? outcomeDocumentUrl,
    String? notes,
    String? outcome,
    String? createdBy,
    String? createdByName,
    String? status,
    String? createdAt,
  }) {
    return CustomerVisitModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      title: title ?? this.title,
      visitDate: visitDate ?? this.visitDate,
      visitTime: visitTime ?? this.visitTime,
      attendees: attendees ?? this.attendees,
      documentName: documentName ?? this.documentName,
      documentUrl: documentUrl ?? this.documentUrl,
      planDocumentName: planDocumentName ?? this.planDocumentName,
      planDocumentUrl: planDocumentUrl ?? this.planDocumentUrl,
      outcomeDocumentName: outcomeDocumentName ?? this.outcomeDocumentName,
      outcomeDocumentUrl: outcomeDocumentUrl ?? this.outcomeDocumentUrl,
      notes: notes ?? this.notes,
      outcome: outcome ?? this.outcome,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@JsonSerializable()
class CustomerVisitsResponseModel {
  const CustomerVisitsResponseModel({this.value, this.isSuccess, this.errors});

  final CustomerVisitsPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory CustomerVisitsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerVisitsResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });

  Map<String, dynamic> toJson() => _$CustomerVisitsResponseModelToJson(this);
}

@JsonSerializable()
class CustomerVisitsPageModel {
  const CustomerVisitsPageModel({this.items, this.data, this.totalCount});

  final List<CustomerVisitModel>? items;
  final List<CustomerVisitModel>? data;
  final int? totalCount;

  List<CustomerVisitModel> get list => items ?? data ?? const [];

  factory CustomerVisitsPageModel.fromJson(Map<String, dynamic> json) =>
      _$CustomerVisitsPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerVisitsPageModelToJson(this);
}

@JsonSerializable()
class SingleCustomerVisitResponseModel {
  const SingleCustomerVisitResponseModel({
    this.value,
    this.isSuccess,
    this.errors,
  });

  final CustomerVisitModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory SingleCustomerVisitResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$SingleCustomerVisitResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SingleCustomerVisitResponseModelToJson(this);
}

