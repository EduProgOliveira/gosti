import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';
import 'package:gosti_mobile/app/modules/service/freezer_service.dart';

enum StatusFreezer { loading, fail, start, load, search, searchFail }

class FreezerController extends GetxController {
  FreezerController(this._service);
  final FreezerService _service;
  late Freezer _freezer;
  List<Freezer> listFreezer = [];
  List<Freezer> listSearch = [];
  var status = StatusFreezer.start.obs;

  Freezer freezer() => _freezer;
  setFreezer(Freezer freezer) => _freezer = freezer;

  searchFreezer(String text) {
    if (text.isNotEmpty) {
      status.value = StatusFreezer.search;
      listSearch = listFreezer.where((element) => element.nome!.toLowerCase().contains(text.toLowerCase())).toList();
      if (listSearch.isEmpty) {
        status.value = StatusFreezer.searchFail;
      }
    }
    if (text.isEmpty) {
      status.value = StatusFreezer.load;
      listSearch = [];
    }
  }

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
