import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gosti_mobile/app/core/common_widgets/confirmed_password.dart';
import 'package:gosti_mobile/app/core/common_widgets/password.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';

part 'confirm_password_state.dart';

class ConfirmPasswordCubit extends Cubit<ConfirmPasswordState> {
  ConfirmPasswordCubit() : super(ConfirmPasswordState());

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  Future<bool> createPassword({
    required String code,
    required String email,
    required String phone,
  }) async {
    print('senha nova cubit');
    print(code);
    print(email);
    print(phone);
    try {
      await _authenticationRepository.setPassword(
        code: code,
        email: email,
        password: state.password.value,
        phone: phone,
      );
      await Future.delayed(const Duration(seconds: 3));
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));

      return true;
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return false;
    }
  }
}
