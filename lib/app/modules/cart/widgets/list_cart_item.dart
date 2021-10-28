import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/utils/utils.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/cart/models/cart.dart';

class CartList extends StatelessWidget {
  const CartList({Key? key, required this.listCart}) : super(key: key);
  final List<CartItem> listCart;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: listCart.map((cart) => CartItemList(cart: cart)).toList());
  }
}

class CartItemList extends StatelessWidget {
  const CartItemList({Key? key, required this.cart}) : super(key: key);
  final CartItem cart;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  cart.name,
                  style: AppTextStyles.body.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text('Disponivel  '),
                Text('${cart.qtdAvailable - cart.qtd}'),
                IconButton(
                  onPressed: () {
                    controller.addItem(
                        id: cart.id,
                        name: cart.name,
                        qtdAvailable: cart.qtdAvailable,
                        price: cart.price);
                  },
                  icon: Icon(
                    Icons.add_circle_sharp,
                    color: AppColors.darkGreen,
                  ),
                ),
                Text('${cart.qtd}'),
                IconButton(
                  onPressed: () async {
                    if (cart.qtd == 1) {
                      await Get.defaultDialog(
                        title: 'Deseja remover este item do carrinho ?',
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                await controller.remove(id: cart.id);
                                Get.back();
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                elevation: 2,
                                backgroundColor: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Não',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                elevation: 2,
                                backgroundColor: AppColors.buttonCupom,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      controller.remove(id: cart.id);
                    }
                  },
                  icon: Icon(
                    Icons.do_not_disturb_on_sharp,
                    color: AppColors.darkRed,
                  ),
                ),
                Text(
                  Utils.getValueInCurrency(cart.price),
                  style: AppTextStyles.priceFoodItemBold,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  Utils.getValueInCurrency(cart.price * cart.qtd),
                  style: AppTextStyles.priceFoodItemBold,
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
