import 'package:get_it/get_it.dart';
import 'package:weaco/core/di/common/common_di_setup.dart';
import 'package:weaco/core/di/feed/feed_di_setup.dart';
import 'package:weaco/core/di/file/file_di_setup.dart';
import 'package:weaco/core/di/location/location_di_setup.dart';
import 'package:weaco/core/di/user/user_di_setup.dart';
import 'package:weaco/core/di/weather/weather_di_setup.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/remove_my_page_feed_use_case.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';
import 'package:weaco/domain/user/use_case/get_my_profile_use_case.dart';
import 'package:weaco/domain/user/use_case/get_profile_image_list_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_up_use_case.dart';
import 'package:weaco/presentation/common/user_provider.dart';
import 'package:weaco/presentation/my_page/my_page_view_model.dart';
import 'package:weaco/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:weaco/domain/feed/use_case/save_edit_feed_use_case.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';
import 'package:weaco/domain/file/use_case/save_image_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_in_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';
import 'package:weaco/presentation/ootd_post/ootd_post_view_model.dart';
import 'package:weaco/presentation/ootd_post/picture_crop/picutre_crop_view_model.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';
import 'package:weaco/presentation/user_page/user_page_view_model.dart';
import 'package:weaco/presentation/sign_in/view_model/sign_in_view_model.dart';

final getIt = GetIt.instance;

/// DI 설정
/// - [commonDiSetup]: 공통 DI 설정
/// - [fileDiSetup]: 파일 DI 설정
/// - [userDiSetup]: 사용자 DI 설정
/// - [locationDiSetup]: 위치 DI 설정
/// - [feedDiSetup]: 피드 DI 설정
/// - [weatherDiSetup]: 날씨 DI 설정
///  common -> user -> location -> feed -> weather 순으로 DI 설정 중요
///  각각 먼저 설정된 DI가 다음 DI에 영향을 줄 수 있기 때문
/// - [setup]: 모든 DI 설정
void diSetup() {
  commonDiSetup();
  fileDiSetup();
  userDiSetup();
  locationDiSetup();
  feedDiSetup();
  weatherDiSetup();

  // Provider
  getIt.registerFactory<UserProvider>(() => UserProvider(
        userAuthRepository: getIt<UserAuthRepository>(),
      ));

  // ViewModel
  getIt.registerFactory<SignUpViewModel>(() => SignUpViewModel(
      signUpUseCase: getIt<SignUpUseCase>(),
      getProfileImagePathUseCase: getIt<GetProfileImageListUseCase>()));

  // ViewModel
  getIt.registerFactory<SignInViewModel>(
      () => SignInViewModel(signInUseCase: getIt<SignInUseCase>()));

  getIt.registerFactory<PictureCropViewModel>(
    () => PictureCropViewModel(saveImageUseCase: getIt<SaveImageUseCase>()),
  );

  getIt.registerFactory<OotdPostViewModel>(
    () => OotdPostViewModel(
      getImageUseCase: getIt<GetImageUseCase>(),
      getDailyLocationWeatherUseCase: getIt<GetDailyLocationWeatherUseCase>(),
      saveEditFeedUseCase: getIt<SaveEditFeedUseCase>(),
      saveImageUseCase: getIt<SaveImageUseCase>(),
    ),
  );

  // View
  getIt.registerFactoryParam<UserPageViewModel, String, void>(
    (param1, _) => UserPageViewModel(
      email: param1,
      getUserProfileUseCase: getIt<GetUserProfileUseCase>(),
      getUserPageFeedsUseCase: getIt<GetUserPageFeedsUseCase>(),
    ),
  );
  getIt.registerFactory<MyPageViewModel>(
    () => MyPageViewModel(
      getMyPageUserProfileUseCase: getIt<GetMyPageUserProfileUseCase>(),
      getMyPageFeedsUseCase: getIt<GetMyPageFeedsUseCase>(),
      removeMyPageFeedUseCase: getIt<RemoveMyPageFeedUseCase>(),
    ),
  );
}
