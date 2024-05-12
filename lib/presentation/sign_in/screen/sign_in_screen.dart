import 'package:flutter/material.dart';
import 'package:weaco/core/util/validation_util.dart';

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
                      color: const Color(0xFFFFFFFF),
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
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            width: double.infinity,
            height: 126,
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFFDCE55)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFD00B0B)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorStyle: const TextStyle(color: Color(0xFFD00B0B)),
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFFDCE55)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFD00B0B)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    errorStyle: const TextStyle(color: Color(0xFFD00B0B)),
                  ),
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
      height: !_isSignUpButtonVisible ? 70 : 140,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFFFFFFF),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSignInButtons(),
          const SizedBox(height: 8),
          if (_isSignUpButtonVisible) _buildSignUpButtons(),
        ],
      ),
    );
  }

  Widget _buildSignInButtons() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: InkWell(
        onTap: isSignInButtonEnabled ? () {} : null,
        child: Container(
          decoration: BoxDecoration(
            color: isSignInButtonEnabled
                ? const Color(0xFFFDCE55)
                : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
}
