import 'package:flutter/material.dart';

class AppSettingLicenseScreen extends StatelessWidget {
  const AppSettingLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('라이선스')),
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: const LicensePage(),
    );
  }
}
