import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/core/util/validation_util.dart';
import 'package:weaco/presentation/common/style/image_path.dart';
import 'package:weaco/presentation/common/user_provider.dart';
import 'package:weaco/presentation/common/util/alert_util.dart';
import 'package:weaco/presentation/sign_in/view_model/sign_in_view_model.dart';

import '../../common/enum/exception_alert.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailFormController = TextEditingController();
  final TextEditingController passwordFormController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSignInButtonEnabled = false;
  bool isSignInSubmit = false;

  @override
  void dispose() {
    emailFormController.dispose();
    passwordFormController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Image.asset(
                          ImagePath.weacoLogoWithTypo,
                          width: 180,
                        ),
                      ),
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
      ),
    );
  }

  Widget _buildLoginTexts() {
    return const Column(
      children: [
        Text(
          '로그인이 필요합니다.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF1A1C29),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Weaco 서비스를 더 이용하시려면\n로그인이 필요해요.',
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
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(focusNode);
                  },
                  cursorColor: const Color(0xFFFDCE55),
                  decoration: InputDecoration(
                    hintText: '이메일',
                    hintStyle: const TextStyle(
                      color: Color(0xFF797979),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    fillColor: const Color(0xFFF3F3F3),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFFD9D9D9)),
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
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordFormController,
                  focusNode: focusNode,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _signInSubmit();
                  },
                  cursorColor: const Color(0xFFFDCE55),
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: '비밀번호',
                      hintStyle: const TextStyle(
                        color: Color(0xFF797979),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      fillColor: const Color(0xFFF3F3F3),
                      filled: true,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFFD9D9D9)),
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
      color: const Color(0xffF5F5F5),
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
        onTap: _signInSubmit,
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
        onTap: () => RouterStatic.pushToSignUp(context),
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
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _signInSubmit() {
    if (isSignInButtonEnabled == false) return;

    final SignInViewModel signInViewModel = context.read<SignInViewModel>();

    if (isSignInSubmit) {
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '이미 로그인 시도하였습니다.');
      return;
    }

    signInViewModel
        .signIn(
            email: emailFormController.text,
            password: passwordFormController.text)
        .then((_) {
      context.read<UserProvider>().signIn(email: emailFormController.text);
      RouterStatic.goToDefault(context);
    }).catchError((e) {
      AlertUtil.showAlert(
        context: context,
        exceptionAlert: signInViewModel.exceptionState?.exceptionAlert ??
            ExceptionAlert.snackBar,
        message: signInViewModel.exceptionState?.message ?? '$e',
      );
    });
    isSignInSubmit = true;
  }

  void _isValidateForm() {
    isSignInSubmit = false;
    isSignInButtonEnabled =
        (RegValidationUtil.isValidEmail(emailFormController.text) &&
            RegValidationUtil.isValidPassword(passwordFormController.text));
    setState(() {});
  }

  bool get _isSignUpButtonVisible {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  String? _checkEmailErrorText() {
    return (emailFormController.text.isEmpty ||
            RegValidationUtil.isValidEmail(emailFormController.text))
        ? null
        : '이메일 형식이 올바르지 않습니다';
  }

  String? _checkPasswordErrorText() {
    return (passwordFormController.text.isEmpty ||
            RegValidationUtil.isValidPassword(passwordFormController.text))
        ? null
        : '비밀번호는 8자 이상, 숫자, 특수문자를 포함해야 합니다';
  }
}
