import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/common_widgets/app_bars.dart';
import 'package:gosti_mobile/app/modules/confirm_password/view/confirm_password_form.dart';

class ConfirmPasswordPage extends StatefulWidget {
  const ConfirmPasswordPage({
    Key? key,
    required this.email,
    required this.phone,
    required this.code,
  }) : super(key: key);

  /* static Page page(AuthStatusFlow authFlow) => MaterialPage<void>(
        child: ConfirmPasswordPage(
          code: authFlow.code,
          email: authFlow.email,
          phone: authFlow.phone,
        ),
      );*/

  final String email;
  final String phone;
  final String code;

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(showBackChevron: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ConfirmPasswordForm(
            code: widget.code,
            email: widget.email,
            phone: widget.phone,
          ),
        ),
      ),
    );
  }
}
