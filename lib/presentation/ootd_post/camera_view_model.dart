import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraViewModel with ChangeNotifier {
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  void pickImage({
    required ImageSource imageSource,
    required Function(String) callback,
  }) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? pickedFile = await picker.pickImage(source: imageSource);

      if (pickedFile != null) {
        _imageFile = pickedFile;
      } else {
        debugPrint('이미지 선택 안 함');
      }
    } on PlatformException {
      callback('access_denied');
    }

    notifyListeners();
  }
}
