import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.g.dart';
part 'transaction_model.freezed.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel(
      {required String title,
      required String description,
      required String dateTime,
      required String transactionAmount,
      required String category,
      required String source,
      required String attachmentUrl}) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json) =>
      _$TransactionModelFromJson(json);
}
