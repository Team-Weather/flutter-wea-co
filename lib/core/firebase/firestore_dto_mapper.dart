import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/weather/model/weather.dart';

Feed toFeed({required Map<String, dynamic> json, required String id}) {
  return Feed(
    id: id,
    imagePath: json['image_path'],
    thumbnailImagePath: json['thumbnail_image_path'] ?? json['image_path'],
    userEmail: json['user_email'],
    description: json['description'],
    weather: Weather.fromJson(json['weather']),
    seasonCode: json['season_code'],
    location: Location.fromJson(json['location']),
    createdAt: (json['created_at'] as Timestamp).toDate(),
    deletedAt: json['deleted_at'] != null
        ? (json['deleted_at'] as Timestamp).toDate()
        : null,
  );
}

Map<String, dynamic> toFeedDto({required Feed feed}) {
  return {
    'image_path': feed.imagePath,
    'thumbnail_image_path': feed.thumbnailImagePath,
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

Map<String, dynamic> toUserProfileDto({required UserProfile userProfile}) {
  return {
    'email': userProfile.email,
    'nickname': userProfile.nickname,
    'gender': userProfile.gender,
    'profile_image_path': userProfile.profileImagePath,
    'feed_count': userProfile.feedCount,
    'created_at': Timestamp.fromDate(userProfile.createdAt),
    'deleted_at': userProfile.deletedAt != null
        ? Timestamp.fromDate(userProfile.deletedAt!)
        : null,
  };
}

UserProfile toUserProfile({required Map<String, dynamic> json}) {
  return UserProfile(
    email: json['email'],
    nickname: json['nickname'],
    gender: json['gender'],
    profileImagePath: json['profile_image_path'],
    feedCount: json['feed_count'],
    createdAt: (json['created_at'] as Timestamp).toDate(),
    deletedAt: json['deleted_at'] != null
        ? (json['deleted_at'] as Timestamp).toDate()
        : null,
  );
}



