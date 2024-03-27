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
      return IBIcon(
        iconData: Icons.restaurant,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.travel:
      return IBIcon(
        iconData: Icons.airplanemode_active,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.utilities:
      return IBIcon(
        iconData: Icons.lightbulb_outline,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.rent:
      return IBIcon(
        iconData: Icons.home,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.entertainment:
      return IBIcon(
        iconData: Icons.local_movies,
        backgroundColor: getCategoryColor(category: category),
      );

    case TransactionCategory.healthcare:
      return IBIcon(
        iconData: Icons.local_hospital,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.education:
      return IBIcon(
        iconData: Icons.school,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.clothing:
      return IBIcon(
        iconData: Icons.shopping_bag,
        backgroundColor: getCategoryColor(category: category),
      );
    case TransactionCategory.grocery:
      return IBIcon(
        iconData: Icons.local_grocery_store,
        backgroundColor: getCategoryColor(category: category),
      );
    default:
      return IBIcon(
        iconData: Icons.attach_money,
        backgroundColor: getCategoryColor(category: category),
      );
  }
}

Color getCategoryColor({required TransactionCategory category}) {
  switch (category) {
    case TransactionCategory.grocery:
      return AppColors.orange;
    case TransactionCategory.travel:
      return AppColors.green;
    case TransactionCategory.utilities:
      return AppColors.lightGreen;
    case TransactionCategory.rent:
      return AppColors.yellow;
    case TransactionCategory.entertainment:
      return AppColors.lightPurple;
    case TransactionCategory.dining:
      return AppColors.lightRed;
    case TransactionCategory.healthcare:
      return AppColors.pink;
    case TransactionCategory.education:
      return AppColors.teal;
    case TransactionCategory.clothing:
      return AppColors.purple;
    default:
      return AppColors.darkBlue;
  }
}

String formatDate({required DateTime dateTime}) =>
    DateFormat('dd MMM yy').format(dateTime);
