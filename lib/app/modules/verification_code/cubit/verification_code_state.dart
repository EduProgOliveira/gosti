part of 'verification_code_cubit.dart';

enum CodeStatus { success, failed, pending, loading }

enum ResendPassword { enabled, disabled }

class VerificationCodeState extends Equatable {
  const VerificationCodeState({
    this.code = '',
    this.status = CodeStatus.pending,
    this.resendPassword = ResendPassword.disabled,
  });

  final String code;
  final CodeStatus status;
  final ResendPassword resendPassword;

  @override
  List<Object> get props => [code, status, resendPassword];

  VerificationCodeState copyWith({
    String? code,
    CodeStatus? status,
    ResendPassword? resendPassword,
  }) =>
      VerificationCodeState(
        code: code ?? this.code,
        status: status ?? this.status,
        resendPassword: resendPassword ?? this.resendPassword,
      );
}
