import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class GetRecommendedFeedsUseCase {
  final FeedRepository _feedRepository;

  GetRecommendedFeedsUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  /// 레포지토리에 필터를 통해 추천 피드를 요청
  /// @param seasonCode: 계절 코드
  /// @param weatherCode: 날씨 코드
  /// @param minTemperature: 최저 기온
  /// @param maxTemperature: 최고 기온
  /// @return: 반환 받은 추천 피드 리스트
  Future<List<Feed>> execute({
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    return await _feedRepository.getRecommendedFeedList(
      dailyLocationWeather: dailyLocationWeather,
    );
  }
}
