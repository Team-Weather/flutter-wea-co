import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weaco/presentation/common/style/colors.dart';
import 'package:weaco/core/go_router/router_static.dart';

class RecommandLoginBottomSheetWidget extends StatelessWidget {
  const RecommandLoginBottomSheetWidget({
    super.key,
    required this.context,
    this.message,
  });

  final BuildContext context;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message ?? '회원 전용 서비스입니다.\n회원가입 또는 로그인 후 이용해주세요 😎',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 로그인 버튼
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  WeacoColors.greyColor80,
                ),
              ),
              onPressed: () {
                RouterStatic.goToSignIn(context);
                context.pop();
              },
              child: const Text(
                '로그인 하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // 회원가입 버튼
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  WeacoColors.accentColor,
                ),
              ),
              onPressed: () {
                RouterStatic.pushToSignUp(context);
                context.pop();
              },
              child: const Text(
                '회원가입 하기',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
