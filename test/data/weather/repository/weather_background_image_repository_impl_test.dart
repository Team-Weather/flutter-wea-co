import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/weather/repository/weather_background_image_repository_impl.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/repository/weather_background_image_repository.dart';

import '../../../mock/data/weather/data_source/remote_data_source/mock_remote_weather_background_image_data_source_impl.dart';

void main() {
  group('ProfileImageRepositoryImpl 클래스', () {
    final mockDataSource = MockRemoteWeatherBackgroundImageDataSourceImpl();
    final WeatherBackgroundImageRepository repository =
        WeatherBackgroundImageRepositoryImpl(remoteDataSource: mockDataSource);

    group('getWeatherBackgroundImageList 메서드는', () {
      tearDown(() {
        mockDataSource.initMockData();
      });

      test(
          'RemoteWeatherBackgroundImageDataSource.getWeatherBackgroundImageList()를 한번 호출한다.',
          () async {
        // Given
        final expectResult = [
          WeatherBackgroundImage(code: 0, imagePath: 'image path')
        ];
        mockDataSource.methodResult = expectResult;

        // When
        mockDataSource.getWeatherBackgroundImageList();

        // Then
        expect(mockDataSource.methodCallCount, 1);
      });

      test(
          'RemoteWeatherBackgroundImageDataSource.getWeatherBackgroundImageList()에서 반환 받은 값을 그대로 반환한다.',
          () async {
        // Given
        final expectResult = [
          WeatherBackgroundImage(code: 0, imagePath: 'image path')
        ];
        mockDataSource.methodResult = expectResult;

        // When
        final result = await repository.getWeatherBackgroundImageList();

        // Then
        expect(expectResult, result);
      });
    });
  });
}
