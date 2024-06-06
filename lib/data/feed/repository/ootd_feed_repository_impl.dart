import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/repository/feed_repository.dart';
import 'package:weaco/domain/feed/repository/ootd_feed_repository.dart';
import 'package:weaco/domain/file/repository/file_repository.dart';
import 'package:weaco/domain/user/repository/user_profile_repository.dart';

class OotdFeedRepositoryImpl implements OotdFeedRepository {
  final FileRepository _fileRepository;
  final FeedRepository _feedRepository;
  final UserProfileRepository _userProfileRepository;

  const OotdFeedRepositoryImpl({
    required FileRepository fileRepository,
    required FeedRepository feedRepository,
    required UserProfileRepository userProfileRepository,
  })  : _fileRepository = fileRepository,
        _feedRepository = feedRepository,
        _userProfileRepository = userProfileRepository;

  /// 피드 저장 및 수정
  @override
  Future<void> saveOotdFeed({required Feed feed}) async {
    feed.id == null ? await _save(feed: feed) : await _update(feed: feed);
  }

  /// 피드 저장
  Future<void> _save({required Feed feed}) async {
    final List<String> path = await _fileRepository.saveOotdImage();

    await _feedRepository.saveFeed(
        editedFeed:
            feed.copyWith(imagePath: path[0], thumbnailImagePath: path[1]));

    await _updateMyFeedCount(1);
  }

  /// 피드 수정
  Future<void> _update({required Feed feed}) async {
    await _feedRepository.saveFeed(editedFeed: feed);
  }

  /// 피드 삭제
  @override
  Future<void> removeOotdFeed({required String id}) async {
    await _feedRepository.deleteFeed(id: id);

    await _updateMyFeedCount(-1);
  }

  /// 유저 피드 카운트 업데이트
  Future<void> _updateMyFeedCount(int count) async {
    final myProfile = await _userProfileRepository.getMyProfile();

    _userProfileRepository.updateUserProfile(
        userProfile:
            myProfile!.copyWith(feedCount: myProfile.feedCount + count));
  }
}
