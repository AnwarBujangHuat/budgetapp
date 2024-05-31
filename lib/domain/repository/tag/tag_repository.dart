import 'package:budgetapp/common/utils/utils.dart';
import 'package:budgetapp/domain/http/app_exception.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'tag_repository.g.dart';

@Riverpod(keepAlive: true)
TagRepository tagRepository(TagRepositoryRef ref) {
  return TagRepository(ref);
}

class TagRepository {
  TagRepository(this._ref);

  final Ref _ref;
  final List<TagModel> tagsList = [];
  Future<Either<AppException, List<TagModel>>> getAllTags() async {
    //return tag directly when not empty
    if (tagsList.isNotEmpty) return Right(tagsList);
    try {
      Map<String, dynamic> jsonData =
          await loadJsonFromAssets('assets/data/tag.json');

      for (var element in jsonData['tags'] as List) {
        tagsList.add(TagModel.fromJson(element as Map<String, dynamic>));
      }

      return Right(tagsList);
    } on Exception catch (e) {
      return Left(AppException.errorWithMessage('Failed to load expenses: $e'));
    }
  }

  Future<List<TagModel>> addElement({required String tagId}) async => [];
}
