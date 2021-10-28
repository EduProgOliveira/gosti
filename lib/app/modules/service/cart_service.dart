import 'package:dio/dio.dart';
import 'package:gosti_mobile/app/modules/cart/models/valid_cart.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class CartService {
  Dio _dio = Dio();

  validCart(ValidCart validCart) async {
    try {
      Response response = await _dio.post(
        AppUrls.WS_BASE + AppUrls.CART,
        data: validCart.toJson(),
        options: Options(headers: {
          "Authorization": "Bearer ${await AppPreferences.TOKEN()}",
        }),
      );
      if (response.statusCode == 200) {
        return ValidCart.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.error);
    }
  }
}
