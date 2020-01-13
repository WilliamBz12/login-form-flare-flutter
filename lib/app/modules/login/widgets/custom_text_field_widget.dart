import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
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
  _CustomTextFieldWidgetState createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              focusNode: widget.focus,
              onChanged: widget.onChanged,
              obscureText: widget.obscureText,
              controller: widget.controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: _textStyle,
                errorText: widget.textError,
                suffixIcon:
                    widget.suffixIcon != null ? widget.suffixIcon : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final TextStyle _textStyle = TextStyle(
    color: Color(0xffb4b7b8),
    fontSize: 15,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
  );
}
