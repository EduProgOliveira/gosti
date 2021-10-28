import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/common_widgets/app_bars.dart';
import 'package:gosti_mobile/app/modules/login/view/view.dart';

class LoginPage extends StatefulWidget {
  static Page page() => MaterialPage<void>(child: LoginPage());

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: LoginForm(),
      ),
    );
  }
}
