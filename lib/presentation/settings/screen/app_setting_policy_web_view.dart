import 'dart:async';
import 'package:flutter/material.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
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
    Timer(const Duration(milliseconds: 3000), () {
      setState(() => _isPageLoading = false);
    });

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller.loadRequest(Uri.parse('https://sites.google.com/view/weaco/'));

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
          if (_isPageLoading)
            Stack(children: [
              const Center(child: CircularProgressIndicator()),
              Container(color: Colors.white)
            ]),
          WebViewWidget(controller: _controller),
        ],
      ),
    );
  }
}
