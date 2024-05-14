import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';

class OotdPostViewModel with ChangeNotifier {
  final GetImageUseCase _getImageUseCase;
  final GetDailyLocationWeatherUseCase _getDailyLocationWeatherUseCase;
  bool _showSpinner = false;

  OotdPostViewModel({
    required GetImageUseCase getImageUseCase,
    required GetDailyLocationWeatherUseCase getDailyLocationWeatherUseCase,
  })  : _getImageUseCase = getImageUseCase,
        _getDailyLocationWeatherUseCase = getDailyLocationWeatherUseCase;

  File? _image;
  Weather? _weather;
  DailyLocationWeather? _dailyLocationWeather;

  Future<void> initOotdPost() async {
    _showSpinner = true;
    notifyListeners();

    try {
      _image = await _getImageUseCase.execute(isOrigin: false);
      _dailyLocationWeather = await _getDailyLocationWeatherUseCase.execute();
      // 현재 시간 날씨
      _weather = _dailyLocationWeather!.weatherList.firstWhere((element) {
        return element.timeTemperature.hour == DateTime.now().hour;
      });
    } catch (e) {
      log(e.toString());
    }

    _showSpinner = false;
    notifyListeners();
  }

  File? get image => _image;

  Weather? get weather => _weather;

  DailyLocationWeather? get dailyLocationWeather => _dailyLocationWeather;

  bool get showSpinner => _showSpinner;
}
