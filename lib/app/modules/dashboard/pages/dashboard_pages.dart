import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_page.dart';
import 'package:gosti_mobile/app/modules/request/request_page.dart';
import 'package:gosti_mobile/app/modules/setting/setting_page.dart';

class DashBoardPages {
  List<Widget> pages() => [
        Container(),
        const RequestPage(),
        const FreezerPage(),
        Container(),
        const SettingPage(),
      ];
}
