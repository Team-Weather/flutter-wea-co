import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/my_page/screen/my_page_screen.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'package:weaco/presentation/ootd_feed/view/ootd_feed_screen.dart';
import 'package:weaco/presentation/ootd_post/camera_view_model.dart';
import 'package:weaco/presentation/ooted_search/screen/ootd_search_screen.dart';

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

  bool isPressingFloatingActionButton = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final CameraViewModel viewModel = context.watch<CameraViewModel>();

    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          HomeScreen(),
          OotdFeedScreen(),
          // 피드 등록 버튼 자리의 화면 대체용
          SizedBox(),
          OotdSearchScreen(),
          MyPageScreen(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedContainer(
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
                          onTap: () {
                            _onPressedButton(
                              viewModel: viewModel,
                              imageSource: ImageSource.camera,
                              context: context,
                            );
                          },
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
                          onTap: () {
                            _onPressedButton(
                              viewModel: viewModel,
                              imageSource: ImageSource.gallery,
                              context: context,
                            );
                          },
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

  void _onPressedButton({
    required CameraViewModel viewModel,
    required ImageSource imageSource,
    required BuildContext context,
  }) {
    viewModel.pickImage(
      imageSource: imageSource,
      callback: (result) {
        if (result) {
          RouterStatic.goToPictureCrop(context, viewModel.imageFile!.path);
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(
                  "설정 변경은 '설정 > 알림 > weaco > 카메라'에서 할 수 있어요.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('닫기'),
                  ),
                  TextButton(
                    onPressed: () {
                      openAppSettings();
                      context.pop();
                    },
                    child: const Text('설정하러 가기'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

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
}
