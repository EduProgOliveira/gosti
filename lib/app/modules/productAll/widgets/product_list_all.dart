import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/productAll/product_all_controller.dart';
import 'package:gosti_mobile/app/modules/productAll/widgets/product_details_all.dart';
import 'package:intl/intl.dart';

class ProductListAll extends StatelessWidget {
  ProductListAll({Key? key, required this.listProduct}) : super(key: key);
  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: listProduct.map((product) => producItem(product)).toList());
  }
}

Widget producItem(Product product) {
  ProductAllController productController = Get.find<ProductAllController>();
//  CartController controller = Get.find<CartController>();
  return GestureDetector(
    onTap: () async {
      await productController.loadProduct(idProduct: product.id!);
      Get.to(() => ProductDetailsAll(product: product));
    },
    child: GetBuilder<CartController>(builder: (controller) {
      return Container(
        height: 90,
        padding: const EdgeInsets.only(top: 0, left: 10, right: 6, bottom: 0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.grey,
            ),
          ),
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.nome!,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        NumberFormat.currency(
                          name: 'R\$ ',
                          decimalDigits: 2,
                        ).format(product.preco),
                        style: AppTextStyles.priceFoodItemBold,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              child: Image.network(
                product.img1!,
                fit: BoxFit.fitWidth,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }),
  );
}
