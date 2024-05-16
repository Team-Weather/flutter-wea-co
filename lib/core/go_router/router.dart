import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_background_image_list_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';
import 'package:weaco/main.dart';
import 'package:weaco/presentation/ootd_feed/view/ootd_feed_screen.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'package:weaco/presentation/ootd_post/ootd_post_view_model.dart';
import 'package:weaco/presentation/ootd_post/picture_crop/picutre_crop_view_model.dart';
import 'package:weaco/presentation/sign_in/view_model/sign_in_view_model.dart';
import 'package:weaco/presentation/sign_up/screen/sign_up_screen.dart';
import 'package:weaco/presentation/sign_in/screen/sign_in_screen.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/home/view_model/home_screen_view_model.dart';
import 'package:weaco/presentation/ootd_feed_detail/view/ootd_feed_detail.dart';
import 'package:weaco/presentation/ootd_post/camera_screen.dart';
import 'package:weaco/presentation/ootd_post/camera_view_model.dart';
import 'package:weaco/presentation/ootd_feed_detail/view_model/ootd_detail_view_model.dart';
import 'package:weaco/presentation/ootd_post/ootd_post_screen.dart';
import 'package:weaco/presentation/ootd_post/picture_crop/picture_crop_screen.dart';
import 'package:weaco/presentation/sign_up/view_model/sign_up_view_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouterPath.defaultPage.path,
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.home.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => HomeScreenViewModel(
            getDailyLocationWeatherUseCase:
                getIt<GetDailyLocationWeatherUseCase>(),
            getBackgroundImageListUseCase:
                getIt<GetBackgroundImageListUseCase>(),
            getRecommendedFeedsUseCase: getIt<GetRecommendedFeedsUseCase>(),
          ),
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
      path: RouterPath.dialog.path,
// builder: (context, state) => DialogScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.appSetting.path,
// builder: (context, state) => AppSettingScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.myPage.path,
// builder: (context, state) => MyPageScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.userPage.path,
// builder: (context, state) => UserPageScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdSearch.path,
// builder: (context, state) => OotdSearchScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdFeed.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<OotdFeedViewModel>(),
          child: const OotdFeedScreen(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.ootdDetail.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => getIt<OotdDetailViewModel>(
              param1: state.uri.queryParameters['id'] ?? ''),
          child: OotdDetailScreen(
            id: state.uri.queryParameters['id'] ?? '',
            mainImagePath: state.uri.queryParameters['imagePath'] ?? '',
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
          child: const OotdPostScreen(),
        );
      },
    ),
  ],
);
