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
      dateTime: json['dateTime'] as String,
      transactionAmount: json['transactionAmount'] as String,
      category: json['category'] as String,
      source: json['source'] as String,
      attachmentUrl: json['attachmentUrl'] as String,
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime,
      'transactionAmount': instance.transactionAmount,
      'category': instance.category,
      'source': instance.source,
      'attachmentUrl': instance.attachmentUrl,
    };
