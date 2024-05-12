bool isValidPassword(String password) {
  final passwordReg = RegExp(r'''
^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).{8,}$''')
      .hasMatch(password);
  return passwordReg;
}

bool isValidEmail(String email) {
  final emailReg = RegExp(r'''
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''').hasMatch(email);
  return emailReg;
}