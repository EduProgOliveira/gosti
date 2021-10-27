class MaskText {
  static maskCep(String cep) {
    final result = cep.substring(0, 2) +
        "." +
        cep.substring(2, 5) +
        "-" +
        cep.substring(5, 8);
    return result;
  }

  static maskDistance(String distance) {
    final result = distance.replaceAll('.', ',');
    return result;
  }
}
