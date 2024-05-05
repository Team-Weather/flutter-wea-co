import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/use_case/get_ootd_feeds_use_case.dart';
import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetOotdFeedsUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetOotdFeedsUseCase useCase =
        GetOotdFeedsUseCase(feedRepository: mockFeedRepository);

    group('execute 메서드는', () {
      setUp(
        () => mockFeedRepository.initMockData(),
      );

      test('FeedRepository.getOotdList()를 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute(createdAt: DateTime.now());

        // Then
        expect(mockFeedRepository.getOotdFeedsListCallCount, expectCount);
      });
    });
  });
}
