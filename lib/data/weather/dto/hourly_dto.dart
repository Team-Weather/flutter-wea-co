class HourlyDto {
  List<String>? _time;
  List? _temperature2m;
  List? _weathercode;

  HourlyDto({
    List<String>? time,
    List? temperature2m,
    List? weathercode,
  }) {
    _time = time ?? [];
    _temperature2m = temperature2m ?? [];
    _weathercode = weathercode ?? [];
  }

  HourlyDto.fromJson({required dynamic json}) {
    _time = json['time'] != null ? json['time'].cast<String>() : [];
    _temperature2m = json['temperature_2m'] != null
        ? json['temperature_2m'] as List
        : [];
    _weathercode =
        json['weathercode'] != null ? json['weathercode'] as List : [];
  }

  HourlyDto copyWith({
    List<String>? time,
    List? temperature2m,
    List? weathercode,
  }) =>
      HourlyDto(
        time: time ?? _time,
        temperature2m: temperature2m ?? _temperature2m,
        weathercode: weathercode ?? _weathercode,
      );

  List<String>? get time => _time;

  List? get temperature2m => _temperature2m;

  List? get weathercode => _weathercode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['temperature_2m'] = _temperature2m;
    map['weathercode'] = _weathercode;
    return map;
  }

  @override
  String toString() {
    return 'HourlyDto{_time: $_time, _temperature2m: $_temperature2m, _weathercode: $_weathercode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourlyDto &&
          runtimeType == other.runtimeType &&
          _time == other._time &&
          _temperature2m == other._temperature2m &&
          _weathercode == other._weathercode;

  @override
  int get hashCode =>
      (_time?.fold(1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _time.hashCode) ^
      (_temperature2m?.fold(1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _temperature2m.hashCode) ^
      (_weathercode?.fold(1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _weathercode.hashCode);
}
