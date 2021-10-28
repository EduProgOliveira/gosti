part of 'sign_up_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.email = const Email.pure(),
    this.phone = const Phone.pure(),
    this.password = const Password.pure(),
    this.countryCode = const CountryCode.pure(),
    this.status = FormzStatus.pure,
    this.isSigningWithGoogle = false,
  });

  final Email email;
  final Phone phone;
  final Password password;
  final CountryCode countryCode;
  final FormzStatus status;
  final bool? isSigningWithGoogle;

  @override
  List<Object> get props => [email, phone, status, password, countryCode];

  SignUpState copyWith({
    Email? email,
    Password? password,
    Phone? phone,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
    CountryCode? countryCode,
    bool? isSigningWithGoogle,
  }) {
    return SignUpState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      password: password ?? this.password,
      countryCode: countryCode ?? this.countryCode,
      isSigningWithGoogle: isSigningWithGoogle ?? this.isSigningWithGoogle,
    );
  }
}
