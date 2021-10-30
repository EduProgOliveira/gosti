import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/image_expand.dart';
import 'package:gosti_mobile/app/modules/productAll/product_all_controller.dart';
import 'package:gosti_mobile/app/modules/productAll/widgets/app_bar_product_all.dart';
import 'package:intl/intl.dart';

class ProductDetailsAll extends StatefulWidget {
  ProductDetailsAll({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetailsAll> createState() => _ProductDetailsAllState();
}

class _ProductDetailsAllState extends State<ProductDetailsAll> {
  ProductAllController productController = Get.find<ProductAllController>();

  num qtd = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarProductAll(),
          GetBuilder<CartController>(builder: (controller) {
            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 50,
                        left: -2,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                        ),
                        items: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageExpand(
                                      nameImage: '${widget.product.img1}',
                                      tag: '1'),
                                ),
                              );
                            },
                            child: Hero(
                              tag: '1',
                              child: Image.network('${widget.product.img1}'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('${widget.product.img2}');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageExpand(
                                      nameImage: '${widget.product.img2}',
                                      tag: '2'),
                                ),
                              );
                            },
                            child: Hero(
                              tag: '2',
                              child: Image.network('${widget.product.img2}'),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageExpand(
                                      nameImage: '${widget.product.img3}',
                                      tag: '3'),
                                ),
                              );
                            },
                            child: Hero(
                              tag: '3',
                              child: Image.network('${widget.product.img3}'),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 50,
                        right: -8,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        NumberFormat.currency(
                          name: 'R\$ ',
                          decimalDigits: 2,
                        ).format(widget.product.preco),
                        style: TextStyle(
                          color: AppColors.darkRed,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        widget.product.nome!,
                        style: AppTextStyles.titleBold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Html(
                        data:
                            '${productController.product.descS} ${productController.product.descC}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
