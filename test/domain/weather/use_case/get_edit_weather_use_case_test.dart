import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/weather/model/weather.dart';
import 'package:weaco/domain/weather/use_case/get_edit_weather_use_case.dart';

import '../../../mock/data/weather/repository/mock_weather_repository.dart';

void main() {
  final MockWeatherRepository mockWeatherRepository = MockWeatherRepository();
  final GetEditWeatherUseCase getEditWeatherUseCase =
      GetEditWeatherUseCase(weatherRepository: mockWeatherRepository);

  group('GetEditWeatherUseCase 클래스', () {
    group('execute() 메소드는 ', () {
      test('getWeather() 메소드를 1회 호출한다.', () async {
        int expectCallCount = 1;

        await getEditWeatherUseCase.execute();

        expect(mockWeatherRepository.getWeatherCallCount, expectCallCount);
      });
      test('getWeather() 메소드로 반환받은 값을 그대로 반환한다.', () async {
        final expectReturnValue = Weather(
          temperature: 28,
          timeTemperature: DateTime(2024, 05, 05),
          code: 0,
          createdAt: DateTime(2024, 05, 05),
        );

        mockWeatherRepository.returnValue = expectReturnValue;

        final actualReturnValue = await getEditWeatherUseCase.execute();

        expect(actualReturnValue, expectReturnValue);
      });
    });
  });
}
