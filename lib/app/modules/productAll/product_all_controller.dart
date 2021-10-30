import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/service/product_service.dart';

enum StatusProductAll { loading, fail, start, load, search, searchFail }

class ProductAllController extends GetxController {
  FreezerController freezerController = Get.find<FreezerController>();
  CartController cartController = Get.put(CartController());
  final ProductService _service = ProductService();

  var status = StatusProductAll.start.obs;
  late Product product;
  List<Product> listProduct = [];
  List<Product> listAcompanhamentos = [];
  List<Product> listCarnes = [];
  List<Product> listEspecialidades = [];
  List<Product> listFit = [];
  List<Product> listMassas = [];
  List<Product> listTradicional = [];

  List<Product> listSearch = [];
  List<Product> listSearchAcompanhamentos = [];
  List<Product> listSearchCarnes = [];
  List<Product> listSearchEspecialidades = [];
  List<Product> listSearchFit = [];
  List<Product> listSearchMassas = [];
  List<Product> listSearchTradicional = [];

  search(String textSearch) async {
    if (textSearch.isNotEmpty) {
      status.value = StatusProductAll.loading;
      listSearch = listProduct
          .where((element) =>
              element.nome!.toLowerCase().contains(textSearch.toLowerCase()))
          .toList();
      listCategorySearch(listSearch);
      status.value = StatusProductAll.search;

      if (listSearch.isEmpty) {
        status.value = StatusProductAll.searchFail;
      }
    }
    if (textSearch.isEmpty) {
      status.value = StatusProductAll.load;
      listSearch = [];
      listSearchAcompanhamentos = [];
      listSearchCarnes = [];
      listSearchEspecialidades = [];
      listSearchFit = [];
      listSearchMassas = [];
      listSearchTradicional = [];
    }
  }

  loadProduct({required int idProduct}) async {
    var response = await _service.getProduct(idProduct: idProduct);
    if (response != null) {
      product = Product.fromJson(response);
    }
  }

  loadListProduct() async {
    listProduct = [];
    listAcompanhamentos = [];
    listCarnes = [];
    listEspecialidades = [];
    listFit = [];
    listMassas = [];
    listTradicional = [];
    status.value = StatusProductAll.loading;

    var response = await _service.getListProduct(idEquip: 115);
    if (response != null) {
      for (var item in response) {
        listProduct.add(Product.fromJson(item));
      }

      listCategory(listProduct);
    }
  }

  List<Product> filterList(List<Product> list, String grupo) {
    List<Product> listFilter =
        list.where((item) => item.grupo! == grupo).toList();
    listFilter.sort((a, b) => a.nome!.compareTo(b.nome!));
    return listFilter;
  }

  listCategory(List<Product> list) {
    if (list.isNotEmpty) {
      listAcompanhamentos = filterList(list, 'Acompanhamentos');
      listCarnes = filterList(list, 'Carnes');
      listEspecialidades = filterList(list, 'Especialidades');
      listFit = filterList(list, 'FIT');
      listMassas = filterList(list, 'Massas');
      listTradicional = filterList(list, 'Tradicional');

      status.value = StatusProductAll.load;
    } else {
      status.value = StatusProductAll.fail;
    }
  }

  listCategorySearch(List<Product> list) {
    if (list.isNotEmpty) {
      listSearchAcompanhamentos = filterList(list, 'Acompanhamentos');
      listSearchCarnes = filterList(list, 'Carnes');
      listSearchEspecialidades = filterList(list, 'Especialidades');
      listSearchFit = filterList(list, 'FIT');
      listSearchMassas = filterList(list, 'Massas');
      listSearchTradicional = filterList(list, 'Tradicional');

      status.value = StatusProductAll.load;
    } else {
      status.value = StatusProductAll.fail;
    }
  }
}
