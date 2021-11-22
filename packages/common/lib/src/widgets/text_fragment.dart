import 'package:flutter/material.dart';

class TextFragment {
  final String text;
  final TextStyle style;

  TextFragment(this.text, this.style);

  Widget toTextWidget() => Text(text, style: style);
}
