import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weaco/presentation/common/style/image_path.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/common/component/bottom_sheet/custom_bottom_sheet.dart';
import 'package:weaco/presentation/common/user_provider.dart';
import 'package:weaco/presentation/home/component/recommend_login_bottom_sheet_widget.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/my_page/screen/my_page_screen.dart';
import 'package:weaco/presentation/navigation_bar/bottom_navigation_widget.dart';
import 'package:weaco/presentation/ootd_feed/screen/ootd_feed_screen.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'package:weaco/presentation/ootd_search/screen/ootd_search_screen.dart';

import '../../ootd_post/view_model/camera_view_model.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
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

    // 뒤로가기 버튼의 누른 시간을 저장하기 위한 변수
    DateTime? currentBackPressTime;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          DateTime now = DateTime.now();
          if (currentBackPressTime == null ||
              now.difference(currentBackPressTime!) >
                  const Duration(seconds: 2)) {
            currentBackPressTime = now;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Column(
                  children: [
                    Text(
                      '뒤로가기 버튼을 한 번 더 누르시면 종료됩니다.',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
                duration: const Duration(seconds: 1),
              ),
            );
            // 처음 뒤로가기 버튼을 눌렀거나 2초 이후에 누를 경우
            return;
          }
          // 2초 이내에 뒤로가기 버튼을 또 눌렀을 경우 앱 종료
          if (Platform.isIOS) {
            exit(0);
          } else {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: const [
            HomeScreen(),
            OotdFeedScreen<OotdFeedViewModel>(),
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
              if (context.read<UserProvider>().email == null) {
                _showBottomSheetForNonMember(
                    '피드는 로그인 후 등록 할 수 있어요.\n회원가입 또는 로그인 후 이용해 주세요 😎');
                return;
              }
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
                ? SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _onPressedButton(
                                viewModel: viewModel,
                                imageSource: ImageSource.camera,
                                context: context,
                              );
                            },
                            child: const ImageIcon(
                              AssetImage(ImagePath.imageIconCam),
                              size: 40,
                              color: Color(0xffF2C347),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _onPressedButton(
                                viewModel: viewModel,
                                imageSource: ImageSource.gallery,
                                context: context,
                              );
                            },
                            child: const ImageIcon(
                              AssetImage(ImagePath.imageIconPhoto),
                              size: 40,
                              color: Color(0xffF2C347),
                            ),
                          ),
                        ),
                      ],
                    ),
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
              // 플로팅버튼 아래 빈 바텀아이템 클릭시 리턴처리
              if (value == 2) {
                return;
              } else if (value == 4 &&
                  context.read<UserProvider>().email == null) {
                // 로그인 하지 않고 마이페이지 진입 시 넛지 팝업 처리
                _showBottomSheetForNonMember(
                    '마이 페이지는 회원 전용 서비스입니다.\n회원가입 또는 로그인 후 이용해주세요 😎');
                return;
              }
              _tabController.animateTo(value);
            },
          ),
        ),
      ),
    );
  }

  /// 비회원이 로그인 후 사용 가능한 서비스 접근 시 안내 바텀시트를 띄우는 함수
  void _showBottomSheetForNonMember(String message) {
    CustomBottomSheet.showSelectBottomSheet(
      context: context,
      isScrollControlled: false,
      child: RecommendLoginBottomSheetWidget(
        context: context,
        message: message,
      ),
    );
  }

  void _onPressedButton({
    required CameraViewModel viewModel,
    required ImageSource imageSource,
    required BuildContext context,
  }) async {
    await viewModel.pickImage(imageSource: imageSource);
    switch (viewModel.status) {
      case CameraImageStatus.idle:
        log('이미지 선택 없음', name: 'MainScreen._onPressedButton()');
      case CameraImageStatus.success:
        if (context.mounted) {
          RouterStatic.goToPictureCrop(context, viewModel.imageFile!.path);
        }

      case CameraImageStatus.error:
        if (context.mounted) {
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
    }
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
