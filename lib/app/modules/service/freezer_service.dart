import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class FreezerService {
  Dio dio = Dio();

  getListFreezer() async {
    var token = await AppPreferences.TOKEN();
    if (token.isEmpty) {
      Get.toNamed(AppPages.LOGIN);
    }

    try {
      var response = await dio.post(
        AppUrls.WS_BASE + AppUrls.FREEZER,
        data: {"latitude": -24.152495, "longitude": -49.824729, "maximo": 2000},
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
