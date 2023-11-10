import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget{
  final String buttonName;
  final VoidCallback onTap;

  final double height;
  final double width;
  final double bottomMargin;
  final double borderWidth;
  final Color buttonColor;
  final Gradient gradient;

  final TextStyle textStyle;

  RoundedButton(
      {this.buttonName,
      this.onTap,
      this.height,
      this.bottomMargin,
      this.borderWidth,
      this.textStyle,
      this.width,
      this.gradient,
      this.buttonColor});
  Widget build(BuildContext context) {
    if (borderWidth != 0.0) {
      return (InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: bottomMargin),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
              gradient: gradient,
              color: buttonColor,
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              border: Border.all(
                  color: const Color.fromRGBO(221, 221, 221, 1.0),
                  width: borderWidth)),
          child: Text(buttonName, style: textStyle),
        ),
      ));
    } else {
      return (InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(bottom: bottomMargin),
          alignment: FractionalOffset.center,
          decoration: BoxDecoration(
            gradient: gradient,
            color: buttonColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Text(buttonName,
              style: textStyle, textAlign: TextAlign.center),
        ),
      ));
    }
  }
  }
