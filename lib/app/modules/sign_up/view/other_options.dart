import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_images.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/app_bars.dart';
import 'package:gosti_mobile/app/core/common_widgets/image_elevated_button.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app/modules/sign_up/cubit/sign_up_cubit.dart';

class OtherOptions extends StatefulWidget {
  const OtherOptions({Key? key}) : super(key: key);

  static Page page() => MaterialPage<void>(child: OtherOptions());

  @override
  State<OtherOptions> createState() => _OtherOptionsState();
}

class _OtherOptionsState extends State<OtherOptions> {
  SignUpCubit bloc = SignUpCubit(AuthenticationRepository());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocListener<SignUpCubit, SignUpState>(
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('Falha ao cadastrar'),
                    ),
                  );
              }

              if (state.status.isSubmissionSuccess) {
                //Modular.to.navigate('verification-code');

                /*context.flow<AuthStatusFlow>().update(
                      (authStatusFlow) => authStatusFlow.copyWith(
                        status: AuthStatus.verification_code,
                        email: state.email.value,
                        phone: state.phone.value,
                        otherOptionsId: state.password.value,
                      ),
                    );*/
              }
            },
            child: Align(
              alignment: const Alignment(0, -1 / 3),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 32.0),
                  Text(
                    'Novo cadastro',
                    style: AppTextStyles.titleBold,
                  ),
                  const SizedBox(height: 32.0),
                  _PhoneInput(),
                  const SizedBox(height: 64.0),
                  _GoogleSignUp(),
                  const SizedBox(height: 16.0),
                  _FacebookSignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
              CountryCodePicker(
                onChanged: (value) {
                  context
                      .read<SignUpCubit>()
                      .countryCodeChanged(value.dialCode.toString());
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
                      errorText:
                          state.email.invalid ? 'Telefone inválido' : null,
                      border: InputBorder.none,
                    ),
                    onChanged: (phone) {
                      context
                          .read<SignUpCubit>()
                          .otherOptionsPhoneChanged(phone);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GoogleSignUp extends StatelessWidget {
  const _GoogleSignUp();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ImageElevatedButton(
          key: Key('loginForm_googleLogin_raisedButton'),
          text: 'ENTRAR COM ',
          imageAsset: AppImages.google,
          onPressed: (state.phone.invalid ||
                  state.phone.pure ||
                  state.status.isSubmissionInProgress)
              ? null
              : () {},
        );
      },
    );
  }
}

class _FacebookSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ImageElevatedButton(
          key: Key('loginForm_facebookLogin_raisedButton'),
          text: 'ENTRAR COM ',
          imageAsset: AppImages.facebook,
          onPressed: (state.phone.invalid ||
                  state.phone.pure ||
                  state.status.isSubmissionInProgress)
              ? null
              : () {},
        );
      },
    );
  }
}
