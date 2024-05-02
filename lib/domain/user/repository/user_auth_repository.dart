abstract interface class UserAuthRepository {
    Future<bool> signOutSetting({required String email});
}