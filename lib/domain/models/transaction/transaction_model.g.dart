// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      transactionAmount: json['transactionAmount'] as String,
      tagId: (json['tagId'] as num).toInt(),
      parentTagId: (json['parentTagId'] as num).toInt(),
      goalTagId: (json['goalTagId'] as num?)?.toInt() ?? 0,
      attachmentUrl: json['attachmentUrl'] as String?,
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']) ??
          TransactionType.out,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'transactionAmount': instance.transactionAmount,
      'tagId': instance.tagId,
      'parentTagId': instance.parentTagId,
      'goalTagId': instance.goalTagId,
      'attachmentUrl': instance.attachmentUrl,
      'type': _$TransactionTypeEnumMap[instance.type]!,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.out: 'out',
};
