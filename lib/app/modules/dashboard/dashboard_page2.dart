import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages.dart';
import 'package:gosti_mobile/app/modules/request/request_page.dart';
import 'package:gosti_mobile/app/modules/setting/setting_page.dart';
import 'package:gosti_mobile/app_pages.dart';

class DashBoardPage extends StatefulWidget {
  DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _page = 0;
  final screens = [
    Container(
      child: Column(
        children: [
          Center(
            child: Text('First'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(AppPages.CART);
            },
            child: Text('OUTRA PAGINA'),
          ),
        ],
      ),
    ),
    Container(
      child: Center(
        child: Text('Secund'),
      ),
    ),
    Container(
      child: Center(
        child: Text('Secund3'),
      ),
    ),
    Container(
      child: const Center(
        child: Text('Lista de produtos'),
      ),
    ),
    SettingPage(),
  ];

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Scaffold(
        body: IndexedStack(
          index: _page,
          children: screens,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          color: AppColors.primaryColor,
          buttonBackgroundColor: AppColors.primaryColor,
          backgroundColor: AppColors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          //letIndexChange: (index) => index != 0,
          height: 50,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: [
            Image.asset(
              'assets/icons/home.png',
              width: 30,
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
