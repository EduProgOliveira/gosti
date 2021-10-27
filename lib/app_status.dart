enum AppState { authenticate, unauthenticated, loading, first }

class AppStatus {
  AppStatus._();

  static var APP_STATUS = AppState.first;
}
