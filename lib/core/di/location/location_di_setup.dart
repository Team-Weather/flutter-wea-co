import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/dio/base_dio.dart';
import 'package:weaco/core/gps/gps_helper.dart';
import 'package:weaco/data/location/data_source/remote_data_source/kakao_reverse_geo_coder_api.dart';
import 'package:weaco/data/location/data_source/remote_data_source/remote_location_data_source.dart';
import 'package:weaco/data/location/repository/location_repository_impl.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';
import 'package:weaco/domain/location/use_case/get_location_use_case.dart';

void locationDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteLocationDataSource>(
      () => KakaoReverseGeoCoderApi(dio: getIt<BaseDio>()));

  // Repository
  getIt.registerLazySingleton<LocationRepository>(() => LocationRepositoryImpl(
      gpsHelper: getIt<GpsHelper>(),
      remoteDataSource: getIt<RemoteLocationDataSource>()));

  // // UseCase
  getIt.registerLazySingleton<GetLocationUseCase>(() =>
      GetLocationUseCase(locationRepository: getIt<LocationRepository>()));
}
