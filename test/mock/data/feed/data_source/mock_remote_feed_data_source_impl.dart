import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class MockRemoteFeedDataSource implements RemoteFeedDataSource {
  final FakeFirebaseFirestore _fakeFirestore;

  MockRemoteFeedDataSource({required FakeFirebaseFirestore fakeFirestore})
      : _fakeFirestore = fakeFirestore;

  @override
  Future<bool> deleteFeed({required String id}) {
    // TODO: implement deleteFeed
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getFeed({required String id}) async {
    DocumentSnapshot docSnapshot =
    await _fakeFirestore.collection("feeds").doc(id).get();
    return docSnapshot.data() as Map<String, dynamic>;
  }

  @override
  Future<List<Feed>> getFeedList({required String email}) {
    // TODO: implement getFeedList
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getRecommendedFeedList(
      {required Location location, required Weather weather}) {
    // TODO: implement getRecommendedFeedList
    throw UnimplementedError();
  }

  @override
  Future<List<Feed>> getSearchFeedList({int? seasonCode, Weather? weather}) {
    // TODO: implement getSearchFeedList
    throw UnimplementedError();
  }

  @override
  Future<bool> saveFeed({required Feed feed}) async {
    DocumentReference docRef = await _fakeFirestore.collection("feeds").add({
      'id': feed.id,
      'createdAt': feed.createdAt,
      'deletedAt': feed.deletedAt,
      'description': feed.description,
      'imagePath': feed.imagePath,
      'seasonCode': feed.seasonCode,
      'userEmail': feed.userEmail,
    });

    await docRef.collection('location').add({
      'lat': feed.location.lat,
      'lng': feed.location.lng,
      'city': feed.location.city,
      'createdAt': feed.location.createdAt,
    });
    await docRef.collection('weather').add({
      'temperature': feed.weather.temperature,
      'timeTemperature': feed.weather.timeTemperature,
      'code': feed.weather.code,
      'createdAt': feed.weather.createdAt,
    });

    return true;
  }
}
