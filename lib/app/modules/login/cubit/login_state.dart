part of 'login_cubit.dart';

enum ForgotPasswordRequest { disabled, enabled }

class LoginState {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.phone = const Phone.pure(),
    this.countryCode = const CountryCode.pure(),
    this.forgotPasswordRequest = ForgotPasswordRequest.disabled,
    this.openOtherOptionsModal = false,
    this.keepConnected = true,
  });

  final Email email;
  final Password password;
  final Phone phone;
  final CountryCode countryCode;
  final FormzStatus status;
  final ForgotPasswordRequest forgotPasswordRequest;
  final bool openOtherOptionsModal;
  final bool keepConnected;

  @override
  List<Object> get props => [
        email,
        password,
        phone,
        status,
        countryCode,
        forgotPasswordRequest,
        openOtherOptionsModal,
        keepConnected,
      ];

  LoginState copyWith({
    Email? email,
    Password? password,
    Phone? phone,
    CountryCode? countryCode,
    FormzStatus? status,
    ForgotPasswordRequest? forgotPasswordRequest,
    bool? openOtherOptionsModal,
    bool? keepConnected,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      keepConnected: keepConnected ?? this.keepConnected,
      countryCode: countryCode ?? this.countryCode,
      openOtherOptionsModal:
          openOtherOptionsModal ?? this.openOtherOptionsModal,
      forgotPasswordRequest:
          forgotPasswordRequest ?? this.forgotPasswordRequest,
    );
  }
}
