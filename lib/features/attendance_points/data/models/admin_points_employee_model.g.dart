// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_points_employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminPointsDepartmentModelImpl _$$AdminPointsDepartmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AdminPointsDepartmentModelImpl(
  id: json['id'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$$AdminPointsDepartmentModelImplToJson(
  _$AdminPointsDepartmentModelImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$AdminPointsEmployeeModelImpl _$$AdminPointsEmployeeModelImplFromJson(
  Map<String, dynamic> json,
) => _$AdminPointsEmployeeModelImpl(
  id: json['id'] as String,
  name: json['name'] as String?,
  employeeCode: json['employeeCode'] as String?,
  position: json['position'] as String?,
  department: json['department'] == null
      ? null
      : AdminPointsDepartmentModel.fromJson(
          json['department'] as Map<String, dynamic>,
        ),
  balances: json['balances'] == null
      ? const PointsBalancesModel()
      : PointsBalancesModel.fromJson(json['balances'] as Map<String, dynamic>),
  level: json['level'] == null
      ? const PointsLevelModel()
      : PointsLevelModel.fromJson(json['level'] as Map<String, dynamic>),
  streak: json['streak'] == null
      ? const PointsStreakModel()
      : PointsStreakModel.fromJson(json['streak'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AdminPointsEmployeeModelImplToJson(
  _$AdminPointsEmployeeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'employeeCode': instance.employeeCode,
  'position': instance.position,
  'department': instance.department,
  'balances': instance.balances,
  'level': instance.level,
  'streak': instance.streak,
};

_$AdminPointsEmployeesPageModelImpl
_$$AdminPointsEmployeesPageModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminPointsEmployeesPageModelImpl(
      items:
          (json['items'] as List<dynamic>?)
              ?.map(
                (e) => AdminPointsEmployeeModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const <AdminPointsEmployeeModel>[],
      totalCount: (json['totalCount'] as num?)?.toInt(),
      index: (json['index'] as num?)?.toInt(),
      itemCount: (json['itemCount'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      hasNext: json['hasNext'] as bool?,
      hasPrevious: json['hasPrevious'] as bool?,
    );

Map<String, dynamic> _$$AdminPointsEmployeesPageModelImplToJson(
  _$AdminPointsEmployeesPageModelImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
  'index': instance.index,
  'itemCount': instance.itemCount,
  'totalPages': instance.totalPages,
  'hasNext': instance.hasNext,
  'hasPrevious': instance.hasPrevious,
};

_$AdminPointsEmployeesResponseModelImpl
_$$AdminPointsEmployeesResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$AdminPointsEmployeesResponseModelImpl(
      value: json['value'] == null
          ? null
          : AdminPointsEmployeesPageModel.fromJson(
              json['value'] as Map<String, dynamic>,
            ),
      isSuccess: json['isSuccess'] as bool?,
      successMessage: json['successMessage'] as String?,
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AdminPointsEmployeesResponseModelImplToJson(
  _$AdminPointsEmployeesResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
