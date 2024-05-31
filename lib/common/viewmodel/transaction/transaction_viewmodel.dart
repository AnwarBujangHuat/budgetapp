import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:budgetapp/domain/repository/transaction/transaction_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'transaction_viewmodel.g.dart';

@riverpod
class TransactionViewmodel extends _$TransactionViewmodel {
  @override
  Future<List<TransactionModel>> build() async {
    final result =
        await ref.read(transactionsRepositoryProvider).getAllExpanses();
    return result.fold(
      (error) => throw Exception(error),
      (data) => data,
    );
  }

  Future<void> getAllExpanses() async {
    state = const AsyncLoading();
    final result =
        await ref.read(transactionsRepositoryProvider).getAllExpanses();
    state = result.fold(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );
  }

  Future<void> insertNewdata() async {
    state = const AsyncLoading();
  }
}
