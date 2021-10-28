part of 'confirm_password_cubit.dart';

class ConfirmPasswordState extends Equatable {
  const ConfirmPasswordState({
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;

  @override
  List<Object> get props => [password, confirmedPassword, status];

  ConfirmPasswordState copyWith({
    Password? password,
    ConfirmedPassword? confirmedPassword,
    FormzStatus? status,
  }) {
    return ConfirmPasswordState(
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
