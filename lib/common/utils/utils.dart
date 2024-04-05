import 'dart:convert';

import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

Color calculateProgressColor({required double value, required double total}) {
  double progress = value / total;
  if (progress == 0) return AppColors.black;

  if (progress < 0.4) {
    return AppColors.lightRed;
  } else if (progress < 0.6) {
    return AppColors.darkYellow;
  } else {
    return AppColors.lightGreen;
  }
}

Color getColorFromHex(String hexColor) {
  String color = hexColor.replaceAll('#', '');
  return Color(int.parse('0xFF$color'));
}

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

String formatDate({required DateTime dateTime}) =>
    DateFormat('dd MMM yy').format(dateTime);
