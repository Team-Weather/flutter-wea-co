class Weather {
  final double temperature;
  final DateTime timeTemperature;
  final int code;
  final DateTime createdAt;

  Weather({
    required this.temperature,
    required this.timeTemperature,
    required this.code,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Weather{temperature: $temperature, timeTemperature: $timeTemperature, code: $code, createdAt: $createdAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          temperature == other.temperature &&
          timeTemperature == other.timeTemperature &&
          code == other.code &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      temperature.hashCode ^
      timeTemperature.hashCode ^
      code.hashCode ^
      createdAt.hashCode;

  Weather copyWith({
    double? temperature,
    DateTime? timeTemperature,
    int? code,
    DateTime? createdAt,
  }) {
    return Weather(
      temperature: temperature ?? this.temperature,
      timeTemperature: timeTemperature ?? this.timeTemperature,
      code: code ?? this.code,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'timeTemperature': timeTemperature.toIso8601String(),
      'code': code,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['temperature'] as double,
      timeTemperature: DateTime.parse(json['timeTemperature']),
      code: json['code'] as int,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
