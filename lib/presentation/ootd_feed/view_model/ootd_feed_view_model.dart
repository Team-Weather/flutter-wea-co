import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/feed/use_case/get_search_feeds_use_case.dart';
import 'package:weaco/presentation/ootd_feed/ootd_card.dart';

class OotdFeedViewModel extends ChangeNotifier {
  final List<OotdCard> _feedList = [];
  int _currentIndex = 0;
  final GetSearchFeedsUseCase _getSearchFeedsUseCase;

  OotdFeedViewModel({required GetSearchFeedsUseCase getSearchFeedsUseCase})
      : _getSearchFeedsUseCase = getSearchFeedsUseCase {
    _loadMorePage();
  }

  List<OotdCard> get feedList => List.unmodifiable(_feedList);
  int get currentIndex => _currentIndex;

  Future<void> _loadMorePage() async {
    final dataList = (await _getSearchFeedsUseCase.execute(
        createdAt: (_feedList.isEmpty) ? null : _feedList.last.feed.createdAt,
        limit: 2));
    _feedList.addAll(dataList.map((feed) => OotdCard(feed: feed)));
    if (dataList.isNotEmpty) {
      notifyListeners();
    }
  }

  void flipCard() {
    _feedList[_currentIndex].isFront = !_feedList[_currentIndex].isFront;
  }

  int moveIndex({required bool isToNext}) {
    final int nextIndex = isToNext ? _currentIndex + 1 : _currentIndex - 1;
    if (nextIndex < 0 || nextIndex >= _feedList.length) {
      return nextIndex;
    }
    _currentIndex = nextIndex;
    if (_currentIndex + 1 == _feedList.length) {
      log('무한 스크롤: 데이터 요청', name: 'OotdFeedViewModel.moveIndex()');
      _loadMorePage();
    }
    Future.delayed(const Duration(milliseconds: 125)).then((value) => notifyListeners());
    return _currentIndex;
  }
}
