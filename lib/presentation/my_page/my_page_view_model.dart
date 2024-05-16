import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:weaco/core/exception/not_found_exception.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_my_page_feeds_use_case.dart';
import 'package:weaco/domain/feed/use_case/remove_my_page_feed_use_case.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_my_profile_use_case.dart';

class MyPageViewModel with ChangeNotifier {
  final GetMyPageUserProfileUseCase _getMyPageUserProfileUseCase;
  final GetMyPageFeedsUseCase _getMyPageFeedsUseCase;
  final RemoveMyPageFeedUseCase _removeMyPageFeedUseCase;

  MyPageViewModel({
    required GetMyPageUserProfileUseCase getMyPageUserProfileUseCase,
    required GetMyPageFeedsUseCase getMyPageFeedsUseCase,
    required RemoveMyPageFeedUseCase removeMyPageFeedUseCase,
  })  : _getMyPageUserProfileUseCase = getMyPageUserProfileUseCase,
        _getMyPageFeedsUseCase = getMyPageFeedsUseCase,
        _removeMyPageFeedUseCase = removeMyPageFeedUseCase {
    initializePageData();
  }

  static const _fetchCount = 21;

  UserProfile? _profile;
  List<Feed> _feedList = [];

  bool _isPageLoading = false;
  bool _isFeedListLoading = false;
  bool _isFeedListReachEnd = false;

  DateTime _lastFeedDateTime = DateTime.now();

  UserProfile? get profile => _profile;

  List<Feed> get feedList => _feedList;

  bool get isPageLoading => _isPageLoading;

  bool get isFeedListLoading => _isFeedListLoading;

  Future<void> initializePageData() async {
    changePageLoadingStatus(true);

    // 초기 프로필, 피드 데이터 요청
    await getProfile()
        .then((_) async => await getInitialFeedList(profile!.email));

    changePageLoadingStatus(false);

    setLastFeedDateTime();
  }

  void changePageLoadingStatus(bool status) {
    _isPageLoading = status;
    notifyListeners();
  }

  void changeFeedListLoadingStatus(bool status) {
    _isFeedListLoading = status;
    notifyListeners();
  }

  void changeIsFeedListReachEndStatus(bool status) {
    _isFeedListReachEnd = status;
    notifyListeners();
  }

  void setLastFeedDateTime() {
    _lastFeedDateTime = _feedList[_feedList.length - 1].createdAt;
    notifyListeners();
  }

  Future<void> getProfile() async {
    try {
      final result = await _getMyPageUserProfileUseCase.execute();

      if (result == null) {
        throw NotFoundException(
          code: 404,
          message: '이메일과 일치하는 사용자가 없습니다.',
        );
      }

      _profile = result;
    } on Exception catch (e) {
      log(e.toString(), name: 'MyPageViewModel.getUserProfile()');
    }
    notifyListeners();
  }

  Future<void> getInitialFeedList(String email) async {
    try {
      _feedList = await _getMyPageFeedsUseCase.execute(
        email: email,
        createdAt: null,
        limit: _fetchCount,
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'MyPageViewModel.getInitialUserFeedList()');
    }
    notifyListeners();
  }

  Future<void> fetchFeed() async {
    // 피드 리스트가 빈배열일 때
    // 모든 피드를 다 불러왔음을 확인하는 플래그값 true 일 때
    // 유저 프로필의 feedCount 와 현재 피드 리스트의 길이가 같을 때
    // -> 피드 페이지네이션 요청 차단
    if (_feedList.isEmpty ||
        _isFeedListReachEnd ||
        _profile!.feedCount == _feedList.length) return;

    // 피드 리스트 로딩중이 아닐때 요청
    if (!_isFeedListLoading) {
      changeFeedListLoadingStatus(true);

      final result = await _getMyPageFeedsUseCase.execute(
        email: profile!.email,
        createdAt: _lastFeedDateTime,
        limit: _fetchCount,
      );

      if (result.length < _fetchCount) {
        changeIsFeedListReachEndStatus(true);
        log('feed list reaches end!', name: 'MyPageViewModel.fetchFeed()');
      }

      _feedList.addAll(result);

      log('feed loaded', name: 'MyPageViewModel.fetchFeed()');
      log('fetched feed count: ${result.length.toString()}',
          name: 'MyPageViewModel.fetchFeed()');

      changeFeedListLoadingStatus(false);
      setLastFeedDateTime();

      notifyListeners();
    }
  }

  Future<void> removeSelectedFeed(String feedId) async {
    try {
      final result = await _removeMyPageFeedUseCase.execute(id: feedId);

      if (result) {
        _decreaseFeedCount();
        _removeFeedFromList(feedId);
      }
    } on Exception catch (e) {
      log(e.toString(), name: 'MyPageViewModel.removeSelectedFeed()');
    }

    notifyListeners();
  }

  void _removeFeedFromList(String id) {
    _feedList.removeWhere((e) => e.id == id);
  }

  void _decreaseFeedCount() {
    if (_profile != null) {
      _profile = _profile!.copyWith(feedCount: _profile!.feedCount - 1);
    }
  }
}
