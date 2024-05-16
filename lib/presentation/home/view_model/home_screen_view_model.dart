import 'package:flutter/material.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';
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
  Weather? _currentWeather;
  List<Weather> _weatherByTimeList = [];
  List<Feed> _feedList = [];
  HomeScreenStatus _status = HomeScreenStatus.idle;
  // 전일 대비 온도차
  double? _temperatureGap;
  String? _weatherBackgroundImage;

  DailyLocationWeather? get dailyLocationWeather => _dailyLocationWeather;
  Weather? get currentWeather => _currentWeather;
  double? get temperatureGap => _temperatureGap ?? 0;
  List<Feed> get feedList => _feedList;
  HomeScreenStatus get status => _status;
  String get backgroundImagePath =>
      _weatherBackgroundImage ?? ImagePath.homeBackgroundSunny;
  List<Weather> get weatherByTimeList => _weatherByTimeList;

  Future<void> initHomeScreen() async {
    _status = HomeScreenStatus.loading;
    notifyListeners();

    try {
      _dailyLocationWeather = await getDailyLocationWeatherUseCase.execute();

      _feedList = await getRecommendedFeedsUseCase.execute(
        dailyLocationWeather: _dailyLocationWeather!,
      );

      if (_dailyLocationWeather != null) {
        // 현재 시간에 맞는 날씨 예보 빼내기
        _currentWeather = dailyLocationWeather!.weatherList.firstWhere(
          (element) => element.timeTemperature.hour == DateTime.now().hour,
        );

        _calculateTemperatureGap();
        await _getWeatherByTimeList();
        await _getBackgroundImagePath();
        _status = HomeScreenStatus.success;
      }

      notifyListeners();
    } catch (e) {
      _status = HomeScreenStatus.error;
      notifyListeners();
    }
  }

  /// 현재 시간부터 24시간 이후까지의 날씨 정보를 가져오기
  Future<void> _getWeatherByTimeList() async {
    DateTime now = DateTime.now();
    int currentHour = now.hour;
    List<Weather> weatherList = [];

    // 현재 시간 이후의 날씨 정보 목록
    List<Weather> weatherAfterCurrentTime = dailyLocationWeather!.weatherList
        .where((e) => e.timeTemperature.hour >= currentHour)
        .toList();

    // 중복되는 시간의 정보를 기록합니다.
    Set<int> hoursAlreadyAdded =
        Set.from(weatherAfterCurrentTime.map((e) => e.timeTemperature.hour));

    // 현재 시간 이후의 객체를 추가합니다.
    weatherList.addAll(weatherAfterCurrentTime);

    // 남은 시간만큼을 dailyLocationWeather!.tomorrowWeatherList에서 가져와서 채웁니다.
    int remainingCount = 24 - weatherAfterCurrentTime.length;

    if (remainingCount > 0) {
      List<Weather> tomorrowWeather = dailyLocationWeather!.tomorrowWeatherList
          .where((e) => !hoursAlreadyAdded.contains(e.timeTemperature.hour))
          .take(remainingCount)
          .toList();

      weatherList.addAll(tomorrowWeather);
    }
    _weatherByTimeList = weatherList;
  }

  /// 배경 이미지 주소 가져오기
  Future<void> _getBackgroundImagePath() async {
    try {
      final weatherBackgroundImageList =
          await getBackgroundImageListUseCase.execute();

      if (weatherBackgroundImageList.isEmpty) {
        _weatherBackgroundImage = ImagePath.homeBackgroundSunny;
      }

      WeatherBackgroundImage image = weatherBackgroundImageList.firstWhere(
          (element) =>
              element.code ==
              WeatherCode.fromDtoCode(currentWeather!.code).value);

      _weatherBackgroundImage = image.imagePath;
    } catch (e) {
      _status = HomeScreenStatus.error;
      notifyListeners();
    }
  }

  /// 전일 대비 온도 계산
  void _calculateTemperatureGap() {
    _temperatureGap = (dailyLocationWeather!.yesterDayWeatherList
            .firstWhere((element) =>
                element.timeTemperature.hour == DateTime.now().hour)
            .temperature) -
        (currentWeather!.temperature);
  }
}
