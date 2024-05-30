import 'dart:developer';
import 'package:weaco/domain/feed/use_case/get_ootd_feeds_use_case.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';
import 'package:weaco/presentation/common/component/base_change_notifier.dart';
import 'package:weaco/presentation/common/enum/exception_alert_type.dart';
import 'package:weaco/presentation/common/state/exception_status.dart';
import 'package:weaco/presentation/ootd_feed/ootd_card.dart';

class OotdFeedViewModel extends BaseChangeNotifier {
  DailyLocationWeather? _dailyLocationWeather;
  bool _isEndOfData = false;
  final List<OotdCard> _feedList = [];
  int _currentIndex = 0;
  final GetOotdFeedsUseCase _getOotdFeedsUseCase;
  final GetDailyLocationWeatherUseCase _getDailyLocationWeatherUseCase;

  OotdFeedViewModel(
      {required GetOotdFeedsUseCase getOotdFeedsUseCase,
      required GetDailyLocationWeatherUseCase getDailyLocationWeatherUseCase})
      : _getOotdFeedsUseCase = getOotdFeedsUseCase,
        _getDailyLocationWeatherUseCase = getDailyLocationWeatherUseCase {
    // initPage();
  }

  List<OotdCard> get feedList => List.unmodifiable(_feedList);

  int get currentIndex => _currentIndex;

  bool get isEndOfData => _isEndOfData;

  Future<void> _getFeedList() async {
    log('함수 호출', name: 'OotdFeedViewModel._getFeedList()');
    if(_isEndOfData) return;
    try {
      log( _feedList.isNotEmpty ? _feedList.last.feed.createdAt.toString() : 'empty', name: 'OotdFeedViewModel._getFeedList()');
      final dataList = (await _getOotdFeedsUseCase.execute(
          createdAt:
              _feedList.isNotEmpty ? _feedList.last.feed.createdAt : null,
          dailyLocationWeather: _dailyLocationWeather!));
      _feedList.addAll(dataList.map((feed) => OotdCard(feed: feed)));
      if (dataList.length < 10) {
        _isEndOfData = true;
      }
    } catch (e) {
      notifyException(exception: e);
    }
    notifyListeners();
  }

  Future<void> initPage() async {
    log('데이터 초기화', name: 'OotdFeedViewModel.initPage()');
    try {
      _currentIndex = 0;
      _isEndOfData = false;
      _dailyLocationWeather = (await _getDailyLocationWeatherUseCase.execute());
      _feedList.clear();
      _getFeedList();
    } catch (e) {
      notifyException(exception: e);
    }
  }

  void flipCard() {
    _feedList[_currentIndex].isFront = !_feedList[_currentIndex].isFront;
  }

  int moveIndex({required bool isToNext}) {
    final int nextIndex = isToNext ? _currentIndex + 1 : _currentIndex - 1;
    if (nextIndex < 0 || nextIndex >= _feedList.length) {
      return nextIndex;
    }
    _currentIndex = nextIndex;
    notifyListeners();
    if (_currentIndex + 2 >= _feedList.length) {
      log('무한 스크롤: 데이터 요청', name: 'OotdFeedViewModel.moveIndex()');
      _getFeedList();
    }
    return _currentIndex;
  }

  @override
  ExceptionStatus exceptionToExceptionStatus({required Object? exception}) {
    log(exception.toString(), name: 'OotdFeedViewModel.exceptionToExceptionStatus()');
    switch (exception) {
      case _:
        ExceptionAlertType status = ExceptionAlertType.snackBar;
        return ExceptionStatus(
            message: '네트워크 오류', exceptionAlertType: status);
    }
  }
}
