import 'package:budgetapp/common/widgets/size_box/sized_boxes.dart';
import 'package:flutter/material.dart';

class IBOutlinedButton extends StatelessWidget {
  const IBOutlinedButton(
      {required this.onTap,
      this.title,
      this.icon,
      this.buttonBuilder,
      super.key,
      this.titleBuilder});
  final Function() onTap;
  final String? title;
  final Widget? icon;
  final Builder? buttonBuilder;
  final Builder? titleBuilder;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onTap,
        child: buttonBuilder ??
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? SizedBox.shrink(),
                if (icon != null) IBSizedW10(),
                titleBuilder ??
                    Text(
                      title ?? '-',
                    ),
              ],
            ));
  }
}
