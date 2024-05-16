import 'package:flutter/material.dart';

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
            icon: ImageIcon(
                AssetImage('asset/icon/weaco_home_weather_icon.png')),
            label: 'Home Weather',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(right: 56.0),
              child: ImageIcon(AssetImage('asset/icon/weaco_feed_icon.png')),
            ),
            label: 'OOTD Feed',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(left: 56.0),
              child: ImageIcon(AssetImage('asset/icon/weaco_search_icon.png')),
            ),
            label: 'search',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('asset/icon/weaco_mypage_icon.png')),
            label: 'MyProfile',
          ),
        ],
      ),
    );
  }
}
