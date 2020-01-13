import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isLoading;

  CustomButtonWidget({
    @required this.text,
    @required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.height - 30,
      height: 50,
      child: RaisedButton(
        child: !isLoading 
          ? Text(
              text,
              style: TextStyle(color: Colors.white),
            )
          : CircularProgressIndicator(),
        color: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        onPressed: !isLoading ? onTap : null,
      ),
    );
  }
}