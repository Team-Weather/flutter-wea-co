import 'package:flutter/material.dart';

class FeedGridEmptyWidget extends StatelessWidget {
  const FeedGridEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 56,
          ),
          SizedBox(height: 8),
          Text(
            '피드가 없습니다.',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
