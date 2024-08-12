import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:budgetapp/domain/repository/transaction/transaction_repository.dart';
import 'package:dartz/dartz.dart';
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
      (data) {
        return data;
      },
    );
  }

  Future<void> getAllExpanses({bool fetchFromRemote = false}) async {
    state = const AsyncLoading();
    final result = await ref
        .read(transactionsRepositoryProvider)
        .getAllExpanses(fetchFromRemote: fetchFromRemote);
    state = result.fold(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );
  }

  Future<void> filterByDate({required String dateType}) async {
    final result = ref
        .read(transactionsRepositoryProvider)
        .filterTransactionByDate(dateType: dateType);
    state = AsyncData(result);
  }
}

@riverpod
class AddNewTransactionNotifier extends _$AddNewTransactionNotifier {
  @override
  Future<bool?> build() async {
    return null;
  }

  Future<void> addNewTransaction(
      {required TransactionModel newTransaction}) async {
    state = const AsyncLoading();
    Either<AppException, bool> result = await ref
        .read(transactionsRepositoryProvider)
        .addNewTransaction(newTransaction: newTransaction);
    state =
        result.fold((err) => AsyncError(err, StackTrace.current), (isSuccess) {
      ///Get the new list from the local database instead of the remote database
      ref
          .read(transactionViewmodelProvider.notifier)
          .getAllExpanses(fetchFromRemote: true);
      return AsyncData(isSuccess);
    });
  }
}
