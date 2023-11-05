// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:renaitechz/shared/state/snackbar_state.dart';

// final snackbarProvider =
//     StateNotifierProvider<SnackbarProvider, SnackbarState>((ref) {
//   return SnackbarProvider(ref);
// });

// class SnackbarProvider extends StateNotifier<SnackbarState> {
//   SnackbarProvider(this._ref) : super(const SnackbarState.emptyMessage());
//   final Ref _ref;

//   // void showLoading() {
//   //   state = SnackbarState.loading();
//   // }

//   // void hideLoading() {
//   //   state = SnackbarState.emptyMessage();
//   // }

//   void showMessage(String message) {
//     state = SnackbarState.showMessage(message);
//     Future.delayed(
//       Duration(seconds: 3),
//       () {
//         state = SnackbarState.emptyMessage();
//       },
//     );
//   }
// }
