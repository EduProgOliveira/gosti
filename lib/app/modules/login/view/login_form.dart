import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:country_code_picker/country_code_picker.dart' as country;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_images.dart';
import 'package:gosti_mobile/app/core/common_widgets/default_elevated_button.dart';
import 'package:gosti_mobile/app/core/common_widgets/default_text_button.dart';
import 'package:gosti_mobile/app/core/common_widgets/image_elevated_button.dart';
import 'package:gosti_mobile/app/modules/login/cubit/login_cubit.dart';
import 'package:gosti_mobile/app/modules/verification_code/view/verification_code_page.dart';
import 'package:gosti_mobile/app_pages.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool keepConnected = false;
  LoginCubit bloc = LoginCubit();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Falha de autenticação')),
            );

          if (state.email.value.contains('@gmail.com') ||
              state.openOtherOptionsModal) {
            /* showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Deseja fazer cadastro com o Google ou Facebook?',
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'other_options');
                          },
                          child: const Text('Sim'),
                        ),
                      ],
                    )).then((value) {
              if (value == 'other_options') {
                context.flow<AuthStatusFlow>().update(
                      (authStatusFlow) => authStatusFlow.copyWith(
                        status: AuthStatus.other_options,
                      ),
                    );
              }
            });*/
          }
        } else if (state.status.isSubmissionSuccess ||
            state.forgotPasswordRequest == ForgotPasswordRequest.enabled) {
          ;
          /*context.flow<AuthStatusFlow>().update(
                (authStatusFlow) => authStatusFlow.copyWith(
                  status: AuthStatus.verification_code,
                  email: state.email.value,
                  phone: state.countryCode.value + state.phone.value,
                ),
              );*/
        } else if (state.status.isSubmissionSuccess) {
          /*context.flow<AppStatus>().update(
                (appStatus) => AppStatus.authenticated,
              );*/
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32.0),
              _EmailInput(
                bloc: bloc,
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Ou',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              _PhoneInput(
                bloc: bloc,
              ),
              const SizedBox(height: 32.0),
              _PasswordInput(
                bloc: bloc,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        BlocBuilder<LoginCubit, LoginState>(
                          bloc: bloc,
                          builder: (context, state) {
                            return Checkbox(
                              checkColor: Colors.white,
                              value: state.keepConnected,
                              onChanged: (_) => bloc.handleKeepConnected(),
                            );
                          },
                        ),
                        Text('Manter conectado')
                      ],
                    ),
                    _ForgotPassword(
                      bloc: bloc,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    _LoginButton(
                      bloc: bloc,
                    ),
                    const SizedBox(height: 8.0),
                    _GoogleSignUp(),
                    const SizedBox(height: 8.0),
                    _FacebookSignUp(),
                    const SizedBox(height: 4.0),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: DefaultTextButton(
                  text: '+ NOVO CADASTRO',
                  onPressed: () {
                    Get.toNamed(AppPages.SIGNUP);
                    //Modular.to.navigate('/sign/');
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  final LoginCubit bloc;

  const _EmailInput({Key? key, required this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) => bloc.emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            labelText: 'E-mail',
            errorText: state.email.invalid ? 'E-mail inválido' : null,
          ),
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final LoginCubit bloc;

  const _PhoneInput({Key? key, required this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              country.CountryCodePicker(
                onChanged: (value) {
                  bloc.countryCodeChanged(value.dialCode.toString());
                },
                initialSelection: 'BR',
                favorite: ['BR', 'US'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
              Expanded(
                child: TextField(
                  key: const Key('loginForm_phoneInput_textField'),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    labelText: "DDD Telefone",
                    errorText: state.email.invalid ? 'Telefone inválido' : null,
                    border: InputBorder.none,
                  ),
                  onChanged: (phone) {
                    bloc.phoneChanged(phone);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  final LoginCubit bloc;

  const _PasswordInput({Key? key, required this.bloc}) : super(key: key);
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: widget.bloc,
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => widget.bloc.passwordChanged(password),
          obscureText: !showPassword,
          decoration: InputDecoration(
            labelText: 'Senha',
            prefixIcon: const Icon(Icons.lock_outline),
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
            errorText: state.password.invalid ? 'Senha Inválida' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatefulWidget {
  final LoginCubit bloc;

  const _LoginButton({Key? key, required this.bloc}) : super(key: key);

  @override
  State<_LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<_LoginButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: widget.bloc,
      buildWhen: (previous, current) =>
          previous.email != current.email ||
          previous.phone != current.phone ||
          previous.password != current.password ||
          previous.countryCode != current.countryCode,
      builder: (context, state) {
        return loading
            ? const CircularProgressIndicator()
            : DefaultElevatedButton(
                text: 'ENTRAR',
                enabled: state.password.valid &&
                    (state.email.valid || state.phone.valid) &&
                    state.countryCode.valid,
                onPressed: () async {
                  loading = true;
                  setState(() {});

                  if (await widget.bloc.logInWithCredentials()) {
                    loading = false;
                    Get.offAndToNamed(AppPages.HOME);
                  }
                  loading = false;
                  setState(() {});
                },
              );
      },
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  final LoginCubit bloc;

  const _ForgotPassword({Key? key, required this.bloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.email != current.email || previous.phone != current.phone,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (!state.email.valid && !state.phone.valid) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                      content: Text('Por favor informe Email e Telefone!')),
                );
            }
          },
          child: DefaultTextButton(
              text: 'ESQUECI A SENHA',
              enabled: bloc.state.phone.valid && state.email.valid,
              onPressed: () async {
                bool val = await bloc.forgotPassword();
                if (val) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VerificationCodePage(
                      email: state.email.value,
                      phone: state.countryCode.value + state.phone.value,
                    );
                  }));
                }
              }),
        );
      },
    );
  }
}

class _GoogleSignUp extends StatelessWidget {
  final LoginCubit bloc = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ImageElevatedButton(
          key: Key('loginForm_googleLogin_raisedButton'),
          text: 'ENTRAR COM ',
          imageAsset: AppImages.google,
          onPressed: () => {},
        );
      },
    );
  }
}

class _FacebookSignUp extends StatelessWidget {
  final LoginCubit bloc = LoginCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ImageElevatedButton(
          key: Key('loginForm_facebookLogin_raisedButton'),
          text: 'ENTRAR COM ',
          imageAsset: AppImages.facebook,
          onPressed: () => {},
        );
      },
    );
  }
}
