// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TagModelImpl _$$TagModelImplFromJson(Map<String, dynamic> json) =>
    _$TagModelImpl(
      tagId: json['tagId'] as int,
      tagName: json['tagName'] as String,
      icon: IconModel.fromJson(json['icon'] as Map<String, dynamic>),
      color: json['color'] as String,
      parentTagId: json['parentTagId'] as int?,
    );

Map<String, dynamic> _$$TagModelImplToJson(_$TagModelImpl instance) =>
    <String, dynamic>{
      'tagId': instance.tagId,
      'tagName': instance.tagName,
      'icon': instance.icon,
      'color': instance.color,
      'parentTagId': instance.parentTagId,
    };

_$IconModelImpl _$$IconModelImplFromJson(Map<String, dynamic> json) =>
    _$IconModelImpl(
      codePaint: json['codePaint'] as int,
      fontFamily: json['fontFamily'] as String,
    );

Map<String, dynamic> _$$IconModelImplToJson(_$IconModelImpl instance) =>
    <String, dynamic>{
      'codePaint': instance.codePaint,
      'fontFamily': instance.fontFamily,
    };
