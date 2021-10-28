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
import 'package:gosti_mobile/app_preferences.dart';

class CheckoutController extends GetxController {
  Checkout checkout = Checkout();
  CheckoutService _service = CheckoutService();

  FreezerController freezerController = Get.find<FreezerController>();
  CartController cartController = Get.find<CartController>();

  TextEditingController cardNumber = TextEditingController();
  TextEditingController cardName = TextEditingController();
  TextEditingController cardCode = TextEditingController();
  TextEditingController cardInstall = TextEditingController();
  TextEditingController cardDocNumber = TextEditingController();

  var cardValid = MaskedTextController(mask: '00/0000');
  String cardBand = '';

  Future<bool> payment() async {
    await Future.delayed(const Duration(seconds: 3));
    int? mes = int.parse(cardValid.text.substring(0, 2));
    int? ano = int.parse(cardValid.text.substring(3, 7));
    String email = await AppPreferences.EMAIL();

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
    Payment payment = Payment(
      transactionAmount: cartController.total,
      token: token,
      description:
          "Pedido ${token.toString().substring(0, 6)} ${cartController.total} reais",
      installments: 1,
      paymentMethodId: cardBand,
      payer: Payer(email: email),
      externalReference:
          "Pedido${token.toString().substring(0, 6)}${cartController.total}",
      additionalInfo: AdditionalInfo(
        items: [
          Items(
            id: "${freezerController.freezer().nome}  ${cartController.total}",
            title:
                "Pedido ${token.toString().substring(0, 6)} ${cartController.total}",
            categoryId: "Gosti",
            quantity: 1,
            unitPrice: cartController.total,
          ),
        ],
      ),
    );
    var status = await _service.doPayment(payment: payment);
    if (status == 'approved') {
      return true;
    }
    return false;
  }
}
