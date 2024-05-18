import 'package:flutter/material.dart';

class FeedGridDeletedUserWidget extends StatelessWidget {
  const FeedGridDeletedUserWidget({super.key});

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
            '찾을 수 없는 사용자입니다.',
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
