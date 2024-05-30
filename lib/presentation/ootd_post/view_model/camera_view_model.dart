import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

enum CameraImageStatus {
  idle,
  success,
  error;

  bool get isIdle => this == CameraImageStatus.idle;

  bool get isSuccess => this == CameraImageStatus.success;

  bool get isError => this == CameraImageStatus.error;
}

class CameraViewModel with ChangeNotifier {
  XFile? _imageFile;
  CameraImageStatus _status = CameraImageStatus.idle;

  XFile? get imageFile => _imageFile;

  CameraImageStatus get status => _status;

  /// 카메라 또는 사진첩에서 이미지 선택
  Future<void> pickImage({
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        _imageFile = pickedFile;
        _status = CameraImageStatus.success;
      }
    } on PlatformException {
      _status = CameraImageStatus.error;
    }
    notifyListeners();
  }
}
