import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:budgetapp/domain/repository/tag/tag_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_viewmodel.g.dart';

@riverpod
class TagViewmodel extends _$TagViewmodel {
  @override
  Future<List<TagModel>> build() async {
    final result = await ref.read(tagRepositoryProvider).getAllTags();
    return result.fold(
      (error) => throw Exception(error),
      (data) => data,
    );
  }

  Future<void> getAllTag() async {
    state = const AsyncLoading();
    final result = await ref.read(tagRepositoryProvider).getAllTags();
    state = result.fold(
      (error) => AsyncError(error, StackTrace.current),
      (data) => AsyncData(data),
    );
  }

  Future<void> insertNewTag() async {
    state = const AsyncLoading();
  }
}
