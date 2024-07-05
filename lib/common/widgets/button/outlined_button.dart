import 'package:budgetapp/app/app_style.dart';
import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:flutter/material.dart';

class IBOutlinedButton extends StatelessWidget {
  const IBOutlinedButton(
      {required this.onTap,
      this.title = '-',
      this.icon,
      this.buttonBuilder,
      this.borderColors,
      super.key,
      this.titleBuilder,
      this.shadowColor = AppColors.grey,
      this.backgroundColor});
  final Function() onTap;
  final String title;
  final Widget? icon;
  final Builder? buttonBuilder;
  final Builder? titleBuilder;
  final Color? borderColors;
  final Color? backgroundColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: Theme.of(context).outlinedButtonTheme.style?.copyWith(
              elevation: WidgetStatePropertyAll(1),
              shadowColor: WidgetStatePropertyAll(shadowColor),
              backgroundColor: WidgetStatePropertyAll(backgroundColor),
              side: WidgetStatePropertyAll(
                BorderSide(color: borderColors ?? AppColors.grey),
              ),
            ),
        onPressed: onTap,
        child: buttonBuilder ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox.shrink(),
                if (icon != null) IBSizedW05(),
                titleBuilder ??
                    Text(
                      overflow: TextOverflow.ellipsis,
                      title,
                    ),
              ],
            ));
  }
}
