import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/models/card_token.dart';
import 'package:gosti_mobile/app/modules/checkout/models/payment.dart';
import 'package:gosti_mobile/app/modules/checkout/models/payment_response.dart';
import 'package:gosti_mobile/app_config.dart';
import 'package:gosti_mobile/app_msg_mp.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:gosti_mobile/app_urls.dart';

class CheckoutService {
  Dio _dio = Dio();
  CartController controller = Get.find<CartController>();

  Future doPayment({required Payment payment}) async {
    try {
      var response = await _dio.post(
        AppUrls.WS_MP +
            '/payments?access_token=' +
            AppConfigMP.ACCESS_TOKEN_TEST,
        data: jsonEncode(payment),
      );
      if (response.statusCode == 201) {
        var msg = AppMsgMP();
        msg.msg(
            id: response.data['id'],
            msg: response.data['status'],
            msg_details: response.data['status_detail']);
        var res = await checkPayment(
            PaymentResponse.fromJson(response.data, controller.pedido));
        print(res);
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
      return {};
    }
  }

  checkPayment(PaymentResponse payment) async {
    Dio dio = Dio();
    var token = await AppPreferences.TOKEN();
    if (token.isEmpty) {
      Get.toNamed(AppPages.LOGIN);
    }
    try {
      var response = await dio.post(
        AppUrls.WS_BASE + AppUrls.CHECKOUT,
        data: jsonEncode(payment.toJson()),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      if (response.statusCode == 200) {
        print(response);
        return response.data;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response!.data);
    }
  }

  cardToken({required CardToken card}) async {
    try {
      var response = await _dio.post(
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
