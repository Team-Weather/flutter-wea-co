class WeatherBackgroundImage {
  final String imagePath;

  WeatherBackgroundImage({required this.imagePath});

  @override
  String toString() {
    return 'WeatherBackgroundImage{imagePath: $imagePath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherBackgroundImage &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath;

  @override
  int get hashCode => imagePath.hashCode;

  WeatherBackgroundImage copyWith({
    String? imagePath,
  }) {
    return WeatherBackgroundImage(
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
