// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contractor_company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContractorCompanyModel _$ContractorCompanyModelFromJson(
  Map<String, dynamic> json,
) {
  return _ContractorCompanyModel.fromJson(json);
}

/// @nodoc
mixin _$ContractorCompanyModel {
  String get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get taxNumber => throw _privateConstructorUsedError;
  String? get commercialReg => throw _privateConstructorUsedError;
  String? get contactName => throw _privateConstructorUsedError;
  String? get contactPhone => throw _privateConstructorUsedError;
  String? get contactEmail => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  int get workerCount => throw _privateConstructorUsedError;
  int get presentCount => throw _privateConstructorUsedError;

  /// Serializes this ContractorCompanyModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContractorCompanyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContractorCompanyModelCopyWith<ContractorCompanyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractorCompanyModelCopyWith<$Res> {
  factory $ContractorCompanyModelCopyWith(
    ContractorCompanyModel value,
    $Res Function(ContractorCompanyModel) then,
  ) = _$ContractorCompanyModelCopyWithImpl<$Res, ContractorCompanyModel>;
  @useResult
  $Res call({
    String id,
    String code,
    String name,
    String? taxNumber,
    String? commercialReg,
    String? contactName,
    String? contactPhone,
    String? contactEmail,
    String status,
    int workerCount,
    int presentCount,
  });
}

/// @nodoc
class _$ContractorCompanyModelCopyWithImpl<
  $Res,
  $Val extends ContractorCompanyModel
>
    implements $ContractorCompanyModelCopyWith<$Res> {
  _$ContractorCompanyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContractorCompanyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? taxNumber = freezed,
    Object? commercialReg = freezed,
    Object? contactName = freezed,
    Object? contactPhone = freezed,
    Object? contactEmail = freezed,
    Object? status = null,
    Object? workerCount = null,
    Object? presentCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            taxNumber: freezed == taxNumber
                ? _value.taxNumber
                : taxNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            commercialReg: freezed == commercialReg
                ? _value.commercialReg
                : commercialReg // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactName: freezed == contactName
                ? _value.contactName
                : contactName // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactPhone: freezed == contactPhone
                ? _value.contactPhone
                : contactPhone // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactEmail: freezed == contactEmail
                ? _value.contactEmail
                : contactEmail // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            workerCount: null == workerCount
                ? _value.workerCount
                : workerCount // ignore: cast_nullable_to_non_nullable
                      as int,
            presentCount: null == presentCount
                ? _value.presentCount
                : presentCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContractorCompanyModelImplCopyWith<$Res>
    implements $ContractorCompanyModelCopyWith<$Res> {
  factory _$$ContractorCompanyModelImplCopyWith(
    _$ContractorCompanyModelImpl value,
    $Res Function(_$ContractorCompanyModelImpl) then,
  ) = __$$ContractorCompanyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String code,
    String name,
    String? taxNumber,
    String? commercialReg,
    String? contactName,
    String? contactPhone,
    String? contactEmail,
    String status,
    int workerCount,
    int presentCount,
  });
}

/// @nodoc
class __$$ContractorCompanyModelImplCopyWithImpl<$Res>
    extends
        _$ContractorCompanyModelCopyWithImpl<$Res, _$ContractorCompanyModelImpl>
    implements _$$ContractorCompanyModelImplCopyWith<$Res> {
  __$$ContractorCompanyModelImplCopyWithImpl(
    _$ContractorCompanyModelImpl _value,
    $Res Function(_$ContractorCompanyModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContractorCompanyModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? name = null,
    Object? taxNumber = freezed,
    Object? commercialReg = freezed,
    Object? contactName = freezed,
    Object? contactPhone = freezed,
    Object? contactEmail = freezed,
    Object? status = null,
    Object? workerCount = null,
    Object? presentCount = null,
  }) {
    return _then(
      _$ContractorCompanyModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        taxNumber: freezed == taxNumber
            ? _value.taxNumber
            : taxNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        commercialReg: freezed == commercialReg
            ? _value.commercialReg
            : commercialReg // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactName: freezed == contactName
            ? _value.contactName
            : contactName // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactPhone: freezed == contactPhone
            ? _value.contactPhone
            : contactPhone // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactEmail: freezed == contactEmail
            ? _value.contactEmail
            : contactEmail // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        workerCount: null == workerCount
            ? _value.workerCount
            : workerCount // ignore: cast_nullable_to_non_nullable
                  as int,
        presentCount: null == presentCount
            ? _value.presentCount
            : presentCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractorCompanyModelImpl implements _ContractorCompanyModel {
  const _$ContractorCompanyModelImpl({
    required this.id,
    required this.code,
    required this.name,
    this.taxNumber,
    this.commercialReg,
    this.contactName,
    this.contactPhone,
    this.contactEmail,
    this.status = 'active',
    this.workerCount = 0,
    this.presentCount = 0,
  });

  factory _$ContractorCompanyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractorCompanyModelImplFromJson(json);

  @override
  final String id;
  @override
  final String code;
  @override
  final String name;
  @override
  final String? taxNumber;
  @override
  final String? commercialReg;
  @override
  final String? contactName;
  @override
  final String? contactPhone;
  @override
  final String? contactEmail;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final int workerCount;
  @override
  @JsonKey()
  final int presentCount;

  @override
  String toString() {
    return 'ContractorCompanyModel(id: $id, code: $code, name: $name, taxNumber: $taxNumber, commercialReg: $commercialReg, contactName: $contactName, contactPhone: $contactPhone, contactEmail: $contactEmail, status: $status, workerCount: $workerCount, presentCount: $presentCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractorCompanyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.taxNumber, taxNumber) ||
                other.taxNumber == taxNumber) &&
            (identical(other.commercialReg, commercialReg) ||
                other.commercialReg == commercialReg) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.contactPhone, contactPhone) ||
                other.contactPhone == contactPhone) &&
            (identical(other.contactEmail, contactEmail) ||
                other.contactEmail == contactEmail) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workerCount, workerCount) ||
                other.workerCount == workerCount) &&
            (identical(other.presentCount, presentCount) ||
                other.presentCount == presentCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    code,
    name,
    taxNumber,
    commercialReg,
    contactName,
    contactPhone,
    contactEmail,
    status,
    workerCount,
    presentCount,
  );

  /// Create a copy of ContractorCompanyModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractorCompanyModelImplCopyWith<_$ContractorCompanyModelImpl>
  get copyWith =>
      __$$ContractorCompanyModelImplCopyWithImpl<_$ContractorCompanyModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractorCompanyModelImplToJson(this);
  }
}

abstract class _ContractorCompanyModel implements ContractorCompanyModel {
  const factory _ContractorCompanyModel({
    required final String id,
    required final String code,
    required final String name,
    final String? taxNumber,
    final String? commercialReg,
    final String? contactName,
    final String? contactPhone,
    final String? contactEmail,
    final String status,
    final int workerCount,
    final int presentCount,
  }) = _$ContractorCompanyModelImpl;

  factory _ContractorCompanyModel.fromJson(Map<String, dynamic> json) =
      _$ContractorCompanyModelImpl.fromJson;

  @override
  String get id;
  @override
  String get code;
  @override
  String get name;
  @override
  String? get taxNumber;
  @override
  String? get commercialReg;
  @override
  String? get contactName;
  @override
  String? get contactPhone;
  @override
  String? get contactEmail;
  @override
  String get status;
  @override
  int get workerCount;
  @override
  int get presentCount;

  /// Create a copy of ContractorCompanyModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractorCompanyModelImplCopyWith<_$ContractorCompanyModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
