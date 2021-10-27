enum AppState { authenticate, unauthenticated, loading, first }

class AppStatus {
  AppStatus._();

  static const APP_STATUS = AppState.first;
}
