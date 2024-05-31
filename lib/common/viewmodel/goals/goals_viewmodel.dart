import 'package:budgetapp/domain/models/goals/goals_model.dart';
import 'package:budgetapp/domain/repository/goal/goal_repository.dart';
import 'package:budgetapp/domain/repository/tag/tag_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'goals_viewmodel.g.dart';

@riverpod
class GoalsViewmodel extends _$GoalsViewmodel {
  @override
  Future<List<GoalsModel>> build() async {
    //init get all tag
    await ref.read(tagRepositoryProvider).getAllTags();
    final result = await ref.read(goalsRepositoryProvider).getAllGoals();
    return result.fold(
      (error) => throw Exception(error),
      (data) => data,
    );
  }

  Future<void> getAllGoals() async {
    state = const AsyncLoading();
    final result = await ref.read(goalsRepositoryProvider).getAllGoals();
    state = result.fold(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );
  }

  Future<void> insertNewGoal() async {
    state = const AsyncLoading();
  }
}
