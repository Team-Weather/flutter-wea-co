enum SeasonCode {
  noData(value: 0, description: '-'),
  spring(value: 1, description: '봄'),
  summer(value: 2, description: '여름'),
  autumn(value: 3, description: '가을'),
  winter(value: 4, description: '겨울');

  final int value;
  final String description;

  const SeasonCode({required this.value, required this.description});

  static SeasonCode fromValue(int value) {
    return switch (value) {
      0 => SeasonCode.noData,
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
