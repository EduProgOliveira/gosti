import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';

class AppBarProduct extends StatelessWidget {
  AppBarProduct({Key? key}) : super(key: key);
  FreezerController freezerController = Get.find<FreezerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppColors.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'Gosti - ',
                style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 20),
              ),
              Text(
                '${freezerController.freezer().nome!}',
                style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          Text(
            'FREEZER',
            style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
