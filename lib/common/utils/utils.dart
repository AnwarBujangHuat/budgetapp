import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/const/const.dart';
import 'package:budgetapp/common/widgets/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color calculateProgressColor({required double value, required double total}) {
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

Widget getCategoryIcon({required TransactionCategory category}) {
  switch (category) {
    case TransactionCategory.dining:
      return CustomIcon(
        iconData: Icons.dining,
        backgroundColor: getCategoryColor(category: category),
      );

    default:
      return CustomIcon(
        iconData: Icons.local_grocery_store,
        backgroundColor: getCategoryColor(
            category:
                category), // You can specify any background color you want
      );
  }
}

Color getCategoryColor({required TransactionCategory category}) {
  switch (category) {
    case TransactionCategory.dining:
      return AppColors.lightRed;

    default:
      return AppColors.darkBlue;
  }
}

String formatDate({required DateTime dateTime}) =>
    DateFormat('dd MMM yy').format(dateTime);
