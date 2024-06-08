import 'package:flutter/material.dart';

class HomeScreenCurrentWeatherTextWidget extends StatelessWidget {
  const HomeScreenCurrentWeatherTextWidget({
    super.key,
    required this.currentWeather,
  });

  final String currentWeather;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentWeather,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}
