import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/common_widgets/button_default_payment.dart';
import 'package:gosti_mobile/app/core/utils/utils.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/amount.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/app_bar_cart.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/list_cart_item.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/search_cart.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/voucher.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);
  FreezerController freezerController = Get.find<FreezerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartController>(builder: (controller) {
        return Column(
          children: [
            AppBarCart(),
            SearchCart(),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CartList(listCart: controller.listCart),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Amount(
                    text: 'Sub Total',
                    total: Utils.getValueInCurrency(20),
                  ),
                  const Voucher(),
                  Amount(
                    text: 'Total à Pagar',
                    total: Utils.getValueInCurrency(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: const Text('Incluir mais produtos'),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  ButtonDefaultPayment(
                    text: 'CONTINUAR PARA O PAGAMENTO',
                    //enabled: cubit.state.cartList.isEmpty ? false : true,
                    onPressed: () {
                      //cubit.checkOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
