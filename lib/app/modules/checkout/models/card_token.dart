class CardToken {
  Cardholder? cardholder;
  String? cardNumber;
  int? expirationMonth;
  int? expirationYear;
  String? securityCode;

  CardToken({
    this.cardholder,
    this.cardNumber,
    this.expirationMonth,
    this.expirationYear,
    this.securityCode,
  });

  factory CardToken.fromJson(Map<String, dynamic> json) {
    return CardToken(
      cardholder: Cardholder.fromJson(json['cardholder']),
      cardNumber: json['cardNumber'],
      expirationMonth: json['expirationMonth'],
      expirationYear: json['expirationYear'],
      securityCode: json['securityCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardholder': cardholder!.toJson(),
      'cardNumber': cardNumber,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'securityCode': securityCode,
    };
  }
}

class Cardholder {
  Identification? identification;
  String? name;

  Cardholder({this.identification, this.name});

  factory Cardholder.fromJson(Map<String, dynamic> json) {
    return Cardholder(
      identification: Identification.fromJson(json['identification']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identification': identification!.toJson(),
      'name': name,
    };
  }
}

class Identification {
  String? number;
  String? type;

  Identification({this.number, this.type});

  factory Identification.fromJson(Map<String, dynamic> json) {
    return Identification(
      number: json['number'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'type': type = "CPF",
    };
  }
}
