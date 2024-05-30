import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/temperature_code.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_search_feeds_use_case.dart';

class OotdSearchViewModel with ChangeNotifier {
  final GetSearchFeedsUseCase _getSearchFeedsUseCase;

  OotdSearchViewModel({required GetSearchFeedsUseCase getSearchFeedsUseCase})
      : _getSearchFeedsUseCase = getSearchFeedsUseCase {
    getInitialFeedList();
  }

  static const _fetchCount = 21;
  static const _fetchMoreCount = 9;

  List<Feed> _searchFeedList = [];

  bool _isPageLoading = false;
  bool _isFeedListLoading = false;
  bool _isFeedListReachEnd = false;

  DateTime _lastFeedDateTime = DateTime.now();

  List<Feed> get searchFeedList => _searchFeedList;

  bool get isPageLoading => _isPageLoading;

  bool get isFeedListLoading => _isFeedListLoading;

  void changePageLoadingStatus(bool status) {
    _isPageLoading = status;
    notifyListeners();
  }

  void changeFeedListLoadingStatus(bool status) {
    _isFeedListLoading = status;
    notifyListeners();
  }

  void changeIsFeedListReachEndStatus(bool status) {
    _isFeedListReachEnd = status;
    notifyListeners();
  }

  void setLastFeedDateTime() {
    if (_searchFeedList.isNotEmpty) {
      _lastFeedDateTime = _searchFeedList[_searchFeedList.length - 1].createdAt;

      notifyListeners();
    }
  }

  void _clearFeedList() {
    _searchFeedList.clear();
    notifyListeners();
  }

  Future<void> getInitialFeedList() async {
    changePageLoadingStatus(true);
    try {
      _searchFeedList = await _getSearchFeedsUseCase.execute(
        limit: _fetchCount,
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'OotdSearchViewModel.fetchInitialFeedList()');
    }

    changePageLoadingStatus(false);
    setLastFeedDateTime();

    notifyListeners();
  }

  Future<void> fetchFeedWhenFilterChange(
      {int weatherCodeValue = 0,
      int seasonCodeValue = 0,
      int temperatureCodeValue = 0}) async {
    // 넘어온 코드가 0일 경우도 선택 안된 것, (null과 동일)
    log('fetchFeedWhenFilterChange 호출 (seasonCodeValue: $seasonCodeValue, weatherCodeValue: $weatherCodeValue, temperatureCodeValue: $temperatureCodeValue');

    final seasonCode = SeasonCode.fromValue(seasonCodeValue);
    final weatherCode = WeatherCode.fromValue(weatherCodeValue);
    final temperatureCode = TemperatureCode.fromValue(temperatureCodeValue);
    log('fetchFeedWhenFilterChange 호출 (seasonCodeValue: $seasonCode, weatherCodeValue: $weatherCode, temperatureCodeValue: $temperatureCode');

    // 요청 보내기
    _clearFeedList();
    changeFeedListLoadingStatus(true);

    final result = await _getSearchFeedsUseCase.execute(
      limit: _fetchCount,
      createdAt: null,
      seasonCode: seasonCode.value <= 0 ? null : seasonCode.value,
      weatherCode: weatherCode.value <= 0 ? null : weatherCode.value,
      minTemperature: temperatureCode.value <= 0 ? null :  temperatureCode.minTemperature,
      maxTemperature: temperatureCode.value <= 0 ? null :  temperatureCode.maxTemperature,
    );

    _searchFeedList.addAll(result);

    changeFeedListLoadingStatus(false);
    setLastFeedDateTime();

    notifyListeners();
  }

  Future<void> fetchFeedWhenScroll(
      {int weatherCodeValue = 0,
      int seasonCodeValue = 0,
      int temperatureCodeValue = 0}) async {
    // 넘어온 코드가 0일 경우도 선택 안된 것, (null과 동일)
    final seasonCode = SeasonCode.fromValue(seasonCodeValue);
    final weatherCode = WeatherCode.fromValue(weatherCodeValue);
    final temperatureCode = TemperatureCode.fromValue(temperatureCodeValue);
    log('fetchFeedWhenFilterChange 호출 (seasonCodeValue: $seasonCode, weatherCodeValue: $weatherCode, temperatureCodeValue: $temperatureCode');

    // 모든 피드를 다 불러왔음을 확인하는 플래그값 true 일 때
    // -> 피드 페이지네이션 요청 차단
    if (_isFeedListReachEnd) return;

    // 요청 보내기
    if (!_isFeedListLoading) {
      changeFeedListLoadingStatus(true);

      final result = await _getSearchFeedsUseCase.execute(
        limit: _fetchMoreCount,
        createdAt: _lastFeedDateTime,
        seasonCode: seasonCode.value <= 0 ? null : seasonCode.value,
        weatherCode: weatherCode.value <= 0 ? null : weatherCode.value,
        minTemperature: temperatureCode.value <= 0 ? null :  temperatureCode.minTemperature,
        maxTemperature: temperatureCode.value <= 0 ? null :  temperatureCode.maxTemperature,
      );

      _searchFeedList.addAll(result);

      log('feed fetched', name: 'UserPageViewModel.fetchFeed()');

      if (result.length < _fetchMoreCount) {
        changeIsFeedListReachEndStatus(true);
        log('feed list reaches end!', name: 'UserPageViewModel.fetchFeed()');
      }

      setLastFeedDateTime();
      changeFeedListLoadingStatus(false);

      notifyListeners();
    }
  }
}
