class ValidCart {
  bool? status;
  int? idEquipto;
  int? idCli;
  num? valorTotal;
  int? valorCupom;
  String? cupom;
  int? idPedido;
  List<Itens>? itens;

  ValidCart(
      {this.status,
      this.idEquipto,
      this.idCli,
      this.valorTotal,
      this.valorCupom,
      this.cupom,
      this.idPedido,
      this.itens});

  factory ValidCart.fromJson(Map<String, dynamic> json) {
    var itens = <Itens>[];
    if (json['itens'] != null) {
      json['itens'].forEach((v) {
        itens.add(Itens.fromJson(v));
      });
    }
    return ValidCart(
      status: json['status'],
      idEquipto: json['idEquipto'],
      idCli: json['idCli'],
      valorTotal: json['valorTotal'],
      valorCupom: json['valorCupom'],
      cupom: json['cupom'],
      idPedido: json['idPedido'],
      itens: itens,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status ?? false,
      'idEquipto': idEquipto,
      'idCli': idCli,
      'valorTotal': valorTotal,
      'valorCupom': valorCupom ?? 0,
      'cupom': cupom ?? '',
      'idPedido': idPedido ?? 0,
      'itens': itens!.map((e) => e.toJson()).toList(),
    };
  }
}

class Itens {
  int? item;
  int? idProd;
  num? qtd;
  num? valorItem;
  String? status;

  Itens({this.item, this.idProd, this.qtd, this.valorItem, this.status});

  factory Itens.fromJson(Map<String, dynamic> json) {
    return Itens(
      item: json['item'],
      idProd: json['idProd'],
      qtd: json['qtd'],
      valorItem: json['valorItem'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'idProd': idProd,
      'qtd': qtd,
      'valorItem': valorItem,
      'status': status ?? '',
    };
  }
}
