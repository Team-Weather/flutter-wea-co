import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/common/file/use_case/get_background_image_list_use_case.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

import '../../../../mock/data/common/file/repository/mock_file_repository_impl.dart';
import '../../../../mock/data/weather/repository/mock_weather_background_image_repository_impl.dart';

void main() {
  group('GetHomeImageUseCase 클래스', () {
    final mockFileRepository = MockWeatherBackgroundImageRepository();
    final GetBackgroundImageListUseCase getHomeBackgroundImageListUseCase =
        GetBackgroundImageListUseCase(
            weatherBackgroundImageRepository: mockFileRepository);
    setUp(() => mockFileRepository.initMockData());
    group('execute 메소드는', () {
      test(
          'WeatherBackgroundImageRepository.getWeatherBackgroundImageList()를 한번 호출한다',
          () async {
        // Given
        const int expectedCallCount = 1;

        // When
        await getHomeBackgroundImageListUseCase.execute();

        // Then
        expect(mockFileRepository.methodCallCount, expectedCallCount);
      });

      test(
          'WeatherBackgroundImageRepository.getWeatherBackgroundImageList()의 반환값을 반환한다',
          () async {
        // Given
        final expected = [WeatherBackgroundImage(code: 0, imagePath: 'test')];
        mockFileRepository.getWeatherBackgroundImageListResult = expected;

        // When
        final actual = await getHomeBackgroundImageListUseCase.execute();

        // Then
        expect(actual, expected);
      });
    });
  });
}
