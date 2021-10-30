import 'package:flutter/cupertino.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/utils/check_card.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/models/card_token.dart';
import 'package:gosti_mobile/app/modules/checkout/models/checkout.dart';
import 'package:gosti_mobile/app/modules/checkout/models/payment.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/service/checkout_service.dart';
import 'package:gosti_mobile/app_msg_mp.dart';
import 'package:gosti_mobile/app_preferences.dart';

enum StatusCheck { loading, fail, success, start }

class CheckoutController extends GetxController {
  Checkout checkout = Checkout();
  CheckoutService _service = CheckoutService();
  var status = StatusCheck.start.obs;

  FreezerController freezerController = Get.find<FreezerController>();
  CartController cartController = Get.find<CartController>();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardName = TextEditingController();
  TextEditingController cardCode = TextEditingController();
  TextEditingController cardInstall = TextEditingController();
  TextEditingController cardDocNumber = TextEditingController();

  var cardValid = MaskedTextController(mask: '00/0000');
  String cardBand = '';

  payment() async {
    status.value = StatusCheck.loading;
    update();
    await Future.delayed(const Duration(seconds: 3));
    int? mes = int.parse(cardValid.text.substring(0, 2));
    int? ano = int.parse(cardValid.text.substring(3, 7));
    String email = 'teste@teste.com';
    if (AppPreferences.getEmail != '') {
      email = AppPreferences.getEmail!;
    }

    CardToken cardToken = CardToken(
      cardholder: Cardholder(
        identification: Identification(
          number: cardDocNumber.text,
          type: 'CPF',
        ),
        name: cardName.text,
      ),
      cardNumber: cardNumber.text,
      expirationMonth: mes,
      expirationYear: ano,
      securityCode: cardCode.text,
    );
    var token = await _service.cardToken(card: cardToken);
    if (token == null) {
      status.value = StatusCheck.fail;
      update();
      Get.back();
      return;
    }
    Payment payment = Payment(
      transactionAmount: cartController.total,
      token: token,
      description:
          "Pedido ${cartController.pedido} ${cartController.total} reais",
      installments: 1,
      paymentMethodId: cardBand,
      payer: Payer(email: email),
      externalReference:
          "Pedido${token.toString().substring(0, 6)}${cartController.total}",
      additionalInfo: AdditionalInfo(
        items: [
          Items(
            id: "${freezerController.freezer().nome}  ${cartController.total}",
            title: "Pedido ${cartController.pedido} ${cartController.total}",
            categoryId: "Gosti",
            quantity: 1,
            unitPrice: cartController.total,
          ),
        ],
      ),
    );
    var response = await _service.doPayment(payment: payment);
    var msg = AppMsgMP();
    msg.msg(
        id: response['id'] ?? 0,
        msg: response['status'] ?? '',
        msg_details: response['status_detail'],
        requestNumber: cartController.pedido);
    response['status'] == "approved"
        ? status.value = StatusCheck.success
        : StatusCheck.fail;
    update();
    Get.back();
    return;
  }
}
