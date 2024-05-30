import 'dart:developer';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_detail_feed_detail_use_case.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';
import 'package:weaco/presentation/common/component/base_change_notifier.dart';
import 'package:weaco/presentation/common/enum/exception_alert_type.dart';
import 'package:weaco/presentation/common/state/exception_status.dart';

class OotdDetailViewModel extends BaseChangeNotifier {
  Feed? _feed;
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  Feed? get feed => _feed;

  final GetDetailFeedDetailUseCase _getDetailFeedDetailUseCase;
  final GetUserProfileUseCase _getUserProfileUseCase;

  OotdDetailViewModel(
      {required GetDetailFeedDetailUseCase getDetailFeedDetailUseCase,
      required GetUserProfileUseCase getUserProfileUseCase,
      required String id})
      : _getDetailFeedDetailUseCase = getDetailFeedDetailUseCase,
        _getUserProfileUseCase = getUserProfileUseCase {
    _getFeedDetail(id: id);
  }

  Future<void> _getFeedDetail({required String id}) async {
    try {
      _feed = (await _getDetailFeedDetailUseCase.execute(id: id)) ??
          (throw Exception());
      _userProfile =
          await _getUserProfileUseCase.execute(email: _feed!.userEmail);
    } catch (e) {
      notifyException(exception: e);
    }
    notifyListeners();
  }

  @override
  ExceptionStatus exceptionToExceptionStatus({required Object? exception}) {
    log(exception.toString(),
        name: 'OotdDetailViewModel.exceptionToExceptionStatus()');
    switch (exception) {
      case _:
        ExceptionAlertType status = ExceptionAlertType.snackBar;
        return ExceptionStatus(message: '네트워크 오류', exceptionAlertType: status);
    }
  }
}
