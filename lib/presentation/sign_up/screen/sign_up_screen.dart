import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/core/enum/gender_code.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/core/util/validation_util.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/user_provider.dart';
import 'package:weaco/presentation/common/util/alert_util.dart';
import 'package:weaco/presentation/sign_up/view_model/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailFormController = TextEditingController();
  final TextEditingController passwordFormController = TextEditingController();
  final TextEditingController passwordConfirmFormController =
      TextEditingController();
  final TextEditingController nicknameFormController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSignUpButtonEnabled = false;
  bool isSignUpSubmit = false;
  GenderCode selectedGender = GenderCode.unknown;

  @override
  void dispose() {
    emailFormController.dispose();
    passwordFormController.dispose();
    passwordConfirmFormController.dispose();
    nicknameFormController.dispose();
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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildForm(),
                  ],
                ),
              ),
            ),
          ),
          _buildSignUpButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: Image.network(ImagePath.weacoLogo).image,
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 8),
          const Text(
            '회원가입',
            style: TextStyle(
              color: Color(0xFF1A1C29),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '첫 회원가입이네요! 기본정보를 입력해주세요',
            style: TextStyle(
              color: Color(0xFF797979),
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SizedBox(
      // width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInputField(
            labelText: '이메일',
            controller: emailFormController,
            isAutoFocus: true,
          ),
          _buildInputField(
            labelText: '비밀번호',
            controller: passwordFormController,
            isObscureText: true,
          ),
          _buildInputField(
            labelText: '비밀번호 확인',
            controller: passwordConfirmFormController,
            isObscureText: true,
          ),
          _buildInputField(
            labelText: '닉네임',
            controller: nicknameFormController,
          ),
          _buildGenderSelection(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    bool isObscureText = false,
    bool isAutoFocus = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: isObscureText,
            autofocus: isAutoFocus,
            textInputAction: labelText == '닉네임'
                ? TextInputAction.done
                : TextInputAction.next,
            onFieldSubmitted: (_) {
              if (labelText == '닉네임') {
                _signUpSubmit();
              }
            },
            cursorColor: const Color(0xFFFDCE55),
            decoration: InputDecoration(
              hintText: labelText,
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
              errorText: _checkErrorText(labelText),
            ),
            onChanged: (value) {
              _isValidateForm();
            },
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _handleGenderSelection(GenderCode.man),
            child: _buildGenderOption(
                GenderCode.man.name, selectedGender == GenderCode.man),
          ),
        ),
        const SizedBox(width: 16), // Add some space between
        Expanded(
          child: GestureDetector(
            onTap: () => _handleGenderSelection(GenderCode.women),
            child: _buildGenderOption(
                GenderCode.women.name, selectedGender == GenderCode.women),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender, bool isSelected) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xF5F5F5FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFFFDCE55) : const Color(0xFFD9D9D9),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.check_circle,
              color: isSelected
                  ? const Color(0xFFFDCE55)
                  : const Color(0xFFD9D9D9),
            ),
            const SizedBox(width: 8),
            // Add some space between the icon and the text
            Text(
              gender,
              style: const TextStyle(
                color: Color(0xFF1A1C29),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      color: const Color(0xF5F5F5FF),
      child: InkWell(
        onTap: isSignUpButtonEnabled ? _signUpSubmit : null,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: isSignUpButtonEnabled
                ? const Color(0xFFFDCE55)
                : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.center,
          child: const Text(
            '가입하기',
            style: TextStyle(
              color: Color(0xF5F5F5FF),
              fontSize: 16,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _signUpSubmit() {
    if (isSignUpButtonEnabled == false) return;

    if (isSignUpSubmit) {
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '이미 회원가입을 시도하였습니다.');
      return;
    }

    final SignUpViewModel signUpViewModel = context.read<SignUpViewModel>();
    signUpViewModel
        .signUp(
      email: emailFormController.text,
      password: passwordFormController.text,
      nickname: nicknameFormController.text,
      genderCode: selectedGender,
    )
        .then((_) {
      context.read<UserProvider>().signIn(email: emailFormController.text);
      AlertUtil.showAlert(
        context: context,
        exceptionAlert: ExceptionAlert.dialog,
        message: '회원가입에 성공하였습니다.',
        buttonText: '둘러보기',
        onPressedCheck: () => RouterStatic.goToHome(context),
      );
    },).catchError((e) {
      AlertUtil.showAlert(
        context: context,
        exceptionAlert: signUpViewModel.exceptionState!.exceptionAlert,
        message: signUpViewModel.exceptionState!.message,
      );
    });
    isSignUpSubmit = true;
  }

  void _isValidateForm() {
    isSignUpButtonEnabled =
        (RegValidationUtil.isValidEmail(emailFormController.text) &&
            RegValidationUtil.isValidPassword(passwordFormController.text) &&
            RegValidationUtil.isValidNickname(nicknameFormController.text) &&
            RegValidationUtil.isValidConfirmPassword(
                passwordFormController.text,
                passwordConfirmFormController.text) &&
            selectedGender != GenderCode.unknown);
    setState(() {});
  }

  void _handleGenderSelection(GenderCode genderCode) {
    selectedGender = genderCode;
    _isValidateForm();
  }

  String? _checkErrorText(String label) {
    isSignUpSubmit = false;

    return switch (label) {
      '이메일' => emailFormController.text.isEmpty ||
              RegValidationUtil.isValidEmail(emailFormController.text)
          ? null
          : '이메일 형식이 올바르지 않습니다',
      '비밀번호' => passwordFormController.text.isEmpty ||
              RegValidationUtil.isValidPassword(passwordFormController.text)
          ? null
          : '비밀번호는 8자 이상, 숫자, 특수문자를 포함해야 합니다',
      '비밀번호 확인' => passwordConfirmFormController.text.isEmpty ||
              RegValidationUtil.isValidConfirmPassword(
                  passwordFormController.text,
                  passwordConfirmFormController.text)
          ? null
          : '비밀번호가 일치하지 않습니다',
      '닉네임' => nicknameFormController.text.isEmpty ||
              RegValidationUtil.isValidNickname(nicknameFormController.text)
          ? null
          : '닉네임은 한글 또는 영문 3자 이상이어야 합니다',
      _ => null,
    };
  }
}
