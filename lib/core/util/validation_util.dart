class RegValidationUtil {
  static bool isValidPassword(String password) {
    return RegExp(r'''
^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).{8,}$''')
        .hasMatch(password);
  }

  static bool isValidEmail(String email) {
    return RegExp(r'''
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''').hasMatch(email);
  }

  static bool isValidConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword && isValidPassword(confirmPassword);
  }

  static bool isValidNickname(String text) {
    return RegExp(r'''
(?:[가-힣]{3,})|(?:[a-zA-Z]{3,})''').hasMatch(text);
  }
}
