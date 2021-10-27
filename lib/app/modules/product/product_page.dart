import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/product/widgets/app_bar_product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/categoria.dart';
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
  ];
  late ScrollController scrollController;
  BuildContext? tabContext;

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
    final categoria = categorias[index].currentContext!;
    await Scrollable.ensureVisible(categoria,
        duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
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
                    Tab(child: Text('Fit')),
                    Tab(child: Text('Massas')),
                    Tab(child: Text('Tradicional')),
                  ],
                  onTap: (int index) => scrollTo(index),
                ),
              ),
              SearchProduct(),
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Categoria(titulo: 'Acompanhamentos', index: categorias[0]),
                    Categoria(titulo: 'Carnes', index: categorias[1]),
                    Categoria(titulo: 'Fit', index: categorias[2]),
                    Categoria(titulo: 'Massas', index: categorias[3]),
                    Categoria(titulo: 'Tradicional', index: categorias[4]),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
