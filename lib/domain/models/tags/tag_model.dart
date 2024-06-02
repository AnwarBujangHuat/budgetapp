import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_model.g.dart';
part 'tag_model.freezed.dart';

@freezed
class TagModel with _$TagModel {
  const factory TagModel({
    required int parentTagId,
    required int tagId,
    required String tagName,
    required IconModel icon,
    required String color,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, Object?> json) =>
      _$TagModelFromJson(json);
}

@freezed
class IconModel with _$IconModel {
  const factory IconModel({
    required int codePaint,
    required String fontFamily,
  }) = _IconModel;

  factory IconModel.fromJson(Map<String, Object?> json) =>
      _$IconModelFromJson(json);
}
