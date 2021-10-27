import 'package:flutter/material.dart';

class ImageElevatedButton extends StatelessWidget {
  final String imageAsset;
  final Function()? onPressed;
  final String text;

  const ImageElevatedButton({
    Key? key,
    required this.imageAsset,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        key: key,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 3),
            Image.asset(imageAsset, height: 40),
          ],
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
