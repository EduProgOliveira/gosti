import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool enabled;

  const DefaultTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: key,
      child: Text(
        text,
        style: TextStyle(
          color: enabled ? theme.primaryColor : theme.disabledColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: enabled ? onPressed : null,
    );
  }
}
