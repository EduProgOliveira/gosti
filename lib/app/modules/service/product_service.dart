import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class ProductService {
  Dio dio = Dio();

  getProduct({required int idProduct}) async {
    var token = await AppPreferences.TOKEN();
    if (token.isEmpty) {
      Get.toNamed(AppPages.LOGIN);
    }
    try {
      var response = await dio.get(
        AppUrls.WS_BASE + AppUrls.PRODUCT + '/$idProduct',
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

  getListProduct({required int idEquip}) async {
    var token = await AppPreferences.TOKEN();
    if (token.isEmpty) {
      Get.toNamed(AppPages.LOGIN);
    }
    try {
      var response = await dio.get(
        AppUrls.WS_BASE + AppUrls.PRODUCT_LIST + '/$idEquip',
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
