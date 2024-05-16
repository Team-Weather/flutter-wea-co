import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppSettingPolicyScreen extends StatefulWidget {
  const AppSettingPolicyScreen({super.key});

  @override
  State<AppSettingPolicyScreen> createState() => _AppSettingPolicyScreenState();
}

class _AppSettingPolicyScreenState extends State<AppSettingPolicyScreen> {
  bool _isPageLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;

    params = const PlatformWebViewControllerCreationParams();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..loadRequest(Uri.parse('https://sites.google.com/view/weaco/'))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() => _isPageLoading = true);
          },
          onPageFinished: (_) {
            setState(() => _isPageLoading = false);
          },
        ),
      );

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text(
          '개인정보처리방침',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isPageLoading)
            Stack(children: [
              Container(color: Colors.white),
              const Center(child: CircularProgressIndicator()),
            ]),
        ],
      ),
    );
  }
}
