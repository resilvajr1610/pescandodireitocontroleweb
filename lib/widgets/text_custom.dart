

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextCustom extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  final textAlign;
  final maxLines;

  TextCustom({
    required this.text,
    this.size = 16.0,
    this.color = PaletteColor.primaryColor,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.maxLines = 1
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Nunito',
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      minFontSize: size,
      maxLines: maxLines,
    );
  }
}
