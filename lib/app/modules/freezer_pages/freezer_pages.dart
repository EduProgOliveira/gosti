import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_page.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';
import 'package:gosti_mobile/app/modules/product/product_page.dart';

class FreezerPages extends StatelessWidget {
  FreezerPages({Key? key}) : super(key: key);
  FreezerPagesController controller = Get.find<FreezerPagesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          FreezerPage(),
          ProductPage(),
        ],
      ),
    );
  }
}
