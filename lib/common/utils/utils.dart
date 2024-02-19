import 'dart:ui';

import 'package:budgetapp/app/app_style.dart';

Color calculateProgressColor(double value, double total) {
  double progress = value / total;
  if (progress == 0) return AppColors.black;

  if (progress < 0.4) {
    return AppColors.lightRed;
  } else if (progress < 0.6) {
    return AppColors.lightYellow;
  } else {
    return AppColors.lightGreen;
  }
}
