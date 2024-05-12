import 'package:flutter/material.dart';

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
  bool isSignUpButtonEnabled = false;
  int selectedGenderIndex = -1; // 0 for '남자', 1 for '여자'

  @override
  void dispose() {
    emailFormController.dispose();
    passwordFormController.dispose();
    passwordConfirmFormController.dispose();
    nicknameFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 80, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildForm(),
                  ],
                ),
              ),
            ),
          ),
          _buildSignInButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlutterLogo(size: 40),
          SizedBox(height: 8),
          Text(
            '회원가입',
            style: TextStyle(
              color: Color(0xFF1A1C29),
              fontSize: 20,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          Text(
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
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInputField(
            labelText: '이메일',
            controller: emailFormController,
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
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: double.infinity,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            obscureText: isObscureText,
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
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _handleGenderSelection(0),
            child: _buildGenderOption('남자', selectedGenderIndex == 0),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => _handleGenderSelection(1),
            child: _buildGenderOption('여자', selectedGenderIndex == 1),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption(String gender, bool isSelected) {
    return Container(
      height: 56,
      margin: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? const Color(0xFFFDCE55) : const Color(0xFFF3F3F3),
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
              color: isSelected ? const Color(0xFFFDCE55) : const Color(0xFFF3F3F3),
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

  Widget _buildSignInButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
      color: const Color(0xFFFFFFFF),
      child: InkWell(
        onTap: isSignUpButtonEnabled ? () {} : null,
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

  void _isValidateForm() {
    isSignUpButtonEnabled = (_isValidEmail(emailFormController.text) &&
        _isValidPassword(passwordFormController.text) &&
        isValidString(nicknameFormController.text) &&
        selectedGenderIndex != -1 &&
        _isValidConfirmPassword(
            passwordFormController.text, passwordConfirmFormController.text));
    setState(() {});
  }

  bool _isValidPassword(String password) {
    final passwordReg = RegExp(r'''
^(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[a-zA-Z])(?=.*\d).{8,}$''')
        .hasMatch(password);
    return passwordReg;
  }

  bool _isValidEmail(String email) {
    final emailReg = RegExp(r'''
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$''').hasMatch(email);
    return emailReg;
  }

  bool _isValidConfirmPassword(String password, String confirmPassword) {
    return password == confirmPassword && _isValidPassword(confirmPassword);
  }

  bool isValidString(String text) {
    return RegExp(r'''
(?:[가-힣]{3,})|(?:[a-zA-Z]{3,})''').hasMatch(text);
  }

  void _handleGenderSelection(int index) {
    setState(() {
      selectedGenderIndex = index;
    });
  }
}
