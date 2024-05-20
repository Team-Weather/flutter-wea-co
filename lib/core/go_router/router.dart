import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/user/use_case/log_out_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_out_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_background_image_list_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';
import 'package:weaco/presentation/my_page/screen/my_page_screen.dart';
import 'package:weaco/presentation/my_page/view_model/my_page_view_model.dart';
import 'package:weaco/presentation/ootd_feed/screen/ootd_feed_screen.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'package:weaco/presentation/ootd_post/screen/camera_screen.dart';
import 'package:weaco/presentation/ootd_post/view_model/ootd_post_view_model.dart';
import 'package:weaco/presentation/ootd_post/view_model/picutre_crop_view_model.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/home/view_model/home_screen_view_model.dart';
import 'package:weaco/presentation/ootd_search/screen/ootd_search_screen.dart';
import 'package:weaco/presentation/ootd_search/view_model/ootd_search_view_model.dart';
import 'package:weaco/presentation/settings/screen/app_setting_policy_screen.dart';
import 'package:weaco/presentation/settings/screen/app_setting_screen.dart';
import 'package:weaco/presentation/settings/view_model/app_setting_view_model.dart';
import 'package:weaco/presentation/ootd_feed_detail/screen/ootd_detail_screen.dart';
import 'package:weaco/presentation/ootd_feed_detail/view_model/ootd_detail_view_model.dart';
import 'package:weaco/presentation/ootd_post/view_model/camera_view_model.dart';
import 'package:weaco/presentation/ootd_post/screen/ootd_post_screen.dart';
import 'package:weaco/presentation/ootd_post/screen/picture_crop_screen.dart';
import 'package:weaco/presentation/main/screen/main_screen.dart';
import 'package:weaco/presentation/sign_in/screen/sign_in_screen.dart';
import 'package:weaco/presentation/sign_in/view_model/sign_in_view_model.dart';
import 'package:weaco/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:weaco/presentation/user_page/screen/user_page_screen.dart';
import 'package:weaco/presentation/user_page/view_model/user_page_view_model.dart';
import 'package:weaco/presentation/sign_up/view_model/sign_up_view_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: RouterPath.defaultPage.path,
        builder: (context, state) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => getIt<HomeScreenViewModel>()),
              ChangeNotifierProvider(create: (_) => getIt<OotdFeedViewModel>()),
              ChangeNotifierProvider(create: (_) => getIt<CameraViewModel>()),
              ChangeNotifierProvider(create: (_) => getIt<OotdFeedViewModel>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<OotdSearchViewModel>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<MyPageViewModel>()),
            ],
            child: const MainScreen(),
          );
        }),
    GoRoute(
      path: RouterPath.home.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<HomeScreenViewModel>(),
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.signUp.path,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<SignUpViewModel>(),
        child: const SignUpScreen(),
      ),
    ),
    GoRoute(
      path: RouterPath.signIn.path,
      builder: (context, state) => ChangeNotifierProvider(
        create: (_) => getIt<SignInViewModel>(),
        child: const SignInScreen(),
      ),
    ),
    GoRoute(
        path: RouterPath.appSetting.path,
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => AppSettingViewModel(
              logOutUseCase: getIt<LogOutUseCase>(),
              signOutUseCase: getIt<SignOutUseCase>(),
            ),
            child: const AppSettingScreen(),
          );
        }),
    GoRoute(
      path: RouterPath.appSettingPolicy.path,
      builder: (context, state) => const AppSettingPolicyScreen(),
    ),
    GoRoute(
      path: RouterPath.appSettingLicense.path,
      builder: (context, state) => const LicensePage(),
    ),
    GoRoute(
      path: RouterPath.myPage.path,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<MyPageViewModel>(),
        child: const MyPageScreen(),
      ),
    ),
    GoRoute(
      path: RouterPath.userPage.path,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<UserPageViewModel>(
          param1: state.uri.queryParameters['email'],
        ),
        child: const UserPageScreen(),
      ),
    ),
    GoRoute(
      path: RouterPath.ootdSearch.path,
      builder: (context, state) => ChangeNotifierProvider(
        create: (context) => getIt<OotdSearchViewModel>(),
        child: const OotdSearchScreen(),
      ),
    ),
    GoRoute(
      path: RouterPath.ootdFeed.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<OotdFeedViewModel>(),
          child: const OotdFeedScreen<OotdFeedViewModel>(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.ootdDetail.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) =>
              getIt<OotdDetailViewModel>(param1: (state.extra as Feed).id),
          child: OotdDetailScreen<OotdDetailViewModel>(
            feed: state.extra as Feed,
          ),
        );
      },
    ),
    GoRoute(
      path: RouterPath.camera.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => CameraViewModel(),
          child: const CameraScreen(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.pictureCrop.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<PictureCropViewModel>(),
          child: PictureCropScreen(
            sourcePath: state.extra as String,
          ),
        );
      },
    ),
    GoRoute(
      path: RouterPath.ootdPost.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<OotdPostViewModel>(),
          child: OotdPostScreen(
            feed: state.extra as Feed?,
          ),
        );
      },
    ),
  ],
);
