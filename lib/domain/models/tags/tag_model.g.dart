// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      parentTagId: (json['parentTagId'] as num).toInt(),
      tagId: (json['tagId'] as num).toInt(),
      tagName: json['tagName'] as String,
      icon: IconModel.fromJson(json['icon'] as Map<String, dynamic>),
      color: json['color'] as String,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'parentTagId': instance.parentTagId,
      'tagId': instance.tagId,
      'tagName': instance.tagName,
      'icon': instance.icon,
      'color': instance.color,
    };

_$IconModelImpl _$$IconModelImplFromJson(Map<String, dynamic> json) =>
    _$IconModelImpl(
      codePaint: (json['codePaint'] as num).toInt(),
      fontFamily: json['fontFamily'] as String,
    );

Map<String, dynamic> _$$IconModelImplToJson(_$IconModelImpl instance) =>
    <String, dynamic>{
      'codePaint': instance.codePaint,
      'fontFamily': instance.fontFamily,
    };
