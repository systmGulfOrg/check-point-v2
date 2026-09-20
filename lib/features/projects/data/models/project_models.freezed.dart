// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectStatusModel _$ProjectStatusModelFromJson(Map<String, dynamic> json) {
  return _ProjectStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectStatusModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get colorHex => throw _privateConstructorUsedError;
  int? get positionOrder => throw _privateConstructorUsedError;
  bool? get isDoneState => throw _privateConstructorUsedError;

  /// Serializes this ProjectStatusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectStatusModelCopyWith<ProjectStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStatusModelCopyWith<$Res> {
  factory $ProjectStatusModelCopyWith(
    ProjectStatusModel value,
    $Res Function(ProjectStatusModel) then,
  ) = _$ProjectStatusModelCopyWithImpl<$Res, ProjectStatusModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? colorHex,
    int? positionOrder,
    bool? isDoneState,
  });
}

/// @nodoc
class _$ProjectStatusModelCopyWithImpl<$Res, $Val extends ProjectStatusModel>
    implements $ProjectStatusModelCopyWith<$Res> {
  _$ProjectStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? colorHex = freezed,
    Object? positionOrder = freezed,
    Object? isDoneState = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            colorHex: freezed == colorHex
                ? _value.colorHex
                : colorHex // ignore: cast_nullable_to_non_nullable
                      as String?,
            positionOrder: freezed == positionOrder
                ? _value.positionOrder
                : positionOrder // ignore: cast_nullable_to_non_nullable
                      as int?,
            isDoneState: freezed == isDoneState
                ? _value.isDoneState
                : isDoneState // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectStatusModelImplCopyWith<$Res>
    implements $ProjectStatusModelCopyWith<$Res> {
  factory _$$ProjectStatusModelImplCopyWith(
    _$ProjectStatusModelImpl value,
    $Res Function(_$ProjectStatusModelImpl) then,
  ) = __$$ProjectStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? colorHex,
    int? positionOrder,
    bool? isDoneState,
  });
}

/// @nodoc
class __$$ProjectStatusModelImplCopyWithImpl<$Res>
    extends _$ProjectStatusModelCopyWithImpl<$Res, _$ProjectStatusModelImpl>
    implements _$$ProjectStatusModelImplCopyWith<$Res> {
  __$$ProjectStatusModelImplCopyWithImpl(
    _$ProjectStatusModelImpl _value,
    $Res Function(_$ProjectStatusModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? colorHex = freezed,
    Object? positionOrder = freezed,
    Object? isDoneState = freezed,
  }) {
    return _then(
      _$ProjectStatusModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        colorHex: freezed == colorHex
            ? _value.colorHex
            : colorHex // ignore: cast_nullable_to_non_nullable
                  as String?,
        positionOrder: freezed == positionOrder
            ? _value.positionOrder
            : positionOrder // ignore: cast_nullable_to_non_nullable
                  as int?,
        isDoneState: freezed == isDoneState
            ? _value.isDoneState
            : isDoneState // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectStatusModelImpl implements _ProjectStatusModel {
  const _$ProjectStatusModelImpl({
    required this.id,
    required this.name,
    this.colorHex,
    this.positionOrder,
    this.isDoneState,
  });

  factory _$ProjectStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectStatusModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? colorHex;
  @override
  final int? positionOrder;
  @override
  final bool? isDoneState;

  @override
  String toString() {
    return 'ProjectStatusModel(id: $id, name: $name, colorHex: $colorHex, positionOrder: $positionOrder, isDoneState: $isDoneState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectStatusModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.colorHex, colorHex) ||
                other.colorHex == colorHex) &&
            (identical(other.positionOrder, positionOrder) ||
                other.positionOrder == positionOrder) &&
            (identical(other.isDoneState, isDoneState) ||
                other.isDoneState == isDoneState));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, colorHex, positionOrder, isDoneState);

  /// Create a copy of ProjectStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectStatusModelImplCopyWith<_$ProjectStatusModelImpl> get copyWith =>
      __$$ProjectStatusModelImplCopyWithImpl<_$ProjectStatusModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectStatusModelImplToJson(this);
  }
}

abstract class _ProjectStatusModel implements ProjectStatusModel {
  const factory _ProjectStatusModel({
    required final String id,
    required final String name,
    final String? colorHex,
    final int? positionOrder,
    final bool? isDoneState,
  }) = _$ProjectStatusModelImpl;

