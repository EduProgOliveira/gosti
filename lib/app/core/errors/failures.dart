/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {
  final String? message;
  SignUpFailure({this.message});
}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {
  String? error;

  LogInWithGoogleFailure({this.error});
}

class LogInWithFacebookFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
