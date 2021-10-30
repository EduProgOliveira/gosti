import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_controller.dart';
import 'package:gosti_mobile/app/modules/dashboard/pages/dashboard_pages.dart';
import 'package:gosti_mobile/app/modules/dashboard/widget/mensagem_sheet.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';

class DashBoardPage extends GetView<DashBoardController> {
  DashBoardPage({Key? key}) : super(key: key);
  FreezerPagesController pages = Get.put(FreezerPagesController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (pages.pageController.page!.round() == 1 &&
            pages.cartController.listCart.length > 0) {
          if (await MensagemSheet.productBack()) {
            pages.cleanCarController();
            pages.pageController.jumpToPage(0);
          }
          return Future.value(false);
        }
        if (pages.pageController.page!.round() == 1) {
          pages.pageController.jumpToPage(0);
          return Future.value(false);
        }
        if (pages.pageController.page!.round() == 0) {
          Get.back();
          return Future.value(false);
        }
        return Future.value(false);
      },
      child: Scaffold(
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
              onTap: () async {
                if (pages.pageController.page!.round() == 1 &&
                    pages.cartController.listCart.length > 0) {
                  if (await MensagemSheet.productBack()) {
                    Get.back();
                  }
                } else if (pages.pageController.page!.round() == 1) {
                  Get.back();
                } else if (pages.pageController.page!.round() == 0) {
                  Get.back();
                }
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
      ),
    );
  }
}
