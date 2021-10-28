import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/app_bars.dart';
import 'package:gosti_mobile/app/core/common_widgets/default_text_button.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app/modules/confirm_password/view/confirm_password_page.dart';
import 'package:gosti_mobile/app/modules/login/view/view.dart';
import 'package:gosti_mobile/app/modules/verification_code/cubit/verification_code_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class VerificationCodePage extends StatefulWidget {
  final String email;
  final String phone;
  final String? otherOptionsId;

  const VerificationCodePage({
    Key? key,
    required this.email,
    required this.phone,
    this.otherOptionsId,
  }) : super(key: key);

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  VerificationCodeCubit bloc =
      VerificationCodeCubit(AuthenticationRepository());

  late Timer _timer;
  int _start = 600;
  bool _enableResendPassword = false;
  var _pinController = TextEditingController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _pinController.clear();
            _enableResendPassword = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    //bloc = Modular.get<VerificationCodeCubit>();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(showBackChevron: false),
      body: BlocListener<VerificationCodeCubit, VerificationCodeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == CodeStatus.failed &&
              state.resendPassword == ResendPassword.enabled) {
            _enableResendPassword = false;
            _start = 600;
            startTimer();

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                    content: Text('Código reenviado para ${widget.email}')),
              );

            return;
          }

          if (state.status == CodeStatus.failed) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Código inválido')),
              );
          }

          if (state.status == CodeStatus.success) {
            if (widget.otherOptionsId != null) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));

              return;
            }

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfirmPasswordPage(
                        email: widget.email,
                        phone: widget.phone,
                        code: state.code)));
          }
        },
        child: _CodeInput(
          timer: _start,
          enableResendPassword: _enableResendPassword,
          pinController: _pinController,
          resendCode: () {
            bloc.resendVerificationCode(
              email: widget.email,
              phone: widget.phone,
            );
          },
          onCodeValidation: (code) {
            if (widget.otherOptionsId != null) {
              bloc.checkVerificationCodeAndSetPassword(
                code: code.toUpperCase(),
                email: widget.email,
                phone: widget.phone,
                password: widget.otherOptionsId ?? '',
              );
            } else {
              bloc.checkVerificationCode(
                code: code.toUpperCase(),
                email: widget.email,
                phone: widget.phone,
              );
            }
          },
        ),
      ),
    );
  }
}

class _CodeInput extends StatelessWidget {
  final timer;
  final enableResendPassword;
  final Function onCodeValidation;
  final Function resendCode;
  final TextEditingController pinController;

  const _CodeInput({
    Key? key,
    this.timer,
    required this.onCodeValidation,
    required this.pinController,
    required this.resendCode,
    this.enableResendPassword,
  }) : super(key: key);

  String getTimerInMinutes(int timer) {
    int minutesInt = timer != 0 ? (timer / 60).ceil() - 1 : 0;
    int minutes = int.parse(minutesInt.toString());
    int seconds = timer % 60;

    var secondsStr = seconds.toString();
    var minutesStr = minutes.toString();

    if (minutes < 10) {
      minutesStr = '0${minutes.toString()}';
    }

    if (seconds < 10) {
      secondsStr = '0${seconds.toString()}';
    }

    return '${minutesStr}:${secondsStr}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'Informe o código de validação recebido no seu e-mail.',
              textAlign: TextAlign.center,
              style: AppTextStyles.titleBold,
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PinCodeTextField(
                controller: pinController,
                appContext: context,
                animationType: AnimationType.scale,
                inputFormatters: [
                  UpperCaseTextFormatter(),
                ],
                length: 6,
                textCapitalization: TextCapitalization.characters,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5.0),
                  activeColor: Colors.red.shade200,
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.red.shade400,
                  selectedColor: Colors.red.shade800,
                ),
                onCompleted: (code) => onCodeValidation(code),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '*Seu código será válido por ${getTimerInMinutes(timer)}',
                    style: AppTextStyles.body,
                  ),
                  DefaultTextButton(
                    text: 'Reenviar código',
                    enabled: enableResendPassword,
                    onPressed:
                        !enableResendPassword ? null : () => resendCode(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
