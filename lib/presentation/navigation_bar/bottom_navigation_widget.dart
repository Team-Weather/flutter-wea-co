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
    return BottomNavigationBar(
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
          icon: Icon(Icons.wb_sunny_outlined),
          label: 'Home Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.space_dashboard_outlined),
          label: 'OOTD Feed',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add, size: 0),
          label: 'Post',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_outlined),
          label: 'MyProfile',
        ),
      ],
    );
  }
}