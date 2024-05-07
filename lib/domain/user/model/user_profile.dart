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

  UserProfile copyWith({
    String? email,
    String? nickname,
    int? gender,
    String? profileImagePath,
    int? feedCount,
    DateTime? createdAt,
    DateTime? deletedAt,
  }) {
    return UserProfile(
      email: email ?? this.email,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      feedCount: feedCount ?? this.feedCount,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'nickname': nickname,
      'gender': gender,
      'profile_image_path': profileImagePath,
      'feed_count': feedCount,
      'created_at': createdAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      nickname: json['nickname'],
      gender: json['gender'],
      profileImagePath: json['profile_image_path'],
      feedCount: json['feed_count'],
      createdAt: DateTime.parse(json['created_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
    );
  }
}
