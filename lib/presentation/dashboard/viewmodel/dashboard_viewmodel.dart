import 'package:hooks_riverpod/hooks_riverpod.dart';

const List<String> filterButton = <String>[
  'Daily',
  'Weekly',
  'Monthly',
  'Yearly',
];
final selectedButtonProvider = StateProvider<String?>((_) => null);
final selectedPeriodProvider = StateProvider<String>((_) => filterButton[0]);
