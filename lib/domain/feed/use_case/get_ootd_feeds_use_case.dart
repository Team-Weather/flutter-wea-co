import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import '../repository/feed_repository.dart';

/// OOTD 피드 페이지에서 유저의 피드 목록을 보여주기 위한 Use Case
class GetOotdFeedsUseCase {
  final FeedRepository _feedRepository;

  GetOotdFeedsUseCase({required FeedRepository feedRepository})
      : _feedRepository = feedRepository;

  Future<List<Feed>> execute({
    required DateTime? createdAt,
    required DailyLocationWeather dailyLocationWeather,
  }) async {
    List<Feed> feedList = [];
    feedList = await _feedRepository.getOotdFeedList(
      createdAt: createdAt ?? DateTime.now(),
      dailyLocationWeather: dailyLocationWeather,
    );
    return feedList;
  }
}
