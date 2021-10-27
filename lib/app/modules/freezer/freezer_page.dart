import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/app_bar_freezer.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/freezer_list.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/search_freezer.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';

class FreezerPage extends StatefulWidget {
  FreezerPage({Key? key}) : super(key: key);

  @override
  State<FreezerPage> createState() => _FreezerPageState();
}

class _FreezerPageState extends State<FreezerPage> {
  FreezerPagesController pages = Get.find<FreezerPagesController>();
  FreezerController controller = Get.find<FreezerController>();

  @override
  void initState() {
    controller.loadListFreezer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppBarFreezer(),
          const SearchFreezer(),
          Obx(() {
            if (controller.status.value == StatusFreezer.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.status.value == StatusFreezer.fail) {
              return const Center(
                child: Text('Erro'),
              );
            }
            return FreezerList(
              listFreezer: controller.listFreezer,
            );
          }),
        ],
      ),
    );
  }
}
