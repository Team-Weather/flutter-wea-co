import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/data/user/data_source/user_auth_data_source.dart';
import 'package:weaco/data/user/repository/user_auth_repository_impl.dart';
import 'package:weaco/domain/user/use_case/log_out_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_out_use_case.dart';
import 'package:weaco/main.dart';
import 'package:weaco/presentation/home/screen/home_screen.dart';
import 'package:weaco/presentation/home/view_model/home_screen_view_model.dart';
import 'package:weaco/presentation/settings/screen/app_setting_license_screen.dart';
import 'package:weaco/presentation/settings/screen/app_setting_policy_web_view.dart';
import 'package:weaco/presentation/settings/screen/app_setting_screen.dart';
import 'package:weaco/presentation/settings/view_model/app_setting_view_model.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: RouterPath.defaultPage.path,
      builder: (context, state) => const MyHomePage(title: 'weaco'),
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
      // builder: (context, state) => SignUpScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.signIn.path,
      // builder: (context, state) => SignInScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.dialog.path,
      // builder: (context, state) => DialogScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.appSetting.path,
      builder: (context, state) => AppSettingScreen(
        appSettingViewModel: AppSettingViewModel(
          logOutUseCase: LogOutUseCase(
            userAuthRepository: UserAuthRepositoryImpl(
                userAuthDataSource: getIt<UserAuthDataSource>(),
                remoteUserProfileDataSource:
                    getIt<RemoteUserProfileDataSource>()),
          ),
          signOutUseCase: getIt<SignOutUseCase>(),
        ),
      ),
    ),
    GoRoute(
      path: RouterPath.appSettingPolicy.path,
      builder: (context, state) => const AppSettingPolicyScreen(),
    ),
    GoRoute(
      path: RouterPath.appSettingLicense.path,
      builder: (context, state) => const AppSettingLicenseScreen(),
    ),
    GoRoute(
      path: RouterPath.myPage.path,
      // builder: (context, state) => MyPageScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.userPage.path,
      // builder: (context, state) => UserPageScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.ootdSearch.path,
      // builder: (context, state) => OotdSearchScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.ootdFeed.path,
      // builder: (context, state) => OotdFeedScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.ootdDetail.path,
      // builder: (context, state) => OotdDetailScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.camera.path,
      // builder: (context, state) => CameraScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.pictureCrop.path,
      // builder: (context, state) => PictureCropScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouterPath.ootdPost.path,
      // builder: (context, state) => OotdPostScreen(),
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
