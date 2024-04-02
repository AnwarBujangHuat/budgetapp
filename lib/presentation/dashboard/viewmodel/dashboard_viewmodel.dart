import 'package:budgetapp/common/const/const.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> filterButton = <String>[
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];
final selectedButtonProvider =
    StateProvider<TransactionType>((_) => TransactionType.income);
final selectedPeriodProvider = StateProvider<String>((_) => filterButton[0]);
