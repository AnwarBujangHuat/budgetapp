// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get transactionAmount => throw _privateConstructorUsedError;
  int get tagId => throw _privateConstructorUsedError;
  int get parentTagId => throw _privateConstructorUsedError;
  int get goalTagId => throw _privateConstructorUsedError;
  String? get attachmentUrl => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime dateTime,
      String transactionAmount,
      int tagId,
      int parentTagId,
      int goalTagId,
      String? attachmentUrl,
      TransactionType type});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? dateTime = null,
    Object? transactionAmount = null,
    Object? tagId = null,
    Object? parentTagId = null,
    Object? goalTagId = null,
    Object? attachmentUrl = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionAmount: null == transactionAmount
          ? _value.transactionAmount
          : transactionAmount // ignore: cast_nullable_to_non_nullable
              as String,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int,
      parentTagId: null == parentTagId
          ? _value.parentTagId
          : parentTagId // ignore: cast_nullable_to_non_nullable
              as int,
      goalTagId: null == goalTagId
          ? _value.goalTagId
          : goalTagId // ignore: cast_nullable_to_non_nullable
              as int,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String description,
      DateTime dateTime,
      String transactionAmount,
      int tagId,
      int parentTagId,
      int goalTagId,
      String? attachmentUrl,
      TransactionType type});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? dateTime = null,
    Object? transactionAmount = null,
    Object? tagId = null,
    Object? parentTagId = null,
    Object? goalTagId = null,
    Object? attachmentUrl = freezed,
    Object? type = null,
  }) {
    return _then(_$TransactionModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionAmount: null == transactionAmount
          ? _value.transactionAmount
          : transactionAmount // ignore: cast_nullable_to_non_nullable
              as String,
      tagId: null == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as int,
      parentTagId: null == parentTagId
          ? _value.parentTagId
          : parentTagId // ignore: cast_nullable_to_non_nullable
              as int,
      goalTagId: null == goalTagId
          ? _value.goalTagId
          : goalTagId // ignore: cast_nullable_to_non_nullable
              as int,
      attachmentUrl: freezed == attachmentUrl
          ? _value.attachmentUrl
          : attachmentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {required this.title,
      required this.description,
      required this.dateTime,
      required this.transactionAmount,
      required this.tagId,
      required this.parentTagId,
      this.goalTagId = 0,
      this.attachmentUrl,
      this.type = TransactionType.out});

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime dateTime;
  @override
  final String transactionAmount;
  @override
  final int tagId;
  @override
  final int parentTagId;
  @override
  @JsonKey()
  final int goalTagId;
  @override
  final String? attachmentUrl;
  @override
  @JsonKey()
  final TransactionType type;

  @override
  String toString() {
    return 'TransactionModel(title: $title, description: $description, dateTime: $dateTime, transactionAmount: $transactionAmount, tagId: $tagId, parentTagId: $parentTagId, goalTagId: $goalTagId, attachmentUrl: $attachmentUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.transactionAmount, transactionAmount) ||
                other.transactionAmount == transactionAmount) &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.parentTagId, parentTagId) ||
                other.parentTagId == parentTagId) &&
            (identical(other.goalTagId, goalTagId) ||
                other.goalTagId == goalTagId) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, dateTime,
      transactionAmount, tagId, parentTagId, goalTagId, attachmentUrl, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {required final String title,
      required final String description,
      required final DateTime dateTime,
      required final String transactionAmount,
      required final int tagId,
      required final int parentTagId,
      final int goalTagId,
      final String? attachmentUrl,
      final TransactionType type}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  DateTime get dateTime;
  @override
  String get transactionAmount;
  @override
  int get tagId;
  @override
  int get parentTagId;
  @override
  int get goalTagId;
  @override
  String? get attachmentUrl;
  @override
  TransactionType get type;
  @override
  @JsonKey(ignore: true)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
