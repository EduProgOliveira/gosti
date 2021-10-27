import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/modules/product/widgets/app_bar_product.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarProduct(),
        ],
      ),
    );
  }
}
