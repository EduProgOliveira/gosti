import 'package:dio/dio.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class ProductService {
  Dio dio = Dio();

  getProduct({required int idProduct}) async {
    try {
      Response response = await dio.get(
        AppUrls.WS_BASE + AppUrls.PRODUCT + '/$idProduct',
        options: Options(
          headers: {"Authorization": "Bearer ${AppPreferences.TOKEN}"},
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
    try {
      Response response = await dio.get(
        AppUrls.WS_BASE + AppUrls.PRODUCT_LIST + '/$idEquip',
        options: Options(
          headers: {"Authorization": "Bearer ${AppPreferences.TOKEN}"},
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
