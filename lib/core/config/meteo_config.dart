import 'package:flutter_dotenv/flutter_dotenv.dart';

class MeteoConfig {
  static final String baseUrl = dotenv.env['METEO_BASE_URL'] ?? 'undefined';
}
