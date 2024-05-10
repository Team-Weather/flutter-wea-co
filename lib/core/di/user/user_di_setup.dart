import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/data/user/data_source/firebase_user_auth_data_source.dart';
import 'package:weaco/data/user/data_source/remote_profile_image_data_source.dart';
import 'package:weaco/data/user/data_source/remote_profile_image_data_source_impl.dart';
import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/data/user/data_source/remote_user_profile_date_source_impl.dart';
import 'package:weaco/data/user/data_source/user_auth_data_source.dart';
import 'package:weaco/data/user/repository/profile_image_repository_impl.dart';
import 'package:weaco/data/user/repository/user_auth_repository_impl.dart';
import 'package:weaco/domain/user/repository/profile_image_repository.dart';
import 'package:weaco/domain/user/repository/user_auth_repository.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';
import 'package:weaco/domain/user/use_case/get_my_profile_use_case.dart';
import 'package:weaco/domain/user/use_case/get_profile_image_list_use_case.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';
import 'package:weaco/domain/user/use_case/log_out_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_in_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_out_use_case.dart';
import 'package:weaco/domain/user/use_case/sign_up_use_case.dart';

void userDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteUserProfileDataSource>(() =>
      RemoteUserProfileDataSourceImpl(
          firestore: getIt<FirebaseFirestore>(),
          firebaseService: getIt<FirebaseAuthService>()));
  getIt.registerLazySingleton<RemoteProfileImageDataSource>(() =>
      RemoteProfileImageDataSourceImpl(firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<UserAuthDataSource>(() =>
      FirebaseUserAuthDataSourceImpl(
          firebaseService: getIt<FirebaseAuthService>()));

  // Repository
  getIt.registerLazySingleton<UserAuthRepository>(() => UserAuthRepositoryImpl(
      userAuthDataSource: getIt<UserAuthDataSource>(),
      remoteUserProfileDataSource: getIt<RemoteUserProfileDataSource>()));
  getIt.registerLazySingleton<ProfileImageRepository>(() =>
      ProfileImageRepositoryImpl(
          remoteDataSource: getIt<RemoteProfileImageDataSource>()));

  // // UseCase
  getIt.registerLazySingleton<GetMyPageUserProfileUseCase>(() =>
      GetMyPageUserProfileUseCase(
          userProfileRepository: getIt<UserProfileRepository>()));
  getIt.registerLazySingleton<GetProfileImageListUseCase>(() =>
      GetProfileImageListUseCase(
          profileImageRepository: getIt<ProfileImageRepository>()));
  getIt.registerLazySingleton<GetUserProfileUseCase>(() =>
      GetUserProfileUseCase(
          userProfileRepository: getIt<UserProfileRepository>()));
  getIt.registerLazySingleton<LogOutUseCase>(
      () => LogOutUseCase(userAuthRepository: getIt<UserAuthRepository>()));
  getIt.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(userAuthRepository: getIt<UserAuthRepository>()));
  getIt.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(userAuthRepository: getIt<UserAuthRepository>()));
  getIt.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(userAuthRepository: getIt<UserAuthRepository>()));
}
