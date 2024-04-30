class Weather {
  final double temperature;
  final DateTime timeTemperature;
  final int code;

  Weather({
    required this.temperature,
    required this.timeTemperature,
    required this.code,
  });

  @override
  String toString() {
    return 'Weather{temperature: $temperature, timeTemperature: $timeTemperature, code: $code}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          temperature == other.temperature &&
          timeTemperature == other.timeTemperature &&
          code == other.code;

  @override
  int get hashCode =>
      temperature.hashCode ^ timeTemperature.hashCode ^ code.hashCode;
}
