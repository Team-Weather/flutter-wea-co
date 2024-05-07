class WeatherBackgroundImage {
  final int code;
  final String imagePath;

  WeatherBackgroundImage({required this.code, required this.imagePath});

  @override
  String toString() {
    return 'WeatherBackgroundImage{code: $code, imagePath: $imagePath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherBackgroundImage &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          imagePath == other.imagePath;

  @override
  int get hashCode => code.hashCode ^ imagePath.hashCode;

  WeatherBackgroundImage copyWith({
    int? code,
    String? imagePath,
  }) {
    return WeatherBackgroundImage(
      code: code ?? this.code,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
