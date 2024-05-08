enum SeasonCode {
  spring(value: 1),
  summer(value: 2),
  autumn(value: 3),
  winter(value: 4);

  final int value;

  const SeasonCode({required this.value});

  static SeasonCode fromValue(int value) {
    return switch (value) {
      1 => SeasonCode.spring,
      2 => SeasonCode.summer,
      3 => SeasonCode.autumn,
      4 => SeasonCode.winter,
      _ => throw ArgumentError('Invalid value')
    };
  }

  static SeasonCode fromMonth(int month) {
    return switch (month) {
      3 || 4 || 5 => SeasonCode.spring,
      6 || 7 || 8 => SeasonCode.summer,
      9 || 10 || 11 => SeasonCode.autumn,
      12 || 1 || 2 => SeasonCode.winter,
      _ => throw ArgumentError('Invalid month'),
    };
  }
}
