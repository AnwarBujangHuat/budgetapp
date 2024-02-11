import 'package:budgetapp/src/presentation/transaction/state/transaction_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final expansesRepositoryProvider = Provider((ref) => ExpansesRepository(ref));

class ExpansesRepository {
  ExpansesRepository(this._ref);
  //use this to read api

  final Ref _ref;
  final List<String> expenses = ["Anwar", "Aiman"];

  Future<TransactionsState> getAllExpanses() async {
    return TransactionsState.loaded(expenses);
  }

  Future<List<String>> addElement({required String data}) async {
    return [...expenses, data];
  }
}
