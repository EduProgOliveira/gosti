part of 'authentication_cubit.dart';

enum AuthStatus {
  authenticate,
  sign_up,
  sign_in,
  forgot_password,
  verification_code,
  new_password,
  other_options,
}

class AuthenticationState extends Equatable {
  const AuthenticationState({
    this.email = '',
    this.phone = '',
    this.code = '',
    this.otherOptionsId = '',
    this.status = AuthStatus.sign_in,
  });

  final String email;
  final String phone;
  final String code;
  final String otherOptionsId;
  final AuthStatus status;

  @override
  List<Object> get props => [email, phone, code, status, otherOptionsId];

  AuthenticationState copyWith({
    String? email,
    String? phone,
    String? code,
    String? otherOptionsId,
    AuthStatus? status,
  }) {
    return AuthenticationState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      code: code ?? this.code,
      otherOptionsId: otherOptionsId ?? this.otherOptionsId,
      status: status ?? this.status,
    );
  }
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {}
