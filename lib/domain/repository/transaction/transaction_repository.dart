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
  final List<TransactionModel> transactionsRecords = [];
  Future<Either<AppException, List<TransactionModel>>> getAllExpanses() async {
    try {
      List<TransactionModel> transactionRecords = [];

      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/data/transaction.json');

      for (var element in jsonData['transactions'] as List<dynamic>) {
        transactionRecords
            .add(TransactionModel.fromJson(element as Map<String, dynamic>));
      }

      return Right(transactionRecords);
    } on Exception catch (e) {
      return Left(AppException.errorWithMessage('Failed to load expenses: $e'));
    }
  }

  Future<List<TransactionModel>> addElement({required String data}) async => [];
}
