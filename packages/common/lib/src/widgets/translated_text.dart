import 'package:flutter/material.dart';

import '../utils.dart';

class TrText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextAlign? textAlign;
  final bool isButton;
  final Map<String, dynamic> args;

  const TrText(
    this.text, {
    Key? key,
    this.style,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.isButton = false,
    this.args = const <String, dynamic>{},
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isButton ? tr(text, args).toUpperCase() : tr(text, args),
      style: style,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }
}
