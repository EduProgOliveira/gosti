import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/app_bar_product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/categoria.dart';
import 'package:gosti_mobile/app/modules/product/widgets/product_list.dart';
import 'package:gosti_mobile/app/modules/product/widgets/search_product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<GlobalKey> categorias = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  late ScrollController scrollController;
  BuildContext? tabContext;

  List<Product> listAcom = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
    Product(nome: 'Peixo', preco: 22.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];

  List<Product> listCarnes = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
    Product(nome: 'Peixo', preco: 22.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];

  List<Product> listEspec = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];
  List<Product> listFit = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];
  List<Product> listMassas = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];
  List<Product> listTradi = [
    Product(nome: 'Arroz Branco', preco: 12.00),
    Product(nome: 'Feijão', preco: 15.00),
    Product(nome: 'Peixo', preco: 22.00),
  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(changeTabs);
  }

  changeTabs() {
    late RenderBox box;
    for (var i = 0; i < categorias.length; i++) {
      box = categorias[i].currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if (scrollController.offset >= position.dy) {
        DefaultTabController.of(tabContext!)!.animateTo(
          i,
          duration: const Duration(milliseconds: 100),
        );
      }
    }
  }

  scrollTo(int index) async {
    scrollController.removeListener(changeTabs);
    final categoria = categorias[index].currentContext!;
    await Scrollable.ensureVisible(categoria,
        duration: const Duration(milliseconds: 500));
    scrollController.addListener(changeTabs);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Builder(builder: (context) {
        tabContext = context;
        return Scaffold(
          body: Column(
            children: [
              AppBarProduct(),
              Container(
                height: 35,
                child: TabBar(
                  isScrollable: true,
                  labelStyle: AppTextStyles.bodyBold,
                  indicatorColor: AppColors.primaryColor,
                  labelColor: AppColors.primaryColor,
                  tabs: const [
                    Tab(child: Text('Acompanhamentos')),
                    Tab(child: Text('Carnes')),
                    Tab(child: Text('Especialidades')),
                    Tab(child: Text('Fit')),
                    Tab(child: Text('Massas')),
                    Tab(child: Text('Tradicional')),
                  ],
                  onTap: (int index) => scrollTo(index),
                ),
              ),
              SearchProduct(),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Categoria(
                          titulo: 'Acompanhamentos', index: categorias[0]),
                      ProductList(listProduct: listAcom),
                      Categoria(titulo: 'Carnes', index: categorias[1]),
                      ProductList(listProduct: listCarnes),
                      Categoria(titulo: 'Especialidade', index: categorias[2]),
                      ProductList(listProduct: listEspec),
                      Categoria(titulo: 'Fit', index: categorias[3]),
                      ProductList(listProduct: listFit),
                      Categoria(titulo: 'Massas', index: categorias[4]),
                      ProductList(listProduct: listMassas),
                      Categoria(titulo: 'Tradicional', index: categorias[5]),
                      ProductList(listProduct: listTradi),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
