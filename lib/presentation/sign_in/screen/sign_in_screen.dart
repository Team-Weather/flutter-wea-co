import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/di/di_setup.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/core/util/validation_util.dart';
import 'package:weaco/presentation/common/handler/exception_handle_dialog.dart';
import 'package:weaco/presentation/sign_in/view_model/sign_in_view_model.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailFormController = TextEditingController();
  final TextEditingController passwordFormController = TextEditingController();
  bool isSignInButtonEnabled = false;

  @override
  void dispose() {
    emailFormController.dispose();
    passwordFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildLogo(),
                    _buildLoginTexts(),
                    _buildLoginForm(),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return SizedBox(
      width: double.infinity,
      height: 360,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 244,
            height: 244,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              color: const Color(0xFFFFF9EC),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 22,
                  top: 95,
                  child: Container(
                    width: 200,
                    height: 54,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: const Color(0xF5F5F5FF),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const ShapeDecoration(
                            color: Color(0xFFD9D9D9),
                            shape: OvalBorder(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 8,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            const SizedBox(height: 7),
                            Container(
                              width: 143,
                              height: 8,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD9D9D9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTexts() {
    return const Column(
      children: [
        Text(
          '로그인이 필요합니다',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1A1C29),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Weaco 서비스를 더 이용하시려면\n로그인이 필요해요',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            width: double.infinity,
            child: Column(
              children: [
                TextFormField(
                  controller: emailFormController,
                  cursorColor: const Color(0xFFFDCE55),
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: const TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                    border: InputBorder.none,
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFFDCE55)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFD00B0B)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFD00B0B)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorStyle: const TextStyle(color: Color(0xFFD00B0B)),
                    errorText: _checkEmailErrorText(),
                  ),
                  onChanged: (value) {
                    _isValidateForm();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: passwordFormController,
                  cursorColor: const Color(0xFFFDCE55),
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: '비밀번호',
                      hintStyle: const TextStyle(
                        color: Color(0xFF797979),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                      border: InputBorder.none,
                      fillColor: const Color(0xFFF3F3F3),
                      filled: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFFFDCE55)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFFD00B0B)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFFD00B0B)),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      errorStyle: const TextStyle(color: Color(0xFFD00B0B)),
                      errorText: _checkPasswordErrorText()),
                  onChanged: (value) {
                    _isValidateForm();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      width: double.infinity,
      height: !_isSignUpButtonVisible ? 62 : 116,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xF5F5F5FF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSignInButtons(),
          if (_isSignUpButtonVisible) _buildSignUpButtons(),
        ],
      ),
    );
  }

  Widget _buildSignInButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 54,
      child: InkWell(
        onTap: isSignInButtonEnabled
            ? () {
                context
                    .read<SignInViewModel>()
                    .signIn(
                      email: emailFormController.text,
                      password: passwordFormController.text,
                    )
                    .then((_) => RouterStatic.goToHome(context))
                    .catchError((e) => getIt<ExceptionHandleDialog>()
                        .showOneButtonDialog(context, e));
              }
            : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSignInButtonEnabled
                ? const Color(0xFFFDCE55)
                : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: const Text(
            '로그인하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButtons() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: InkWell(
        onTap: () => RouterStatic.goToSignUp(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: const Text(
            '회원가입',
            style: TextStyle(
              color: Color(0xFF292929),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _isValidateForm() {
    isSignInButtonEnabled = (isValidEmail(emailFormController.text) &&
        isValidPassword(passwordFormController.text));
    setState(() {});
  }

  bool get _isSignUpButtonVisible {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  String? _checkEmailErrorText() {
    return (emailFormController.text.isEmpty ||
            isValidEmail(emailFormController.text))
        ? null
        : '이메일 형식이 올바르지 않습니다';
  }

  String? _checkPasswordErrorText() {
    return (passwordFormController.text.isEmpty ||
            isValidPassword(passwordFormController.text))
        ? null
        : '비밀번호는 8자 이상, 숫자, 특수문자를 포함해야 합니다';
  }
}
