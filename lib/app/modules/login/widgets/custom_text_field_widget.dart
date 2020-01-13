import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final double width;
  final FocusNode focus;
  final Widget suffixIcon;
  final Function onChanged;
  final String textError;

  CustomTextFieldWidget({
    this.hintText,
    @required this.controller,
    this.width,
    this.obscureText = false,
    this.focus,
    this.onChanged,
    this.suffixIcon,
    this.textError,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              focusNode: focus,
              onChanged: onChanged,
              obscureText: obscureText,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                errorText: textError,
                suffixIcon: suffixIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
