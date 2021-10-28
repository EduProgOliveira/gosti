import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:gosti_mobile/app_preferences.dart';
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
          initialRoute: AppStatus.APP_STATUS == AppState.authenticate
              ? AppPages.HOME
              : AppPages.LOGIN,
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
  await Future.delayed(const Duration(seconds: 3));
  await AppPreferences.TOKEN().then((token) => token.isNotEmpty
      ? AppStatus.APP_STATUS = AppState.authenticate
      : AppStatus.APP_STATUS = AppState.unauthenticated);
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/launch_image.png');
  }
}
