import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_view_viewmodel.g.dart';

@riverpod
class TransactionSelectedTag extends _$TransactionSelectedTag {
  @override
  TagModel? build() => null;

  void changeTag({required TagModel tag}) {
    state = tag;
  }
}

@riverpod
class TransactionSelectedType extends _$TransactionSelectedType {
  @override
  TransactionType build() => TransactionType.out;

  void changeType({required TransactionType type}) {
    state = type == TransactionType.income
        ? TransactionType.out
        : TransactionType.income;
  }
}

@riverpod
class CalculatorNotifier extends _$CalculatorNotifier {
  @override
  double? build() => null;

  void updateValue({required double? val}) {
    state = val;
  }
}
