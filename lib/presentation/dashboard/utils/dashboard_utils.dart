import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';

Map<int, List<TransactionModel>> mapTransactionToParentTag(
    {required List<TransactionModel> transactionList,
    required TransactionType transactionType}) {
  final Map<int, List<TransactionModel>> mapTransactionToParentTag = {};

  for (var transaction in transactionList) {
    if (transaction.type == transactionType) {
      mapTransactionToParentTag[transaction.parentTagId] = [
        ...mapTransactionToParentTag[transaction.parentTagId] ?? [],
        transaction
      ];
    }
  }
  return mapTransactionToParentTag;
}

Map<int, double> getTotalTransactionByParentGroup(
    {required List<TransactionModel> transactionList,
    required TransactionType transactionType}) {
  Map<int, double> result = {};
  mapTransactionToParentTag(
          transactionList: transactionList, transactionType: transactionType)
      .forEach((key, value) {
    for (var element in value) {
      double currentTotal = result[key] ?? 0;
      result[key] =
          (currentTotal += double.tryParse(element.transactionAmount) ?? 0);
    }
  });
  return result;
}

String? getTagDetail({required List<TagModel> tagList, required int tagId}) {
  for (var tag in tagList) {
    if (tag.tagId == tagId) {
      return capitalize(s: tag.tagName);
    }
  }
  return null;
}

double getTotalTransaction(
    {required List<TransactionModel> transactionList,
    TransactionType transactionType = TransactionType.income}) {
  double result = 0;
  getTotalTransactionByParentGroup(
          transactionList: transactionList, transactionType: transactionType)
      .forEach((key, value) {
    result += value;
  });
  return result;
}
