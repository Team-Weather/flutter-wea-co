import 'package:flutter/material.dart';

class HomeScreenDailyLowestTemperatureTextWidget extends StatelessWidget {
  const HomeScreenDailyLowestTemperatureTextWidget({
    super.key,
    required this.lowestTemperature,
  });

  final String lowestTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '최저 $lowestTemperature℃',
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
        shadows: [
          Shadow(
              blurRadius: 4,
              color: Color.fromARGB(165, 0, 0, 0),
              offset: Offset(1, 1)),
        ],
      ),
    );
  }
}
