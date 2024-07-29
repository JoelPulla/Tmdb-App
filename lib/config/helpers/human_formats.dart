import 'package:intl/intl.dart';

class HumanFormats {
  static String numberFormat(double number) {
    final formatteddNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      locale: 'en',
      symbol: '',
    ).format(number);

    return formatteddNumber;
  }
}
