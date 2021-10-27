import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_binding.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_page.dart';
import 'package:gosti_mobile/app/modules/home/home_binding.dart';
import 'package:gosti_mobile/app/modules/home/home_page.dart';
import 'package:gosti_mobile/app_pages.dart';

class AppRoutes {
  AppRoutes._();
  static var routes = <GetPage>[
    GetPage(
        name: AppPages.HOME,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
      name: AppPages.DASHBOARD,
      page: () => const DashBoardPage(),
      binding: DashBoardBinding(),
    ),
  ];
}
