import 'package:flutter/material.dart';

enum SpecialKeyType { backspace, enter, shift }

class SpecialKey extends StatelessWidget {
  final SpecialKeyType? _keyType;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final int flex;

  const SpecialKey(
    this._keyType, {
    Key? key,
    this.onPressed,
    this.onLongPressed,
    this.flex = 1,
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
            onTap: () => onPressed?.call(),
            onLongPress: () => onLongPressed?.call(),
            child: Container(child: _buildWidget()),
          ),
        ),
      ),
    );
  }

  Widget _buildWidget() {
    if (_keyType == SpecialKeyType.backspace) {
      return const Center(child: Icon(Icons.backspace));
    } else if (_keyType == SpecialKeyType.enter) {
      return const Center(child: Icon(Icons.keyboard_return));
    } else if (_keyType == SpecialKeyType.shift) {
      return const Center(child: Text('SHIFT'));
    } else {
      return const Center(child: Text('UNKNOWN'));
    }
  }
}
