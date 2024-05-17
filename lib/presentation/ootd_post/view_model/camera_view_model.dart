import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraViewModel with ChangeNotifier {
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  /// 카메라 또는 사진첩에서 이미지 선택
  void pickImage({
    required ImageSource imageSource,
    required Function(bool) callback,
  }) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        debugPrint('이미지 선택 안 함');
      }
      callback(true);
    } on PlatformException {
      callback(false);
    }

    notifyListeners();
  }
}
