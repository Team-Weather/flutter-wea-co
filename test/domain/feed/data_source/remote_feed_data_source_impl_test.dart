import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source_impl.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/location/model/location.dart';
import 'package:weaco/domain/weather/model/weather.dart';

void main() {
  final fakeFirestore = FakeFirebaseFirestore();
  final RemoteFeedDataSource dataSource =
      RemoteFeedDataSourceImpl(fireStore: fakeFirestore);
  group(
    'RemoteFeedDataSourceImpl 클래스',
    () {
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

      group('getSearchFeedList는', () {
        test('Firebase Storage를 통해 파라미터로 받은 조건에 해당하는 값을 받는다.', () async {
          // Given
          for (int i = 0; i < 3; i++) {
            await fakeFirestore.collection('feeds').add({
              'weather': {
                'code': i, // 날씨 코드
                'temperature': 22.0, // 온도
                'time_temperature': DateTime.parse('2024-05-01 13:27:00'),
                'created_at': DateTime.parse('2024-05-01 13:27:00'),
              },
              'location': {
                'lat': 35.234,
                'lng': 131.1,
                'city': '서울시 구로구',
                'created_at': Timestamp.now(),
              },
              'created_at': DateTime.parse('2024-05-01 13:27:00'),
              'description': 'desc',
              'image_path':
                  'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
              'season_code': 0,
              'user_email': 'hoogom87@gmail.com',
            });
          }

          // When
          final res = await dataSource.getSearchFeedList(
            createdAt: DateTime.now(),
            limit: 20,
            seasonCode: 0,
            weatherCode: 0,
            minTemperature: 20,
            maxTemperature: 25,
          );

          // Then
          expect(res.length, 1);
        });
      });

      group('getRecommendedFeedList', () {
        test('Firebase Storage를 통해 파라미터로 받은 조건에 해당하는 값을 받는다.', () async {
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

          // Given
          for (int i = 0; i < 3; i++) {
            await fakeFirestore.collection('feeds').add({
              'weather': mockWeather.toJson(),
              'location': mockLocation.toJson(),
              'created_at': DateTime.parse('2024-05-01 13:27:00'),
              'description': 'desc',
              'image_path':
                  'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
              'season_code': i + 1,
              'user_email': 'hoogom87@gmail.com',
            });
          }

          // When
          final res = await dataSource.getRecommendedFeedList(
            city: mockLocation.city,
            temperature: mockWeather.temperature,
          );

          // Then
          expect(res.length, 3);
        });
      });
    },
  );
}
