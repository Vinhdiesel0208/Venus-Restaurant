import 'package:flutter/material.dart';
import 'package:thebags_mobile/constants/theme.dart';

class Input extends StatelessWidget {
  final String? placeholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final bool obscureText;
  final String? errorText; // Thêm biến lỗi

  const Input({
    super.key,
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.controller,
    this.autofocus = false,
    this.borderColor = ArgonColors.border,
    this.obscureText = false,
    this.errorText, // Thêm tham số này
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          cursorColor: ArgonColors.muted,
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          autofocus: autofocus,
          obscureText: obscureText,
          style: TextStyle(
              height: 0.85, fontSize: 14.0, color: ArgonColors.initial),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
            filled: true,
            fillColor: ArgonColors.white,
            hintStyle: TextStyle(color: ArgonColors.muted),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder,
            errorText: errorText, // Sử dụng biến lỗi ở đây
          ),
        ),
      ],
    );
  }
}
