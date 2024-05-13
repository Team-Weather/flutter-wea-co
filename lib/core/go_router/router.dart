import 'package:go_router/go_router.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/main.dart';
import 'package:weaco/presentation/navigation_bar/widget_view_sample.dart';

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
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.signUp.path,
      // builder: (context, state) => SignUpScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.signIn.path,
      // builder: (context, state) => SignInScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.dialog.path,
      // builder: (context, state) => DialogScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.appSetting.path,
      // builder: (context, state) => AppSettingScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.myPage.path,
      // builder: (context, state) => MyPageScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.userPage.path,
      // builder: (context, state) => UserPageScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdSearch.path,
      // builder: (context, state) => OotdSearchScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdFeed.path,
      // builder: (context, state) => OotdFeedScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdDetail.path,
      // builder: (context, state) => OotdDetailScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.camera.path,
      // builder: (context, state) => CameraScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.pictureCrop.path,
      // builder: (context, state) => PictureCropScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
    GoRoute(
      path: RouterPath.ootdPost.path,
      // builder: (context, state) => OotdPostScreen(),
      builder: (context, state) => const HomeScreen(
        title: '',
      ),
    ),
  ],
);
