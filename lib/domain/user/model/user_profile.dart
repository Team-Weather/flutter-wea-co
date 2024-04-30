class UserProfile {
  final String email;
  final String nickname;
  final int gender;
  final String profileImagePath;
  final int feedCount;
  final DateTime createdAt;
  final DateTime? deletedAt;

  UserProfile({
    required this.email,
    required this.nickname,
    required this.gender,
    required this.profileImagePath,
    required this.feedCount,
    required this.createdAt,
    this.deletedAt,
  });

  @override
  String toString() {
    return 'UserProfile{email: $email, nickname: $nickname, gender: $gender, profileImagePath: $profileImagePath, feedCount: $feedCount, createdAt: $createdAt, deletedAt: $deletedAt}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          nickname == other.nickname &&
          gender == other.gender &&
          profileImagePath == other.profileImagePath &&
          feedCount == other.feedCount &&
          createdAt == other.createdAt &&
          deletedAt == other.deletedAt;

  @override
  int get hashCode =>
      email.hashCode ^
      nickname.hashCode ^
      gender.hashCode ^
      profileImagePath.hashCode ^
      feedCount.hashCode ^
      createdAt.hashCode ^
      deletedAt.hashCode;
}
