class Payment {
  double? transactionAmount;
  String? token;
  String? description;
  int? installments;
  String? paymentMethodId;
  Payer? payer;
  String? externalReference;
  AdditionalInfo? additionalInfo;

  Payment({
    this.transactionAmount,
    this.token,
    this.description,
    this.installments,
    this.paymentMethodId,
    this.payer,
    this.externalReference,
    this.additionalInfo,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      transactionAmount: json['transaction_amount'],
      token: json['token'],
      description: json['description'],
      installments: json['installments'],
      paymentMethodId: json['payment_method_id'],
      payer: Payer.fromJson(json['payer']),
      externalReference: json['external_reference'],
      additionalInfo: AdditionalInfo.fromJson(json['additional_info']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_amount': transactionAmount,
      'token': token,
      'description': description,
      'installments': installments,
      'payment_method_id': paymentMethodId,
      'payer': Payer().toJson(),
      'external_reference': externalReference,
      'additional_info': AdditionalInfo().toJson(),
    };
  }
}

class Payer {
  String? email;

  Payer({this.email});

  factory Payer.fromJson(Map<String, dynamic> json) {
    return Payer(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class AdditionalInfo {
  List<Items>? items;

  AdditionalInfo({this.items});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    List<Items> itemsTemp = [];
    json['items'].forEach((v) {
      itemsTemp.add(Items.fromJson(v));
    });
    return AdditionalInfo(
      items: itemsTemp,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> itemsTemp = {};
    items!.forEach((v) {
      itemsTemp = v.toJson();
    });
    return {
      'items': itemsTemp,
    };
  }
}

class Items {
  String? id;
  String? title;
  String? categoryId;
  int? quantity;
  double? unitPrice;

  Items({this.id, this.title, this.categoryId, this.quantity, this.unitPrice});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      id: json['id'],
      title: json['title'],
      categoryId: json['category_id'],
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category_id': categoryId,
      'quantity': quantity,
      'unit_price': unitPrice,
    };
  }
}
