import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source.dart';
import 'package:weaco/data/feed/data_source/remote_feed_data_source_impl.dart';
import 'package:weaco/data/feed/repository/feed_repository_impl.dart';
import 'package:weaco/data/feed/repository/ootd_feed_repository_impl.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';
import 'package:weaco/domain/feed/repository/ootd_feed_repository.dart';
import 'package:weaco/domain/feed/use_case/get_detail_feed_detail_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_ootd_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_recommended_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_search_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/remove_my_page_feed_use_case.dart';
import 'package:weaco/domain/feed/use_case/save_edit_feed_use_case.dart';
import 'package:weaco/domain/file/repository/file_repository.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'package:weaco/presentation/ootd_feed_detail/view_model/ootd_detail_view_model.dart';

void feedDiSetup() {
  // DataSource
  getIt.registerLazySingleton<RemoteFeedDataSource>(
      () => RemoteFeedDataSourceImpl(fireStore: getIt<FirebaseFirestore>()));

  // Repository
  getIt.registerLazySingleton<FeedRepository>(() =>
      FeedRepositoryImpl(remoteFeedDataSource: getIt<RemoteFeedDataSource>()));
  getIt.registerLazySingleton<OotdFeedRepository>(() => OotdFeedRepositoryImpl(
      fileRepository: getIt<FileRepository>(),
      feedRepository: getIt<FeedRepository>(),
      userProfileRepository: getIt<UserProfileRepository>()));

  // UseCase
  getIt.registerLazySingleton<GetDetailFeedDetailUseCase>(() =>
      GetDetailFeedDetailUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<GetMyPageFeedsUseCase>(
      () => GetMyPageFeedsUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<GetOotdFeedsUseCase>(
      () => GetOotdFeedsUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<GetRecommendedFeedsUseCase>(() =>
      GetRecommendedFeedsUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<GetSearchFeedsUseCase>(
      () => GetSearchFeedsUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<GetUserPageFeedsUseCase>(
      () => GetUserPageFeedsUseCase(feedRepository: getIt<FeedRepository>()));
  getIt.registerLazySingleton<RemoveMyPageFeedUseCase>(() =>
      RemoveMyPageFeedUseCase(ootdFeedRepository: getIt<OotdFeedRepository>()));
  getIt.registerLazySingleton<SaveEditFeedUseCase>(() =>
      SaveEditFeedUseCase(ootdFeedRepository: getIt<OotdFeedRepository>()));
  
  // ViewModel
  getIt.registerFactory(() => OotdFeedViewModel(getSearchFeedsUseCase: getIt<GetSearchFeedsUseCase>()));
  getIt.registerFactoryParam((id, _) => OotdDetailViewModel(getDetailFeedDetailUseCase: getIt<GetDetailFeedDetailUseCase>(), getUserProfileUseCase: getIt<GetUserProfileUseCase>(), id: id as String));
}
