import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/dio/base_dio.dart';
import 'package:weaco/core/exception/handler/exception_message_handler.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/core/gps/gps_helper.dart';
import 'package:weaco/core/hive/hive_wrapper.dart';
import 'package:weaco/core/path_provider/path_provider_service.dart';
import 'package:weaco/presentation/common/handler/check_handle_dialog.dart';

void commonDiSetup() {
  // Firebase
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // PathProvider
  getIt.registerLazySingleton<PathProviderService>(() => PathProviderService());

  // Dio
  getIt.registerLazySingleton<BaseDio>(
      () => BaseDio(httpClientAdapter: HttpClientAdapter()));

  // Gps
  getIt.registerLazySingleton<GpsHelper>(() => GpsHelper());

  // Hive
  getIt.registerLazySingleton<HiveWrapper>(() => HiveWrapper());

  // Dialog
  getIt.registerLazySingleton<CheckHandleDialog>(() => CheckHandleDialog());

  // Exception
  getIt.registerLazySingleton<ExceptionMessageHandler>(
      () => ExceptionMessageHandler());
}
