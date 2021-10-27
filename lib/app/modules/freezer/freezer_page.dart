import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/app_bar_freezer.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/freezer_list.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/search_freezer.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';

class FreezerPage extends GetView<FreezerController> {
  FreezerPage({Key? key}) : super(key: key);
  FreezerPagesController pages = Get.find<FreezerPagesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarFreezer(),
          SearchFreezer(),
          FreezerList(),
        ],
      ),
    );
  }
}
