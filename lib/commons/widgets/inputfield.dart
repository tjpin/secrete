// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  bool hasBorder;
  final Widget? icon;
  final String? hint;
  final TextStyle style;
  final double? fieldHeight;
  final double? borderRadius;
  final double? cpadding;
  final bool? isPassword;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int? maxLength;
  final Function? textChanged;
  InputField({
    super.key,
    this.hasBorder = true,
    this.icon,
    this.hint,
    this.cpadding,
    this.isPassword,
    this.focusNode,
    this.fieldHeight,
    this.keyboardType,
    this.maxLength,
    this.textChanged,
    this.borderRadius,
    required this.style,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: maxLength ?? 200,
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      style: style,
      cursorColor: style.color,
      focusNode: focusNode,
      obscureText: isPassword ?? false,
      onChanged: (_) => textChanged!(_) ?? (_) {},
      decoration: InputDecoration(
          suffixIcon: icon ?? const Text(""),
          counterText: "",
          contentPadding: EdgeInsets.only(left: cpadding ?? 10),
          hintText: hint ?? "Enter text...",
          enabledBorder: hasBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 3),
                  borderSide: BorderSide(width: 1, color: Colors.grey[800]!),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey[800]!)),
          focusedBorder: hasBorder
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 3),
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).colorScheme.error),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey[800]!)),
          hintStyle: style.copyWith(color: style.color!.withOpacity(0.5))),
    );
  }
}
