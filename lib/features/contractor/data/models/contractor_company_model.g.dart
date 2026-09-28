// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contractor_company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContractorCompanyModelImpl _$$ContractorCompanyModelImplFromJson(
  Map<String, dynamic> json,
) => _$ContractorCompanyModelImpl(
  id: json['id'] as String,
  code: json['code'] as String,
  name: json['name'] as String,
  taxNumber: json['taxNumber'] as String?,
  commercialReg: json['commercialReg'] as String?,
  contactName: json['contactName'] as String?,
  contactPhone: json['contactPhone'] as String?,
  contactEmail: json['contactEmail'] as String?,
  status: json['status'] as String? ?? 'active',
  workerCount: (json['workerCount'] as num?)?.toInt() ?? 0,
  presentCount: (json['presentCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ContractorCompanyModelImplToJson(
  _$ContractorCompanyModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'code': instance.code,
  'name': instance.name,
  'taxNumber': instance.taxNumber,
  'commercialReg': instance.commercialReg,
  'contactName': instance.contactName,
  'contactPhone': instance.contactPhone,
  'contactEmail': instance.contactEmail,
  'status': instance.status,
  'workerCount': instance.workerCount,
  'presentCount': instance.presentCount,
};
