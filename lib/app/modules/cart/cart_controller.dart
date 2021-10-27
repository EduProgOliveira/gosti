import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/cart/models/cart.dart';
import 'package:gosti_mobile/app/modules/product/models/product.dart';

class CartController extends GetxController {
  List<CartItem> listCart = [];
  double total = 0.00;
  num totalItens = 0;

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
