class CartItem {
  final int id;
  final String name;
  final num price;
  final num qtd;
  final num qtdAvailable;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.qtd,
    required this.qtdAvailable,
  });
}

class CartState {
  const CartState({
    this.loading = true,
    this.cartList = const [],
    this.total = 0.0,
    this.subTotal = 0.0,
  });

  final bool loading;
  final List<CartItem> cartList;
  final double total;
  final double subTotal;

  @override
  List<Object> get props => [
        loading,
        cartList,
        total,
        subTotal,
      ];

  CartState copyWith({
    bool? loading,
    List<CartItem>? cartList,
    double? total,
    double? subTotal,
  }) {
    return CartState(
      loading: loading ?? this.loading,
      cartList: cartList ?? this.cartList,
      subTotal: subTotal ?? this.subTotal,
      total: total ?? this.subTotal,
    );
  }
}
