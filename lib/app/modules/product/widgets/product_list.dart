import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
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
  return Container(
    padding: const EdgeInsets.only(top: 5, left: 10),
    height: 75,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.grey,
        ),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text(product.nome!)),
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
                    '0',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      /* if (bloc.checkQtdAvailable(_food) < 1) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                            "${_food.nome} não está disponivel"),
                                      ),
                                    );
                                } else {
                                  bloc.addItem(
                                    id: _food.id!,
                                    name: _food.nome!,
                                    price: _food.preco!,
                                    qtdAvailable: _food.saldos!.saldo,
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                            "${_food.nome} Adicionado ao carrinho !"),
                                      ),
                                    );
                                }*/
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
        Expanded(
          child: Image.network(
            'https://riopreto.gosti.com.br/wp-content/uploads/2021/08/IMG_2348-scaled-1.jpg',
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
}
