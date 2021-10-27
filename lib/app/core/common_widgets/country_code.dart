import 'package:formz/formz.dart';

enum CountryCodeValidationError { invalid }

class CountryCodee extends FormzInput<String, CountryCodeValidationError> {
  const CountryCodee.pure() : super.pure('+55');
  const CountryCodee.dirty([String value = '']) : super.dirty(value);

  static final _countyrCodeRegExp = RegExp(r'^([+]\d\d*)$');

  @override
  CountryCodeValidationError? validator(String? value) {
    return _countyrCodeRegExp.hasMatch(value ?? '')
        ? null
        : CountryCodeValidationError.invalid;
  }
}
