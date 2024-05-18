import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/util/alert_util.dart';
import 'package:weaco/presentation/settings/view_model/app_setting_view_model.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppSettingViewModel>().getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppSettingViewModel>();
    final versionInfo = viewModel.packageInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () =>
                      RouterStatic.pushToAppSettingLicense(context),
                  child: Text(
                    '라이선스',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => RouterStatic.pushToAppSettingPolicy(context),
                  child: Text(
                    '개인정보처리방침',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => AlertUtil.showAlert(
                    context: context,
                    exceptionAlert: ExceptionAlert.dialogTwoButton,
                    message: '로그아웃 하시겠습니까?',
                    leftButtonText: '취소',
                    rightButtonText: '확인',
                    onPressedLeft: () => Navigator.of(context).pop(),
                    onPressedRight: _logOutSubmit,
                  ),
                  child: Text(
                    '로그아웃',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => AlertUtil.showAlert(
                    context: context,
                    exceptionAlert: ExceptionAlert.dialogTwoButton,
                    message: '회원탈퇴 하시겠습니까?',
                    leftButtonText: '취소',
                    rightButtonText: '확인',
                    onPressedLeft: () => Navigator.of(context).pop(),
                    onPressedRight: _signOutSubmit,
                  ),
                  child: Text(
                    '회원탈퇴',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(child: Text('버전 v ${versionInfo?.version ?? '0.0.0.'}')),
          ],
        ),
      ),
    );
  }

  void _logOutSubmit() async {
    bool isSuccessLogOut = context.read<AppSettingViewModel>().isLogOuting;

    if (isSuccessLogOut) {
      RouterStatic.goToHome(context);
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '로그아웃에 성공했습니다.');
    } else {
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '로그아웃에 실패했습니다.');
    }
  }

  void _signOutSubmit() async {
    bool isSuccessSignOut = context.read<AppSettingViewModel>().isSignOuting;

    if (isSuccessSignOut) {
      RouterStatic.goToHome(context);
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '회원탈퇴에 성공했습니다.');
    } else {
      AlertUtil.showAlert(
          context: context,
          exceptionAlert: ExceptionAlert.snackBar,
          message: '회원탈퇴에 실패했습니다.');
    }
  }
}
