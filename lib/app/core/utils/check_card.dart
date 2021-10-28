class CheckCard {
  static String? card(String number) {
    var elo = RegExp(
        r"^(4011(78|79)|43(1274|8935)|45(1416|7393|763(1|2))|50(4175|6699|67[0-7][0-9]|9000)|50(9[0-9][0-9][0-9])|627780|63(6297|6368)|650(03([^4])|04([0-9])|05(0|1)|05([7-9])|06([0-9])|07([0-9])|08([0-9])|4([0-3][0-9]|8[5-9]|9[0-9])|5([0-9][0-9]|3[0-8])|9([0-6][0-9]|7[0-8])|7([0-2][0-9])|541|700|720|727|901)|65165([2-9])|6516([6-7][0-9])|65500([0-9])|6550([0-5][0-9])|655021|65505([6-7])|6516([8-9][0-9])|65170([0-4]))");
    var mastercard = RegExp(
        r"^(5[0-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))");
    var hipercard = RegExp(
        r"^(606282[0-9]{13}$|^606282[0-9]{10}$|^606282[0-9]{7}$|^3841[0-9]{15}$|^3841[0-9]{12}$|^3841[0-9]{9}$|^637[0-9]{16}$|^637[0-9]{13}$|^637[0-9]{10})");
    var aura = RegExp(r"^507860[0-9]{10}$|^504175[0-9]{10}");
    var visa = RegExp(r"^4[0-9]{15}$|^4[0-9]{12}");
    var diners = RegExp(
        r"^3[68][0-9]{14}$|^3[68][0-9]{12}$|^30[15][0-9]{13}$|^30[15][0-9]{11}");
    var amex = RegExp(r"^3[47][0-9]{13}");
    var discover =
        RegExp(r"^6011[0-9]{12}$|^622[0-9]{13}$|^64[0-9]{14}$|^65[0-9]{14}");
    var jbc = RegExp(r"^35[0-9]{14}");

    if (elo.hasMatch(number)) {
      return 'elo';
    }
    if (mastercard.hasMatch(number)) {
      return 'master';
    }

    if (hipercard.hasMatch(number)) {
      return 'hipercard';
    }
    if (aura.hasMatch(number)) {
      return 'aura';
    }
    if (visa.hasMatch(number)) {
      return 'visa';
    }
    if (diners.hasMatch(number)) {
      return 'diners';
    }
    if (amex.hasMatch(number)) {
      return 'amex';
    }
    if (discover.hasMatch(number)) {
      return 'discover';
    }
    if (jbc.hasMatch(number)) {
      return 'jbc';
    }
    return '';
  }
}
