import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  final Function? onChanged;

  const EmailField({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: 'E-mail',
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        widget.onChanged!(value);
      },
    );
  }
}
