import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:country_code_picker/country_code_picker.dart' as country;
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/default_elevated_button.dart';
import 'package:gosti_mobile/app/modules/authentication/repository.dart';
import 'package:gosti_mobile/app/modules/sign_up/cubit/sign_up_cubit.dart';
import 'package:gosti_mobile/app/modules/verification_code/view/verification_code_page.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpCubit bloc = SignUpCubit(AuthenticationRepository());

  @override
  void initState() {
//    bloc = Modular.get<SignUpCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Falha ao cadastrar')),
            );
        }

        if (bloc.state.status.isSubmissionSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VerificationCodePage(
              email: state.email.value,
              phone: state.countryCode.value + state.phone.value,
            );
          }));
        }
      },
      child: SingleChildScrollView(
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
              TextField(
                key: const Key('signUpForm_emailInput_textField'),
                onChanged: (email) => bloc.emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'E-mail',
                  errorText:
                      bloc.state.email.invalid ? 'E-mail inválido' : null,
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CountryCodePicker(
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
                          errorText: bloc.state.email.invalid
                              ? 'Telefone inválido'
                              : null,
                          border: InputBorder.none,
                        ),
                        onChanged: (phone) {
                          bloc.phoneChanged(phone);
                        }),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<SignUpCubit, SignUpState>(
                bloc: bloc,
                builder: (context, state) {
                  return DefaultElevatedButton(
                    enabled: bloc.state.status.isValidated,
                    text: 'CADASTRAR',
                    onPressed: () async {
                      await bloc.signUpFormSubmitted();
                    },
                  );
                },
              ),
              const SizedBox(height: 16.0),
              _OtherOptions(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
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
                      context.read<SignUpCubit>().phoneChanged(phone);
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : DefaultElevatedButton(
                key: Key('signUpForm_continue_raisedButton'),
                text: 'CADASTRAR',
                enabled: state.status.isValidated,
                onPressed: () =>
                    context.read<SignUpCubit>().signUpFormSubmitted(),
              );
      },
    );
  }
}

class _OtherOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultElevatedButton(
      key: Key('signUpForm_otherOptions_raisedButton'),
      text: 'OUTRAS OPÇÕES',
      onPressed: () {},
    );
  }
}
