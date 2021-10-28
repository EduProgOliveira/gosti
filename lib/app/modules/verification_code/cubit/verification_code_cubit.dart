import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';

part 'verification_code_state.dart';

class VerificationCodeCubit extends Cubit<VerificationCodeState> {
  VerificationCodeCubit(this._authenticationRepository)
      : super(VerificationCodeState());

  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  Future checkVerificationCode({
    required String email,
    required String phone,
    required String code,
  }) async {
    try {
      emit(state.copyWith(status: CodeStatus.loading));
      await _authenticationRepository.verifyCode(
        code: code,
        email: email,
        phone: phone,
      );
      emit(state.copyWith(
        status: CodeStatus.success,
        code: code,
      ));
      return;
    } on Exception {
      emit(state.copyWith(status: CodeStatus.failed));
    }
  }

  Future<void> checkVerificationCodeAndSetPassword({
    required String email,
    required String password,
    required String phone,
    required String code,
  }) async {
    emit(state.copyWith(status: CodeStatus.loading));
    try {
      await _authenticationRepository.verifyCodeAndSetPassword(
        code: code,
        email: email,
        password: password,
        phone: phone,
      );
      emit(state.copyWith(status: CodeStatus.success));
    } on Exception {
      emit(state.copyWith(status: CodeStatus.failed));
    }
  }

  Future<void> resendVerificationCode({
    required email,
    required phone,
  }) async {
    emit(state.copyWith(status: CodeStatus.loading));
    try {
      await _authenticationRepository.forgotPassword(
        email: email,
        phone: phone,
      );

      emit(state.copyWith(
        status: CodeStatus.success,
        resendPassword: ResendPassword.enabled,
      ));
    } on Exception {
      emit(state.copyWith(status: CodeStatus.failed));
    }
  }
}
