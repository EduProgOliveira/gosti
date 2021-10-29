import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gosti_mobile/app/modules/checkout/models/card_token.dart';
import 'package:gosti_mobile/app/modules/checkout/models/payment.dart';
import 'package:gosti_mobile/app_config.dart';
import 'package:gosti_mobile/app_urls.dart';

class CheckoutService {
  Dio _dio = Dio();

  Future doPayment({required Payment payment}) async {
    try {
      Response response = await _dio.post(
        AppUrls.WS_MP +
            '/payments?access_token=' +
            AppConfigMP.ACCESS_TOKEN_TEST,
        data: jsonEncode(payment),
      );
      if (response.statusCode == 201) {
        print(response.data['status']);
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      return {};
    }
  }

  cardToken({required CardToken card}) async {
    try {
      Response response = await _dio.post(
        AppUrls.WS_MP +
            '/card_tokens?access_token=' +
            AppConfigMP.ACCESS_TOKEN_TEST,
        data: jsonEncode(card),
      );

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
