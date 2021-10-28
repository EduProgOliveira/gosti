import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/cart_page.dart';
import 'package:gosti_mobile/app/modules/checkout/checkout_page.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_binding.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_page.dart';
import 'package:gosti_mobile/app/modules/home/home_binding.dart';
import 'package:gosti_mobile/app/modules/home/home_page.dart';
import 'package:gosti_mobile/app/modules/login/login.dart';
import 'package:gosti_mobile/app/modules/sign_up/view/view.dart';
import 'package:gosti_mobile/app_pages.dart';

class AppRoutes {
  AppRoutes._();
  static var routes = <GetPage>[
    GetPage(
      name: AppPages.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppPages.SIGNUP,
      page: () => const SignUpPage(),
    ),
    GetPage(
        name: AppPages.HOME,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
      name: AppPages.DASHBOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: AppPages.CART,
      page: () => CartPage(),
    ),
    GetPage(
      name: AppPages.CHECKOUT,
      page: () => CheckoutPage(),
    ),
  ];
}
