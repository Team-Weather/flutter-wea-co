import 'package:flutter/material.dart';
import 'package:weaco/common/image_path.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 32,
        currentIndex: currentIndex,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        unselectedIconTheme: const IconThemeData(color: Color(0xffd5d5d5)),
        onTap: onTap,
        mouseCursor: SystemMouseCursors.click,
        backgroundColor: Theme.of(context).colorScheme.background,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImagePath.imageIconHome)),
            label: 'Home Weather',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImagePath.imageIconFeed)),
            label: 'OOTD Feed',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImagePath.imageIconSearch)),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(ImagePath.imageIconMyPage)),
            label: 'MyProfile',
          ),
        ],
      ),
    );
  }
}
