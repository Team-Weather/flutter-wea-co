import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/ootd_post/camera_view_model.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CameraViewModel viewModel = context.watch<CameraViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('카메라'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (viewModel.imageFile != null)
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File(viewModel.imageFile!.path)),
            )
          else
            const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.lightBlueAccent,
            ),
          const SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => _onPressedButton(
                  viewModel: viewModel,
                  imageSource: ImageSource.camera,
                  context: context,
                ),
                icon: const Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
              ),
              IconButton(
                onPressed: () => _onPressedButton(
                  viewModel: viewModel,
                  imageSource: ImageSource.gallery,
                  context: context,
                ),
                icon: const Icon(
                  Icons.photo_library,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onPressedButton({
    required CameraViewModel viewModel,
    required ImageSource imageSource,
    required BuildContext context,
  }) {
    viewModel.pickImage(
      imageSource: imageSource,
      callback: (result) {
        if (result) {
          RouterStatic.goToPictureCrop(context, viewModel.imageFile!.path);
          // context.go(
          //   RouterPath.pictureCrop.path,
          //   extra: viewModel.imageFile!.path,
          // );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text(
                  "설정 변경은 '설정 > 알림 > weaco > 카메라'에서 할 수 있어요.",
                ),
                actions: [
                  TextButton(
                    onPressed: () => context.pop(),
                    child: const Text('닫기'),
                  ),
                  TextButton(
                    onPressed: () {
                      openAppSettings();
                      context.pop();
                    },
                    child: const Text('설정하러 가기'),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}
