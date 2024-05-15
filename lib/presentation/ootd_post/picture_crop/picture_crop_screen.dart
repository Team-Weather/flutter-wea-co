import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/ootd_post/picture_crop/picutre_crop_view_model.dart';

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
  void initState() {
    super.initState();
    _cropImage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  Future<void> _cropImage() async {
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
      _croppedFile = croppedFile;

      _cropResult();
    }
  }

  void _cropResult() async {
    final PictureCropViewModel viewModel = context.read<PictureCropViewModel>();
    if (_croppedFile == null) {
      return;
    } else {
      await viewModel.saveOriginImage(file: File(widget.sourcePath));

      await viewModel.saveCroppedImage(file: File(_croppedFile!.path));

      if (viewModel.status.isSuccess) {
        if (mounted) {
          RouterStatic.goToOotdPost(context);
        }
      } else if (viewModel.status.isError) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('잠시 후 다시 시도해 주시기 바랍니다.'),
            ),
          );
        }
      }
    }
  }
}
