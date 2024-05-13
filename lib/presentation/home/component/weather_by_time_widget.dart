import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weaco/domain/common/enum/weather_code.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';

class WeatherByTimeWidget extends StatelessWidget {
  const WeatherByTimeWidget({
    super.key,
    required this.dailyLocationWeather,
    required this.index,
  });

  final DailyLocationWeather? dailyLocationWeather;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat('aa HH시', 'ko_KR').format(
                dailyLocationWeather!.weatherList[index].timeTemperature),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Image.asset(
            WeatherCode.fromCode(dailyLocationWeather!.weatherList[index].code)
                .iconPath,
            width: 28,
          ),
          const SizedBox(height: 4),
          Text(
            '${dailyLocationWeather?.weatherList[index].temperature}°',
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
