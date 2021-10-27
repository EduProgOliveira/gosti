import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  // static final _passwordRegExp =
  //     RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
  static final _passwordRegExp = RegExp(r'^[0-9a-zA-Z]{6,}$');

  @override
  PasswordValidationError? validator(String? value) {
    _passwordRegExp.hasMatch(value ?? '');

    return _passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid;
  }
}
