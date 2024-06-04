import 'package:firebase_storage/firebase_storage.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/core/path_provider/path_provider_service.dart';
import 'package:weaco/core/util/image_compressor_util.dart';
import 'package:weaco/data/file/data_source/local/local_file_data_source.dart';
import 'package:weaco/data/file/data_source/local/local_file_data_source_impl.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source_impl.dart';
import 'package:weaco/data/file/repository/file_repository_impl.dart';
import 'package:weaco/domain/file/repository/file_repository.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';
import 'package:weaco/domain/file/use_case/save_image_use_case.dart';

void fileDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteFileDataSource>(() =>
      RemoteFileDataSourceImpl(
          firebaseStorage: getIt<FirebaseStorage>(),
          firebaseAuthService: getIt<FirebaseAuthService>()));
  getIt.registerLazySingleton<LocalFileDataSource>(() =>
      LocalFileDataSourceImpl(pathProvider: getIt<PathProviderService>()));

  // Repository
  getIt.registerLazySingleton<FileRepository>(() => FileRepositoryImpl(
      remoteFileDataSource: getIt<RemoteFileDataSource>(),
      localFileDataSource: getIt<LocalFileDataSource>()));

  // UseCase
  getIt.registerLazySingleton<SaveImageUseCase>(
      () => SaveImageUseCase(fileRepository: getIt<FileRepository>(), imageCompressor: ImageCompressorImpl()));
  getIt.registerLazySingleton<GetImageUseCase>(
      () => GetImageUseCase(fileRepository: getIt<FileRepository>()));
}
