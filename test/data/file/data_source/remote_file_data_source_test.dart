import 'dart:io';

import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/core/path_provider/path_provider_service.dart';
import 'package:weaco/data/file/data_source/local/local_file_data_source.dart';
import 'package:weaco/data/file/data_source/local/local_file_data_source_impl.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source.dart';
import 'package:weaco/data/file/data_source/remote/remote_file_data_source_impl.dart';

import '../../../mock/data/common/file/repository/mock_path_provider_service_impl.dart';

void main() {
  final PathProviderService mockPathProvider = MockPathProviderServiceImpl();
  final LocalFileDataSource localFileDataSource =
      LocalFileDataSourceImpl(pathProvider: mockPathProvider);

  final MockFirebaseStorage storage = MockFirebaseStorage();
  final RemoteFileDataSource remoteFileDataSource =
      RemoteFileDataSourceImpl(firebaseStorage: storage);

  group('RemoteFileDataSourceImpl 클래스', () {
    tearDown(() {
      if (File('test/mock/assets/cropped.png').existsSync()) {
        File('test/mock/assets/cropped.png').deleteSync();
      }
    });

    group('saveImage() 메소드는', () {
      test('File 객체를 인자로 받아 업로드하고 다운로드 경로를 반환한다.', () async {
        // Given
        const isOrigin = false;
        File('test/mock/assets/cropped.png').writeAsBytesSync(
            File('test/mock/assets/test_image.png').readAsBytesSync());

        final bucketPath = await storage.ref().child('').getDownloadURL();

        // When
        File? file = await localFileDataSource.getImagePath(isOrigin: isOrigin);

        if (file != null) {
          final splitImagePath = file.path.split('/');
          final imageName = splitImagePath[splitImagePath.length - 1];

          final path = await remoteFileDataSource.saveImage(image: file);

          expect(path, '${bucketPath}feed_images/$imageName');
        }
      });
    });
  });
}
