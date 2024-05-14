import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/main.dart';
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
          create: (_) => HomeScreenViewModel(),
          child: const HomeScreen(),
        );
      },
    ),
    GoRoute(
      path: RouterPath.signUp.path,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: RouterPath.signIn.path,
      // builder: (context, state) => SignInScreen(),
      builder: (context, state) => const SignInScreen(),
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
      // builder: (context, state) => OotdFeedScreen(),
      builder: (context, state) => const MyHomePage(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdDetail.path,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => OotdDetailViewModel(getDetailFeedDetailUseCase: getIt(), getUserProfileUseCase: getIt(), id: state.extra as String),
          child: const OotdDetailScreen(),
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
      builder: (context, state) => const PictureCropScreen(),
    ),
    GoRoute(
      path: RouterPath.ootdPost.path,
      builder: (context, state) => const OotdPostScreen(),
    ),
  ],
);
