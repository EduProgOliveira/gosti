class Freezer {
  int? id;
  double? latitude;
  double? longitude;
  String? nome;
  String? cep;
  String? endereco;
  String? bairro;
  String? cidade;
  String? uf;
  String? ativo;
  double? distancia;

  Freezer({
    this.id,
    this.latitude,
    this.longitude,
    this.nome,
    this.cep,
    this.endereco,
    this.bairro,
    this.cidade,
    this.uf,
    this.ativo,
    this.distancia,
  });

  factory Freezer.fromJson(Map<String, dynamic> json) {
    return Freezer(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      nome: json['nome'],
      cep: json['cep'],
      endereco: json['endereco'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
      ativo: json['ativo'],
      distancia: json['distancia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'nome': nome,
      'cep': cep,
      'endereco': endereco,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'ativo': ativo,
      'distancia': distancia
    };
  }
}
