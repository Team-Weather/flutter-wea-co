import 'package:weaco/domain/user/model/user_profile.dart';

abstract interface class UserProfileRepository {
  Future<UserProfile?> getDetailUserProfile({required String email});
}