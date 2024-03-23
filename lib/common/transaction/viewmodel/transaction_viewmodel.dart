import 'package:budgetapp/domain/repository/budget_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'transaction_viewmodel.g.dart';

@riverpod
class TransactionViewmodel extends _$TransactionViewmodel {
  @override
  Future<List<String>> build() async => [];

  Future<void> getAllExpanses() async {
    state = const AsyncLoading();
    final result = await ref.read(expansesRepositoryProvider).getAllExpanses();
    state = result.fold(
        (error) => AsyncError(error, StackTrace.current), AsyncData.new);
  }

  Future<void> insertNewdata() async {
    state = const AsyncLoading();

    List<String> response =
        await ref.read(expansesRepositoryProvider).addElement(data: 'Ikhsan');
  }
}
