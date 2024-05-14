// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_background_image_list_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';

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
  HomeScreenViewModel({
    required this.getDailyLocationWeatherUseCase,
    required this.getBackgroundImageListUseCase,
    required this.getRecommendedFeedsUseCase,
  });

  final GetDailyLocationWeatherUseCase getDailyLocationWeatherUseCase;
  final GetBackgroundImageListUseCase getBackgroundImageListUseCase;
  final GetRecommendedFeedsUseCase getRecommendedFeedsUseCase;

  DailyLocationWeather? _dailyLocationWeather;

  List<Feed> _feedList = [];
  HomeScreenStatus _status = HomeScreenStatus.idle;

  DailyLocationWeather? get dailyLocationWeather => _dailyLocationWeather;
  List<Feed> get feedList => _feedList;
  HomeScreenStatus get status => _status;

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
      _dailyLocationWeather = await getDailyLocationWeatherUseCase.execute();

      // TODO. OOTD 목록 10개 부르기
      _feedList = await getRecommendedFeedsUseCase.execute(
        dailyLocationWeather: _dailyLocationWeather!,
      );

      if (_dailyLocationWeather != null) {
        _status = HomeScreenStatus.success;
      }

      // TODO. 전일 대비 계산

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      // TODO. 에러 다이얼로그 또는 스낵바 처리
      _status = HomeScreenStatus.error;
      notifyListeners();
    }
  }
}
