import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages.dart';
import 'package:gosti_mobile/app/modules/productAll/all_product_page.dart';
import 'package:gosti_mobile/app/modules/request/request_page.dart';
import 'package:gosti_mobile/app/modules/setting/setting_page.dart';

class DashBoardPages {
  List<Widget> pages() => [
        Container(),
        const RequestPage(),
        FreezerPages(),
//        ProductAllPage(),
        Container(
          child: const Center(
            child: Text('Lista de produtos'),
          ),
        ),
        const SettingPage(),
      ];
}
