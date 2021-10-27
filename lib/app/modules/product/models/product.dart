class Product {
  int? id;
  String? nome;
  String? descS;
  String? descC;
  num? preco;
  String? grupo;
  String? img1;
  String? img2;
  String? img3;
  String? sku;
  String? ativo;
  Saldos? saldo;

  Product({
    this.id,
    this.nome,
    this.descS,
    this.descC,
    this.preco,
    this.grupo,
    this.img1,
    this.img2,
    this.img3,
    this.sku,
    this.ativo,
    this.saldo,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    Saldos? saldoTemp;
    if (json['saldos'] != null) {
      for (var item in json['saldos']) {
        saldoTemp = Saldos.fromJson(item);
      }
    }
    return Product(
      id: json['id'],
      nome: json['nome'],
      descS: json['desc_s'],
      descC: json['desc_c'],
      preco: json['preco'],
      grupo: json['grupo'],
      img1: json['img1'],
      img2: json['img2'],
      img3: json['img3'],
      sku: json['sku'],
      ativo: json['ativo'],
      saldo: saldoTemp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'desc_s': descS,
      'desc_c': descC,
      'preco': preco,
      'grupo': grupo,
      'img1': img1,
      'img2': img2,
      'img3': img3,
      'sku': sku,
      'ativo': ativo,
      'saldos': saldo!.toJson(),
    };
  }
}

class Saldos {
  int? idEquipto;
  int? idProduto;
  num? saldo;
  int? minimo;

  Saldos({this.idEquipto, this.idProduto, this.saldo, this.minimo});

  factory Saldos.fromJson(Map<String, dynamic> json) {
    return Saldos(
      idEquipto: json['id_equipto'],
      idProduto: json['id_produto'],
      saldo: json['saldo'],
      minimo: json['minimo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_equipto': idEquipto,
      'id_produto': idProduto,
      'saldo': saldo,
      'minimo': minimo,
    };
  }
}
