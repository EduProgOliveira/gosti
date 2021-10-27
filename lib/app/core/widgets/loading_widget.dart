import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, required this.child, required this.value})
      : super(key: key);
  final bool value;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: value == true ? const CircularProgressIndicator() : child,
    );
  }
}
