class AppMsgMP {
  msg({required int id, required String msg, String? msg_details}) {
    switch (msg) {
      case "approved":
        return currentStatus = "Pagamento aprovado";
      case "in_process":
        if (msg_details == "pending_contingency") {
          return currentStatus =
              "id $id' peding_contingency Estamos processando o pagamento. Informaremos posteriormente.";
        }
        if (msg_details == "pending_review_manual") {
          return currentStatus =
              "id $id' peding_contingency Estamos processando seu pagamento. Informaremos posteriormente ou se necessitamos de mais informações.";
        }
        return currentStatus =
            "id $id' Estamos processando o pagamento. Informaremos posteriormente.";
      case "rejected":
        if (msg_details == "cc_rejected_bad_filled_card_number") {
          return currentStatus =
              "id $id' cc_rejected_bad_filled_card_number. Revise o número do cartão.";
        }
        if (msg_details == "cc_rejected_bad_filled_date") {
          return currentStatus =
              "id $id' cc_rejected_bad_filled_date Revise a data de vencimento";
        }
        if (msg_details == "cc_rejected_bad_filled_other") {
          return currentStatus =
              "id $id' cc_rejected_bad_filled_other Revise os dados";
        }
        if (msg_details == "cc_rejected_bad_filled_security_code") {
          return currentStatus =
              "id $id' cc_rejected_bad_filled_security_code Revise o código de segurança do cartão.";
        }
        if (msg_details == "cc_rejected_blacklist") {
          return currentStatus =
              "id $id' cc_rejected_blacklist Não pudemos processar seu pagamento.";
        }
        if (msg_details == "cc_rejected_call_for_authorize") {
          return currentStatus =
              "id $id' cc_rejected_call_for_authorize Você deve autorizar com a Bandeira o pagamento do valor ao Mercado Pago.";
        }
        if (msg_details == "cc_rejected_card_disabled") {
          return currentStatus =
              "id $id' cc_rejected_card_disabled Ligue para a Bandeira para ativar seu cartão. O telefone fica no verso do seu cartão.";
        }
        if (msg_details == "cc_rejected_card_error") {
          return currentStatus =
              "id $id' cc_rejected_card_error Não conseguimos processar seu pagamento";
        }
        if (msg_details == "cc_rejected_duplicated_payment") {
          return currentStatus =
              "id $id' cc_rejected_duplicated_payment Você já efetuou um pagamento com esse valor. Caso precise pagar novamente, utilize outro cartão ou outra forma de pagamento.";
        }
        if (msg_details == "cc_rejected_high_risk") {
          return currentStatus =
              "id $id' cc_rejected_high_risk Seu pagamento foi recusado. Escolha outra forma de pagamento. Recomendamos meios de pagamento em dinheiro.";
        }
        if (msg_details == "cc_rejected_insufficient_amount") {
          return currentStatus =
              "id $id' cc_rejected_insufficient_amount O cartão possui saldo insuficiente.";
        }
        return currentStatus = "Cartão Rejeitado";
      default:
        return currentStatus = "MENSAGENS COSTOMIZADAS";
    }
  }

  static String? currentStatus;
}
