import 'package:flutter/material.dart';

class LabelText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  LabelText(
    this.text, {
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          style, // Puedes pasar un estilo personalizado desde fuera o usar el estilo predeterminado
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
