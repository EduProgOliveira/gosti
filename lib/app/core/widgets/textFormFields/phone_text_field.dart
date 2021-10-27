import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart' as country;

class PhoneField extends StatelessWidget {
  final Function? onChanged;

  const PhoneField({Key? key, required this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.flag),
        hintText: '+55 DDD Telefone',
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        onChanged!(value);
      },
    );
  }
}
