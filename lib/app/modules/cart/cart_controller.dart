import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/models/cart.dart';
import 'package:gosti_mobile/app/modules/cart/models/valid_cart.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';
import 'package:gosti_mobile/app/modules/service/cart_service.dart';
import 'package:gosti_mobile/app_preferences.dart';

class CartController extends GetxController {
  CartService _service = CartService();
  FreezerController freezerController = Get.find<FreezerController>();
  List<CartItem> listCart = <CartItem>[].obs;
  List<CartItem> listCartEmpty = <CartItem>[].obs;
  double total = 0.00;
  num totalItens = 0;
  int pedido = 0;

  clear() {
    listCart = [];
    listCartEmpty = [];
    total = 0.00;
    totalItens = 0;
    pedido = 0;
  }

  Future<bool> validCart() async {
    List<Itens> itensTemp = [];
    await Future.delayed(const Duration(seconds: 3));

    for (var i = 0; i < listCart.length; i++) {
      itensTemp.add(Itens(
        item: i + 1,
        idProd: listCart[i].id,
        qtd: listCart[i].qtd,
        valorItem: listCart[i].price,
      ));
    }

    ValidCart response = await _service.validCart(ValidCart(
      idCli: await AppPreferences.ID(),
      idEquipto: freezerController.freezer().id,
      valorTotal: total,
      itens: itensTemp,
    ));

    if (response.status == true) {
      pedido = response.idPedido!;
      return true;
    }

    for (var i = 0; i < listCart.length; i++) {
      if (listCart[i].id == response.itens![i].idProd) {
        listCartEmpty.add(listCart[i]);
      }
    }

    return false;
  }

  void addItem({
    required int id,
    required String name,
    required num qtdAvailable,
    required num price,
    num newQtd = 1,
  }) {
    if (listCart.isNotEmpty) {
      bool val = listCart.any((element) => element.id == id);
      if (val) {
        int index = listCart.indexWhere((element) => element.id == id);
        num newQtdUpdate = listCart[index].qtd + newQtd;

        var cartItem = CartItem(
            id: id,
            name: name,
            qtd: newQtdUpdate,
            qtdAvailable: qtdAvailable,
            price: price);

        if (newQtdUpdate <= qtdAvailable) {
          listCart.removeAt(index);
          listCart.insert(index, cartItem);
        }
      } else {
        var cartItem = CartItem(
            id: id,
            name: name,
            qtd: newQtd,
            qtdAvailable: qtdAvailable,
            price: price);
        if (newQtd <= qtdAvailable) {
          listCart.add(cartItem);
          total = somar(listCart);
          totalItens = totalItems(listCart);
        }
      }
    } else {
      var cartItem = CartItem(
          id: id,
          name: name,
          qtd: newQtd,
          qtdAvailable: qtdAvailable,
          price: price);

      if (newQtd <= qtdAvailable) {
        listCart.add(cartItem);

        total = somar(listCart);
        totalItens = totalItems(listCart);
      }
    }

    total = somar(listCart);
    totalItens = totalItems(listCart);
    update();
  }

  remove({required int id, int newQtd = 1}) {
    bool val = listCart.any((element) => element.id == id);
    if (val) {
      int index = listCart.indexWhere((element) => element.id == id);
      CartItem item = listCart.elementAt(index);
      if (item.qtd == 1 || item.qtd - newQtd == 0) {
        listCart.removeAt(index);
        total = somar(listCart);
        totalItens = totalItems(listCart);
      } else {
        var cartItem = CartItem(
            id: item.id,
            name: item.name,
            qtd: item.qtd - newQtd,
            qtdAvailable: item.qtdAvailable,
            price: item.price);
        listCart.removeAt(index);
        listCart.insert(index, cartItem);

        total = somar(listCart);
        totalItens = totalItems(listCart);
      }
    }
    update();
  }

  num totalItems(List<CartItem> listCart) =>
      listCart.fold(0, (a, b) => a + b.qtd);
  double somar(List<CartItem> listCart) =>
      listCart.fold(0.0, (a, b) => a + (b.price * b.qtd));

  checkQtdAvailable(Product product) {
    bool val = listCart.any((element) => element.id == product.id);
    if (val) {
      int index = listCart.indexWhere((element) => element.id == product.id);
      num qtdUpdate = product.saldo!.saldo! - listCart[index].qtd;
      return qtdUpdate;
    }

    return product.saldo?.saldo ?? 0;
  }
}
