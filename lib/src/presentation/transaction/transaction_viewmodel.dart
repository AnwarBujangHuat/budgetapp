import 'package:budgetapp/src/domain/repository/budget_repository.dart';
import 'package:budgetapp/src/presentation/transaction/state/transaction_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transactionsProvider =
    StateNotifierProvider<TransactionsProvider, TransactionsState>((ref) {
  return TransactionsProvider(ref);
});

class TransactionsProvider extends StateNotifier<TransactionsState> {
  TransactionsProvider(this._ref) : super(const TransactionsState.loading()) {
    getAllExpanses();
  }

  final Ref _ref;
  late final ExpansesRepository _expensesRepository =
      _ref.read(expansesRepositoryProvider);

  Future<void> getAllExpanses() async {
    state = const TransactionsState.loading();
    List<String> response = await _expensesRepository.getAllExpanses();

    if (mounted) {
      state = TransactionsState.loaded(response);
    }
  }

  Future<void> insertNewdata() async {
    List<String> response =
        await _expensesRepository.addElement(data: 'Ikhsan');
  }
}
