// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_badge_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PointsBadgeItemModel _$PointsBadgeItemModelFromJson(Map<String, dynamic> json) {
  return _PointsBadgeItemModel.fromJson(json);
}

/// @nodoc
mixin _$PointsBadgeItemModel {
  String get key => throw _privateConstructorUsedError;
  String? get nameEn => throw _privateConstructorUsedError;
  String? get nameAr => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get titleAr => throw _privateConstructorUsedError;
  String? get descriptionEn => throw _privateConstructorUsedError;
  String? get descriptionAr => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  int? get threshold => throw _privateConstructorUsedError;
  bool get isUnlocked => throw _privateConstructorUsedError;
  String? get unlockedAt => throw _privateConstructorUsedError;
  double? get progress => throw _privateConstructorUsedError;
  int get currentProgress => throw _privateConstructorUsedError;
  int get targetProgress => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;

  /// Serializes this PointsBadgeItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsBadgeItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsBadgeItemModelCopyWith<PointsBadgeItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsBadgeItemModelCopyWith<$Res> {
  factory $PointsBadgeItemModelCopyWith(
    PointsBadgeItemModel value,
    $Res Function(PointsBadgeItemModel) then,
  ) = _$PointsBadgeItemModelCopyWithImpl<$Res, PointsBadgeItemModel>;
  @useResult
  $Res call({
    String key,
    String? nameEn,
    String? nameAr,
    String? title,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    String? description,
    String? icon,
    int? threshold,
    bool isUnlocked,
    String? unlockedAt,
    double? progress,
    int currentProgress,
    int targetProgress,
    double progressPercentage,
  });
}

/// @nodoc
class _$PointsBadgeItemModelCopyWithImpl<
  $Res,
  $Val extends PointsBadgeItemModel
