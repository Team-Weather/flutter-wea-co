import 'package:weaco/common/image_path.dart';

enum WeatherCode {
  noData(
    value: 0,
    iconPath: '',
    description: '-',
  ), // no data
  clearSky(
      value: 1,
      iconPath: ImagePath.weatherClearSkyIcon,
      description: '맑음'), // 맑음
  partlyCloudy(
    value: 2,
    iconPath: ImagePath.weatherPartlyCloudy,
    description: '흐림',
  ), // 조금 흐림
  fog(
    value: 3,
    iconPath: ImagePath.weatherFog,
    description: '안개',
  ), // 안개
  drizzle(
    value: 4,
    iconPath: ImagePath.weatherDrizzle,
    description: '이슬비',
  ), // 이슬비
  freezingDrizzle(
      value: 5,
      iconPath: ImagePath.weatherDrizzle,
      description: '진눈깨비'),
  rain(
    value: 6,
    iconPath: ImagePath.weatherRain,
    description: '비',
  ), // 비
  rainShower(
      value: 7,
      iconPath: ImagePath.weatherRainShower,
      description: '소나기'), // 소나기
  freezingRain(
      value: 8,
      iconPath: ImagePath.weatherFreezingRain,
      description: '얼어 붙은 비'), // 얼어 붙은 비
  snow(
    value: 9,
    iconPath: ImagePath.weatherSnow,
    description: '눈',
  ), // 눈
  snowGrain(
    value: 10,
    iconPath: ImagePath.weatherSnow,
    description: '싸락눈',
  ), // 싸락눈
  snowShower(
    value: 11,
    iconPath: ImagePath.weatherSnow,
    description: '소낙눈',
  ), // 소낙눈
  thunderStorm(
    value: 12,
    iconPath: ImagePath.weatherThunderStorm,
    description: '뇌우',
  ), // 뇌우
  thunderStormHail(
    value: 13,
    iconPath: ImagePath.weatherThunderStormHail,
    description: '눈보라',
  ); // 우박을 동반한 뇌우

  final int value;
  final String iconPath;
  final String description;

  const WeatherCode(
      {required this.value, required this.iconPath, required this.description});

  // WeatherCode의 value 값으로 WeatherCode 매핑
  static WeatherCode fromValue(int value) {
    return switch (value) {
      0 => WeatherCode.noData,
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
      _ => throw ArgumentError('Invalid value')
    };
  }

  // Api에서 받아온 데이터를 WeatherCode로 변경
  static WeatherCode fromDtoCode(int code) {
    return switch (code) {
      0 => WeatherCode.clearSky,
      1 || 2 || 3 => WeatherCode.partlyCloudy,
      45 || 48 => WeatherCode.fog,
      51 || 53 || 55 => WeatherCode.drizzle,
      56 || 57 ||  66 || 67 => WeatherCode.freezingDrizzle,
      61 || 63 || 65 => WeatherCode.rain,
      80 || 81 || 82 => WeatherCode.rainShower,
      71 || 73 || 75 => WeatherCode.snow,
      77 => WeatherCode.snowGrain,
      85 || 86 => WeatherCode.snowShower,
      95 => WeatherCode.thunderStorm,
      96 || 99 => WeatherCode.thunderStormHail,
      _ => throw ArgumentError('Invalid value')
    };
  }
}
