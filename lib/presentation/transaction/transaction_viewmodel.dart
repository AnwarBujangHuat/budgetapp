import 'package:budgetapp/domain/repository/budget_repository.dart';
import 'package:budgetapp/presentation/transaction/state/transaction_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'transaction_viewmodel.g.dart';

@riverpod
class TransactionViewmodel extends _$TransactionViewmodel {
  @override
  TransactionsState build() {
    return const TransactionsState.loading();
  }

  Future<void> getAllExpanses() async {
    state = const TransactionsState.loading();
    state = await ref.read(expansesRepositoryProvider).getAllExpanses();
  }

  Future<void> insertNewdata() async {
    List<String> response =
        await ref.read(expansesRepositoryProvider).addElement(data: 'Ikhsan');
  }
}
