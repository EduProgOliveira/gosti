import 'package:gosti_mobile/app_msg_mp.dart';
import 'package:gosti_mobile/app_preferences.dart';

class PaymentResponse {
  bool? status;
  int? idCli;
  int? idPedido;
  int? valorTotal;
  String? adquirente;
  String? bandeira;
  String? dataAprovacao;
  String? autorizacao;
  String? observacao;

  PaymentResponse(
      {this.status,
      this.idCli,
      this.idPedido,
      this.valorTotal,
      this.adquirente,
      this.bandeira,
      this.dataAprovacao,
      this.autorizacao,
      this.observacao});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    idCli = AppPreferences.getId;
    idPedido = json['id'];
    valorTotal = json['transaction_amount'];
    adquirente = 'Mercado Pago';
    bandeira = json['payment_method_id'];
    dataAprovacao = json['date_approved'];
    autorizacao = "id" + json['id'];
    observacao = AppMsgMP.currentStatus;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['idCli'] = this.idCli;
    data['idPedido'] = this.idPedido;
    data['valorTotal'] = this.valorTotal;
    data['adquirente'] = this.adquirente;
    data['bandeira'] = this.bandeira;
    data['dataAprovacao'] = this.dataAprovacao;
    data['autorizacao'] = this.autorizacao;
    data['observacao'] = this.observacao;
    return data;
  }
}
