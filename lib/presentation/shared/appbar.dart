import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_font.dart';

class MTAppBar extends StatelessWidget {
  const MTAppBar({super.key, required this.title, required this.onPressedBack});
  final String title;
  final Function() onPressedBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(title,
          style: const TextStyle(
              fontSize: AppFontSizes.title1,
              color: AppColors.white,
              fontWeight: FontWeight.bold)),
      leading: GestureDetector(
        onTap: () => onPressedBack,
        child: const Icon(
          Icons.menu,
          color: AppColors.white,
        ),
      ),
    );
  }
}
