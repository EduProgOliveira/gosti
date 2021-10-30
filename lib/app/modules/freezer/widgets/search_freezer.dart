import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';

class SearchFreezer extends StatelessWidget {
  SearchFreezer({Key? key}) : super(key: key);
  FreezerController controller = Get.find<FreezerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: 'Localize um freezer',
          hintStyle: AppTextStyles.body20.copyWith(fontSize: 16),
          contentPadding: const EdgeInsets.all(10),
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
        ),
        onChanged: controller.searchFreezer,
      ),
    );
  }
}
