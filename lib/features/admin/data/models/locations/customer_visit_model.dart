import 'package:json_annotation/json_annotation.dart';

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
    this.notes,
    this.outcome,
    this.status = 'scheduled',
    this.createdAt,
  });

  final String? id;
  final String? customerId;
  final String? customerName;
  final String? title;
  final String? visitDate;
  final String? visitTime;
  final List<String> attendees;
  final String? documentName;
  final String? documentUrl;
  final String? notes;
  final String? outcome;
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
    String? notes,
    String? outcome,
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
      notes: notes ?? this.notes,
      outcome: outcome ?? this.outcome,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
