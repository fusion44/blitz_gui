import 'package:flutter/material.dart';

class TextKey extends StatelessWidget {
  final String _text;
  final ValueSetter<String>? onTextInput;
  final int flex;
  final bool shifted;

  const TextKey(
    this._text, {
    Key? key,
    this.onTextInput,
    this.flex = 1,
    this.shifted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          elevation: 2.0,
          child: InkWell(
            onTap: () {
              onTextInput?.call(_text);
            },
            child: Container(
              child: Center(child: Text(_text)),
            ),
          ),
        ),
      ),
    );
  }
}
