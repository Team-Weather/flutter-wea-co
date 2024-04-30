class UserAuth {
  final String email;
  final String password;

  UserAuth({
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'UserAuth{email: $email, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAuth &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password;

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
