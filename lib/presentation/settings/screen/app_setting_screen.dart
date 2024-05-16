import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
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
        title: const Center(child: Text('설정')),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => RouterStatic.popToHome(context)),
        backgroundColor: Theme
            .of(context)
            .canvasColor,
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => RouterStatic.pushToAppSettingPolicy(context),
                  child: Text(
                    '개인정보처리방침',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () async {
                    bool isSuccessLogOut = context.read<AppSettingViewModel>().isLogOuting;
                    if (isSuccessLogOut) {
                      RouterStatic.goToHome(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('로그아웃에 실패했습니다.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '로그아웃',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () async {
                    bool isSuccess = context.read<AppSettingViewModel>().isSignOuting;
                    if (isSuccess) {
                      RouterStatic.goToHome(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('회원탈퇴에 성공했습니다.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('회원탈퇴에 실패했습니다.'),
                        ),
                      );
                    }
                  },
                  child: Text(
                    '회원탈퇴',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
                child:
                Text('버전 v ${versionInfo?.version ?? '0.0.0.'}')),
          ],
        ),
      ),
    );
  }
}
