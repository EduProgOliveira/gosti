import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/default_elevated_button.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app/modules/confirm_password/cubit/confirm_password_cubit.dart';

class ConfirmPasswordForm extends StatefulWidget {
  final String email;
  final String phone;
  final String code;

  const ConfirmPasswordForm({
    Key? key,
    required this.email,
    required this.phone,
    required this.code,
  }) : super(key: key);

  @override
  State<ConfirmPasswordForm> createState() => _ConfirmPasswordFormState();
}

class _ConfirmPasswordFormState extends State<ConfirmPasswordForm> {
  late ConfirmPasswordCubit bloc = ConfirmPasswordCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  validatePassword(String password) {
    setState(() {
      ConfirmPasswordCubit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfirmPasswordCubit, ConfirmPasswordState>(
      bloc: bloc,
      listener: (context, state) {
        if (bloc.state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Falha ao mudar senha')),
            );
        }

        if (bloc.state.status.isSubmissionSuccess) {
          //Future.delayed(Duration(seconds: 2), () => Modular.to.navigate('/login/'));
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: BlocBuilder<ConfirmPasswordCubit, ConfirmPasswordState>(
          bloc: bloc,
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Informe a nova senha',
                  style: AppTextStyles.titleBold,
                ),
                const SizedBox(height: 40),
                _PasswordInput(bloc: bloc),
                const SizedBox(height: 30),
                _ConfirmPasswordInput(
                  bloc: bloc,
                ),
                const SizedBox(height: 30),
                _ConfirmPasswordButton(
                  bloc: bloc,
                  code: widget.code,
                  email: widget.email,
                  phone: widget.phone,
                ),
                const SizedBox(height: 60),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PasswordInput extends StatefulWidget {
  final ConfirmPasswordCubit bloc;

  const _PasswordInput({Key? key, required this.bloc}) : super(key: key);

  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool showPassword = false;
  bool isMoreOrEqualEightChars = false;
  bool hasAtLeastOneNumber = false;
  bool hasAtLeastOneUpper = false;
  bool hasAtLeastOneLower = false;

  validatePassword(String password) {
    setState(() {
      hasAtLeastOneUpper = password.contains(RegExp(r'[A-Z]'));
      hasAtLeastOneLower = password.contains(RegExp(r'[a-z]'));
      isMoreOrEqualEightChars = password.contains(RegExp(r'(\w){8,}'));
      hasAtLeastOneNumber = password.contains(RegExp(r'(\d)'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmPasswordCubit, ConfirmPasswordState>(
      bloc: widget.bloc,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (password) {
                widget.bloc.passwordChanged(password);
                validatePassword(password);
              },
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Senha',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  iconSize: 22,
                  icon: Icon(
                    showPassword
                        ? FontAwesomeIcons.solidEye
                        : FontAwesomeIcons.solidEyeSlash,
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            // Text('Sua senha deve conter:'),
            // Row(
            //   children: [
            //     Checkbox(
            //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //       checkColor: Colors.white,
            //       value: isMoreOrEqualEightChars,
            //       onChanged: (bool? value) {},
            //     ),
            //     Text('Mínimo de 8 caracteres'),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Checkbox(
            //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //       checkColor: Colors.white,
            //       value: hasAtLeastOneNumber,
            //       onChanged: (bool? value) {},
            //     ),
            //     Text('1 número'),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Checkbox(
            //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //       checkColor: Colors.white,
            //       value: hasAtLeastOneLower,
            //       onChanged: (bool? value) {},
            //     ),
            //     Text('1 letra minúscula'),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Checkbox(
            //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //       checkColor: Colors.white,
            //       value: hasAtLeastOneUpper,
            //       onChanged: (bool? value) {},
            //     ),
            //     Text('1 letra maiúscula'),
            //   ],
            // )
          ],
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatefulWidget {
  final ConfirmPasswordCubit bloc;

  const _ConfirmPasswordInput({Key? key, required this.bloc}) : super(key: key);

  @override
  _ConfirmPasswordInputState createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<_ConfirmPasswordInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmPasswordCubit, ConfirmPasswordState>(
      bloc: widget.bloc,
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          onChanged: (password) =>
              widget.bloc.confirmedPasswordChanged(password),
          obscureText: !showPassword,
          decoration: InputDecoration(
            labelText: 'Confirmar Senha',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              iconSize: 22,
              icon: Icon(
                showPassword
                    ? FontAwesomeIcons.solidEye
                    : FontAwesomeIcons.solidEyeSlash,
              ),
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
            ),
            errorText: widget.bloc.state.confirmedPassword.invalid
                ? 'As senhas são diferentes'
                : null,
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordButton extends StatelessWidget {
  final ConfirmPasswordCubit bloc;
  bool showPassword = false;

  final String email;
  final String phone;
  final String code;

  _ConfirmPasswordButton({
    Key? key,
    required this.email,
    required this.phone,
    required this.code,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfirmPasswordCubit, ConfirmPasswordState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress ||
                state.status.isSubmissionSuccess
            ? const CircularProgressIndicator()
            : DefaultElevatedButton(
                text: 'CADASTRAR',
                enabled: state.status.isValidated,
                onPressed: () async {
                  bool val = await bloc.createPassword(
                    code: code,
                    email: email,
                    phone: phone,
                  );
                  if (val) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Senha alterada com Sucesso !')),
                      );
                    //Modular.to.popAndPushNamed('/login/');
                  } else {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Erro ao criar nova senha !')),
                      );
                  }
                },
              );
      },
    );
  }
}