>
    implements $PointsBadgeItemModelCopyWith<$Res> {
  _$PointsBadgeItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsBadgeItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? nameEn = freezed,
    Object? nameAr = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionAr = freezed,
    Object? description = freezed,
    Object? icon = freezed,
    Object? threshold = freezed,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
    Object? progress = freezed,
    Object? currentProgress = null,
    Object? targetProgress = null,
    Object? progressPercentage = null,
  }) {
    return _then(
      _value.copyWith(
            key: null == key
                ? _value.key
                : key // ignore: cast_nullable_to_non_nullable
                      as String,
            nameEn: freezed == nameEn
                ? _value.nameEn
                : nameEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            nameAr: freezed == nameAr
                ? _value.nameAr
                : nameAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            titleAr: freezed == titleAr
                ? _value.titleAr
                : titleAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionEn: freezed == descriptionEn
                ? _value.descriptionEn
                : descriptionEn // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionAr: freezed == descriptionAr
                ? _value.descriptionAr
                : descriptionAr // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            threshold: freezed == threshold
                ? _value.threshold
                : threshold // ignore: cast_nullable_to_non_nullable
                      as int?,
            isUnlocked: null == isUnlocked
                ? _value.isUnlocked
                : isUnlocked // ignore: cast_nullable_to_non_nullable
                      as bool,
            unlockedAt: freezed == unlockedAt
                ? _value.unlockedAt
                : unlockedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            progress: freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as double?,
            currentProgress: null == currentProgress
                ? _value.currentProgress
                : currentProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            targetProgress: null == targetProgress
                ? _value.targetProgress
                : targetProgress // ignore: cast_nullable_to_non_nullable
                      as int,
            progressPercentage: null == progressPercentage
                ? _value.progressPercentage
                : progressPercentage // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PointsBadgeItemModelImplCopyWith<$Res>
    implements $PointsBadgeItemModelCopyWith<$Res> {
  factory _$$PointsBadgeItemModelImplCopyWith(
    _$PointsBadgeItemModelImpl value,
    $Res Function(_$PointsBadgeItemModelImpl) then,
  ) = __$$PointsBadgeItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String key,
    String? nameEn,
    String? nameAr,
    String? title,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    String? description,
    String? icon,
    int? threshold,
    bool isUnlocked,
    String? unlockedAt,
    double? progress,
    int currentProgress,
    int targetProgress,
    double progressPercentage,
  });
}

/// @nodoc
class __$$PointsBadgeItemModelImplCopyWithImpl<$Res>
    extends _$PointsBadgeItemModelCopyWithImpl<$Res, _$PointsBadgeItemModelImpl>
    implements _$$PointsBadgeItemModelImplCopyWith<$Res> {
  __$$PointsBadgeItemModelImplCopyWithImpl(
    _$PointsBadgeItemModelImpl _value,
    $Res Function(_$PointsBadgeItemModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsBadgeItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? nameEn = freezed,
    Object? nameAr = freezed,
    Object? title = freezed,
    Object? titleAr = freezed,
    Object? descriptionEn = freezed,
    Object? descriptionAr = freezed,
    Object? description = freezed,
    Object? icon = freezed,
    Object? threshold = freezed,
    Object? isUnlocked = null,
    Object? unlockedAt = freezed,
    Object? progress = freezed,
    Object? currentProgress = null,
    Object? targetProgress = null,
    Object? progressPercentage = null,
  }) {
    return _then(
      _$PointsBadgeItemModelImpl(
        key: null == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String,
        nameEn: freezed == nameEn
            ? _value.nameEn
            : nameEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        nameAr: freezed == nameAr
            ? _value.nameAr
            : nameAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        titleAr: freezed == titleAr
            ? _value.titleAr
            : titleAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionEn: freezed == descriptionEn
            ? _value.descriptionEn
            : descriptionEn // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionAr: freezed == descriptionAr
            ? _value.descriptionAr
            : descriptionAr // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        threshold: freezed == threshold
            ? _value.threshold
            : threshold // ignore: cast_nullable_to_non_nullable
                  as int?,
        isUnlocked: null == isUnlocked
            ? _value.isUnlocked
            : isUnlocked // ignore: cast_nullable_to_non_nullable
                  as bool,
        unlockedAt: freezed == unlockedAt
            ? _value.unlockedAt
            : unlockedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        progress: freezed == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as double?,
        currentProgress: null == currentProgress
            ? _value.currentProgress
            : currentProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        targetProgress: null == targetProgress
            ? _value.targetProgress
            : targetProgress // ignore: cast_nullable_to_non_nullable
                  as int,
        progressPercentage: null == progressPercentage
            ? _value.progressPercentage
            : progressPercentage // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsBadgeItemModelImpl extends _PointsBadgeItemModel {
  const _$PointsBadgeItemModelImpl({
    required this.key,
    this.nameEn,
    this.nameAr,
    this.title,
    this.titleAr,
    this.descriptionEn,
    this.descriptionAr,
    this.description,
    this.icon,
    this.threshold,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress,
    this.currentProgress = 0,
    this.targetProgress = 0,
    this.progressPercentage = 0.0,
  }) : super._();

  factory _$PointsBadgeItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsBadgeItemModelImplFromJson(json);

  @override
  final String key;
  @override
  final String? nameEn;
  @override
  final String? nameAr;
  @override
  final String? title;
  @override
  final String? titleAr;
  @override
  final String? descriptionEn;
  @override
  final String? descriptionAr;
  @override
  final String? description;
  @override
  final String? icon;
  @override
  final int? threshold;
  @override
  @JsonKey()
  final bool isUnlocked;
  @override
  final String? unlockedAt;
  @override
  final double? progress;
  @override
  @JsonKey()
  final int currentProgress;
  @override
  @JsonKey()
  final int targetProgress;
  @override
  @JsonKey()
  final double progressPercentage;

  @override
  String toString() {
    return 'PointsBadgeItemModel(key: $key, nameEn: $nameEn, nameAr: $nameAr, title: $title, titleAr: $titleAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, description: $description, icon: $icon, threshold: $threshold, isUnlocked: $isUnlocked, unlockedAt: $unlockedAt, progress: $progress, currentProgress: $currentProgress, targetProgress: $targetProgress, progressPercentage: $progressPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsBadgeItemModelImpl &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.nameAr, nameAr) || other.nameAr == nameAr) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.titleAr, titleAr) || other.titleAr == titleAr) &&
            (identical(other.descriptionEn, descriptionEn) ||
                other.descriptionEn == descriptionEn) &&
            (identical(other.descriptionAr, descriptionAr) ||
                other.descriptionAr == descriptionAr) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked) &&
            (identical(other.unlockedAt, unlockedAt) ||
                other.unlockedAt == unlockedAt) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.currentProgress, currentProgress) ||
                other.currentProgress == currentProgress) &&
            (identical(other.targetProgress, targetProgress) ||
                other.targetProgress == targetProgress) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    key,
    nameEn,
    nameAr,
    title,
    titleAr,
    descriptionEn,
    descriptionAr,
    description,
    icon,
    threshold,
    isUnlocked,
    unlockedAt,
    progress,
    currentProgress,
    targetProgress,
    progressPercentage,
  );

  /// Create a copy of PointsBadgeItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsBadgeItemModelImplCopyWith<_$PointsBadgeItemModelImpl>
  get copyWith =>
      __$$PointsBadgeItemModelImplCopyWithImpl<_$PointsBadgeItemModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsBadgeItemModelImplToJson(this);
  }
}

abstract class _PointsBadgeItemModel extends PointsBadgeItemModel {
  const factory _PointsBadgeItemModel({
    required final String key,
    final String? nameEn,
    final String? nameAr,
    final String? title,
    final String? titleAr,
    final String? descriptionEn,
    final String? descriptionAr,
    final String? description,
    final String? icon,
    final int? threshold,
    final bool isUnlocked,
    final String? unlockedAt,
    final double? progress,
    final int currentProgress,
    final int targetProgress,
    final double progressPercentage,
  }) = _$PointsBadgeItemModelImpl;
  const _PointsBadgeItemModel._() : super._();

  factory _PointsBadgeItemModel.fromJson(Map<String, dynamic> json) =
      _$PointsBadgeItemModelImpl.fromJson;

