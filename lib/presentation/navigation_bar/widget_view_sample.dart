import 'package:flutter/material.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';

class WidgetViewSample extends StatefulWidget {
  const WidgetViewSample({super.key, required this.title});

  final String title;

  @override
  State<WidgetViewSample> createState() => _WidgetViewSampleState();
}

class _WidgetViewSampleState extends State<WidgetViewSample> {
  int _currentIndex = 0;
  bool isPressingFloatingActionButton = false;

  final List<Widget> pages = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () => RouterStatic.goToHome(context),
              child: const Text('Go to HomeScreen')),
          pages[_currentIndex],
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          if (!isPressingFloatingActionButton)
            SizedBox(
              width: 72,
              height: 72,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isPressingFloatingActionButton = true;
                  });
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    setState(() {
                      isPressingFloatingActionButton = false;
                    });
                  });
                },
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: deviceWidth * 0.005),
                ),
                backgroundColor: Theme.of(context).canvasColor,
                child: const
                    ImageIcon(
                      AssetImage('asset/icon/weaco_post_icon.png'),
                      size: 40,
                      color: Color(0xffF2C347),
                    ),
              ),
            ),
          if (isPressingFloatingActionButton)
            SizedBox(
              width: 128,
              height: 72,
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: deviceWidth * 0.005),
                ),
                backgroundColor: Theme.of(context).canvasColor,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageIcon(AssetImage('asset/icon/weaco_cam_icon.png')),
                    ImageIcon(AssetImage('asset/icon/weaco_photo_icon.png')),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
