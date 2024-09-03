import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
import 'package:budgetapp/presentation/dashboard/viewmodel/dashboard_viewmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_repository.g.dart';

@Riverpod(keepAlive: true)
TransactionRepository transactionsRepository(TransactionsRepositoryRef ref) {
  return TransactionRepository(ref);
}

class TransactionRepository {
  TransactionRepository(this._ref);

  final Ref _ref;
  final List<TransactionModel> _transactionsRecords = [];
  Future<Either<AppException, List<TransactionModel>>> getAllExpanses(
      {bool fetchFromRemote = false}) async {
    if (fetchFromRemote) {
      return Right(_transactionsRecords);
    }
    try {
      _transactionsRecords.clear();

      /// Load from local storage now
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/data/transaction.json');

      for (var element in jsonData['transactions'] as List<dynamic>) {
        _transactionsRecords
            .add(TransactionModel.fromJson(element as Map<String, dynamic>));
      }
      return Right(_transactionsRecords);
    } on Exception catch (e) {
      return Left(AppException.errorWithMessage('Failed to load expenses: $e'));
    }
  }

  Future<Either<AppException, bool>> addNewTransaction(
      {required TransactionModel newTransaction}) async {
    /// Insert at first index

    _transactionsRecords.insert(0, newTransaction);
    return Right(true);
  }

  List<TransactionModel> filterTransactionDuration(
      {required TransactionDuration dateType}) {
    switch (dateType) {
      case TransactionDuration.weekly:
        {
          return _transactionsRecords.sublist(0, 2);
        }
      case TransactionDuration.monthly:
        {
          return _transactionsRecords.sublist(2, 5);
        }
      case TransactionDuration.yearly:
        {
          return _transactionsRecords.sublist(0, 5);
        }

      /// The default duration is daily
      default:
        return _transactionsRecords;
    }
  }
}
