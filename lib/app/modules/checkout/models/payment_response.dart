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

  PaymentResponse.fromJson(Map<String, dynamic> json, int pedido) {
    DateTime dat;
    String date = '';
    if (json['date_approved'] != null) {
      dat = DateTime.parse(json['date_approved']);
      date = '${dat.day}' + '/' + '${dat.month}' + '/' + '${dat.year}';
    } else {
      dat = DateTime.now();
      date = '${dat.day}' + '/' + '${dat.month}' + '/' + '${dat.year}';
    }

    status = json['status'] == "approved" ? true : false;
    idCli = AppPreferences.getId;
    idPedido = pedido;
    valorTotal = json['transaction_amount'];
    adquirente = 'Mercado Pago';
    bandeira = json['payment_method_id'];
    dataAprovacao = date;
    autorizacao = "id" + json['id'].toString();
    observacao = 'AppMsgMP.currentStatus';
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
