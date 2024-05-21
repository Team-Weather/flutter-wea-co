import 'package:flutter/material.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/presentation/home/component/weather_by_time_widget.dart';

class WeatherByTimeListWidget extends StatefulWidget {
  const WeatherByTimeListWidget({
    super.key,
    required this.weatherList,
  });

  final List<Weather>? weatherList;

  @override
  State<WeatherByTimeListWidget> createState() =>
      _WeatherByTimeListWidgetState();
}

class _WeatherByTimeListWidgetState extends State<WeatherByTimeListWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double heightPercentage = 105 / screenHeight;

    return Container(
        alignment: Alignment.center,
        height: screenHeight * heightPercentage,
        decoration: BoxDecoration(
            color: const Color.fromARGB(136, 90, 152, 196),
            borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.weatherList!.length,
            itemBuilder: (context, index) {
              return WeatherByTimeWidget(
                weatherList: widget.weatherList,
                index: index,
              );
            }));
  }
}
