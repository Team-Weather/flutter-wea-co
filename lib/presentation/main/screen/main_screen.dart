import 'package:flutter/material.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'package:weaco/presentation/ootd_feed/view/ootd_feed_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool isPressingUploadFeedButton = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(tabListener);
  }

  @override
  void dispose() {
    _tabController.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomeScreen(),
          OotdFeedScreen(),
          // 피드 등록 버튼 자리의 화면 대체용
          SizedBox(),
          // TODO. OOTD검색화면
          Center(child: Text('OOTD검색화면')),
          // TODO. MyPage
          Center(child: Text('MyPage')),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          isPressingUploadFeedButton
              ? Container(
                  width: 128,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 카메라 버튼
                      IconButton(
                        onPressed: () {
                          RouterStatic.goToCamera(context);
                        },
                        icon: const Icon(
                          Icons.camera_alt_rounded,
                          color: Color(0xffF2C347),
                          size: 40,
                        ),
                      ),
                      // 갤러리 버튼
                      IconButton(
                        onPressed: () {
                          // TODO. 갤러리 화면으로 이동
                        },
                        icon: const Icon(
                          Icons.photo_album_outlined,
                          color: Color(0xffF2C347),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  width: 72,
                  height: 72,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        isPressingUploadFeedButton = true;
                      });
                      Future.delayed(const Duration(milliseconds: 2000), () {
                        setState(() {
                          isPressingUploadFeedButton = false;
                        });
                      });
                    },
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    backgroundColor: Theme.of(context).canvasColor,
                    child: const Icon(
                      Icons.add,
                      color: Color(0xffF2C347),
                      size: 40,
                    ),
                  ),
                ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationWidget(
          currentIndex: _currentIndex,
          onTap: (int value) {
            if (value == 2) return;
            _tabController.animateTo(value);
          },
        ),
      ),
    );
  }
}
