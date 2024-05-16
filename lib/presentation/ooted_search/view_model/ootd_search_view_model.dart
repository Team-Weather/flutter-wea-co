import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/temperature_code.dart';
import 'package:weaco/core/enum/weather_code.dart';

class OotdSearchViewModel extends ChangeNotifier {
  void tmpMethod(
      {int weatherCodeValue = 0,
      int seasonCodeValue = 0,
      int temperatureCodeValue = 0}) {
    // 넘어온 코드가 0일 경우도 선택 안된 것, (null과 동일)
    final seasonCode = SeasonCode.fromValue(seasonCodeValue);
    final weatherCode = WeatherCode.fromValue(weatherCodeValue);
    final temperatureCode = TemperatureCode.fromValue(temperatureCodeValue);
    log('tmpMethod 호출 (seasonCodeValue: $seasonCode, weatherCodeValue: $weatherCode, temperatureCodeValue: $temperatureCode');
  }
}
