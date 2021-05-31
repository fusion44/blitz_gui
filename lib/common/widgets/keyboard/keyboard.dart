import 'package:flutter/material.dart';

export 'custom_keyboard.dart';

// Basis for this code: https://medium.com/flutter-community/custom-in-app-keyboard-in-flutter-b925d56c8465
void handleInsertText(TextEditingController ctrl, String input) {
  final text = ctrl.text;
  final textSelection = ctrl.selection;
  final newText = text.replaceRange(
    textSelection.start,
    textSelection.end,
    input,
  );
  final textLength = input.length;
  ctrl.text = newText;
  ctrl.selection = textSelection.copyWith(
    baseOffset: textSelection.start + textLength,
    extentOffset: textSelection.start + textLength,
  );
}

// Basis for this code: https://medium.com/flutter-community/custom-in-app-keyboard-in-flutter-b925d56c8465
void handleBackspace(TextEditingController ctrl) {
  final text = ctrl.text;
  final textSelection = ctrl.selection;
  final selectionLength = textSelection.end - textSelection.start;
  if (selectionLength > 0) {
    final newText = text.replaceRange(
      textSelection.start,
      textSelection.end,
      '',
    );
    ctrl.text = newText;
    ctrl.selection = textSelection.copyWith(
      baseOffset: textSelection.start,
      extentOffset: textSelection.start,
    );
    return;
  }
  // The cursor is at the beginning.
  if (textSelection.start == 0) return;

  // Delete the previous character
  final previousCodeUnit = text.codeUnitAt(textSelection.start - 1);
  final offset = _isUtf16Surrogate(previousCodeUnit) ? 2 : 1;
  final newStart = textSelection.start - offset;
  final newEnd = textSelection.start;
  final newText = text.replaceRange(newStart, newEnd, '');
  ctrl.text = newText;
  ctrl.selection = textSelection.copyWith(
    baseOffset: newStart,
    extentOffset: newStart,
  );
}

bool _isUtf16Surrogate(int value) => value & 0xF800 == 0xD800;
