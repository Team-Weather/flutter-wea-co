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
                const Text(''),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '',
                style: TextStyle(
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
