import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() =>
      _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState
    extends State<FloatingActionButtonWidget> {
  bool isPressingFloatingActionButton = false;
  bool isExpanded = false;

  void _toggleFloatingActionButton() {
    setState(() {
      isExpanded = !isExpanded;
    });
    if (isExpanded) {
      Future.delayed(
        const Duration(milliseconds: 2500),
        () {
          setState(() {
            isExpanded = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.decelerate,
      width: isExpanded ? 120 : 72,
      height: 72,
      transformAlignment: Alignment.center,
      child: FloatingActionButton(
        onPressed: () {
          _toggleFloatingActionButton();
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        backgroundColor: isExpanded
            ? Theme.of(context).canvasColor
            : Theme.of(context).primaryColor,
        child: (isExpanded)
            ? Stack(
                children: [
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        left: isExpanded ? 16 : 32,
                        top: 16,
                        child: const ImageIcon(
                          AssetImage('asset/icon/weaco_cam_icon.png'),
                          size: 40,
                          color: Color(0xffF2C347),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                        top: 16,
                        right: isExpanded ? 16 : 32,
                        child: const ImageIcon(
                          AssetImage('asset/icon/weaco_photo_icon.png'),
                          size: 40,
                          color: Color(0xffF2C347),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const ImageIcon(
                AssetImage('asset/icon/weaco_feed_add_icon.png'),
                size: 40,
                color: Colors.white,
              ),
      ),
    );
  }
}
