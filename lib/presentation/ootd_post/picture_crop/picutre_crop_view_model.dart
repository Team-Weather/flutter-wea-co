import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/file/use_case/save_image_use_case.dart';

class PictureCropViewModel with ChangeNotifier {
  final SaveImageUseCase _saveImageUseCase;

  PictureCropViewModel({
    required SaveImageUseCase saveImageUseCase,
  })  : _saveImageUseCase = saveImageUseCase;

  /// 원본 이미지 저장
  void saveOriginImage({required File file}) async {
    await _saveImageUseCase.execute(isOrigin: true, file: file);
  }

  /// 크롭 이미지 저장
  void saveCroppedImage({
    required File file,
    required Function(bool) callback,
  }) async {
    final bool result =
        await _saveImageUseCase.execute(isOrigin: false, file: file);

    callback(result);
  }
}
