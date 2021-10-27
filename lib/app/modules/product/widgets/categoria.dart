import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';

class Categoria extends StatelessWidget {
  const Categoria({Key? key, required this.titulo, required this.index})
      : super(key: key);
  final String titulo;
  final Key index;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: index,
      padding: const EdgeInsets.symmetric(vertical: 2),
      color: AppColors.lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
