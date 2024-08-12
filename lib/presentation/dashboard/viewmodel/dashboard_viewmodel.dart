import 'package:budgetapp/common/const/const.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dashboard_viewmodel.g.dart';

const List<String> filterButton = <String>[
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];

@riverpod
class TransactionTypeNotifier extends _$TransactionTypeNotifier {
  @override
  TransactionType build() => TransactionType.income;

  void changeType({required TransactionType type}) {
    state = (type == TransactionType.income
        ? TransactionType.out
        : TransactionType.income);
  }
}

final selectedPeriodProvider = StateProvider<String>((_) => filterButton[0]);
