import 'package:flutter/material.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class UserProfileWidget extends StatelessWidget {
  final UserProfile _userProfile;

  const UserProfileWidget({
    super.key,
    required UserProfile userProfile,
  }) : _userProfile = userProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: CircleAvatar(
                maxRadius: 32,
                backgroundImage: NetworkImage(_userProfile.profileImagePath),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userProfile.nickname,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _userProfile.email.split('@')[0],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '게시물 ${_userProfile.feedCount}',
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
