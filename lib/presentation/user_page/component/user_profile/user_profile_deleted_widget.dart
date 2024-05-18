import 'package:flutter/material.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class UserProfileDeletedWidget extends StatelessWidget {
  final UserProfile _userProfile;

  const UserProfileDeletedWidget({
    super.key,
    required UserProfile userProfile,
  }) : _userProfile = userProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                maxRadius: 26,
                backgroundImage: NetworkImage(_userProfile.profileImagePath),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    _userProfile.nickname,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff9F9F9F),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '게시물 0',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xff9F9F9F),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
