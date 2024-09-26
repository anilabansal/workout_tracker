import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String? text;
  final Color? color;
  final bool? softWrap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final String? fontFamily;
  final TextAlign? textAlign;

  const CommonText({
    this.overflow,
    this.text,
    this.softWrap,
    this.fontFamily,
    this.decoration,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.textAlign,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      softWrap: softWrap ?? false,
      style: TextStyle(
        overflow: overflow,

        fontFamily: fontFamily,
        decoration: decoration,
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,

      ),
    );
  }
}