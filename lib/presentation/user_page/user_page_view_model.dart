import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:weaco/core/exception/not_found_exception.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';

class UserPageViewModel with ChangeNotifier {
  final String _email;
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetUserPageFeedsUseCase _getUserPageFeedsUseCase;

  UserPageViewModel({
    required String email,
    required GetUserProfileUseCase getUserProfileUseCase,
    required GetUserPageFeedsUseCase getUserPageFeedsUseCase,
  })  : _email = email,
        _getUserProfileUseCase = getUserProfileUseCase,
        _getUserPageFeedsUseCase = getUserPageFeedsUseCase {
    initializeUserPageData();
  }

  static const _count = 21;

  UserProfile? _userProfile;
  List<Feed> _userFeedList = [];

  bool _isPageLoading = false;
  bool _isFeedListLoading = false;

  DateTime _lastFeedDateTime = DateTime.now();

  UserProfile? get userProfile => _userProfile;

  List<Feed> get userFeedList => _userFeedList;

  bool get isPageLoading => _isPageLoading;

  bool get isFeedListLoading => _isFeedListLoading;

  DateTime? get lastFeedDateTime => _lastFeedDateTime;

  Future<void> initializeUserPageData() async {
    changePageLoadingStatus(true);
    await getUserProfile(_email);
    await getInitialUserFeedList(_email);
    changePageLoadingStatus(false);

    setLastFeedDateTime();
    notifyListeners();
  }

  void changePageLoadingStatus(bool status) {
    _isPageLoading = status;
  }

  void changeFeedListLoadingStatus(bool status) {
    _isFeedListLoading = status;
  }

  void setLastFeedDateTime() {
    _lastFeedDateTime = _userFeedList[_userFeedList.length - 1].createdAt;
  }

  Future<void> getUserProfile(String email) async {
    try {
      final result = await _getUserProfileUseCase.execute(email: email);

      if (result == null) {
        throw NotFoundException(
          code: 404,
          message: '이메일과 일치하는 사용자가 없습니다.',
        );
      }

      _userProfile = result;
    } on Exception catch (e) {
      log(e.toString(), name: 'UserPageViewModel.getUserProfile()');
    }
  }

  Future<void> getInitialUserFeedList(String email) async {
    try {
      _userFeedList = await _getUserPageFeedsUseCase.execute(
        email: email,
        createdAt: null,
        limit: _count,
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'UserPageViewModel.getInitialUserFeedList()');
    }
  }

  Future<void> fetchFeed() async {
    if (!_isFeedListLoading) {
      changeFeedListLoadingStatus(true);

      if (_userProfile!.feedCount == _userFeedList.length) return;

      final result = await _getUserPageFeedsUseCase.execute(
        email: _email,
        createdAt: _lastFeedDateTime,
        limit: _count,
      );

      _userFeedList.addAll(result);

      log('feed loaded', name: 'UserPageViewModel.fetchFeed()');
      log(_userFeedList.length.toString(),
          name: 'UserPageViewModel.fetchFeed()');

      changeFeedListLoadingStatus(false);
      setLastFeedDateTime();

      notifyListeners();
    }
  }
}
