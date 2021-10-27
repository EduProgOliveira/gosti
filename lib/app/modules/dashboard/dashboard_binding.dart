import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<FreezerController>(() => FreezerController());
  }
}
