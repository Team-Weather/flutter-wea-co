class GpsPosition {
  final double lat;
  final double lng;

  GpsPosition({required this.lat, required this.lng});

  @override
  String toString() {
    return 'GpsPosition{lat: $lat, lng: $lng}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GpsPosition &&
          runtimeType == other.runtimeType &&
          lat == other.lat &&
          lng == other.lng;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
