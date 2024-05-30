import 'package:flutter_dotenv/flutter_dotenv.dart';

class KakaoConfig {
  static final String apiKey = dotenv.env['KAKAO_API_KEY'] ?? 'undefined';
}
