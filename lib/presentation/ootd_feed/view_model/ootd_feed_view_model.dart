import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/presentation/ootd_feed/ootd_card.dart';

class OotdFeedViewModel extends ChangeNotifier {
  final List<OotdCard> _feedList = [];
  List<OotdCard> get feedList => List.unmodifiable(_feedList);


  OotdFeedViewModel() {
    loadMorePage();
  }

  void loadMorePage() {
    for (int i = 0; i < 5; i++) {
      _feedList.add(OotdCard(
          data: Feed(
              id: '${_feedList.length}',
              imagePath:
                  'https://user-images.githubusercontent.com/38002959/143966223-7c10b010-32a9-4fd5-b021-3a9764134318.png',
              userEmail: 'hoogom87@gmail.com',
              description: '겨울에는 역시 롱패딩',
              weather: Weather(
                  temperature: -10.2,
                  timeTemperature: DateTime.now(),
                  code: 0,
                  createdAt: DateTime.now()),
              seasonCode: 1,
              location: Location(
                  lat: 36.984, lng: 128.546, city: '서울시 노원구', createdAt: DateTime.now()),
              createdAt: DateTime.now())));
    }
    notifyListeners();
  }
}
