import 'dart:convert';

import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/domain/models/tags/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
/*Documentation for Utilities File 
List Down all The utilities here*/

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

Color getColorFromTag({required int tagId, required List<TagModel> tagList}) {
  String currentColor = 'FFFFF';
  for (var tag in tagList) {
    if (tag.tagId == tagId) {
      currentColor = tag.color;
      break;
    }
  }
  return getColorFromHex(currentColor);
}

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString) as Map<String, dynamic>;
}

String formatDate({required DateTime dateTime}) =>
    DateFormat('dd MMM yy').format(dateTime);
String capitalize({required String s}) => s[0].toUpperCase() + s.substring(1);
bool isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;
