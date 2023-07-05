import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String value;
  final double fontSize, letterSpacing;
  final FontWeight fontWeight;
  final TextDecoration? textDecoration;
  final TextOverflow textOverflow;
  final bool isStrike;
  final FontStyle fontStyle;
  final int? maxLine;
  final Color? color;
  final TextStyle? textStyle;
  final TextAlign? align;
  const CustomText(
      {super.key,
      required this.value,
      this.fontWeight = FontWeight.w400,
      this.fontSize = 14,
      this.letterSpacing = 0,
      this.textDecoration = TextDecoration.none,
      this.textOverflow = TextOverflow.clip,
      this.isStrike = false,
      this.fontStyle = FontStyle.normal,
      this.maxLine,
      this.color,
      this.textStyle,
      this.align});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      textScaleFactor: 1.0,
      maxLines: maxLine,
      overflow: textOverflow,
      textAlign: align,
      style: textStyle ??
          Theme.of(context).textTheme.body.copyWith(
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              color: color ?? Colors.black,
              decoration:
                  isStrike ? TextDecoration.lineThrough : textDecoration,
              fontStyle: fontStyle),
    );
  }
}
