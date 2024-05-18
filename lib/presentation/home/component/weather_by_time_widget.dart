import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/domain/weather/model/weather.dart';

class WeatherByTimeWidget extends StatelessWidget {
  const WeatherByTimeWidget({
    super.key,
    required this.weatherList,
    required this.index,
  });

  final List<Weather>? weatherList;
  final int index;

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('aa HH시', 'ko_KR')
        .format(weatherList![index].timeTemperature);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              time == '오전 00시' ? '내일' : time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Image.asset(
            WeatherCode.fromValue(weatherList![index].code).iconPath,
            width: 28,
          ),
          const SizedBox(height: 4),
          Text(
            '${weatherList![index].temperature}℃',
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
