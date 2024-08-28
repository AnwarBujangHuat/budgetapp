import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_view_viewmodel.g.dart';

@riverpod
class SelectedTag extends _$SelectedTag {
  @override
  TagModel? build() => null;

  void changeTag({required TagModel tag}) {
    state = tag;
  }
}

@riverpod
class CalculatorNotifier extends _$CalculatorNotifier {
  @override
  double? build() => null;

  void updateValue({required double? val}) {
    state = val;
  }
}
