import 'package:dio/dio.dart';
import 'package:gosti_mobile/app/modules/checkout/models/card_token.dart';
import 'package:gosti_mobile/app/modules/checkout/models/payment.dart';
import 'package:gosti_mobile/app_config.dart';
import 'package:gosti_mobile/app_urls.dart';

class CheckoutService {
  Dio _dio = Dio();

  doPayment({required Payment payment}) async {
    Response response = await _dio.post(
      AppUrls.WS_MP + '/payments',
      data: payment.toJson(),
      options: Options(
        headers: {
          "Authentication": "Bearer " + AppConfigMP.ACCESS_TOKEN_TEST,
        },
      ),
    );
    if (response.statusCode == 201) {
      print(response.data);
      return response.data['status'];
    }
    return null;
  }

  cardToken({required CardToken card}) async {
    try {
      Response response = await _dio.post(
        AppUrls.WS_MP + '/card_tokens',
        data: card.toJson(),
        options: Options(
          headers: {
            "Authentication": "Bearer " + AppConfigMP.ACCESS_TOKEN_TEST,
          },
        ),
      );

      print(response);

      if (response.statusCode == 201) {
        return response.data['id'];
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.message);
      return null;
    }
  }
}
