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

  static String shortDate(DateTime date) {
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
}
