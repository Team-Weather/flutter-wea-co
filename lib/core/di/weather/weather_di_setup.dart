import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/dio/base_dio.dart';
import 'package:weaco/core/hive/hive_wrapper.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source.dart';
import 'package:weaco/data/weather/data_source/local_data_source/local_daily_location_weather_data_source_impl.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/meteo_weather_api.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_background_image_data_source.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_background_image_data_source_impl.dart';
import 'package:weaco/data/weather/data_source/remote_data_source/remote_weather_data_source.dart';
import 'package:weaco/data/weather/repository/daily_location_weather_repository_impl.dart';
import 'package:weaco/data/weather/repository/weather_background_image_repository_impl.dart';
import 'package:weaco/domain/location/repository/location_repository.dart';
import 'package:weaco/domain/weather/repository/daily_location_weather_repository.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';
import 'package:weaco/domain/weather/use_case/get_background_image_list_use_case.dart';
import 'package:weaco/domain/weather/use_case/get_daily_location_weather_use_case.dart';

void weatherDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteWeatherDataSource>(
      () => MeteoWeatherApi(dio: getIt<BaseDio>()));
  getIt.registerLazySingleton<RemoteWeatherBackgroundImageDataSource>(() =>
      RemoteWeatherBackgroundImageDataSourceImpl(
          firestore: getIt<FirebaseFirestore>()));
  getIt.registerLazySingleton<LocalDailyLocationWeatherDataSource>(() =>
      LocalDailyLocationWeatherDataSourceImpl(
          hiveWrapper: getIt<HiveWrapper>()));

  // Repository
  getIt.registerLazySingleton<DailyLocationWeatherRepository>(
      () => DailyLocationWeatherRepositoryImpl(
            localDailyLocationWeatherDataSource:
                getIt<LocalDailyLocationWeatherDataSource>(),
            remoteWeatherDataSource: getIt<RemoteWeatherDataSource>(),
            locationRepository: getIt<LocationRepository>(),
          ));
  getIt.registerLazySingleton<WeatherBackgroundImageRepository>(
      () => WeatherBackgroundImageRepositoryImpl(
            remoteDataSource: getIt<RemoteWeatherBackgroundImageDataSource>(),
          ));

  // UseCase
  getIt.registerLazySingleton<GetDailyLocationWeatherUseCase>(() =>
      GetDailyLocationWeatherUseCase(
          dailyLocationWeatherRepository:
              getIt<DailyLocationWeatherRepository>()));
  getIt.registerLazySingleton<GetBackgroundImageListUseCase>(() =>
      GetBackgroundImageListUseCase(
          weatherBackgroundImageRepository:
              getIt<WeatherBackgroundImageRepository>()));
}
