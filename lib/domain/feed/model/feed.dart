class Feed {
  final int id;
  final String imagePath;
  final String userEmail;
  final String description;
  final String weather;
  final int seasonCode;
  final String location;
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
    return 'Feed{id: $id, imagePath: $imagePath, userEmail: $userEmail, description: $description, weather: $weather, seasonCode: $seasonCode, location: $location, createdAt: $createdAt, deletedAt: $deletedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Feed &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imagePath == other.imagePath &&
          userEmail == other.userEmail &&
          description == other.description &&
          weather == other.weather &&
          seasonCode == other.seasonCode &&
          location == other.location &&
          createdAt == other.createdAt &&
          deletedAt == other.deletedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      imagePath.hashCode ^
      userEmail.hashCode ^
      description.hashCode ^
      weather.hashCode ^
      seasonCode.hashCode ^
      location.hashCode ^
      createdAt.hashCode ^
      deletedAt.hashCode;
}
