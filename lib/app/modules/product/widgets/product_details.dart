import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/product_controller.dart';
import 'package:gosti_mobile/app/modules/product/widgets/app_bar_product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/image_expand.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductController productController = Get.find<ProductController>();

  num qtd = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarProduct(),
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
                        'Disponível ${controller.checkQtdAvailable(widget.product) == 0 ? 0 : controller.checkQtdAvailable(widget.product) - (qtd) <= 0 ? 0 : controller.checkQtdAvailable(widget.product) - (qtd)}',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              if ((qtd + 1) <= widget.product.saldo!.saldo!) {
                                qtd++;
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.add_circle_sharp,
                              color: AppColors.darkGreen,
                            ),
                          ),
                          Text('${qtd}'),
                          IconButton(
                            onPressed: () {
                              if ((qtd - 1) != 0) {
                                qtd--;
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.do_not_disturb_on_sharp,
                              color: AppColors.darkRed,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (controller.checkQtdAvailable(widget.product) >
                              0) {
                            controller.addItem(
                                id: widget.product.id!,
                                name: widget.product.nome!,
                                price: widget.product.preco!,
                                qtdAvailable: widget.product.saldo!.saldo!,
                                newQtd: qtd);
                            Get.snackbar('Adicionado ao carrinho!',
                                "${widget.product.nome}",
                                backgroundColor: Colors.green[300],
                                colorText: Colors.white);

                            await Future.delayed(const Duration(seconds: 4))
                                .then((value) => Get.back());
                          } else {
                            Get.snackbar('Não está disponivel!',
                                "${widget.product.nome}",
                                backgroundColor: Colors.red[300],
                                colorText: Colors.white);
                          }
                        },
                        child: const Text('COMPRAR'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(100, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                      ),
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
