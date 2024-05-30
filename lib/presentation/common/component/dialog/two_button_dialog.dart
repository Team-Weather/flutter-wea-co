import 'package:flutter/material.dart';

/// 버튼 두 개가 있는 다이얼로그
class TwoButtonDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onPressedLeft;
  final VoidCallback onPressedRight;
  final String leftButtonText;
  final String rightButtonCancelText;
  final int leftButtonColor;
  final int rightButtonColor;

  const TwoButtonDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedLeft,
    required this.onPressedRight,
    required this.leftButtonText,
    required this.rightButtonCancelText,
    this.leftButtonColor = 0xFFFDCE55,
    this.rightButtonColor = 0xFFB1B1B1,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    content,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF1D1B20),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(leftButtonColor),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: onPressedLeft,
                      child: Text(
                        leftButtonText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color(rightButtonColor),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: onPressedRight,
                      child: Text(
                        rightButtonCancelText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
