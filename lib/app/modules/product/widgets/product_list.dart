import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/product_controller.dart';
import 'package:gosti_mobile/app/modules/product/widgets/product_details.dart';
import 'package:intl/intl.dart';

class ProductList extends StatelessWidget {
  ProductList({Key? key, required this.listProduct}) : super(key: key);
  final List<Product> listProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: listProduct.map((product) => producItem(product)).toList());
  }
}

Widget producItem(Product product) {
  ProductController productController = Get.find<ProductController>();
//  CartController controller = Get.find<CartController>();
  return GestureDetector(
    onTap: () async {
      await productController.loadProduct(idProduct: product.id!);
      Get.to(() => ProductDetails(product: product));
    },
    child: GetBuilder<CartController>(builder: (controller) {
      return Container(
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
                    children: [
                      Icon(
                        Icons.help_outline_rounded,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Disponível',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${controller.checkQtdAvailable(product)}',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (controller.checkQtdAvailable(product) < 1) {
                            Get.snackbar(
                                'Não está disponivel!', "${product.nome}",
                                backgroundColor: Colors.red[300],
                                colorText: Colors.white);
                          } else {
                            controller.addItem(
                              id: product.id!,
                              name: product.nome!,
                              price: product.preco!,
                              qtdAvailable: product.saldo!.saldo!,
                            );
                            Get.snackbar(
                                'Adicionado ao carrinho!', "${product.nome}",
                                backgroundColor: Colors.green[300],
                                colorText: Colors.white);
                          }
                        },
                        icon: const Image(
                          image: AssetImage('assets/icons/carrinho1.png'),
                          width: 25,
                          height: 25,
                        ),
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
