import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';
import 'package:weaco/domain/weather/use_case/get_home_image_use_case.dart';

import '../../../mock/data/weather/repository/mock_weather_background_image_repository.dart';

void main() {
  group('GetHomeImageUseCase 클래스', () {
    final MockWeatherBackgroundImageRepository
        mockWeatherBackgroundImageRepository =
        MockWeatherBackgroundImageRepository();
    final GetHomeImageUseCase getHomeImageUseCase = GetHomeImageUseCase(
        weatherBackgroundImageRepository: mockWeatherBackgroundImageRepository);
    setUp(() => mockWeatherBackgroundImageRepository.initMockData());
    group('execute 메소드는', () {
      test(
          'WeatherBackgroundImageRepository.getWeatherBackgroundImageList()를 한번 호출한다',
          () async {
        // Given
        const int expectedCallCount = 1;

        // When
        await getHomeImageUseCase.execute();

        // Then
        expect(
            mockWeatherBackgroundImageRepository
                .getWeatherBackgroundImageListCallCount,
            expectedCallCount);
      });

      test(
          'WeatherBackgroundImageRepository.getWeatherBackgroundImageList()의 반환값을 반환한다',
          () async {
        // Given
        final expected = [WeatherBackgroundImage(imagePath: 'test')];
        mockWeatherBackgroundImageRepository
            .getWeatherBackgroundImageListResult = [
          WeatherBackgroundImage(imagePath: 'test')
        ];

        // When
        final actual = await getHomeImageUseCase.execute();

        // Then
        expect(actual, expected);
      });
    });
  });
}
