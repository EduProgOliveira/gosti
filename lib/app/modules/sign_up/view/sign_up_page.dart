import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/common_widgets/app_bars.dart';
import 'package:gosti_mobile/app/modules/sign_up/view/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: SignUpPage());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //Modular.to.navigate('/login/');
        return Future.value(false);
      },
      child: Scaffold(
        appBar: buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
