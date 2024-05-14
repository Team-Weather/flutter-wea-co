import 'package:flutter/material.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/presentation/home/component/weather_by_time_widget.dart';

class WeatherByTimeListWidget extends StatefulWidget {
  const WeatherByTimeListWidget({
    super.key,
    required this.dailyLocationWeather,
    required this.scrollController,
  });

  final DailyLocationWeather? dailyLocationWeather;
  final ScrollController scrollController;

  @override
  State<WeatherByTimeListWidget> createState() =>
      _WeatherByTimeListWidgetState();
}

class _WeatherByTimeListWidgetState extends State<WeatherByTimeListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController.jumpTo(
          (widget.scrollController.position.maxScrollExtent / 4) *
              (DateTime.now().hour ~/ 5));
    });
  }

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
              controller: widget.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.dailyLocationWeather?.weatherList.length,
              itemBuilder: (context, index) {
                return WeatherByTimeWidget(
                  dailyLocationWeather: widget.dailyLocationWeather,
                  index: index,
                );
              })),
    );
  }
}
