import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app_status.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (AppStatus.APP_STATUS == AppState.loading) {
          return const Splash();
        }
        return const GetMaterialApp(
          initialRoute: '/',
          routes: {},
        );
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
    );
  }
}
