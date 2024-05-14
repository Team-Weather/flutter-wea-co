import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';

class PictureCropScreen extends StatefulWidget {
  final String sourcePath;

  const PictureCropScreen({
    super.key,
    required this.sourcePath,
  });

  @override
  State<PictureCropScreen> createState() => _PictureCropScreenState();
}

class _PictureCropScreenState extends State<PictureCropScreen> {
  CroppedFile? _croppedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              '확인',
              style: TextStyle(
                color: Color(0xFFFC8800),
                fontSize: 18,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _croppedFile != null
                ? SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Image.file(File(_croppedFile!.path)),
                    ),
                  )
                : const Text('이미지 없을 무'),
            ElevatedButton(
              onPressed: () async {
                await cropImage();
              },
              child: const Text('이미지 가져오기'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cropImage() async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: widget.sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true, // 비율 고정
        ),
        IOSUiSettings(
          title: '이미지 자르기',
          minimumAspectRatio: 1.0, // 비율 고정
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _croppedFile = croppedFile;
      });
    }
  }
}
