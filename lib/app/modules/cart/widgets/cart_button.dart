import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';

class CartButton extends StatelessWidget {
  CartButton({Key? key}) : super(key: key);
  //CartController controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GetBuilder<CartController>(builder: (controller) {
            return Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(200),
              ),
              child: Center(
                child: Text(
                  '${controller.totalItens}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
              ),
            );
          }),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/carrinho.png'),
          ),
        ],
      ),
    );
  }
}
