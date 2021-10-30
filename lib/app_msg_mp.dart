class AppMsgMP {
  msg({
    int? requestNumber,
    required int id,
    required String msg,
    String? msg_details,
  }) {
    switch (msg) {
      case "approved":
        return currentStatus = ["Pagamento aprovado"];
      case "in_process":
        if (msg_details == "pending_contingency") {
          return currentStatus = [
            "Estamos processando o pagamento. Informaremos posteriormente.",
            "in_process",
            "peding_contingency",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "pending_review_manual") {
          return currentStatus = [
            "Estamos processando seu pagamento. Informaremos posteriormente ou se necessitamos de mais informações.",
            "in_process",
            "peding_contingency",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        return currentStatus = [
          "Estamos processando o pagamento. Informaremos posteriormente.",
          "in_process",
          "PED$requestNumber",
          "ID$id"
        ];
      case "rejected":
        if (msg_details == "cc_rejected_bad_filled_card_number") {
          return currentStatus = [
            "Revise o número do cartão.",
            "rejected",
            "cc_rejected_bad_filled_card_number",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_bad_filled_date") {
          return currentStatus = [
            "Revise a data de vencimento.",
            "rejected",
            "cc_rejected_bad_filled_date",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_bad_filled_other") {
          return currentStatus = [
            "Revise os dados.",
            "rejected",
            "cc_rejected_bad_filled_other",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_bad_filled_security_code") {
          return currentStatus = [
            "Revise o código de segurança do cartão.",
            "rejected",
            "cc_rejected_bad_filled_security_code",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_blacklist") {
          return currentStatus = [
            "Não pudemos processar seu pagamento.",
            "rejected",
            "cc_rejected_blacklist",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_call_for_authorize") {
          return currentStatus = [
            "Você deve autorizar com a Bandeira o pagamento do valor ao Mercado Pago.",
            "rejected",
            "cc_rejected_call_for_authorize",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_card_disabled") {
          return currentStatus = [
            "Ligue para a Bandeira para ativar seu cartão. O telefone fica no verso do seu cartão.",
            "rejected",
            "cc_rejected_card_disabled",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_card_error") {
          return currentStatus = [
            "Não conseguimos processar seu pagamento.",
            "rejected",
            "cc_rejected_card_error",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_duplicated_payment") {
          return currentStatus = [
            "Você já efetuou um pagamento com esse valor. Caso precise pagar novamente, utilize outro cartão ou outra forma de pagamento.",
            "rejected",
            "cc_rejected_duplicated_payment",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_high_risk") {
          return currentStatus = [
            "Seu pagamento foi recusado. Escolha outra forma de pagamento. Recomendamos meios de pagamento em dinheiro.",
            "rejected",
            "cc_rejected_high_risk",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        if (msg_details == "cc_rejected_insufficient_amount") {
          return currentStatus = [
            "O cartão possui saldo insuficiente.",
            "rejected",
            "cc_rejected_insufficient_amount",
            "PED$requestNumber",
            "ID$id"
          ];
        }
        return currentStatus = ["NADA", "DE", "MENSAGENS"];
      default:
        return currentStatus = ["MENSAGENS COSTOMIZADAS"];
    }
  }

  static List<String> currentStatus = [];
}
