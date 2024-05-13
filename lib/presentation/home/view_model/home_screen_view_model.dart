import 'package:flutter/material.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';

enum HomeScreenStatus {
  idle,
  loading,
  success,
  error;

  bool get isIdle => this == HomeScreenStatus.idle;
  bool get isLoading => this == HomeScreenStatus.loading;
  bool get isSuccess => this == HomeScreenStatus.success;
  bool get isError => this == HomeScreenStatus.error;
}

class HomeScreenViewModel with ChangeNotifier {
  DailyLocationWeather? _dailyLocationWeather;
  late final DailyLocationWeatherRepository dailyLocationWeatherRepository;
  List<Feed> _feedList = [];
  HomeScreenStatus _status = HomeScreenStatus.idle;

  DailyLocationWeather? get dailyLocationWeather => _dailyLocationWeather;
  List<Feed> get feedList => _feedList;
  HomeScreenStatus get status => _status;

  final _mockDailyLocationWeather = DailyLocationWeather(
    seasonCode: 0,
    highTemperature: 30,
    lowTemperature: 20,
    weatherList: [
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
    ],
    yesterDayWeatherList: [
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
      Weather(
        temperature: 25,
        timeTemperature: DateTime.parse('2024-05-06'),
        code: 1,
        createdAt: DateTime.parse('2024-05-06'),
      ),
    ],
    location: Location(
      lat: 31.23,
      lng: 29.48,
      city: '서울시, 노원구',
      createdAt: DateTime.parse('2024-05-06'),
    ),
    createdAt: DateTime.now(),
  );

  final _mockFeedList = [
    Feed(
        id: '0',
        imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
        userEmail: 'hoogom87@gmail.com',
        description: '오늘의 OOTD',
        weather: Weather(
            code: 0,
            temperature: 23.4,
            timeTemperature: DateTime.now(),
            createdAt: DateTime.now()),
        seasonCode: 0,
        location: Location(
            createdAt: DateTime.now(), lat: 38.325, lng: 128.4356, city: '서울'),
        createdAt: DateTime.now(),
        deletedAt: DateTime.now()),
    Feed(
        id: '0',
        imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
        userEmail: 'hoogom87@gmail.com',
        description: '오늘의 OOTD',
        weather: Weather(
            code: 0,
            temperature: 23.4,
            timeTemperature: DateTime.now(),
            createdAt: DateTime.now()),
        seasonCode: 0,
        location: Location(
            createdAt: DateTime.now(), lat: 38.325, lng: 128.4356, city: '서울'),
        createdAt: DateTime.now(),
        deletedAt: DateTime.now()),
    Feed(
        id: '0',
        imagePath:
            'https://fastly.picsum.photos/id/813/200/300.jpg?hmac=D5xik3d3YUFq2gWtCzrQZs6zuAcmSvgqdZb063ezs4U',
        userEmail: 'hoogom87@gmail.com',
        description: '오늘의 OOTD',
        weather: Weather(
            code: 0,
            temperature: 23.4,
            timeTemperature: DateTime.now(),
            createdAt: DateTime.now()),
        seasonCode: 0,
        location: Location(
            createdAt: DateTime.now(), lat: 38.325, lng: 128.4356, city: '서울'),
        createdAt: DateTime.now(),
        deletedAt: DateTime.now())
  ];

  Future<void> initHomeScreen() async {
    _status = HomeScreenStatus.loading;
    try {
      // _dailyLocationWeather =
      //     await dailyLocationWeatherRepository.getDailyLocationWeather();

      // TODO. OOTD 목록 10개 부르기

      _dailyLocationWeather = _mockDailyLocationWeather;
      _feedList = _mockFeedList;

      if (_dailyLocationWeather != null) {
        _status = HomeScreenStatus.success;
      }
      notifyListeners();
    } catch (e) {
      // TODO. 에러 다이얼로그 또는 스낵바 처리
      _status = HomeScreenStatus.error;
    }
  }
}
