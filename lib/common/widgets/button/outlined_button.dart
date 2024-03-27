import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/material.dart';

class IBOutlinedButton extends StatelessWidget {
  const IBOutlinedButton(
      {required this.title,
      required this.onTap,
      this.icon = const SizedBox.shrink(),
      super.key});
  final String title;
  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              icon,
              Text(
                title,
                style: theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.white.withOpacity(.5)),
              borderRadius: BorderRadius.circular(5))),
    );
  }
}
