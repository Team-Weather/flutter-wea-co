import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/data/weather/data_soruce/remote_weather_background_image_data_source.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

class RemoteWeatherBackgroundImageDataSourceImpl
    implements RemoteWeatherBackgroundImageDataSource {
  final FirebaseFirestore _firestore;

  RemoteWeatherBackgroundImageDataSourceImpl(
      {required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<WeatherBackgroundImage>> getWeatherBackgroundImageList() async {
    QuerySnapshot<Map<String, dynamic>> result =
        await _firestore.collection('weather_background_images').get();
    return result.docs
        .map((e) => WeatherBackgroundImage(
            code: e.data()['code'], imagePath: e.data()['image_path']))
        .toList();
  }
}
