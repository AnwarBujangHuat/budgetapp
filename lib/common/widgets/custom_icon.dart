import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData iconData;
  final Color? backgroundColor;
  final double size;

  const CustomIcon({
    Key? key,
    required this.iconData,
    this.backgroundColor,
    this.size = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      radius: size / 2,
      child: Icon(
        iconData,
        color: Colors.white,
        size: size * 0.6, // Adjust icon size as needed
      ),
    );
  }
}
