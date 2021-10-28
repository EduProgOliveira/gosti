import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:gosti_mobile/app/core/common_widgets/country_code.dart';
import 'package:gosti_mobile/app/core/common_widgets/email.dart';
import 'package:gosti_mobile/app/core/common_widgets/password.dart';
import 'package:gosti_mobile/app/core/common_widgets/phone.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void emailChanged(String value) {
    var email = Email.pure();
    if (value != '') {
      email = Email.dirty(value);
    }

    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
        state.phone,
        state.countryCode,
      ]),
    ));
  }

  void phoneChanged(String value) {
    var phone = const Phone.pure();
    if (value != '') {
      phone = Phone.dirty(value);
    }

    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([
        phone,
        state.password,
        state.email,
        state.countryCode,
      ]),
    ));
  }

  void countryCodeChanged(String value) {
    var countryCode = const CountryCode.pure();
    if (value != '') {
      countryCode = CountryCode.dirty(value);
    }

    emit(state.copyWith(
      countryCode: countryCode,
      status: Formz.validate([
        countryCode,
        state.password,
        state.phone,
        state.email,
      ]),
    ));
  }

  void passwordChanged(String value) {
    var password = Password.pure();
    if (value != '') {
      password = Password.dirty(value);
    }

    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.email,
        state.phone,
        state.countryCode,
      ]),
    ));
  }

  Future<bool> logInWithCredentials() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final completePhone = state.countryCode.value + state.phone.value;

      await _authenticationRepository.logInWithEmailOrPhoneAndPassword(
        email: state.email.value,
        phone: completePhone,
        password: state.password.value,
        keepConnected: state.keepConnected,
      );

      await Future.delayed(Duration(seconds: 3), () {
        emit(state.copyWith(
          status: FormzStatus.submissionSuccess,
          email: Email.pure(),
          phone: Phone.pure(),
          countryCode: CountryCode.pure(),
          password: Password.pure(),
        ));
      });

      //emit(state.copyWith(status: FormzStatus.submissionSuccess));
      return true;
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return false;
    }
  }

  Future<bool> forgotPassword() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.forgotPassword(
        email: state.email.value,
        phone: state.countryCode.value + state.phone.value,
      );
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
        forgotPasswordRequest: ForgotPasswordRequest.enabled,
      ));
      return true;
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
      return false;
    }
  }

  void resetModal() {
    emit(state.copyWith(
      openOtherOptionsModal: false,
    ));
  }

  void handleKeepConnected() {
    emit(state.copyWith(
      keepConnected: !state.keepConnected,
    ));
  }

  /*Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final completePhone = state.countryCode.value + state.phone.value;
      await _authenticationRepository.logInWithGoogle(
        completePhone,
        state.keepConnected,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        openOtherOptionsModal: true,
      ));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }*/

  /*Future<void> logInWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final completePhone = state.countryCode.value + state.phone.value;
      await _authenticationRepository.logInWithFacebook(
          completePhone, state.keepConnected);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        openOtherOptionsModal: true,
      ));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }*/
}
