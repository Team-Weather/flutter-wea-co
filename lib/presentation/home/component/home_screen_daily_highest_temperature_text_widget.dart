import 'package:flutter/material.dart';

class HomeScreenDailyHighestTemperatureTextWidget extends StatelessWidget {
  const HomeScreenDailyHighestTemperatureTextWidget({
    super.key,
    required this.highestTemperature,
  });

  final String highestTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '최고 $highestTemperature℃',
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
