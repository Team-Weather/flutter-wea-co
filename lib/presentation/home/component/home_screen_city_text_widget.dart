import 'package:flutter/material.dart';

class HomeScreenCityTextWidget extends StatelessWidget {
  final String city;

  const HomeScreenCityTextWidget({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      city,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}
