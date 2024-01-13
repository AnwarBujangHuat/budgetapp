import 'package:hooks_riverpod/hooks_riverpod.dart';

final communityRepositoryProvider = Provider((ref) => CommunityRepository(ref));

class CommunityRepository {
  CommunityRepository(this._ref);
  final Ref _ref;

  Future<List<String>> getAllCommunity() async {
    return [];
  }
}
