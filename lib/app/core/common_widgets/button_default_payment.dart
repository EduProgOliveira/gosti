import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';

class ButtonDefaultPayment extends StatelessWidget {
  final bool enabled;
  final Function() onPressed;
  final String text;

  const ButtonDefaultPayment({
    Key? key,
    this.enabled = true,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        key: key,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.buttonCupom,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: Text(text),
        onPressed: enabled ? onPressed : null,
      ),
    );
  }
}
