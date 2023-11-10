import 'package:flutter/material.dart';
import 'package:app_test/src/widgets/Buttons/roundedButton.dart';
class Btns{
  static text(String title, [VoidCallback onTap, TextAlign align]) {
    if (onTap == null) onTap = () {};
    if (align == null) align = TextAlign.left;
    return new TextButton2(
        buttonName: title,
        onPressed: onTap,
        buttonTextStyle: textStyleSmall,
        textAlign: align);
  }
 static rounded(String title, [VoidCallback onTap, Size screenSize]) {
    //Size screenSize = MediaQuery.of(context).size;
    if (onTap == null) onTap = () {};
    if (screenSize == null) screenSize = Size.fromWidth(500);
    return new RoundedButton(
      buttonName: title,
      onTap: onTap,
      width: screenSize.width,
      bottomMargin: 10.0,
      borderWidth: 0.0,
      textStyle: textStyleBtn,
      gradient: btnGradient,
      buttonColor: primaryColor,
    );
  }

  static roundedRed(String title, [VoidCallback onTap, Size screenSize]) {
    if (onTap == null) onTap = () {};
    if (screenSize == null) screenSize = Size.fromWidth(500);
    return new RoundedButton(
      buttonName: title,
      onTap: onTap,
      width: screenSize.width,
      bottomMargin: 10.0,
      borderWidth: 0.0,
      textStyle: textStyleBtn,
      buttonColor: Colors.redAccent,
    );
  }




}