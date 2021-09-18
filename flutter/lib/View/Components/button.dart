import 'package:flutter/material.dart';


//ساخت ویجت دکمه 
// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({Key key, this.text, this.textColor, this.buttonColor, this.onPressed})
      : super(key: key);

  VoidCallback onPressed;
  String text;
  Color buttonColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: onPressed,
        elevation: 0,
        color: buttonColor,
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
        ),
        textColor: textColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
