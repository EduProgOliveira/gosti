class Payment {
  num? transactionAmount;
  String? token;
  String? description;
  int? installments;
  String? paymentMethodId;
  Payer? payer;
  String? externalReference;
  AdditionalInfo? additionalInfo;

  Payment(
      {this.transactionAmount,
      this.token,
      this.description,
      this.installments,
      this.paymentMethodId,
      this.payer,
      this.externalReference,
      this.additionalInfo});

  Payment.fromJson(Map<String, dynamic> json) {
    transactionAmount = json['transaction_amount'];
    token = json['token'];
    description = json['description'];
    installments = json['installments'];
    paymentMethodId = json['payment_method_id'];
    payer = json['payer'] != null ? Payer.fromJson(json['payer']) : null;
    externalReference = json['external_reference'];
    additionalInfo = json['additional_info'] != null
        ? new AdditionalInfo.fromJson(json['additional_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['transaction_amount'] = this.transactionAmount;
    data['token'] = this.token;
    data['description'] = this.description;
    data['installments'] = this.installments;
    data['payment_method_id'] = this.paymentMethodId;
    if (this.payer != null) {
      data['payer'] = this.payer!.toJson();
    }
    data['external_reference'] = this.externalReference;
    if (this.additionalInfo != null) {
      data['additional_info'] = this.additionalInfo!.toJson();
    }
    return data;
  }
}

class Payer {
  String? email;

  Payer({this.email});

  Payer.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class AdditionalInfo {
  List<Items>? items;

  AdditionalInfo({this.items});

  AdditionalInfo.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      List<Items> items = [];
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? title;
  String? categoryId;
  int? quantity;
  double? unitPrice;

  Items({this.id, this.title, this.categoryId, this.quantity, this.unitPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    quantity = json['quantity'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['category_id'] = this.categoryId;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    return data;
  }
}
