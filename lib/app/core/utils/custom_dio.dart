import 'package:dio/dio.dart';
import 'package:gosti_mobile/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDio {
  Dio dio = Dio();
  late final SharedPreferences prefs;
  var token = '';
  CustomDio() {
    SharedPreferences.getInstance().then((value) {
      token = value.getString('token')!;
      dio.options.baseUrl = AppUrls.WS_BASE;
      dio.interceptors.add(InterceptorsWrapper(
        onRequest: onRequest,
      ));
    });
  }

  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {"Authorization": "Bearer $token"};
  }
}
