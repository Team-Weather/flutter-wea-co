import 'package:flutter/material.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/presentation/home/component/weather_by_time_widget.dart';

class WeatherByTimeListWidget extends StatelessWidget {
  const WeatherByTimeListWidget({
    super.key,
    required this.dailyLocationWeather,
  });

  final DailyLocationWeather? dailyLocationWeather;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(136, 90, 152, 196),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dailyLocationWeather?.weatherList.length,
              itemBuilder: (context, index) {
                return WeatherByTimeWidget(
                  dailyLocationWeather: dailyLocationWeather,
                  index: index,
                );
              })),
    );
  }
}
