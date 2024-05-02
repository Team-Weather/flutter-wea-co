import 'package:weaco/domain/user/model/user_profile.dart';

abstract interface class UserProfileRepository {
  Future<UserProfile?> getUserProfile({required String email});
}
