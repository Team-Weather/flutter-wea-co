enum WeatherCode {
  noData(value: 0, iconPath: '', description: '-'), // 맑음
  clearSky(value: 1, iconPath: '', description: '맑음'), // 맑음
  partlyCloudy(value: 2, iconPath: '', description: '조금 흐림'), // 조금 흐림
  fog(value: 3, iconPath: '', description: '안개'), // 안개
  drizzle(value: 4, iconPath: '', description: '이슬비'), // 이슬비
  freezingDrizzle(
      value: 5, iconPath: '', description: '얼어 붙은 이슬비'), // 얼어 붙은 이슬비
  rain(value: 6, iconPath: '', description: '비'), // 비
  rainShower(value: 7, iconPath: '', description: '소나기'), // 소나기
  freezingRain(value: 8, iconPath: '', description: '얼어 붙은 비'), // 얼어 붙은 비
  snow(value: 9, iconPath: '', description: '눈'), // 눈
  snowGrain(value: 10, iconPath: '', description: '싸락눈'), // 싸락눈
  snowShower(value: 11, iconPath: '', description: '소낙눈'), // 소낙눈
  thunderStorm(value: 12, iconPath: '', description: '뇌우'), // 뇌우
  thunderStormHail(
      value: 13, iconPath: '', description: '우박을 동반한 뇌우'); // 우박을 동반한 뇌우

  final int value;
  final String iconPath;
  final String description;

  const WeatherCode(
      {required this.value, required this.iconPath, required this.description});

  static WeatherCode fromValue(int value) {
    return switch (value) {
      1 => WeatherCode.clearSky,
      2 => WeatherCode.partlyCloudy,
      3 => WeatherCode.fog,
      4 => WeatherCode.drizzle,
      5 => WeatherCode.freezingDrizzle,
      6 => WeatherCode.rain,
      7 => WeatherCode.rainShower,
      8 => WeatherCode.freezingRain,
      9 => WeatherCode.snow,
      10 => WeatherCode.snowGrain,
      11 => WeatherCode.snowShower,
      12 => WeatherCode.thunderStorm,
      13 => WeatherCode.thunderStormHail,
      _ => WeatherCode.noData
    };
  }

  static WeatherCode fromCode(int code) {
    return switch (code) {
      0 => WeatherCode.clearSky,
      1 || 2 || 3 => WeatherCode.partlyCloudy,
      45 || 48 => WeatherCode.fog,
      51 || 53 || 55 => WeatherCode.drizzle,
      56 || 57 => WeatherCode.freezingDrizzle,
      61 || 63 || 65 => WeatherCode.rain,
      80 || 81 || 82 => WeatherCode.rainShower,
      66 || 67 => WeatherCode.freezingRain,
      71 || 73 || 75 => WeatherCode.snow,
      77 => WeatherCode.snowGrain,
      85 || 86 => WeatherCode.snowShower,
      95 => WeatherCode.thunderStorm,
      96 || 99 => WeatherCode.thunderStormHail,
      _ => throw Exception()
    };
  }
}
