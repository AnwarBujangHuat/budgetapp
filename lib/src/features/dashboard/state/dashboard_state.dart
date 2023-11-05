import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/http/app_exception.dart';

part 'dashboard_state.freezed.dart';

@freezed
class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = Loading;

  const factory DashboardState.loaded(List<String> dataList) = Loaded;

  const factory DashboardState.error(AppException appException) = Error;
}
