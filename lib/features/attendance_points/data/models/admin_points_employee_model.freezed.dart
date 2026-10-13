// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_points_employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminPointsDepartmentModel _$AdminPointsDepartmentModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPointsDepartmentModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPointsDepartmentModel {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this AdminPointsDepartmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPointsDepartmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPointsDepartmentModelCopyWith<AdminPointsDepartmentModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPointsDepartmentModelCopyWith<$Res> {
  factory $AdminPointsDepartmentModelCopyWith(
    AdminPointsDepartmentModel value,
    $Res Function(AdminPointsDepartmentModel) then,
  ) =
      _$AdminPointsDepartmentModelCopyWithImpl<
        $Res,
        AdminPointsDepartmentModel
      >;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$AdminPointsDepartmentModelCopyWithImpl<
  $Res,
  $Val extends AdminPointsDepartmentModel
>
    implements $AdminPointsDepartmentModelCopyWith<$Res> {
  _$AdminPointsDepartmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPointsDepartmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? name = freezed}) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminPointsDepartmentModelImplCopyWith<$Res>
    implements $AdminPointsDepartmentModelCopyWith<$Res> {
  factory _$$AdminPointsDepartmentModelImplCopyWith(
    _$AdminPointsDepartmentModelImpl value,
    $Res Function(_$AdminPointsDepartmentModelImpl) then,
  ) = __$$AdminPointsDepartmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$AdminPointsDepartmentModelImplCopyWithImpl<$Res>
    extends
        _$AdminPointsDepartmentModelCopyWithImpl<
          $Res,
          _$AdminPointsDepartmentModelImpl
        >
    implements _$$AdminPointsDepartmentModelImplCopyWith<$Res> {
  __$$AdminPointsDepartmentModelImplCopyWithImpl(
    _$AdminPointsDepartmentModelImpl _value,
    $Res Function(_$AdminPointsDepartmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPointsDepartmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = freezed, Object? name = freezed}) {
    return _then(
      _$AdminPointsDepartmentModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPointsDepartmentModelImpl implements _AdminPointsDepartmentModel {
  const _$AdminPointsDepartmentModelImpl({this.id, this.name});

  factory _$AdminPointsDepartmentModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminPointsDepartmentModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'AdminPointsDepartmentModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPointsDepartmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of AdminPointsDepartmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPointsDepartmentModelImplCopyWith<_$AdminPointsDepartmentModelImpl>
  get copyWith =>
      __$$AdminPointsDepartmentModelImplCopyWithImpl<
        _$AdminPointsDepartmentModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPointsDepartmentModelImplToJson(this);
  }
}

abstract class _AdminPointsDepartmentModel
    implements AdminPointsDepartmentModel {
  const factory _AdminPointsDepartmentModel({
    final String? id,
    final String? name,
  }) = _$AdminPointsDepartmentModelImpl;

  factory _AdminPointsDepartmentModel.fromJson(Map<String, dynamic> json) =
      _$AdminPointsDepartmentModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;

  /// Create a copy of AdminPointsDepartmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPointsDepartmentModelImplCopyWith<_$AdminPointsDepartmentModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AdminPointsEmployeeModel _$AdminPointsEmployeeModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPointsEmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPointsEmployeeModel {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get employeeCode => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  AdminPointsDepartmentModel? get department =>
      throw _privateConstructorUsedError;
  PointsBalancesModel get balances => throw _privateConstructorUsedError;
  PointsLevelModel get level => throw _privateConstructorUsedError;
  PointsStreakModel get streak => throw _privateConstructorUsedError;

  /// Serializes this AdminPointsEmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPointsEmployeeModelCopyWith<AdminPointsEmployeeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPointsEmployeeModelCopyWith<$Res> {
  factory $AdminPointsEmployeeModelCopyWith(
    AdminPointsEmployeeModel value,
    $Res Function(AdminPointsEmployeeModel) then,
  ) = _$AdminPointsEmployeeModelCopyWithImpl<$Res, AdminPointsEmployeeModel>;
  @useResult
  $Res call({
    String id,
    String? name,
    String? employeeCode,
    String? position,
    AdminPointsDepartmentModel? department,
    PointsBalancesModel balances,
    PointsLevelModel level,
    PointsStreakModel streak,
  });

  $AdminPointsDepartmentModelCopyWith<$Res>? get department;
  $PointsBalancesModelCopyWith<$Res> get balances;
  $PointsLevelModelCopyWith<$Res> get level;
  $PointsStreakModelCopyWith<$Res> get streak;
}

/// @nodoc
class _$AdminPointsEmployeeModelCopyWithImpl<
  $Res,
  $Val extends AdminPointsEmployeeModel
>
    implements $AdminPointsEmployeeModelCopyWith<$Res> {
  _$AdminPointsEmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? employeeCode = freezed,
    Object? position = freezed,
    Object? department = freezed,
    Object? balances = null,
    Object? level = null,
    Object? streak = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeCode: freezed == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as AdminPointsDepartmentModel?,
            balances: null == balances
                ? _value.balances
                : balances // ignore: cast_nullable_to_non_nullable
                      as PointsBalancesModel,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as PointsLevelModel,
            streak: null == streak
                ? _value.streak
                : streak // ignore: cast_nullable_to_non_nullable
                      as PointsStreakModel,
          )
          as $Val,
    );
  }

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminPointsDepartmentModelCopyWith<$Res>? get department {
    if (_value.department == null) {
      return null;
    }

    return $AdminPointsDepartmentModelCopyWith<$Res>(_value.department!, (
      value,
    ) {
      return _then(_value.copyWith(department: value) as $Val);
    });
  }

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsBalancesModelCopyWith<$Res> get balances {
    return $PointsBalancesModelCopyWith<$Res>(_value.balances, (value) {
      return _then(_value.copyWith(balances: value) as $Val);
    });
  }

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsLevelModelCopyWith<$Res> get level {
    return $PointsLevelModelCopyWith<$Res>(_value.level, (value) {
      return _then(_value.copyWith(level: value) as $Val);
    });
  }

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsStreakModelCopyWith<$Res> get streak {
    return $PointsStreakModelCopyWith<$Res>(_value.streak, (value) {
      return _then(_value.copyWith(streak: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminPointsEmployeeModelImplCopyWith<$Res>
    implements $AdminPointsEmployeeModelCopyWith<$Res> {
  factory _$$AdminPointsEmployeeModelImplCopyWith(
    _$AdminPointsEmployeeModelImpl value,
    $Res Function(_$AdminPointsEmployeeModelImpl) then,
  ) = __$$AdminPointsEmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? name,
    String? employeeCode,
    String? position,
    AdminPointsDepartmentModel? department,
    PointsBalancesModel balances,
    PointsLevelModel level,
    PointsStreakModel streak,
  });

  @override
  $AdminPointsDepartmentModelCopyWith<$Res>? get department;
  @override
  $PointsBalancesModelCopyWith<$Res> get balances;
  @override
  $PointsLevelModelCopyWith<$Res> get level;
  @override
  $PointsStreakModelCopyWith<$Res> get streak;
}

/// @nodoc
class __$$AdminPointsEmployeeModelImplCopyWithImpl<$Res>
    extends
        _$AdminPointsEmployeeModelCopyWithImpl<
          $Res,
          _$AdminPointsEmployeeModelImpl
        >
    implements _$$AdminPointsEmployeeModelImplCopyWith<$Res> {
  __$$AdminPointsEmployeeModelImplCopyWithImpl(
    _$AdminPointsEmployeeModelImpl _value,
    $Res Function(_$AdminPointsEmployeeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? employeeCode = freezed,
    Object? position = freezed,
    Object? department = freezed,
    Object? balances = null,
    Object? level = null,
    Object? streak = null,
  }) {
    return _then(
      _$AdminPointsEmployeeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeCode: freezed == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as AdminPointsDepartmentModel?,
        balances: null == balances
            ? _value.balances
            : balances // ignore: cast_nullable_to_non_nullable
                  as PointsBalancesModel,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as PointsLevelModel,
        streak: null == streak
            ? _value.streak
            : streak // ignore: cast_nullable_to_non_nullable
                  as PointsStreakModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPointsEmployeeModelImpl implements _AdminPointsEmployeeModel {
  const _$AdminPointsEmployeeModelImpl({
    required this.id,
    this.name,
    this.employeeCode,
    this.position,
    this.department,
    this.balances = const PointsBalancesModel(),
    this.level = const PointsLevelModel(),
    this.streak = const PointsStreakModel(),
  });

  factory _$AdminPointsEmployeeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminPointsEmployeeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final String? employeeCode;
  @override
  final String? position;
  @override
  final AdminPointsDepartmentModel? department;
  @override
  @JsonKey()
  final PointsBalancesModel balances;
  @override
  @JsonKey()
  final PointsLevelModel level;
  @override
  @JsonKey()
  final PointsStreakModel streak;

  @override
  String toString() {
    return 'AdminPointsEmployeeModel(id: $id, name: $name, employeeCode: $employeeCode, position: $position, department: $department, balances: $balances, level: $level, streak: $streak)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPointsEmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.balances, balances) ||
                other.balances == balances) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.streak, streak) || other.streak == streak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    employeeCode,
    position,
    department,
    balances,
    level,
    streak,
  );

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPointsEmployeeModelImplCopyWith<_$AdminPointsEmployeeModelImpl>
  get copyWith =>
      __$$AdminPointsEmployeeModelImplCopyWithImpl<
        _$AdminPointsEmployeeModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPointsEmployeeModelImplToJson(this);
  }
}

abstract class _AdminPointsEmployeeModel implements AdminPointsEmployeeModel {
  const factory _AdminPointsEmployeeModel({
    required final String id,
    final String? name,
    final String? employeeCode,
    final String? position,
    final AdminPointsDepartmentModel? department,
    final PointsBalancesModel balances,
    final PointsLevelModel level,
    final PointsStreakModel streak,
  }) = _$AdminPointsEmployeeModelImpl;

  factory _AdminPointsEmployeeModel.fromJson(Map<String, dynamic> json) =
      _$AdminPointsEmployeeModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  String? get employeeCode;
  @override
  String? get position;
  @override
  AdminPointsDepartmentModel? get department;
  @override
  PointsBalancesModel get balances;
  @override
  PointsLevelModel get level;
  @override
  PointsStreakModel get streak;

  /// Create a copy of AdminPointsEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPointsEmployeeModelImplCopyWith<_$AdminPointsEmployeeModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AdminPointsEmployeesPageModel _$AdminPointsEmployeesPageModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPointsEmployeesPageModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPointsEmployeesPageModel {
  List<AdminPointsEmployeeModel> get items =>
      throw _privateConstructorUsedError;
  int? get totalCount => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  int? get itemCount => throw _privateConstructorUsedError;
  int? get totalPages => throw _privateConstructorUsedError;
  bool? get hasNext => throw _privateConstructorUsedError;
  bool? get hasPrevious => throw _privateConstructorUsedError;

  /// Serializes this AdminPointsEmployeesPageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPointsEmployeesPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPointsEmployeesPageModelCopyWith<AdminPointsEmployeesPageModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPointsEmployeesPageModelCopyWith<$Res> {
  factory $AdminPointsEmployeesPageModelCopyWith(
    AdminPointsEmployeesPageModel value,
    $Res Function(AdminPointsEmployeesPageModel) then,
  ) =
      _$AdminPointsEmployeesPageModelCopyWithImpl<
        $Res,
        AdminPointsEmployeesPageModel
      >;
  @useResult
  $Res call({
    List<AdminPointsEmployeeModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  });
}

/// @nodoc
class _$AdminPointsEmployeesPageModelCopyWithImpl<
  $Res,
  $Val extends AdminPointsEmployeesPageModel
>
    implements $AdminPointsEmployeesPageModelCopyWith<$Res> {
  _$AdminPointsEmployeesPageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPointsEmployeesPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? index = freezed,
    Object? itemCount = freezed,
    Object? totalPages = freezed,
    Object? hasNext = freezed,
    Object? hasPrevious = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<AdminPointsEmployeeModel>,
            totalCount: freezed == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            index: freezed == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                      as int?,
            itemCount: freezed == itemCount
                ? _value.itemCount
                : itemCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            totalPages: freezed == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int?,
            hasNext: freezed == hasNext
                ? _value.hasNext
                : hasNext // ignore: cast_nullable_to_non_nullable
                      as bool?,
            hasPrevious: freezed == hasPrevious
                ? _value.hasPrevious
                : hasPrevious // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminPointsEmployeesPageModelImplCopyWith<$Res>
    implements $AdminPointsEmployeesPageModelCopyWith<$Res> {
  factory _$$AdminPointsEmployeesPageModelImplCopyWith(
    _$AdminPointsEmployeesPageModelImpl value,
    $Res Function(_$AdminPointsEmployeesPageModelImpl) then,
  ) = __$$AdminPointsEmployeesPageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AdminPointsEmployeeModel> items,
    int? totalCount,
    int? index,
    int? itemCount,
    int? totalPages,
    bool? hasNext,
    bool? hasPrevious,
  });
}

/// @nodoc
class __$$AdminPointsEmployeesPageModelImplCopyWithImpl<$Res>
    extends
        _$AdminPointsEmployeesPageModelCopyWithImpl<
          $Res,
          _$AdminPointsEmployeesPageModelImpl
        >
    implements _$$AdminPointsEmployeesPageModelImplCopyWith<$Res> {
  __$$AdminPointsEmployeesPageModelImplCopyWithImpl(
    _$AdminPointsEmployeesPageModelImpl _value,
    $Res Function(_$AdminPointsEmployeesPageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPointsEmployeesPageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? totalCount = freezed,
    Object? index = freezed,
    Object? itemCount = freezed,
    Object? totalPages = freezed,
    Object? hasNext = freezed,
    Object? hasPrevious = freezed,
  }) {
    return _then(
      _$AdminPointsEmployeesPageModelImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<AdminPointsEmployeeModel>,
        totalCount: freezed == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        index: freezed == index
            ? _value.index
            : index // ignore: cast_nullable_to_non_nullable
                  as int?,
        itemCount: freezed == itemCount
            ? _value.itemCount
            : itemCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        totalPages: freezed == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int?,
        hasNext: freezed == hasNext
            ? _value.hasNext
            : hasNext // ignore: cast_nullable_to_non_nullable
                  as bool?,
        hasPrevious: freezed == hasPrevious
            ? _value.hasPrevious
            : hasPrevious // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPointsEmployeesPageModelImpl
    implements _AdminPointsEmployeesPageModel {
  const _$AdminPointsEmployeesPageModelImpl({
    final List<AdminPointsEmployeeModel> items =
        const <AdminPointsEmployeeModel>[],
    this.totalCount,
    this.index,
    this.itemCount,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
  }) : _items = items;

  factory _$AdminPointsEmployeesPageModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminPointsEmployeesPageModelImplFromJson(json);

  final List<AdminPointsEmployeeModel> _items;
  @override
  @JsonKey()
  List<AdminPointsEmployeeModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int? totalCount;
  @override
  final int? index;
  @override
  final int? itemCount;
  @override
  final int? totalPages;
  @override
  final bool? hasNext;
  @override
  final bool? hasPrevious;

  @override
  String toString() {
    return 'AdminPointsEmployeesPageModel(items: $items, totalCount: $totalCount, index: $index, itemCount: $itemCount, totalPages: $totalPages, hasNext: $hasNext, hasPrevious: $hasPrevious)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPointsEmployeesPageModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.itemCount, itemCount) ||
                other.itemCount == itemCount) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrevious, hasPrevious) ||
                other.hasPrevious == hasPrevious));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    totalCount,
    index,
    itemCount,
    totalPages,
    hasNext,
    hasPrevious,
  );

  /// Create a copy of AdminPointsEmployeesPageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPointsEmployeesPageModelImplCopyWith<
    _$AdminPointsEmployeesPageModelImpl
  >
  get copyWith =>
      __$$AdminPointsEmployeesPageModelImplCopyWithImpl<
        _$AdminPointsEmployeesPageModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPointsEmployeesPageModelImplToJson(this);
  }
}

abstract class _AdminPointsEmployeesPageModel
    implements AdminPointsEmployeesPageModel {
  const factory _AdminPointsEmployeesPageModel({
    final List<AdminPointsEmployeeModel> items,
    final int? totalCount,
    final int? index,
    final int? itemCount,
    final int? totalPages,
    final bool? hasNext,
    final bool? hasPrevious,
  }) = _$AdminPointsEmployeesPageModelImpl;

  factory _AdminPointsEmployeesPageModel.fromJson(Map<String, dynamic> json) =
      _$AdminPointsEmployeesPageModelImpl.fromJson;

  @override
  List<AdminPointsEmployeeModel> get items;
  @override
  int? get totalCount;
  @override
  int? get index;
  @override
  int? get itemCount;
  @override
  int? get totalPages;
  @override
  bool? get hasNext;
  @override
  bool? get hasPrevious;

  /// Create a copy of AdminPointsEmployeesPageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPointsEmployeesPageModelImplCopyWith<
    _$AdminPointsEmployeesPageModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

AdminPointsEmployeesResponseModel _$AdminPointsEmployeesResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPointsEmployeesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPointsEmployeesResponseModel {
  AdminPointsEmployeesPageModel? get value =>
      throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this AdminPointsEmployeesResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPointsEmployeesResponseModelCopyWith<AdminPointsEmployeesResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPointsEmployeesResponseModelCopyWith<$Res> {
  factory $AdminPointsEmployeesResponseModelCopyWith(
    AdminPointsEmployeesResponseModel value,
    $Res Function(AdminPointsEmployeesResponseModel) then,
  ) =
      _$AdminPointsEmployeesResponseModelCopyWithImpl<
        $Res,
        AdminPointsEmployeesResponseModel
      >;
  @useResult
  $Res call({
    AdminPointsEmployeesPageModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  $AdminPointsEmployeesPageModelCopyWith<$Res>? get value;
}

/// @nodoc
class _$AdminPointsEmployeesResponseModelCopyWithImpl<
  $Res,
  $Val extends AdminPointsEmployeesResponseModel
>
    implements $AdminPointsEmployeesResponseModelCopyWith<$Res> {
  _$AdminPointsEmployeesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            value: freezed == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as AdminPointsEmployeesPageModel?,
            isSuccess: freezed == isSuccess
                ? _value.isSuccess
                : isSuccess // ignore: cast_nullable_to_non_nullable
                      as bool?,
            successMessage: freezed == successMessage
                ? _value.successMessage
                : successMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
          )
          as $Val,
    );
  }

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminPointsEmployeesPageModelCopyWith<$Res>? get value {
    if (_value.value == null) {
      return null;
    }

    return $AdminPointsEmployeesPageModelCopyWith<$Res>(_value.value!, (value) {
      return _then(_value.copyWith(value: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminPointsEmployeesResponseModelImplCopyWith<$Res>
    implements $AdminPointsEmployeesResponseModelCopyWith<$Res> {
  factory _$$AdminPointsEmployeesResponseModelImplCopyWith(
    _$AdminPointsEmployeesResponseModelImpl value,
    $Res Function(_$AdminPointsEmployeesResponseModelImpl) then,
  ) = __$$AdminPointsEmployeesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AdminPointsEmployeesPageModel? value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });

  @override
  $AdminPointsEmployeesPageModelCopyWith<$Res>? get value;
}

/// @nodoc
class __$$AdminPointsEmployeesResponseModelImplCopyWithImpl<$Res>
    extends
        _$AdminPointsEmployeesResponseModelCopyWithImpl<
          $Res,
          _$AdminPointsEmployeesResponseModelImpl
        >
    implements _$$AdminPointsEmployeesResponseModelImplCopyWith<$Res> {
  __$$AdminPointsEmployeesResponseModelImplCopyWithImpl(
    _$AdminPointsEmployeesResponseModelImpl _value,
    $Res Function(_$AdminPointsEmployeesResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$AdminPointsEmployeesResponseModelImpl(
        value: freezed == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as AdminPointsEmployeesPageModel?,
        isSuccess: freezed == isSuccess
            ? _value.isSuccess
            : isSuccess // ignore: cast_nullable_to_non_nullable
                  as bool?,
        successMessage: freezed == successMessage
            ? _value.successMessage
            : successMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPointsEmployeesResponseModelImpl
    implements _AdminPointsEmployeesResponseModel {
  const _$AdminPointsEmployeesResponseModelImpl({
    this.value,
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _errors = errors;

  factory _$AdminPointsEmployeesResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminPointsEmployeesResponseModelImplFromJson(json);

  @override
  final AdminPointsEmployeesPageModel? value;
  @override
  final bool? isSuccess;
  @override
  final String? successMessage;
  final List<String>? _errors;
  @override
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AdminPointsEmployeesResponseModel(value: $value, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPointsEmployeesResponseModelImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.successMessage, successMessage) ||
                other.successMessage == successMessage) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    value,
    isSuccess,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPointsEmployeesResponseModelImplCopyWith<
    _$AdminPointsEmployeesResponseModelImpl
  >
  get copyWith =>
      __$$AdminPointsEmployeesResponseModelImplCopyWithImpl<
        _$AdminPointsEmployeesResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPointsEmployeesResponseModelImplToJson(this);
  }
}

abstract class _AdminPointsEmployeesResponseModel
    implements AdminPointsEmployeesResponseModel {
  const factory _AdminPointsEmployeesResponseModel({
    final AdminPointsEmployeesPageModel? value,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$AdminPointsEmployeesResponseModelImpl;

  factory _AdminPointsEmployeesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) = _$AdminPointsEmployeesResponseModelImpl.fromJson;

  @override
  AdminPointsEmployeesPageModel? get value;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of AdminPointsEmployeesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPointsEmployeesResponseModelImplCopyWith<
    _$AdminPointsEmployeesResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
