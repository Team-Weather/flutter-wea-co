import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source_impl.dart';
import 'package:weaco/domain/feed/use_case/get_detail_feed_detail_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_ootd_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_search_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/remove_my_page_feed_use_case.dart';
import 'package:weaco/domain/feed/use_case/save_edit_feed_use_case.dart';

void feedDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteFeedDataSource>(
      () => RemoteFeedDataSourceImpl(fireStore: getIt<FirebaseFirestore>()));

  // Repository

  // UseCase
  ///[feedRepository] merge되면 밑의 getIt()에 제네릭으로 타입 주입
  getIt.registerLazySingleton<GetDetailFeedDetailUseCase>(
      () => GetDetailFeedDetailUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<GetMyPageFeedsUseCase>(
      () => GetMyPageFeedsUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<GetOotdFeedsUseCase>(
      () => GetOotdFeedsUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<GetRecommendedFeedsUseCase>(
      () => GetRecommendedFeedsUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<GetSearchFeedsUseCase>(
      () => GetSearchFeedsUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<GetUserPageFeedsUseCase>(
      () => GetUserPageFeedsUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<RemoveMyPageFeedUseCase>(
      () => RemoveMyPageFeedUseCase(feedRepository: getIt()));
  getIt.registerLazySingleton<SaveEditFeedUseCase>(
      () => SaveEditFeedUseCase(feedRepository: getIt()));
}
