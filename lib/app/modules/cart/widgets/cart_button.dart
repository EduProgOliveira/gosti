import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Text(
                '0',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Image.asset('assets/icons/carrinho.png'),
          ),
        ],
      ),
    );
  }
}
