// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextH2 extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign? align;
  final double initialFontSize;

  const TextH2({
    super.key,
    required this.text,
    required this.color,
    this.initialFontSize = 16.0,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: initialFontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      textAlign: align ?? TextAlign.start,
    );
  }
}
