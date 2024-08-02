import 'package:intl/intl.dart';

class HumanFormats {
  static String numberFormat(double number, [int decimals = 0]) {
    final formatteddNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      locale: 'en',
      symbol: '',
    ).format(number);

    return formatteddNumber;
  }
}
