import 'package:hooks_riverpod/hooks_riverpod.dart';

final expansesRepositoryProvider = Provider((ref) => ExpansesRepository(ref));

class ExpansesRepository {
  ExpansesRepository(this._ref);
  final Ref _ref;
  final List<String> expenses = ["Anwar", "Aiman"];

  Future<List<String>> getAllExpanses() async {
    return expenses;
  }

  Future<List<String>> addElement({required String data}) async {
    return [...expenses, data];
  }
}
