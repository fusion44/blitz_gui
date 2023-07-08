import 'package:flutter/material.dart';
import 'package:flutter_ansi_up/flutter_ansi_up.dart';

class AnsiTextWidget extends StatelessWidget {
  final String text;

  const AnsiTextWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return Container();

    final up = FlutterAnsiUp(text);
    List<TextSpan> textSpans = [];
    for (final r in up.decode()) {
      textSpans.add(
        TextSpan(
          text: r.text,
          style: TextStyle(color: r.fgColor),
        ),
      );
    }

    return SelectableText.rich(
      TextSpan(
        children: textSpans,
        style: DefaultTextStyle.of(context).style,
      ),
    );
  }
}
