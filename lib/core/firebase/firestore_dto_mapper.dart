import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

Feed toFeed({required Map<String, dynamic> feedDto, required String id}) {
  return Feed(
    id: id,
    imagePath: feedDto['image_path'],
    userEmail: feedDto['user_email'],
    description: feedDto['description'],
    weather: Weather.fromJson(feedDto['weather']),
    seasonCode: feedDto['season_code'],
    location: Location.fromJson(feedDto['location']),
    createdAt: (feedDto['created_at'] as Timestamp).toDate(),
    deletedAt: feedDto['deleted_at'] != null
        ? (feedDto['deleted_at'] as Timestamp).toDate()
        : null,
  );
}

Map<String, dynamic> toFeedDto({required Feed feed}) {
  return {
    'image_path': feed.imagePath,
    'user_email': feed.userEmail,
    'description': feed.description,
    'weather': feed.weather.toJson(),
    'season_code': feed.seasonCode,
    'location': feed.location.toJson(),
    'created_at': Timestamp.fromDate(feed.createdAt),
    'deleted_at':
        feed.deletedAt != null ? Timestamp.fromDate(feed.deletedAt!) : null,
  };
}
