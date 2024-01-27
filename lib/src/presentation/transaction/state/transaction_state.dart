import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/http/app_exception.dart';

part 'transaction_state.freezed.dart';

@freezed
class TransactionsState with _$TransactionsState {
  const factory TransactionsState.loading() = Loading;

  const factory TransactionsState.loaded(List<String> dataList) = Loaded;

  const factory TransactionsState.error(AppException appException) = Error;
}
