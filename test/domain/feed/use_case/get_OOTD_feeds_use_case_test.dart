import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/use_case/get_OOTD_feeds_use_case.dart';

import '../../../mock/data/feed/repository/mock_feed_repository_impl.dart';

void main() {
  group('GetOOTDFeedsUseCase 클래스', () {
    final mockFeedRepository = MockFeedRepositoryImpl();
    final GetOOTDFeedsUseCase useCase =
        GetOOTDFeedsUseCase(feedRepository: mockFeedRepository);

    group('execute 메서드는', () {
      setUp(
        () => mockFeedRepository.initMockData(),
      );

      test('FeedRepository.getOOTDList()를 한번 호출한다.', () async {
        // Given
        const expectCount = 1;

        // When
        await useCase.execute(createdAt: DateTime.now());

        // Then
        expect(mockFeedRepository.getOOTDFeedsListCallCount, expectCount);
      });
    });
  });
}
