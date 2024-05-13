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

  /// 피드 저장
  @override
  Future<bool> saveOotdFeed({required Feed feed}) async {
    final String path = await _fileRepository.saveOotdImage();

    final saveResult = await _feedRepository.saveFeed(
        editedFeed: feed.copyWith(imagePath: path));

    await _updateMyFeedCount(1);

    return saveResult;
  }

  /// 피드 삭제
  @override
  Future<bool> removeOotdFeed({required String id}) async {
    await _feedRepository.deleteFeed(id: id);

    await _updateMyFeedCount(-1);

    return true;
  }

  /// 유저 피드 카운트 업데이트
  Future<void> _updateMyFeedCount(int count) async {
    final myProfile = await _userProfileRepository.getMyProfile();

    _userProfileRepository.updateUserProfile(
        userProfile:
            myProfile!.copyWith(feedCount: myProfile.feedCount + count));
  }
}
