import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/init_functions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class FreezerService {
  Dio dio = Dio();

  getListFreezer() async {
    Position position = await InitFunctions.getLocation();
    var token = await AppPreferences.TOKEN();
    if (token.isEmpty) {
      Get.toNamed(AppPages.LOGIN);
    }

    try {
      var response = await dio.post(
        AppUrls.WS_BASE + AppUrls.FREEZER,
        data: {
          "latitude": position.latitude,
          "longitude": position.longitude,
          "maximo": 2000
        },
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        return response.data;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response!.data);
    }
  }
}
