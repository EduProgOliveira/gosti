import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/service/product_service.dart';

enum StatusProduct { loading, fail, start, load }

class ProductController extends GetxController {
  FreezerController freezerController = Get.find<FreezerController>();
  CartController cartController = Get.put(CartController());
  final ProductService _service = ProductService();

  var status = StatusProduct.start.obs;
  late Product product;
  List<Product> listProduct = [];
  List<Product> listAcompanhamentos = [];
  List<Product> listCarnes = [];
  List<Product> listEspecialidades = [];
  List<Product> listFit = [];
  List<Product> listMassas = [];
  List<Product> listTradicional = [];

  loadProduct({required int idProduct}) async {
    var response = await _service.getProduct(idProduct: idProduct);
    if (response != null) {
      product = Product.fromJson(response);
    }
  }

  loadListProduct() async {
    status.value = StatusProduct.loading;
    var response =
        await _service.getListProduct(idEquip: freezerController.freezer().id!);
    if (response != null) {
      for (var item in response) {
        listProduct.add(Product.fromJson(item));
      }

      if (listProduct.isNotEmpty) {
        if (freezerController.freezer().id == 0) {
          listAcompanhamentos = filterList(listProduct, 'Acompanhamentos');
          listCarnes = filterList(listProduct, 'Carnes');
          listEspecialidades = filterList(listProduct, 'Especialidades');
          listFit = filterList(listProduct, 'FIT');
          listMassas = filterList(listProduct, 'Massas');
          listTradicional = filterList(listProduct, 'Tradicional');
        } else {
          listAcompanhamentos = filterList(listProduct, 'Acompanhamentos');
          listCarnes = filterList(listProduct, 'Carnes');
          listEspecialidades = filterList(listProduct, 'Especialidades');
          listFit = filterList(listProduct, 'FIT');
          listMassas = filterList(listProduct, 'Massas');
          listTradicional = filterList(listProduct, 'Tradicional');
        }
        status.value = StatusProduct.load;
      } else {
        status.value = StatusProduct.fail;
      }
    }
  }

  List<Product> filterList(List<Product> list, String grupo) {
    List<Product> listFilter = list
        .where((item) => item.grupo! == grupo)
        .where((item) => item.saldo?.saldo != null && item.saldo!.saldo! > 0)
        .toList();
    listFilter.sort((a, b) => a.nome!.compareTo(b.nome!));
    return listFilter;
  }
}
