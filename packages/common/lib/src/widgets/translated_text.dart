import 'package:flutter/material.dart';

import '../utils.dart';

class TrText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final bool isButton;

  const TrText(
    this.text, {
    Key? key,
    this.style,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.isButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isButton ? tr(text).toUpperCase() : tr(text),
      style: style,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