  @override
  String get key;
  @override
  String? get nameEn;
  @override
  String? get nameAr;
  @override
  String? get title;
  @override
  String? get titleAr;
  @override
  String? get descriptionEn;
  @override
  String? get descriptionAr;
  @override
  String? get description;
  @override
  String? get icon;
  @override
  int? get threshold;
  @override
  bool get isUnlocked;
  @override
  String? get unlockedAt;
  @override
  double? get progress;
  @override
  int get currentProgress;
  @override
  int get targetProgress;
  @override
  double get progressPercentage;

  /// Create a copy of PointsBadgeItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsBadgeItemModelImplCopyWith<_$PointsBadgeItemModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PointsBadgesResponseModel _$PointsBadgesResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _PointsBadgesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PointsBadgesResponseModel {
  List<PointsBadgeItemModel> get value => throw _privateConstructorUsedError;
  bool? get isSuccess => throw _privateConstructorUsedError;
  String? get successMessage => throw _privateConstructorUsedError;
  List<String>? get errors => throw _privateConstructorUsedError;

  /// Serializes this PointsBadgesResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PointsBadgesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PointsBadgesResponseModelCopyWith<PointsBadgesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsBadgesResponseModelCopyWith<$Res> {
  factory $PointsBadgesResponseModelCopyWith(
    PointsBadgesResponseModel value,
    $Res Function(PointsBadgesResponseModel) then,
  ) = _$PointsBadgesResponseModelCopyWithImpl<$Res, PointsBadgesResponseModel>;
  @useResult
  $Res call({
    List<PointsBadgeItemModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });
}

/// @nodoc
class _$PointsBadgesResponseModelCopyWithImpl<
  $Res,
  $Val extends PointsBadgesResponseModel
>
    implements $PointsBadgesResponseModelCopyWith<$Res> {
  _$PointsBadgesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PointsBadgesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as List<PointsBadgeItemModel>,
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
}

/// @nodoc
abstract class _$$PointsBadgesResponseModelImplCopyWith<$Res>
    implements $PointsBadgesResponseModelCopyWith<$Res> {
  factory _$$PointsBadgesResponseModelImplCopyWith(
    _$PointsBadgesResponseModelImpl value,
    $Res Function(_$PointsBadgesResponseModelImpl) then,
  ) = __$$PointsBadgesResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<PointsBadgeItemModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  });
}

/// @nodoc
class __$$PointsBadgesResponseModelImplCopyWithImpl<$Res>
    extends
        _$PointsBadgesResponseModelCopyWithImpl<
          $Res,
          _$PointsBadgesResponseModelImpl
        >
    implements _$$PointsBadgesResponseModelImplCopyWith<$Res> {
  __$$PointsBadgesResponseModelImplCopyWithImpl(
    _$PointsBadgesResponseModelImpl _value,
    $Res Function(_$PointsBadgesResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PointsBadgesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? isSuccess = freezed,
    Object? successMessage = freezed,
    Object? errors = freezed,
  }) {
    return _then(
      _$PointsBadgesResponseModelImpl(
        value: null == value
            ? _value._value
            : value // ignore: cast_nullable_to_non_nullable
                  as List<PointsBadgeItemModel>,
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
class _$PointsBadgesResponseModelImpl implements _PointsBadgesResponseModel {
  const _$PointsBadgesResponseModelImpl({
    final List<PointsBadgeItemModel> value = const <PointsBadgeItemModel>[],
    this.isSuccess,
    this.successMessage,
    final List<String>? errors,
  }) : _value = value,
       _errors = errors;

  factory _$PointsBadgesResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsBadgesResponseModelImplFromJson(json);

  final List<PointsBadgeItemModel> _value;
  @override
  @JsonKey()
  List<PointsBadgeItemModel> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

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
    return 'PointsBadgesResponseModel(value: $value, isSuccess: $isSuccess, successMessage: $successMessage, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsBadgesResponseModelImpl &&
            const DeepCollectionEquality().equals(other._value, _value) &&
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
    const DeepCollectionEquality().hash(_value),
    isSuccess,
    successMessage,
    const DeepCollectionEquality().hash(_errors),
  );

  /// Create a copy of PointsBadgesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsBadgesResponseModelImplCopyWith<_$PointsBadgesResponseModelImpl>
  get copyWith =>
      __$$PointsBadgesResponseModelImplCopyWithImpl<
        _$PointsBadgesResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsBadgesResponseModelImplToJson(this);
  }
}

abstract class _PointsBadgesResponseModel implements PointsBadgesResponseModel {
  const factory _PointsBadgesResponseModel({
    final List<PointsBadgeItemModel> value,
    final bool? isSuccess,
    final String? successMessage,
    final List<String>? errors,
  }) = _$PointsBadgesResponseModelImpl;

  factory _PointsBadgesResponseModel.fromJson(Map<String, dynamic> json) =
      _$PointsBadgesResponseModelImpl.fromJson;

  @override
  List<PointsBadgeItemModel> get value;
  @override
  bool? get isSuccess;
  @override
  String? get successMessage;
  @override
  List<String>? get errors;

  /// Create a copy of PointsBadgesResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PointsBadgesResponseModelImplCopyWith<_$PointsBadgesResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
