import 'package:flutter/material.dart';

class SuffixIconWidget extends StatefulWidget {
  final bool actived;
  final Function onTap;

  SuffixIconWidget({this.actived, this.onTap});
  @override
  _SuffixIconWidgetState createState() => _SuffixIconWidgetState();
}

class _SuffixIconWidgetState extends State<SuffixIconWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: widget.actived 
          ? Icon(Icons.visibility) 
          : Icon(Icons.visibility_off),
      onTap: widget.onTap,
    );
  }
}
