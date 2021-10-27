import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/dashboard/dashboard_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/service/freezer_service.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FreezerService());
    Get.put(DashBoardController());
    Get.put(FreezerController(Get.find()));
  }
}
