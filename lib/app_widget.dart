import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_routes.dart';
import 'package:gosti_mobile/app_status.dart';
import 'package:gosti_mobile/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkAuth(),
      builder: (context, snap) {
        if (AppStatus.APP_STATUS == AppState.loading) {
          return const Splash();
        }
        return GetMaterialApp(
          title: 'Gosti Mobile',
          defaultTransition: Transition.rightToLeft,
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.HOME,
          theme: theme,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}

checkAuth() async {
  AppStatus.APP_STATUS = AppState.loading;
  await Future.delayed(const Duration(seconds: 2));
  AppStatus.APP_STATUS = AppState.authenticate;
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
