import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:budgetapp/domain/models/goals/goals_model.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'goal_repository.g.dart';

@Riverpod(keepAlive: true)
GoalsRepository goalsRepository(GoalsRepositoryRef ref) {
  return GoalsRepository(ref);
}

class GoalsRepository {
  GoalsRepository(this._ref);

  final Ref _ref;
  final List<GoalsModel> goalsRecords = [];
  Future<Either<AppException, List<GoalsModel>>> getAllGoals() async {
    try {
      List<GoalsModel> goalsRecords = [];

      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/data/goals.json');

      for (var element in jsonData['goals'] as List<dynamic>) {
        goalsRecords.add(GoalsModel.fromJson(element as Map<String, dynamic>));
      }

      return Right(goalsRecords);
    } on Exception catch (e) {
      return Left(AppException.errorWithMessage('Failed to load expenses: $e'));
    }
  }

  Future<List<GoalsModel>> addElement({required String data}) async => [];
}
