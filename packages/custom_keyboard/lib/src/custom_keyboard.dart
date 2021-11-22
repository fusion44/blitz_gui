import 'package:flutter/material.dart';

import 'special_key.dart';
import 'text_key.dart';

// Basis for this code: https://medium.com/flutter-community/custom-in-app-keyboard-in-flutter-b925d56c8465

class CustomKeyboard extends StatefulWidget {
  final ValueSetter<String>? onTextInput;
  final VoidCallback? onBackspace;
  final VoidCallback? onEnter;

  const CustomKeyboard({
    Key? key,
    this.onTextInput,
    this.onBackspace,
    this.onEnter,
  }) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  bool _shift = false;
  bool _longShift = false;

  void _textInputHandler(String text) => widget.onTextInput?.call(text);
  void _backspaceHandler() => widget.onBackspace?.call();
  void _enterHandler() => widget.onEnter?.call();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          _buildRowOne(),
          _buildRowTwo(),
          _buildRowThree(),
          _buildRowFour(),
          _buildRowFive(),
        ],
      ),
    );
  }

  Expanded _buildRowOne() {
    return Expanded(
      child: Row(
        children: [
          TextKey('1', onTextInput: _textInputHandler),
          TextKey('2', onTextInput: _textInputHandler),
          TextKey('3', onTextInput: _textInputHandler),
          TextKey('4', onTextInput: _textInputHandler),
          TextKey('5', onTextInput: _textInputHandler),
          TextKey('6', onTextInput: _textInputHandler),
          TextKey('7', onTextInput: _textInputHandler),
          TextKey('8', onTextInput: _textInputHandler),
          TextKey('9', onTextInput: _textInputHandler),
          TextKey('0', onTextInput: _textInputHandler),
        ],
      ),
    );
  }

  Expanded _buildRowTwo() {
    return Expanded(
      child: Row(
        children: [
          TextKey('q', onTextInput: _textInputHandler, shifted: _shift),
          TextKey('w', onTextInput: _textInputHandler, shifted: _shift),
          TextKey('e', onTextInput: _textInputHandler, shifted: _shift),
          TextKey('r', onTextInput: _textInputHandler),
          TextKey('t', onTextInput: _textInputHandler),
          TextKey('y', onTextInput: _textInputHandler),
          TextKey('u', onTextInput: _textInputHandler),
          TextKey('i', onTextInput: _textInputHandler),
          TextKey('o', onTextInput: _textInputHandler),
          TextKey('p', onTextInput: _textInputHandler),
        ],
      ),
    );
  }

  Widget _buildRowThree() {
    return Expanded(
      child: Row(
        children: [
          TextKey('a', onTextInput: _textInputHandler),
          TextKey('s', onTextInput: _textInputHandler),
          TextKey('d', onTextInput: _textInputHandler),
          TextKey('f', onTextInput: _textInputHandler),
          TextKey('g', onTextInput: _textInputHandler),
          TextKey('h', onTextInput: _textInputHandler),
          TextKey('j', onTextInput: _textInputHandler),
          TextKey('k', onTextInput: _textInputHandler),
          TextKey('l', onTextInput: _textInputHandler),
        ],
      ),
    );
  }

  Widget _buildRowFour() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextKey('z', onTextInput: _textInputHandler),
          TextKey('x', onTextInput: _textInputHandler),
          TextKey('c', onTextInput: _textInputHandler),
          TextKey('v', onTextInput: _textInputHandler),
          TextKey('b', onTextInput: _textInputHandler),
          TextKey('n', onTextInput: _textInputHandler),
          TextKey('m', onTextInput: _textInputHandler),
          SpecialKey(SpecialKeyType.backspace, onPressed: _backspaceHandler),
        ],
      ),
    );
  }

  Widget _buildRowFive() {
    return Expanded(
      child: Row(
        children: [
          SpecialKey(
            SpecialKeyType.shift,
            onPressed: () {
              if (_shift || _longShift) {
                setState(() => _shift = _longShift = false);
              } else {
                setState(() => _shift = true);
              }
            },
            onLongPressed: () {
              if (!_longShift) {
                setState(() => _shift = _longShift = false);
              } else {
                setState(() => _shift = _longShift = true);
              }
            },
          ),
          TextKey(' ', flex: 4, onTextInput: _textInputHandler),
          TextKey(',', onTextInput: _textInputHandler),
          SpecialKey(SpecialKeyType.enter, onPressed: _enterHandler),
        ],
      ),
    );
  }
}
