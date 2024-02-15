import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final expansesRepositoryProvider = Provider((ref) => ExpansesRepository(ref));

class ExpansesRepository {
  ExpansesRepository(this._ref);
  //use this to read api

  final Ref _ref;
  final List<String> expenses = ["Anwar", "Aiman"];

  Future<Either<AppException, List<String>>> getAllExpanses() async {
    return Right(expenses);
  }

  Future<List<String>> addElement({required String data}) async {
    return [...expenses, data];
  }
}
