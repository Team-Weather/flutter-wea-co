import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/file/use_case/save_image_use_case.dart';

enum PictureCropSaveStatus {
  idle,
  success,
  error;

  bool get isIdle => this == PictureCropSaveStatus.idle;

  bool get isSuccess => this == PictureCropSaveStatus.success;

  bool get isError => this == PictureCropSaveStatus.error;
}

class PictureCropViewModel with ChangeNotifier {
  final SaveImageUseCase _saveImageUseCase;
  PictureCropSaveStatus _status = PictureCropSaveStatus.idle;

  PictureCropViewModel({
    required SaveImageUseCase saveImageUseCase,
  }) : _saveImageUseCase = saveImageUseCase;

  /// 원본 이미지 저장
  Future<void> saveOriginImage({required File file}) async {
    await _saveImageUseCase.execute(isOrigin: true, file: file);
  }

  /// 크롭 이미지 저장
  Future<void> saveCroppedImage({required File file}) async {
    final bool result =
        await _saveImageUseCase.execute(isOrigin: false, file: file);

    if (result) {
      _status = PictureCropSaveStatus.success;
    } else {
      _status = PictureCropSaveStatus.error;
    }
    notifyListeners();
  }

  PictureCropSaveStatus get status => _status;
}
