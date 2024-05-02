abstract interface class UserAuthRepository {
    Future<bool> logOutSetting({required String email});
}