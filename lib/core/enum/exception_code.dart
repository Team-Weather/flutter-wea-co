enum ExceptionCode {
  unknownException(
    code: '500',
    errorMessage: '',
    alertMessage: '',
  ),
  internalServerException(
    code: '400',
    errorMessage: '',
    alertMessage: '',
  ),
  notFoundException(
    code: '404',
    errorMessage: '',
    alertMessage: '',
  ),
  userNotFoundException(
    code: 'user-not-found',
    errorMessage: '존재하지 않는 유저입니다.',
    alertMessage: '',
  ),
  wrongPasswordException(
    code: 'wrong-password',
    errorMessage: '비밀번호가 맞지 않습니다.',
    alertMessage: '',
  ),
  emailAlreadyInUseException(
    code: 'email-already-in-use',
    errorMessage: '이미 가입된 이메일입니다.',
    alertMessage: '',
  ),
  invalidEmailException(
    code: 'invalid-email',
    errorMessage: '이메일 형식이 올바르지 못합니다.',
    alertMessage: '',
  ),
  weakPasswordException(
    code: 'weak-password',
    errorMessage: '비밀번호 형식이 안전하지 않습니다.',
    alertMessage: '',
  ),
  networkRequestFailedException(
    code: 'network-request-failed',
    errorMessage: '네트워크가 불안정 합니다.',
    alertMessage: '',
  ),
  userDisabledException(
    code: 'user-disabled',
    errorMessage: '이미 탈퇴한 회원입니다.',
    alertMessage: '',
  ),
  invalidCredentialException(
      code: 'invalid-credential',
      errorMessage: '이메일과 비밀번호를 확인해주세요.',
      alertMessage: '');

  final String code;
  final String errorMessage;
  final String alertMessage;

  const ExceptionCode(
      {required this.code,
      required this.alertMessage,
      required this.errorMessage});

  static ExceptionCode fromStatus(String status) {
    return switch (status) {
      '500' => ExceptionCode.unknownException,
      '400' => ExceptionCode.internalServerException,
      '404' => ExceptionCode.notFoundException,
      'user-not-found' => ExceptionCode.userNotFoundException,
      'wrong-password' => ExceptionCode.wrongPasswordException,
      'email-already-in-use' => ExceptionCode.emailAlreadyInUseException,
      'invalid-email' => ExceptionCode.invalidEmailException,
      'weak-password' => ExceptionCode.weakPasswordException,
      'network-request-failed' => ExceptionCode.networkRequestFailedException,
      'user-disabled' => ExceptionCode.userDisabledException,
      'invaild-credential' => ExceptionCode.invalidCredentialException,
      _ => ExceptionCode.unknownException,
    };
  }
}
