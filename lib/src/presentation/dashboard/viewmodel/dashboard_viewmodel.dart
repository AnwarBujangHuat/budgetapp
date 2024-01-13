import 'package:budgetapp/src/domain/repository/budget_repository.dart';
import 'package:budgetapp/src/presentation/dashboard/state/dashboard_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> filterButton = <String>[
  'Yearly',
  'Monthly',
  'Weekly',
  'Daily'
];
final selectedButtonProvider = StateProvider<String?>((_) => null);
final selectedPeriodProvider = StateProvider<String>((_) => filterButton[0]);
final dashboardProvider =
    StateNotifierProvider<DashboardProvider, DashboardState>((ref) {
  return DashboardProvider(ref);
});

class DashboardProvider extends StateNotifier<DashboardState> {
  DashboardProvider(this._ref) : super(const DashboardState.loading()) {
    getAllExpanses();
  }

  final Ref _ref;
  late final ExpansesRepository _expensesRepository =
      _ref.read(expansesRepositoryProvider);

  Future<void> getAllExpanses() async {
    state = const DashboardState.loading();
    List<String> response = await _expensesRepository.getAllExpanses();

    if (mounted) {
      state = DashboardState.loaded(response);
    }
  }

  Future<void> insertNewdata() async {
    List<String> response =
        await _expensesRepository.addElement(data: 'Ikhsan');
  }
}
