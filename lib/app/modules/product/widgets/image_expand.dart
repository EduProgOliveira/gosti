import 'package:flutter/material.dart';

class ImageExpand extends StatelessWidget {
  const ImageExpand({Key? key, required this.nameImage, required this.tag})
      : super(key: key);

  final String nameImage;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        body: Center(
          child: Hero(
            tag: tag,
            child: Image.network(
              nameImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
