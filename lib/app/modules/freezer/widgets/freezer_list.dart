import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/freezer_list_item.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';

class FreezerList extends StatelessWidget {
  FreezerList({Key? key, required this.listFreezer}) : super(key: key);
  FreezerController controller = Get.find<FreezerController>();
  final List<Freezer> listFreezer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          return await controller.loadListFreezer();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: listFreezer
                .map((freezer) =>
                    freezerItem(freezer: freezer, controller: controller))
                .toList(),
          ),
        ),
      ),
    );
  }
}

Widget freezerItem(
    {required Freezer freezer, required FreezerController controller}) {
  FreezerPagesController pages = Get.find<FreezerPagesController>();

  return GestureDetector(
    onTap: () {
      controller.setFreezer(freezer);
      pages.pageController.jumpToPage(1);
    },
    child: FreezerListItem(
      freezer: freezer,
    ),
  );
}