  factory _ProjectStatusModel.fromJson(Map<String, dynamic> json) =
      _$ProjectStatusModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get colorHex;
  @override
  int? get positionOrder;
  @override
  bool? get isDoneState;

  /// Create a copy of ProjectStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectStatusModelImplCopyWith<_$ProjectStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get endDate => throw _privateConstructorUsedError;
  String? get departmentId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(readValue: _readDepartmentName)
  String? get departmentName => throw _privateConstructorUsedError;
  String? get managerId =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(readValue: _readManagerName)
  String? get managerName => throw _privateConstructorUsedError;
  List<ProjectStatusModel> get statuses => throw _privateConstructorUsedError;

  /// Serializes this ProjectModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
    ProjectModel value,
    $Res Function(ProjectModel) then,
  ) = _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String? code,
    String? description,
    String? startDate,
    String? endDate,
    String? departmentId,
    @JsonKey(readValue: _readDepartmentName) String? departmentName,
    String? managerId,
    @JsonKey(readValue: _readManagerName) String? managerName,
    List<ProjectStatusModel> statuses,
  });
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? statuses = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            departmentId: freezed == departmentId
                ? _value.departmentId
                : departmentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            departmentName: freezed == departmentName
                ? _value.departmentName
                : departmentName // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerId: freezed == managerId
                ? _value.managerId
                : managerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerName: freezed == managerName
                ? _value.managerName
                : managerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            statuses: null == statuses
                ? _value.statuses
                : statuses // ignore: cast_nullable_to_non_nullable
                      as List<ProjectStatusModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
    _$ProjectModelImpl value,
    $Res Function(_$ProjectModelImpl) then,
  ) = __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? code,
    String? description,
    String? startDate,
    String? endDate,
    String? departmentId,
    @JsonKey(readValue: _readDepartmentName) String? departmentName,
    String? managerId,
    @JsonKey(readValue: _readManagerName) String? managerName,
    List<ProjectStatusModel> statuses,
  });
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
    _$ProjectModelImpl _value,
    $Res Function(_$ProjectModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? code = freezed,
    Object? description = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? departmentId = freezed,
    Object? departmentName = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? statuses = null,
  }) {
    return _then(
      _$ProjectModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        departmentId: freezed == departmentId
            ? _value.departmentId
            : departmentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        departmentName: freezed == departmentName
            ? _value.departmentName
            : departmentName // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerId: freezed == managerId
            ? _value.managerId
            : managerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerName: freezed == managerName
            ? _value.managerName
            : managerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        statuses: null == statuses
            ? _value._statuses
            : statuses // ignore: cast_nullable_to_non_nullable
                  as List<ProjectStatusModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModelImpl implements _ProjectModel {
  const _$ProjectModelImpl({
    required this.id,
    required this.name,
    this.code,
    this.description,
    this.startDate,
    this.endDate,
    this.departmentId,
    @JsonKey(readValue: _readDepartmentName) this.departmentName,
    this.managerId,
    @JsonKey(readValue: _readManagerName) this.managerName,
    final List<ProjectStatusModel> statuses = const <ProjectStatusModel>[],
  }) : _statuses = statuses;

  factory _$ProjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? code;
  @override
  final String? description;
  @override
  final String? startDate;
  @override
  final String? endDate;
  @override
  final String? departmentId;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readDepartmentName)
  final String? departmentName;
  @override
  final String? managerId;
  // ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readManagerName)
  final String? managerName;
  final List<ProjectStatusModel> _statuses;
  @override
  @JsonKey()
  List<ProjectStatusModel> get statuses {
    if (_statuses is EqualUnmodifiableListView) return _statuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statuses);
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, name: $name, code: $code, description: $description, startDate: $startDate, endDate: $endDate, departmentId: $departmentId, departmentName: $departmentName, managerId: $managerId, managerName: $managerName, statuses: $statuses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.departmentId, departmentId) ||
                other.departmentId == departmentId) &&
            (identical(other.departmentName, departmentName) ||
                other.departmentName == departmentName) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.managerName, managerName) ||
                other.managerName == managerName) &&
            const DeepCollectionEquality().equals(other._statuses, _statuses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    code,
    description,
    startDate,
    endDate,
    departmentId,
    departmentName,
    managerId,
    managerName,
    const DeepCollectionEquality().hash(_statuses),
  );

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModelImplToJson(this);
  }
}

