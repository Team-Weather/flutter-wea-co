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
  Widget build(BuildContext context) {
    final viewModel = context.watch<AppSettingViewModel>();

    ///1. AppSettingScreen에서 AppSettingViewModel을 watch한다.
    return ChangeNotifierProvider(
      create: (context) => viewModel..getPackageInfo(),
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('설정')),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => RouterStatic.popToHome(context)),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body:
            Consumer<AppSettingViewModel>(builder: (context, viewModel, child) {
          return Padding(
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
                      onPressed: () =>
                          RouterStatic.pushToAppSettingPolicy(context),
                      child: Text(
                        '개인정보처리방침',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 8),

                    ///4. User가 로그아웃 메뉴를 터치 시 로그아웃 api를 호출한다.
                    /// 4-1. 서버에서 로그아웃 성공 응답 반환 시, 로그아웃 처리를 한다. (로그인 토큰 삭제 및 삭제해야 할
                    /// 캐시 삭제)
                    /// 4-2. 홈으로 이동한다. 스낵바로 로그아웃 성공 알림을 띄운다.
                    /// 4-3. 서버에서 로그아웃 실패 응답 반환 시, 스낵바로 로그아웃 실패 알림을 띄운다.
                    TextButton(
                      onPressed: () async {
                        await context.read<AppSettingViewModel>().logOut();
                        bool isSuccessLogOut = viewModel.isLogOuting; ///true 반환
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(height: 8),

                    ///5. User가 회원탈퇴 메뉴를 터치 시 회원탈퇴 api를 호출한다.
                    /// 5-1. 서버에서 탈퇴 성공 응답 반환 시, 로그인 토큰 삭제 및 캐시 삭제 처리 후 홈으로 이동한다.
                    /// 5-2. 스낵바로 탈퇴 성공 알림을 띄운다.
                    /// 5-3. 서버에서 탈퇴 실패 응답 반환 시, 스낵바로 회원탈퇴 실패 알림을 띄운다.
                    TextButton(
                      onPressed: () async {
                        await context.read<AppSettingViewModel>().signOut();
                        bool isSuccess = viewModel.isSignOuting;
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                    child: Text(
                        '버전 v ${viewModel.packageInfo?.version ?? '0.0.0'}')),
              ],
            ),
          );
        }),
      ),
    );
  }
}
