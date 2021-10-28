import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';

class AppBarCheckout extends StatelessWidget {
  const AppBarCheckout({Key? key}) : super(key: key);

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
          Text(
            'Gosti',
            style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 20),
          ),
          Text(
            'CHECKOUT',
            style: AppTextStyles.buttonTextStyle.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
