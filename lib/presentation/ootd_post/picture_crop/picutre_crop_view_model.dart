import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:weaco/domain/file/use_case/get_image_use_case.dart';
import 'package:weaco/domain/file/use_case/save_image_use_case.dart';

class PictureCropViewModel with ChangeNotifier {
  final SaveImageUseCase _saveImageUseCase;
  final GetImageUseCase _getImageUseCase;
  File? _file;

  PictureCropViewModel({
    required SaveImageUseCase saveImageUseCase,
    required GetImageUseCase getImageUseCase,
  })  : _saveImageUseCase = saveImageUseCase,
        _getImageUseCase = getImageUseCase;

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
