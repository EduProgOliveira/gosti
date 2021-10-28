import 'package:formz/formz.dart';

enum CountryCodeValidationError { invalid }

class CountryCode extends FormzInput<String, CountryCodeValidationError> {
  const CountryCode.pure() : super.pure('+55');
  const CountryCode.dirty([String value = '']) : super.dirty(value);

  static final _countyrCodeRegExp = RegExp(r'^([+]\d\d*)$');

  @override
  CountryCodeValidationError? validator(String? value) {
    return _countyrCodeRegExp.hasMatch(value ?? '')
        ? null
        : CountryCodeValidationError.invalid;
  }
}
