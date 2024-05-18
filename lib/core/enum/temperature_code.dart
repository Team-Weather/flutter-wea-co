enum TemperatureCode {
  noData(value: 0, description: '전체', minTemperature: 0, maxTemperature: 0),
  underMinusTen(
      value: 1,
      description: '-10°C 이하',
      minTemperature: -30,
      maxTemperature: -10),
  overMinusTenToZero(
      value: 2,
      description: '-10°C ~ 0°C',
      minTemperature: -10,
      maxTemperature: 0),
  overZeroToTen(
      value: 3,
      description: '0°C ~ 10°C',
      minTemperature: 0,
      maxTemperature: 10),
  overTenToTwenty(
      value: 4,
      description: '10°C ~ 20°C',
      minTemperature: 10,
      maxTemperature: 20),
  overTwentyToThirty(
      value: 5,
      description: '20°C ~ 30°C',
      minTemperature: 20,
      maxTemperature: 30),
  overThirty(
      value: 6, description: '30°C 이상', minTemperature: 30, maxTemperature: 50);

  final int value;
  final String description;
  final int minTemperature;
  final int maxTemperature;

  const TemperatureCode(
      {required this.value,
      required this.description,
      required this.minTemperature,
      required this.maxTemperature});

  static TemperatureCode fromValue(int value) {
    return switch (value) {
      0 || -1 => TemperatureCode.noData,
      1 => TemperatureCode.underMinusTen,
      2 => TemperatureCode.overMinusTenToZero,
      3 => TemperatureCode.overZeroToTen,
      4 => TemperatureCode.overTenToTwenty,
      5 => TemperatureCode.overTwentyToThirty,
      6 => TemperatureCode.overThirty,
      _ => throw ArgumentError('Invalid value')
    };
  }
}
