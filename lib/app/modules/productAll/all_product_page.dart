import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/product/widgets/categoria.dart';
import 'package:gosti_mobile/app/modules/productAll/product_all_controller.dart';
import 'package:gosti_mobile/app/modules/productAll/widgets/app_bar_product_all.dart';
import 'package:gosti_mobile/app/modules/productAll/widgets/product_list_all.dart';
import 'package:gosti_mobile/app/modules/productAll/widgets/search_product_all.dart';

class ProductAllPage extends StatefulWidget {
  ProductAllPage({Key? key}) : super(key: key);

  @override
  State<ProductAllPage> createState() => _ProductAllPageState();
}

class _ProductAllPageState extends State<ProductAllPage> {
  final List<GlobalKey> categorias = [
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
    GlobalKey(),
  ];
  ProductAllController controller = Get.put(ProductAllController());
  late ScrollController scrollController;
  BuildContext? tabContext;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(changeTabs);
    controller.loadListProduct();
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
        duration: const Duration(milliseconds: 400));
    scrollController.addListener(changeTabs);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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
              AppBarProductAll(),
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
              SearchProductAll(),
              Obx(() {
                if (controller.status.value == StatusProductAll.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (controller.status.value == StatusProductAll.searchFail) {
                  return const Center(
                    child: Text('Produto não encontrado'),
                  );
                }
                if (controller.status.value == StatusProductAll.search) {
                  return Expanded(
                    child: RefreshIndicator(
                      displacement: 10,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return await controller.loadListProduct();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        child: Column(
                          children: checkSearch(categorias, controller),
                        ),
                      ),
                    ),
                  );
                }
                if (controller.status.value == StatusProductAll.load) {
                  return Expanded(
                    child: RefreshIndicator(
                      displacement: 10,
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        return await controller.loadListProduct();
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: scrollController,
                        itemBuilder: (context, index) {
                          return Column(
                            children: check(categorias, controller),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text('Erro ao carregar os produtos'),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}

List<Widget> check(
    List<GlobalKey> categorias, ProductAllController controller) {
  List<Widget> widget = [];
  List<String> categoriasName = [
    'Acompanhamentos',
    'Carnes',
    'Especialidade',
    'Fit',
    'Massas',
    'Tradicional'
  ];
  List<List<Product>> produtos = [
    controller.listAcompanhamentos,
    controller.listCarnes,
    controller.listEspecialidades,
    controller.listFit,
    controller.listMassas,
    controller.listTradicional
  ];
  for (var i = 0; i < categorias.length; i++) {
    if (produtos[i].isNotEmpty) {
      widget.add(Categoria(titulo: categoriasName[i], index: categorias[i]));
      widget.add(ProductListAll(listProduct: produtos[i]));
    }
  }
  return widget;
}

List<Widget> checkSearch(
    List<GlobalKey> categorias, ProductAllController controller) {
  List<Widget> widget = [];
  List<String> categoriasName = [
    'Acompanhamentos',
    'Carnes',
    'Especialidade',
    'Fit',
    'Massas',
    'Tradicional'
  ];
  List<List<Product>> produtos = [
    controller.listSearchAcompanhamentos,
    controller.listSearchCarnes,
    controller.listSearchEspecialidades,
    controller.listSearchFit,
    controller.listSearchMassas,
    controller.listSearchTradicional
  ];
  for (var i = 0; i < categorias.length; i++) {
    if (produtos[i].isNotEmpty) {
      widget.add(Categoria(titulo: categoriasName[i], index: categorias[i]));
      widget.add(ProductListAll(listProduct: produtos[i]));
    }
  }
  return widget;
}
