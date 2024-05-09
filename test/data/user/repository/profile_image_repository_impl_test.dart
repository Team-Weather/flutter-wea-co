import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/user/repository/profile_image_repository_impl.dart';
import 'package:weaco/domain/user/model/profile_image.dart';
import 'package:weaco/domain/user/repository/profile_image_repository.dart';

import '../../../mock/data/user/data_source/mock_remote_profile_image_data_source_impl.dart';

void main() {
  group('ProfileImageRepositoryImpl 클래스', () {
    final mockDataSource = MockRemoteProfileImageDataSourceImpl();
    final ProfileImageRepository repository =
        ProfileImageRepositoryImpl(remoteDataSource: mockDataSource);

    group('getProfileImageList 메서드는', () {
      tearDown(() {
        mockDataSource.initMockData();
      });

      test('RemoteProfileImageDataSource.getProfileImageList()를 한번 호출한다.',
          () async {
        // Given
        final expectResult = [ProfileImage(id: '0', imagePath: 'image path')];
        mockDataSource.methodResult = expectResult;

        // When
        mockDataSource.getProfileImageList();

        // Then
        expect(mockDataSource.methodCallCount, 1);
      });

      test(
          'RemoteProfileImageDataSource.getProfileImageList()에서 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final expectResult = [ProfileImage(id: '0', imagePath: 'image path')];
        mockDataSource.methodResult = expectResult;

        // When
        final result = await repository.getProfileImageList();

        // Then
        expect(expectResult, result);
      });
    });
  });
}
