import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/domain/user/use_case/get_user_profile_use_case.dart';

class MockGetUserProfileUseCase implements GetUserProfileUseCase {
  int executeCallCount = 0;
  String methodParameter = '';
  UserProfile? returnValue;

  void initMockData() {
    executeCallCount = 0;
    methodParameter = '';
    returnValue = null;
  }

  /// [execute] 호출시
  /// [executeCallCount] + 1
  /// [methodParameter] 에 전달 받은 인자 저장
  /// [returnValue] 반환
  @override
  Future<UserProfile?> execute({required String email}) async {
    executeCallCount++;
    methodParameter = email;
    return await Future.value(returnValue);
  }
}