abstract class _ProjectModel implements ProjectModel {
  const factory _ProjectModel({
    required final String id,
    required final String name,
    final String? code,
    final String? description,
    final String? startDate,
    final String? endDate,
    final String? departmentId,
    @JsonKey(readValue: _readDepartmentName) final String? departmentName,
    final String? managerId,
    @JsonKey(readValue: _readManagerName) final String? managerName,
    final List<ProjectStatusModel> statuses,
  }) = _$ProjectModelImpl;

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$ProjectModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get code;
  @override
  String? get description;
  @override
  String? get startDate;
  @override
  String? get endDate;
  @override
  String? get departmentId; // ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readDepartmentName)
  String? get departmentName;
  @override
  String? get managerId; // ignore: invalid_annotation_target
  @override
  @JsonKey(readValue: _readManagerName)
  String? get managerName;
  @override
  List<ProjectStatusModel> get statuses;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ProjectTaskModel _$ProjectTaskModelFromJson(Map<String, dynamic> json) {
  return _ProjectTaskModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectTaskModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  String? get statusId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get priority => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String? get startDate => throw _privateConstructorUsedError;
  String? get dueDate => throw _privateConstructorUsedError;
  int? get estimatedMinutes => throw _privateConstructorUsedError;
  int? get actualMinutes =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target, Freezed forwards this converter to the generated field.
  @JsonKey(fromJson: _assigneeIdsFromJson)
  List<String> get assigneeIds => throw _privateConstructorUsedError;
  List<TaskAttachmentModel> get attachments =>
      throw _privateConstructorUsedError;

  /// Serializes this ProjectTaskModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectTaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectTaskModelCopyWith<ProjectTaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectTaskModelCopyWith<$Res> {
  factory $ProjectTaskModelCopyWith(
    ProjectTaskModel value,
    $Res Function(ProjectTaskModel) then,
  ) = _$ProjectTaskModelCopyWithImpl<$Res, ProjectTaskModel>;
  @useResult
  $Res call({
    String id,
    String title,
    String? projectId,
    String? statusId,
    String? description,
    String? priority,
    List<String> tags,
    String? startDate,
    String? dueDate,
    int? estimatedMinutes,
    int? actualMinutes,
    @JsonKey(fromJson: _assigneeIdsFromJson) List<String> assigneeIds,
    List<TaskAttachmentModel> attachments,
  });
}

/// @nodoc
class _$ProjectTaskModelCopyWithImpl<$Res, $Val extends ProjectTaskModel>
    implements $ProjectTaskModelCopyWith<$Res> {
  _$ProjectTaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectTaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? projectId = freezed,
    Object? statusId = freezed,
    Object? description = freezed,
    Object? priority = freezed,
    Object? tags = null,
    Object? startDate = freezed,
    Object? dueDate = freezed,
    Object? estimatedMinutes = freezed,
    Object? actualMinutes = freezed,
    Object? assigneeIds = null,
    Object? attachments = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            statusId: freezed == statusId
                ? _value.statusId
                : statusId // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            priority: freezed == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            dueDate: freezed == dueDate
                ? _value.dueDate
                : dueDate // ignore: cast_nullable_to_non_nullable
                      as String?,
            estimatedMinutes: freezed == estimatedMinutes
                ? _value.estimatedMinutes
                : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            actualMinutes: freezed == actualMinutes
                ? _value.actualMinutes
                : actualMinutes // ignore: cast_nullable_to_non_nullable
                      as int?,
            assigneeIds: null == assigneeIds
                ? _value.assigneeIds
                : assigneeIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<TaskAttachmentModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectTaskModelImplCopyWith<$Res>
    implements $ProjectTaskModelCopyWith<$Res> {
  factory _$$ProjectTaskModelImplCopyWith(
    _$ProjectTaskModelImpl value,
    $Res Function(_$ProjectTaskModelImpl) then,
  ) = __$$ProjectTaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? projectId,
    String? statusId,
    String? description,
    String? priority,
    List<String> tags,
    String? startDate,
    String? dueDate,
    int? estimatedMinutes,
    int? actualMinutes,
    @JsonKey(fromJson: _assigneeIdsFromJson) List<String> assigneeIds,
    List<TaskAttachmentModel> attachments,
  });
}

