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
      goalTagId: json['goalTagId'] as int? ?? null,
      category:
          $enumDecodeNullable(_$TransactionCategoryEnumMap, json['category']) ??
              TransactionCategory.other,
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
      'goalTagId': instance.goalTagId,
      'category': _$TransactionCategoryEnumMap[instance.category]!,
      'type': _$TransactionTypeEnumMap[instance.type]!,
    };

const _$TransactionCategoryEnumMap = {
  TransactionCategory.grocery: 'grocery',
  TransactionCategory.travel: 'travel',
  TransactionCategory.utilities: 'utilities',
  TransactionCategory.rent: 'rent',
  TransactionCategory.entertainment: 'entertainment',
  TransactionCategory.dining: 'dining',
  TransactionCategory.healthcare: 'healthcare',
  TransactionCategory.education: 'education',
  TransactionCategory.clothing: 'clothing',
  TransactionCategory.other: 'other',
};

const _$TransactionTypeEnumMap = {
  TransactionType.income: 'income',
  TransactionType.out: 'out',
};
