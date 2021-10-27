import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';

class FreezerController extends GetxController {
  final Freezer _freezer = Freezer(nome: 'Tottalité');
  freezer() => _freezer;
}
