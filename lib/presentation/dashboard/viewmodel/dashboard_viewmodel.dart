import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/viewmodel/transaction/transaction_viewmodel.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_viewmodel.g.dart';

const List<TransactionDuration> filterButton = <TransactionDuration>[
  TransactionDuration.daily,
  TransactionDuration.weekly,
  TransactionDuration.monthly,
  TransactionDuration.yearly,
];

@riverpod
class TransactionTypeNotifier extends _$TransactionTypeNotifier {
  @override
  TransactionType build() => TransactionType.out;

  void changeType({required TransactionType type}) {
    state = (type == TransactionType.income
        ? TransactionType.out
        : TransactionType.income);
  }
}

@riverpod
class DashboardTransactionList extends _$DashboardTransactionList {
  List<TransactionModel> _cachedList = [];
  @override
  Future<List<TransactionModel>> build() async {
    AsyncValue<List<TransactionModel>> transactionViewModel =
        await ref.watch(transactionViewmodelProvider);

    switch (transactionViewModel) {
      case AsyncData(:final value):
        {
          return _cachedList = value;
        }
      case AsyncError(:final error):
        {
          throw error as Exception;
        }
    }
    return [];
  }

  Future<void> filterByDate({required TransactionDuration dateType}) async {
    /// Handle the data local here
    switch (dateType) {
      case TransactionDuration.weekly:
        {
          state = AsyncData(_cachedList.sublist(0, 2));
        }
      case TransactionDuration.monthly:
        {
          state = AsyncData(_cachedList.sublist(2, 5));
        }
      case TransactionDuration.yearly:
        {
          state = AsyncData(_cachedList.sublist(0, 5));
        }

      /// The default duration is daily
      default:
        state = AsyncData(_cachedList);
    }
  }
}

@riverpod
class TransactionDurationNotifier extends _$TransactionDurationNotifier {
  @override
  TransactionDuration build() => filterButton[0];

  void changeDuration({required TransactionDuration duration}) {
    state = duration;

    /// Update the dashboard transaction list to filter the right duration
    ref
        .read(dashboardTransactionListProvider.notifier)
        .filterByDate(dateType: duration);
  }
}

enum TransactionDuration { daily, weekly, monthly, yearly }
