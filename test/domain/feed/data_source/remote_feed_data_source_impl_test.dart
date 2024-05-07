import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

import '../../../mock/data/feed/data_source/mock_remote_feed_data_source_impl.dart';

void main() {
  group(
    'RemoteFeedDataSourceImpl 클래스',
    () {
      late MockRemoteFeedDataSource dataSource;
      late FakeFirebaseFirestore fakeFirestore;

      setUp(() {
        fakeFirestore = FakeFirebaseFirestore();
        dataSource = MockRemoteFeedDataSource(fakeFirestore: fakeFirestore);
      });

      group(
        'saveFeed는',
        () {
          test('saveFeed는 true를 반환해야 한다', () async {
            // Given
            Weather mockWeather = Weather(
              temperature: 31,
              timeTemperature: DateTime.parse('2024-05-06'),
              code: 1,
              createdAt: DateTime.parse('2024-05-06'),
            );
            Location mockLocation = Location(
              lat: 31.23,
              lng: 29.48,
              city: '서울시, 노원구',
              createdAt: DateTime.parse('2024-05-06'),
            );
            final mockFeed = Feed(
              id: 'id',
              imagePath: 'imagePath',
              userEmail: 'test@email.com',
              description: 'This is a test feed',
              weather: mockWeather,
              seasonCode: 2,
              location: mockLocation,
              createdAt: DateTime.parse('2024-05-06'),
            );

            // When
            final result = await dataSource.saveFeed(feed: mockFeed);

            // Then
            expect(result, true);
          });
          test(
            'saveFeed는 Firestore에 데이터를 추가해야 한다.',
            () async {
              // Given
              Weather mockWeather = Weather(
                temperature: 31,
                timeTemperature: DateTime.parse('2024-05-06'),
                code: 1,
                createdAt: DateTime.parse('2024-05-06'),
              );
              Location mockLocation = Location(
                lat: 31.23,
                lng: 29.48,
                city: '서울시, 노원구',
                createdAt: DateTime.parse('2024-05-06'),
              );
              DateTime dateTime = DateTime.now();

              final mockFeed = Feed(
                id: 'gyubro',
                imagePath: 'imagePath',
                userEmail: 'test@email.com',
                description: 'This is a test feed',
                weather: mockWeather,
                seasonCode: 2,
                location: mockLocation,
                createdAt: dateTime,
              );
              await dataSource.saveFeed(feed: mockFeed);

              // When
              final snapshot = await fakeFirestore.collection('feeds').get();

              // Then
              expect(snapshot.docs.length, 1);
              expect(
                snapshot.docs.first.data()['id'],
                equals(mockFeed.id),
              );
            },
          );
        },
      );
      group('getFeed는', () {
        test('getFeed는 Json을 반환해야 한다', () async {

        });
      });
    },
  );
}
