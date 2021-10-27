import 'package:intl/intl.dart';

class Utils {
  static String getValueInCurrency(num value) => NumberFormat.currency(
        name: 'R\$ ',
        decimalDigits: 2,
      ).format(value);
}
