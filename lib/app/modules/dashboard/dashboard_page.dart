import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_controller.dart';
import 'package:gosti_mobile/app/modules/dashboard/pages/dashboard_pages.dart';

class DashBoardPage extends GetView<DashBoardController> {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: DashBoardPages().pages(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: 2,
        color: AppColors.primaryColor,
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        letIndexChange: (index) => index != 0,
        height: 50,
        onTap: (index) {
          controller.pageController.jumpToPage(index);
        },
        items: [
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              'assets/icons/home.png',
              width: 30,
            ),
          ),
          Image.asset(
            'assets/icons/pedidos.png',
            width: 30,
          ),
          Image.asset(
            'assets/icons/lupa1.png',
            width: 30,
          ),
          Image.asset(
            'assets/icons/lista-produtos.png',
            width: 40,
          ),
          Image.asset(
            'assets/icons/perfil.png',
            width: 30,
          ),
        ],
      ),
    );
  }
}
