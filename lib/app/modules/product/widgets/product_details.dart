import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/product_controller.dart';
import 'package:gosti_mobile/app/modules/product/widgets/app_bar_product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/image_expand.dart';
import 'package:intl/intl.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductController controller = Get.find<ProductController>();
  CartController cartController = Get.find<CartController>();

  num qtd = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarProduct(),
          Row(
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
                      'Disponível ${cartController.checkQtdAvailable(widget.product) == 0 ? 0 : cartController.checkQtdAvailable(widget.product) - (qtd) <= 0 ? 0 : cartController.checkQtdAvailable(widget.product) - (qtd)}',
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
                            if ((qtd + 1) <= controller.product.saldo!.saldo!) {
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
                      onPressed: () {
                        if (controller.product.saldo!.saldo! > 0) {
                          cartController.addItem(
                              id: widget.product.id!,
                              name: widget.product.nome!,
                              price: widget.product.preco!,
                              qtdAvailable: widget.product.saldo!.saldo!,
                              newQtd: qtd);
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                    "${widget.product.nome}  Adicionado ao carrinho !"),
                              ),
                            );
                          //Modular.to.pop('/home/');
                        } else {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    "${widget.product.nome} não está disponivel"),
                              ),
                            );
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
          ),
        ],
      ),
    );
  }
}
