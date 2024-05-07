class DailyDto {
  List<String>? _time;
  List<num>? _temperature2mMax;
  List<num>? _temperature2mMin;

  DailyDto({
    List<String>? time,
    List<num>? temperature2mMax,
    List<num>? temperature2mMin,
  }) {
    _time = time ?? [];
    _temperature2mMax = temperature2mMax ?? [];
    _temperature2mMin = temperature2mMin ?? [];
  }

  DailyDto.fromJson({required dynamic json}) {
    _time = json['time'] != null ? json['time'].cast<String>() : [];
    _temperature2mMax = json['temperature_2m_max'] != null
        ? json['temperature_2m_max'] as List<num>
        : [];
    _temperature2mMin = json['temperature_2m_min'] != null
        ? json['temperature_2m_min'] as List<num>
        : [];
  }

  DailyDto copyWith({
    List<String>? time,
    List<num>? temperature2mMax,
    List<num>? temperature2mMin,
  }) =>
      DailyDto(
        time: time ?? _time,
        temperature2mMax: temperature2mMax ?? _temperature2mMax,
        temperature2mMin: temperature2mMin ?? _temperature2mMin,
      );

  List<String>? get time => _time;

  List<num>? get temperature2mMax => _temperature2mMax;

  List<num>? get temperature2mMin => _temperature2mMin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['temperature_2m_max'] = _temperature2mMax;
    map['temperature_2m_min'] = _temperature2mMin;
    return map;
  }

  @override
  String toString() {
    return 'DailyDto{_time: $_time, _temperature2mMax: $_temperature2mMax, _temperature2mMin: $_temperature2mMin}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyDto &&
          runtimeType == other.runtimeType &&
          _time == other._time &&
          _temperature2mMax == other._temperature2mMax &&
          _temperature2mMin == other._temperature2mMin;

  @override
  int get hashCode =>
      (_time?.fold(1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _time.hashCode) ^
      (_temperature2mMax?.fold(
              1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _temperature2mMax.hashCode) ^
      (_temperature2mMin?.fold(
              1, (prev, next) => prev.hashCode ^ next.hashCode) ??
          _temperature2mMin.hashCode);
}
