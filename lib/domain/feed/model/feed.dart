import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class Feed {
  final String id;
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

  Feed copyWith({
    int? id,
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
}
