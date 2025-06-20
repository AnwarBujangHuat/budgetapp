import 'package:budgetapp/app/app_style.dart';
import 'package:flutter/material.dart';

class IBTextButton extends StatelessWidget {
  const IBTextButton(
      {required this.title,
      required this.onTap,
      this.icon = const SizedBox.shrink(),
      this.textColor,
      super.key,
      this.padding = const EdgeInsets.all(AppSize.paddingMedium)});
  final String title;
  final Widget icon;
  final Function() onTap;
  final Color? textColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,

      /// Set the minimum button height for 48px
      child: Container(
        constraints: BoxConstraints(
          minHeight: AppSize.appSizeS48,
        ),
        padding: padding,
        child: Row(
          children: [
            icon,
            Text(
              title,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: textColor, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
