import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/save_edit_feed_use_case.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';

class OotdPostViewModel with ChangeNotifier {
  final GetImageUseCase _getImageUseCase;
  final GetDailyLocationWeatherUseCase _getDailyLocationWeatherUseCase;
  final SaveEditFeedUseCase _saveEditFeedUseCase;
  bool _showSpinner = false;

  OotdPostViewModel({
    required GetImageUseCase getImageUseCase,
    required GetDailyLocationWeatherUseCase getDailyLocationWeatherUseCase,
    required SaveEditFeedUseCase saveEditFeedUseCase,
  })  : _getImageUseCase = getImageUseCase,
        _getDailyLocationWeatherUseCase = getDailyLocationWeatherUseCase,
        _saveEditFeedUseCase = saveEditFeedUseCase;

  File? _image;
  Weather? _weather;
  DailyLocationWeather? _dailyLocationWeather;

  void initOotdPost() async {
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

  void saveFeed(String description, Function(bool) callback) async {
    final Feed feed = Feed(
      id: null,
      imagePath: image!.path,
      userEmail: 'abc@gmail.com',
      description: description,
      weather: Weather(
        temperature: weather!.temperature,
        timeTemperature: weather!.timeTemperature,
        code: weather!.code,
        createdAt: DateTime.now(),
      ),
      seasonCode: dailyLocationWeather!.seasonCode,
      location: Location(
        lat: dailyLocationWeather!.location.lat,
        lng: dailyLocationWeather!.location.lng,
        city: dailyLocationWeather!.location.city,
        createdAt: DateTime.now(),
      ),
      createdAt: DateTime.now(),
    );

    final result = await _saveEditFeedUseCase.execute(feed: feed);

    callback(result);
  }

  File? get image => _image;

  Weather? get weather => _weather;

  DailyLocationWeather? get dailyLocationWeather => _dailyLocationWeather;

  bool get showSpinner => _showSpinner;
}
