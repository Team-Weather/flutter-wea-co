class Location {
  final double lat;
  final double lng;
  final String city;
  final DateTime createdAt;

  const Location({
    required this.lat,
    required this.lng,
    required this.city,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Location{lat: $lat, lng: $lng, city: $city, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Location &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng &&
          city == other.city &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      lat.hashCode ^ lng.hashCode ^ city.hashCode ^ createdAt.hashCode;

  Location copyWith({
    double? lat,
    double? lng,
    String? city,
    DateTime? createdAt,
  }) {
    return Location(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
