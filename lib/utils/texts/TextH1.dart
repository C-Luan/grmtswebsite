// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextH1 extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign? align;

  const TextH1({
    super.key,
    required this.text,
    required this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: color,
            fontWeight: FontWeight.bold,
          ),
          textAlign: align ?? TextAlign.start,
        ),
      ],
    );
  }
}