/// @nodoc
class __$$ProjectTaskModelImplCopyWithImpl<$Res>
    extends _$ProjectTaskModelCopyWithImpl<$Res, _$ProjectTaskModelImpl>
    implements _$$ProjectTaskModelImplCopyWith<$Res> {
  __$$ProjectTaskModelImplCopyWithImpl(
    _$ProjectTaskModelImpl _value,
    $Res Function(_$ProjectTaskModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectTaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? projectId = freezed,
    Object? statusId = freezed,
    Object? description = freezed,
    Object? priority = freezed,
    Object? tags = null,
    Object? startDate = freezed,
    Object? dueDate = freezed,
    Object? estimatedMinutes = freezed,
    Object? actualMinutes = freezed,
    Object? assigneeIds = null,
    Object? attachments = null,
  }) {
    return _then(
      _$ProjectTaskModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        statusId: freezed == statusId
            ? _value.statusId
            : statusId // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        priority: freezed == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        dueDate: freezed == dueDate
            ? _value.dueDate
            : dueDate // ignore: cast_nullable_to_non_nullable
                  as String?,
        estimatedMinutes: freezed == estimatedMinutes
            ? _value.estimatedMinutes
            : estimatedMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        actualMinutes: freezed == actualMinutes
            ? _value.actualMinutes
            : actualMinutes // ignore: cast_nullable_to_non_nullable
                  as int?,
        assigneeIds: null == assigneeIds
            ? _value._assigneeIds
            : assigneeIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<TaskAttachmentModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectTaskModelImpl implements _ProjectTaskModel {
  const _$ProjectTaskModelImpl({
    required this.id,
    required this.title,
    this.projectId,
    this.statusId,
    this.description,
    this.priority,
    final List<String> tags = const <String>[],
    this.startDate,
    this.dueDate,
    this.estimatedMinutes,
    this.actualMinutes,
    @JsonKey(fromJson: _assigneeIdsFromJson)
    final List<String> assigneeIds = const <String>[],
    final List<TaskAttachmentModel> attachments = const <TaskAttachmentModel>[],
  }) : _tags = tags,
       _assigneeIds = assigneeIds,
       _attachments = attachments;

  factory _$ProjectTaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectTaskModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? projectId;
  @override
  final String? statusId;
  @override
  final String? description;
  @override
  final String? priority;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final String? startDate;
  @override
  final String? dueDate;
  @override
  final int? estimatedMinutes;
  @override
  final int? actualMinutes;
  // ignore: invalid_annotation_target, Freezed forwards this converter to the generated field.
  final List<String> _assigneeIds;
  // ignore: invalid_annotation_target, Freezed forwards this converter to the generated field.
  @override
  @JsonKey(fromJson: _assigneeIdsFromJson)
  List<String> get assigneeIds {
    if (_assigneeIds is EqualUnmodifiableListView) return _assigneeIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assigneeIds);
  }

  final List<TaskAttachmentModel> _attachments;
  @override
  @JsonKey()
  List<TaskAttachmentModel> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  @override
  String toString() {
    return 'ProjectTaskModel(id: $id, title: $title, projectId: $projectId, statusId: $statusId, description: $description, priority: $priority, tags: $tags, startDate: $startDate, dueDate: $dueDate, estimatedMinutes: $estimatedMinutes, actualMinutes: $actualMinutes, assigneeIds: $assigneeIds, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectTaskModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.statusId, statusId) ||
                other.statusId == statusId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            (identical(other.estimatedMinutes, estimatedMinutes) ||
                other.estimatedMinutes == estimatedMinutes) &&
            (identical(other.actualMinutes, actualMinutes) ||
                other.actualMinutes == actualMinutes) &&
            const DeepCollectionEquality().equals(
              other._assigneeIds,
              _assigneeIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    projectId,
    statusId,
    description,
    priority,
    const DeepCollectionEquality().hash(_tags),
    startDate,
    dueDate,
    estimatedMinutes,
    actualMinutes,
    const DeepCollectionEquality().hash(_assigneeIds),
    const DeepCollectionEquality().hash(_attachments),
  );

  /// Create a copy of ProjectTaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectTaskModelImplCopyWith<_$ProjectTaskModelImpl> get copyWith =>
      __$$ProjectTaskModelImplCopyWithImpl<_$ProjectTaskModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectTaskModelImplToJson(this);
  }
}

abstract class _ProjectTaskModel implements ProjectTaskModel {
  const factory _ProjectTaskModel({
    required final String id,
    required final String title,
    final String? projectId,
    final String? statusId,
    final String? description,
    final String? priority,
    final List<String> tags,
    final String? startDate,
    final String? dueDate,
    final int? estimatedMinutes,
    final int? actualMinutes,
    @JsonKey(fromJson: _assigneeIdsFromJson) final List<String> assigneeIds,
    final List<TaskAttachmentModel> attachments,
  }) = _$ProjectTaskModelImpl;

  factory _ProjectTaskModel.fromJson(Map<String, dynamic> json) =
      _$ProjectTaskModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get projectId;
  @override
  String? get statusId;
  @override
  String? get description;
  @override
  String? get priority;
  @override
  List<String> get tags;
  @override
  String? get startDate;
  @override
  String? get dueDate;
  @override
  int? get estimatedMinutes;
  @override
  int? get actualMinutes; // ignore: invalid_annotation_target, Freezed forwards this converter to the generated field.
  @override
  @JsonKey(fromJson: _assigneeIdsFromJson)
  List<String> get assigneeIds;
  @override
  List<TaskAttachmentModel> get attachments;

  /// Create a copy of ProjectTaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectTaskModelImplCopyWith<_$ProjectTaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskAttachmentModel _$TaskAttachmentModelFromJson(Map<String, dynamic> json) {
  return _TaskAttachmentModel.fromJson(json);
}

/// @nodoc
mixin _$TaskAttachmentModel {
  String get id => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TaskAttachmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskAttachmentModelCopyWith<TaskAttachmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAttachmentModelCopyWith<$Res> {
  factory $TaskAttachmentModelCopyWith(
    TaskAttachmentModel value,
    $Res Function(TaskAttachmentModel) then,
  ) = _$TaskAttachmentModelCopyWithImpl<$Res, TaskAttachmentModel>;
  @useResult
  $Res call({
    String id,
    String? fileName,
    String? fileUrl,
    int? fileSize,
    String? mimeType,
    String? createdAt,
  });
}

/// @nodoc
class _$TaskAttachmentModelCopyWithImpl<$Res, $Val extends TaskAttachmentModel>
    implements $TaskAttachmentModelCopyWith<$Res> {
  _$TaskAttachmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileName = freezed,
    Object? fileUrl = freezed,
    Object? fileSize = freezed,
    Object? mimeType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fileName: freezed == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileUrl: freezed == fileUrl
                ? _value.fileUrl
                : fileUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileSize: freezed == fileSize
                ? _value.fileSize
                : fileSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            mimeType: freezed == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskAttachmentModelImplCopyWith<$Res>
    implements $TaskAttachmentModelCopyWith<$Res> {
  factory _$$TaskAttachmentModelImplCopyWith(
    _$TaskAttachmentModelImpl value,
    $Res Function(_$TaskAttachmentModelImpl) then,
  ) = __$$TaskAttachmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? fileName,
    String? fileUrl,
    int? fileSize,
    String? mimeType,
    String? createdAt,
  });
}

/// @nodoc
class __$$TaskAttachmentModelImplCopyWithImpl<$Res>
    extends _$TaskAttachmentModelCopyWithImpl<$Res, _$TaskAttachmentModelImpl>
    implements _$$TaskAttachmentModelImplCopyWith<$Res> {
  __$$TaskAttachmentModelImplCopyWithImpl(
    _$TaskAttachmentModelImpl _value,
    $Res Function(_$TaskAttachmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fileName = freezed,
    Object? fileUrl = freezed,
    Object? fileSize = freezed,
    Object? mimeType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$TaskAttachmentModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: freezed == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileUrl: freezed == fileUrl
            ? _value.fileUrl
            : fileUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSize: freezed == fileSize
            ? _value.fileSize
            : fileSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        mimeType: freezed == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAttachmentModelImpl implements _TaskAttachmentModel {
  const _$TaskAttachmentModelImpl({
    required this.id,
    this.fileName,
    this.fileUrl,
    this.fileSize,
    this.mimeType,
    this.createdAt,
  });

  factory _$TaskAttachmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAttachmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? fileName;
  @override
  final String? fileUrl;
  @override
  final int? fileSize;
  @override
  final String? mimeType;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'TaskAttachmentModel(id: $id, fileName: $fileName, fileUrl: $fileUrl, fileSize: $fileSize, mimeType: $mimeType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAttachmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fileName,
    fileUrl,
    fileSize,
    mimeType,
    createdAt,
  );

  /// Create a copy of TaskAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAttachmentModelImplCopyWith<_$TaskAttachmentModelImpl> get copyWith =>
      __$$TaskAttachmentModelImplCopyWithImpl<_$TaskAttachmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAttachmentModelImplToJson(this);
  }
}

abstract class _TaskAttachmentModel implements TaskAttachmentModel {
  const factory _TaskAttachmentModel({
    required final String id,
    final String? fileName,
    final String? fileUrl,
    final int? fileSize,
    final String? mimeType,
    final String? createdAt,
  }) = _$TaskAttachmentModelImpl;

  factory _TaskAttachmentModel.fromJson(Map<String, dynamic> json) =
      _$TaskAttachmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get fileName;
  @override
  String? get fileUrl;
  @override
  int? get fileSize;
  @override
  String? get mimeType;
  @override
  String? get createdAt;

  /// Create a copy of TaskAttachmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAttachmentModelImplCopyWith<_$TaskAttachmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskAuditModel _$TaskAuditModelFromJson(Map<String, dynamic> json) {
  return _TaskAuditModel.fromJson(json);
}

/// @nodoc
mixin _$TaskAuditModel {
  String get id => throw _privateConstructorUsedError;
  String? get action => throw _privateConstructorUsedError;
  String? get actorName => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TaskAuditModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskAuditModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskAuditModelCopyWith<TaskAuditModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAuditModelCopyWith<$Res> {
  factory $TaskAuditModelCopyWith(
    TaskAuditModel value,
    $Res Function(TaskAuditModel) then,
  ) = _$TaskAuditModelCopyWithImpl<$Res, TaskAuditModel>;
  @useResult
  $Res call({String id, String? action, String? actorName, String? createdAt});
}

/// @nodoc
class _$TaskAuditModelCopyWithImpl<$Res, $Val extends TaskAuditModel>
    implements $TaskAuditModelCopyWith<$Res> {
  _$TaskAuditModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskAuditModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = freezed,
    Object? actorName = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            action: freezed == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as String?,
            actorName: freezed == actorName
                ? _value.actorName
                : actorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskAuditModelImplCopyWith<$Res>
    implements $TaskAuditModelCopyWith<$Res> {
  factory _$$TaskAuditModelImplCopyWith(
    _$TaskAuditModelImpl value,
    $Res Function(_$TaskAuditModelImpl) then,
  ) = __$$TaskAuditModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String? action, String? actorName, String? createdAt});
}

/// @nodoc
class __$$TaskAuditModelImplCopyWithImpl<$Res>
    extends _$TaskAuditModelCopyWithImpl<$Res, _$TaskAuditModelImpl>
    implements _$$TaskAuditModelImplCopyWith<$Res> {
  __$$TaskAuditModelImplCopyWithImpl(
    _$TaskAuditModelImpl _value,
    $Res Function(_$TaskAuditModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskAuditModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? action = freezed,
    Object? actorName = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$TaskAuditModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        action: freezed == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as String?,
        actorName: freezed == actorName
            ? _value.actorName
            : actorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAuditModelImpl implements _TaskAuditModel {
  const _$TaskAuditModelImpl({
    required this.id,
    this.action,
    this.actorName,
    this.createdAt,
  });

  factory _$TaskAuditModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAuditModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? action;
  @override
  final String? actorName;
  @override
  final String? createdAt;

  @override
  String toString() {
    return 'TaskAuditModel(id: $id, action: $action, actorName: $actorName, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAuditModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.actorName, actorName) ||
                other.actorName == actorName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, action, actorName, createdAt);

  /// Create a copy of TaskAuditModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAuditModelImplCopyWith<_$TaskAuditModelImpl> get copyWith =>
      __$$TaskAuditModelImplCopyWithImpl<_$TaskAuditModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAuditModelImplToJson(this);
  }
}

abstract class _TaskAuditModel implements TaskAuditModel {
  const factory _TaskAuditModel({
    required final String id,
    final String? action,
    final String? actorName,
    final String? createdAt,
  }) = _$TaskAuditModelImpl;

  factory _TaskAuditModel.fromJson(Map<String, dynamic> json) =
      _$TaskAuditModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get action;
  @override
  String? get actorName;
  @override
  String? get createdAt;

  /// Create a copy of TaskAuditModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAuditModelImplCopyWith<_$TaskAuditModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
