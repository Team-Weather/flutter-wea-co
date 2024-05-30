import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/style/image_path.dart';

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
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
      width: isExpanded ? 148 : 72,
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
                      GestureDetector(
                        onTap: () {},
                        child: AnimatedPositioned(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          left: isExpanded ? 22 : 32,
                          top: 16,
                          child: const ImageIcon(
                            AssetImage(ImagePath.imageIconCam),
                            size: 40,
                            color: Color(0xffF2C347),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: AnimatedPositioned(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          top: 16,
                          right: isExpanded ? 22 : 32,
                          child: const ImageIcon(
                            AssetImage(ImagePath.imageIconPhoto),
                            size: 40,
                            color: Color(0xffF2C347),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : const ImageIcon(
                AssetImage(ImagePath.imageIconFeedAdd),
                size: 40,
                color: Colors.white,
              ),
      ),
    );
  }
}
