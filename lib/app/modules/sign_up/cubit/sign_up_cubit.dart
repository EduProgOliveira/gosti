import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gosti_mobile/app/core/common_widgets/confirmed_password.dart';
import 'package:gosti_mobile/app/core/common_widgets/country_code.dart';
import 'package:gosti_mobile/app/core/common_widgets/email.dart';
import 'package:gosti_mobile/app/core/common_widgets/password.dart';
import 'package:gosti_mobile/app/core/common_widgets/phone.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app/modules/sign_up/utils/utils.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authenticationRepository) : super(const SignUpState());

  AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  void emailChanged(String value) {
    var email = Email.pure();
    if (value != '') {
      email = Email.dirty(value);
    }

    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.phone]),
    ));
  }

  void phoneChanged(String value) {
    var phone = Phone.pure();
    if (value != '') {
      phone = Phone.dirty(value);
    }

    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone, state.email]),
    ));
  }

  void countryCodeChanged(String value) {
    var countryCode = CountryCode.pure();
    if (value != '') {
      countryCode = CountryCode.dirty(value);
    }

    emit(state.copyWith(
      countryCode: countryCode,
      status: Formz.validate([state.phone, countryCode]),
    ));
  }

  void otherOptionsPhoneChanged(String value) {
    var phone = Phone.pure();
    if (value != '') {
      phone = Phone.dirty(value);
    }

    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone]),
    ));
  }

  /*Future<void> signUpWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final completePhone = state.countryCode.value + state.phone.value;
      final user =
          await _authenticationRepository.signUpWithGoogle(completePhone);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      emit(state.copyWith(
        email: Email.dirty(user.email ?? ''),
        phone: Phone.dirty(user.telefone ?? ''),
        password: Password.dirty(user.id ?? ''),
        isSigningWithGoogle: true,
      ));
    } on Exception {
      await _authenticationRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }*/

  /*Future<void> signUpWithFacebook() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final completePhone = state.countryCode.value + state.phone.value;
      final user =
          await _authenticationRepository.signUpWithFacebook(completePhone);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));

      emit(state.copyWith(
        email: Email.dirty(user.email ?? ''),
        phone: Phone.dirty(user.telefone ?? ''),
        password: Password.dirty(user.id ?? ''),
        isSigningWithGoogle: true,
      ));
    } on Exception {
      await _authenticationRepository.logOut();
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError {
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }*/

  Future signUpFormSubmitted() async {
    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
        password: Password.dirty(getRandomString(6)),
      ),
    );

    try {
      bool val = await _authenticationRepository.signUp(
        email: state.email.value,
        phone: state.countryCode.value + state.phone.value,
        password: state.password.value,
      );

      if (val) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
