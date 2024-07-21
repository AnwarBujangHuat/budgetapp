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
      source: json['source'] as String,
      attachmentUrl: json['attachmentUrl'] as String,
      tagId: json['tagId'] as int,
      parentTagId: json['parentTagId'] as int?,
      goalTagId: json['goalTagId'] as int? ?? 0,
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
      'source': instance.source,
      'attachmentUrl': instance.attachmentUrl,
      'tagId': instance.tagId,
      'parentTagId': instance.parentTagId,
      'goalTagId': instance.goalTagId,
      'type': _$TransactionTypeEnumMap[instance.type]!,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.out: 'out',
};
