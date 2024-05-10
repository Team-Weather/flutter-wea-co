import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/common/convertor.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class Feed {
  final String? id;
  final String imagePath;
  final String userEmail;
  final String description;
  final Weather weather;
  final int seasonCode;
  final Location location;
  final DateTime createdAt;
  final DateTime? deletedAt;

  Feed({
    required this.id,
    required this.imagePath,
    required this.userEmail,
    required this.description,
    required this.weather,
    required this.seasonCode,
    required this.location,
    required this.createdAt,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'Feed(id: $id, imagePath: $imagePath, userEmail: $userEmail, description: $description, weather: $weather, seasonCode: $seasonCode, location: $location, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(covariant Feed other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.imagePath == imagePath &&
        other.userEmail == userEmail &&
        other.description == description &&
        other.weather == weather &&
        other.seasonCode == seasonCode &&
        other.location == location &&
        other.createdAt == createdAt &&
        other.deletedAt == deletedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        imagePath.hashCode ^
        userEmail.hashCode ^
        description.hashCode ^
        weather.hashCode ^
        seasonCode.hashCode ^
        location.hashCode ^
        createdAt.hashCode ^
        deletedAt.hashCode;
  }

  Feed copyWith({
    String? id,
    String? imagePath,
    String? userEmail,
    String? description,
    Weather? weather,
    int? seasonCode,
    Location? location,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return Feed(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      userEmail: userEmail ?? this.userEmail,
      description: description ?? this.description,
      weather: weather ?? this.weather,
      seasonCode: seasonCode ?? this.seasonCode,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_path': imagePath,
      'user_email': userEmail,
      'description': description,
      'weather': weather.toFirebase(),
      'season_code': seasonCode,
      'location': location.toFirebase(),
      'created_at': createdAt,
      'deleted_at': deletedAt,
    };
  }

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['id'],
      imagePath: json['image_path'],
      userEmail: json['user_email'],
      description: json['description'],
      weather: Weather.fromFirebase(json['weather']),
      seasonCode: json['season_code'],
      location: Location.fromFirebase(json['location']),
      createdAt: convertTimestampToDateTime(json['created_at']),
      deletedAt: json['deleted_at'] != null
          ? convertTimestampToDateTime(json['deleted_at'])
          : null,
    );
  }
  factory Feed.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Feed(
      id: doc.id,
      imagePath: doc.data()!['image_path'],
      userEmail: doc.data()!['user_email'],
      description: doc.data()!['description'],
      weather: Weather.fromFirebase(doc.data()!['weather']),
      seasonCode: doc.data()!['season_code'],
      location: Location.fromFirebase(doc.data()!['location']),
      createdAt: convertTimestampToDateTime(doc.data()!['created_at']),
      deletedAt: doc.data()?['deleted_at'] != null
          ? convertTimestampToDateTime(doc.data()!['deleted_at'])
          : null,
    );
  }
}
