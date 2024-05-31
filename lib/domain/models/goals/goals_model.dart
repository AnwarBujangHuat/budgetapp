import 'package:budgetapp/common/const/const.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'goals_model.g.dart';
part 'goals_model.freezed.dart';

@freezed
class GoalsModel with _$GoalsModel {
  const factory GoalsModel({
    required int goalTagId,
    required String title,
    required String description,
    required int total,
    required int progress,
    required DateTime startDate,
    required DateTime endDate,
    @Default(TransactionType.income) TransactionType type,
  }) = _GoalsModel;

  factory GoalsModel.fromJson(Map<String, Object?> json) =>
      _$GoalsModelFromJson(json);
}
