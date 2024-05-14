import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/presentation/ootd_post/picture_crop/picutre_crop_view_model.dart';

class PictureCropScreen extends StatefulWidget {
  const PictureCropScreen({super.key});

  @override
  State<PictureCropScreen> createState() => _PictureCropScreenState();
}

class _PictureCropScreenState extends State<PictureCropScreen> {
  late Future<void> _cropImageFuture;
  CroppedFile? _croppedFile;
  final String samplePath =
      '/data/data/team.weather.weaco/cache/0ddabc12-9269-428b-8123-b09d1230c5a62983180504067444417.jpg';

  @override
  void initState() {
    super.initState();
    _cropImageFuture = _cropImage(samplePath);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PictureCropViewModel>();

    return FutureBuilder(
      future: _cropImageFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          _cropResult(samplePath, viewModel);
          return const Scaffold(
            body: SizedBox(),
          );
        }
      },
    );
  }

  Future<void> _cropImage(String samplePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: samplePath,
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
      _croppedFile = croppedFile;
    }
  }

  void _cropResult(String samplePath, PictureCropViewModel viewModel) {
    if (_croppedFile == null) {
      return;
    } else {
      viewModel.saveOriginImage(file: File(samplePath));

      viewModel.saveCroppedImage(
        file: File(_croppedFile!.path),
        callback: (result) {
          if (result) {
            context.push(RouterPath.ootdPost.path);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('잠시 후 다시 시도해 주시기 바랍니다.'),
              ),
            );
          }
        },
      );
    }
  }
}
