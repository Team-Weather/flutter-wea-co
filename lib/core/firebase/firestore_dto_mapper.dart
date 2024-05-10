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
    weather: toWeather(weatherDto: feedDto['weather']),
    seasonCode: feedDto['season_code'],
    location: toLocation(locationDto: feedDto['location']),
    createdAt: (feedDto['created_at'] as Timestamp).toDate(),
    deletedAt: feedDto['deleted_at'] != null
        ? (feedDto['deleted_at'] as Timestamp).toDate()
        : null,
  );
}

Location toLocation({required Map<String, dynamic> locationDto}) {
  return Location(
    lat: locationDto['lat'] as double,
    lng: locationDto['lng'] as double,
    city: locationDto['city'] as String,
    createdAt: (locationDto['created_at'] as Timestamp).toDate(),
  );
}

Weather toWeather({required Map<String, dynamic> weatherDto}) {
  return Weather(
    temperature: weatherDto['temperature'] as double,
    timeTemperature: (weatherDto['time_temperature'] as Timestamp).toDate(),
    code: weatherDto['code'] as int,
    createdAt: (weatherDto['created_at'] as Timestamp).toDate(),
  );
}

Map<String, dynamic> toWeatherDto({required Weather weather}) {
  return {
    'temperature': weather.temperature,
    'time_temperature': weather.timeTemperature,
    'code': weather.code,
    'created_at': Timestamp.fromDate(weather.createdAt),
  };
}

Map<String, dynamic> toLocationDto({required Location location}) {
  return {
    'lat': location.lat,
    'lng': location.lng,
    'city': location.city,
    'created_at': Timestamp.fromDate(location.createdAt),
  };
}

Map<String, dynamic> toFeedDto({required Feed feed}) {
  return {
    'id': feed.id,
    'image_path': feed.imagePath,
    'user_email': feed.userEmail,
    'description': feed.description,
    'weather': toWeatherDto(weather: feed.weather),
    'season_code': feed.seasonCode,
    'location': toLocationDto(location: feed.location),
    'created_at': Timestamp.fromDate(feed.createdAt),
    'deleted_at':
        feed.deletedAt != null ? Timestamp.fromDate(feed.deletedAt!) : null,
  };
}
