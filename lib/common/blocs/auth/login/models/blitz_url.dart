import 'package:formz/formz.dart';

enum BlitzURLValidationError { empty, invalid }

class BlitzURL extends FormzInput<String, BlitzURLValidationError> {
  const BlitzURL.pure([String value = '']) : super.pure(value);
  const BlitzURL.dirty([String value = '']) : super.dirty(value);

  @override
  BlitzURLValidationError? validator(String? value) {
    if (value == null || value.isEmpty) return BlitzURLValidationError.empty;

    try {
      Uri.parse(value);
    } catch (e) {
      return BlitzURLValidationError.invalid;
    }
  }
}
