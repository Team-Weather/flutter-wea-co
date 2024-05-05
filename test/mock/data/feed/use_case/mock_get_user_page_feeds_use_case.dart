import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/feed/use_case/get_user_page_feeds_use_case.dart';

class MockGetUserPageFeedsUseCase implements GetUserPageFeedsUseCase {
  int executeCallCount = 0;
  Map<String, dynamic> methodParameterMap = {};
  List<Feed> returnValue = [];

  void initMockData() {
    executeCallCount = 0;
    methodParameterMap.clear();
    returnValue.clear();
  }

  /// [execute] 호출시
  /// [executeCallCount] + 1
  /// [methodParameterMap] 에 전달 받은 인자 저장
  /// [returnValue] 반환
  @override
  Future<List<Feed>> execute({
    required String email,
    required DateTime? createdAt,
    int? limit = 20,
  }) async {
    executeCallCount++;
    methodParameterMap = {
      'email': email,
      'createdAt': createdAt,
      'limit': limit,
    };
    return await Future.value(returnValue);
  }
}
