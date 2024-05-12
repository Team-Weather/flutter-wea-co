import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NewOotd extends StatefulWidget {
  const NewOotd({super.key});

  @override
  State<NewOotd> createState() => _NewOotdState();
}

class _NewOotdState extends State<NewOotd> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() => checkPermission());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카메라'),
        centerTitle: true,
      ),
    );
  }

  Future<void> checkPermission() async {
    if (await Permission.camera.status.isDenied ||
        await Permission.storage.status.isDenied) {
      await [Permission.camera, Permission.storage].request();

      if (await Permission.camera.isGranted &&
          await Permission.storage.isGranted) {
        debugPrint('isGranted');
      } else {
        debugPrint('isDenied');
      }
    }
  }
}
