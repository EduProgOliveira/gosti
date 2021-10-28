class Checkout {
  bool status;
  int idCli;
  int idPedido;
  int valorTotal;
  String adquirente;
  String bandeira;
  String dataAprovacao;
  String autorizacao;
  String observacao;

  Checkout({
    this.status = false,
    this.idCli = 0,
    this.idPedido = 0,
    this.valorTotal = 0,
    this.adquirente = "",
    this.bandeira = "",
    this.dataAprovacao = "",
    this.autorizacao = "",
    this.observacao = "",
  });

  Checkout copyWith({
    bool? status,
    int? idCli,
    int? idPedido,
    int? valorTotal,
    String? adquirente,
    String? bandeira,
    String? dataAprovacao,
    String? autorizacao,
    String? observacao,
  }) {
    return Checkout(
      status: status ?? this.status,
      idCli: idCli ?? this.idCli,
      idPedido: idPedido ?? this.idPedido,
      valorTotal: valorTotal ?? this.valorTotal,
      adquirente: adquirente ?? this.adquirente,
      bandeira: bandeira ?? this.bandeira,
      dataAprovacao: dataAprovacao ?? this.dataAprovacao,
      observacao: observacao ?? this.observacao,
    );
  }

  factory Checkout.fromJson(Map<String, dynamic> json) {
    return Checkout(
      status: json['status'],
      idCli: json['idCli'],
      idPedido: json['idPedido'],
      valorTotal: json['valorTotal'],
      adquirente: json['adquirente'],
      bandeira: json['bandeira'],
      dataAprovacao: json['dataAprovacao'],
      autorizacao: json['autorizacao'],
      observacao: json['observacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'idCli': idCli,
      'idPedido': idPedido,
      'valorTotal': valorTotal,
      'adquirente': adquirente,
      'bandeira': bandeira,
      'dataAprovacao': dataAprovacao,
      'autorizacao': autorizacao,
      'observacao': observacao,
    };
  }
}
