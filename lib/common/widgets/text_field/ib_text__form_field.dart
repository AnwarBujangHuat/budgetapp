import 'package:flutter/material.dart';

class IBTextFormField extends StatefulWidget {
  const IBTextFormField(
      {super.key,
      this.hintText,
      this.labelText,
      this.trailingButton,
      this.controller});
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Widget? trailingButton;
  @override
  State<IBTextFormField> createState() => _IBTextFormFieldState();
}

class _IBTextFormFieldState extends State<IBTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.trailingButton,
          hintText: widget.hintText,
          labelText: widget.labelText),
    );
  }
}
