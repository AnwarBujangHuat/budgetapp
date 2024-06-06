import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:budgetapp/domain/models/transaction/transaction_model.dart';
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
  final Map<int, List<TransactionModel>> _mapTransRecToParTag = {};
  Future<Either<AppException, List<TransactionModel>>> getAllExpanses() async {
    try {
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/data/transaction.json');

      for (var element in jsonData['transactions'] as List<dynamic>) {
        _transactionsRecords
            .add(TransactionModel.fromJson(element as Map<String, dynamic>));
      }
      getTransactionRecordMap();
      return Right(_transactionsRecords);
    } on Exception catch (e) {
      return Left(AppException.errorWithMessage('Failed to load expenses: $e'));
    }
  }

  Future<List<TransactionModel>> addElement({required String data}) async => [];
  Map<int, List<TransactionModel>> getTransactionRecordMap() {
    for (var transaction in _transactionsRecords) {
      _mapTransRecToParTag[transaction.parentTagId ?? transaction.tagId] = [
        ..._mapTransRecToParTag[transaction.parentTagId ?? transaction.tagId] ??
            [],
        transaction
      ];
    }

    return _mapTransRecToParTag;
  }
}
