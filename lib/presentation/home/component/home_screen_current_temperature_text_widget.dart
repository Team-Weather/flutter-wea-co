import 'package:flutter/material.dart';

class HomeScreenCurrentTemperatureTextWidget extends StatelessWidget {
  const HomeScreenCurrentTemperatureTextWidget({
    super.key,
    required this.currentTemperature,
  });

  final String currentTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currentTemperature℃',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 60,
      ),
    );
  }
}
