import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final Function? onChanged;

  const PasswordField({Key? key, required this.onChanged}) : super(key: key);
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        hintText: 'Senha',
        suffixIcon: GestureDetector(
          child: Icon(
              _showPassword == true ? Icons.visibility : Icons.visibility_off),
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      obscureText: !_showPassword,
      onChanged: (value) {
        widget.onChanged!(value);
      },
    );
  }
}
