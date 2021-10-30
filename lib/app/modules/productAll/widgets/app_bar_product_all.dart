import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/cart/widgets/cart_button.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';

class AppBarProductAll extends StatelessWidget {
  AppBarProductAll({Key? key}) : super(key: key);
  FreezerController freezerController = Get.find<FreezerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 10),
            child: Row(
              children: [
                Text(
                  'Gosti - ',
                  style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 20),
                ),
                Text(
                  'Lista de Produtos',
                  style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),
          CartButton(),
        ],
      ),
    );
  }
}
