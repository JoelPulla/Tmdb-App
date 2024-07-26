import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  //Api key Data Base
  static String tmdbApiKey = dotenv.env['TMDBKEY'] ?? 'No Hay Data';
}
