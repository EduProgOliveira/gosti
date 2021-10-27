import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  final bool enabled;
  final Function() onPressed;
  final String text;

  const DefaultElevatedButton({
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
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: theme.primaryColor,
        ),
        child: Text(text),
        onPressed: enabled ? onPressed : null,
      ),
    );
  }
}
