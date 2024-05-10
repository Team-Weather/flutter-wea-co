import 'package:go_router/go_router.dart';
import 'package:weaco/main.dart';
import 'package:weaco/presentation/home/home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'weaco'),
    ),
    GoRoute(
      path: '/homeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/signUp',
      // builder: (context, state) => SignUpScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/signIn',
      // builder: (context, state) => SignInScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/dialog',
      // builder: (context, state) => DialogScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/appSetting',
      // builder: (context, state) => AppSettingScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/myPage',
      // builder: (context, state) => MyPageScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/userPage',
      // builder: (context, state) => UserPageScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ootdSearchScreen',
      // builder: (context, state) => OotdSearchScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ootdFeedScreen',
      // builder: (context, state) => OotdFeedScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ootdDetailScreen',
      // builder: (context, state) => OotdDetailScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cameraScreen',
      // builder: (context, state) => CameraScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/pictureCropScreen',
      // builder: (context, state) => PictureCropScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/ootdPostScreen',
      // builder: (context, state) => OotdPostScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
