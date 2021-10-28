import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  final AuthenticationRepository repository = AuthenticationRepository();

  Future init() async {
    try {
      emit(AuthenticationLoading());
      final result = await repository.verify();
      if (result) {
        emit(state.copyWith(
          status: AuthStatus.authenticate,
        ));
      } else {
        Future.delayed(const Duration(seconds: 5),
            () => emit(AuthenticationUnauthenticated()));
      }

      Future.delayed(
          const Duration(seconds: 3), () => emit(AuthenticationLoaded()));
    } catch (e) {
      Future.delayed(const Duration(seconds: 3),
          () => emit(AuthenticationUnauthenticated()));
    }
  }

  Future<bool> logout() async {
    final result = repository.logout();
    return result;
  }
}
