import 'package:flutter/material.dart';

class IconElevatedButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  final String text;

  const IconElevatedButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 280,
      child: ElevatedButton.icon(
        key: key,
        label: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: theme.accentColor,
        ),
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
