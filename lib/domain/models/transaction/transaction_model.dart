import 'package:budgetapp/common/const/const.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required String title,
    required String description,
    required DateTime dateTime,
    required String transactionAmount,
    required int tagId,
    required int parentTagId,
    @Default(0) int goalTagId,
    String? attachmentUrl,
    @Default(TransactionType.out) TransactionType type,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);
}
