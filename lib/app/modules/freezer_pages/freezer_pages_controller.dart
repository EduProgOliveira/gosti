import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';

class FreezerPagesController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  CartController cartController = Get.put(CartController());

  cleanCarController() {
    cartController.clear();
  }
}
