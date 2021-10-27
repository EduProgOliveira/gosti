import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';
import 'package:gosti_mobile/app/modules/service/freezer_service.dart';

enum StatusFreezer { loading, fail, start, load }

class FreezerController extends GetxController {
  FreezerController(this._service);
  final FreezerService _service;
  late Freezer _freezer;
  List<Freezer> listFreezer = [];
  var status = StatusFreezer.start.obs;

  Freezer freezer() => _freezer;
  setFreezer(Freezer freezer) => _freezer = freezer;

  loadListFreezer() async {
    listFreezer = [];
    status.value = StatusFreezer.loading;
    var response = await _service.getListFreezer();
    if (response != null) {
      for (var item in response) {
        listFreezer.add(Freezer.fromJson(item));
      }
    }
    status.value = StatusFreezer.load;
  }
}
