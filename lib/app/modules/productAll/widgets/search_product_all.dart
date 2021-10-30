import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/productAll/product_all_controller.dart';

class SearchProductAll extends StatelessWidget {
  SearchProductAll({Key? key}) : super(key: key);
  ProductAllController controller = Get.find<ProductAllController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: 'Localize um produto',
          hintStyle: AppTextStyles.body20.copyWith(fontSize: 16),
          contentPadding: const EdgeInsets.all(10),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        onChanged: controller.search,
      ),
    );
  }
}
