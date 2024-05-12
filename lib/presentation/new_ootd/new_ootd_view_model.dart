import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class NewOotdViewModel with ChangeNotifier {
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  void pickedImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _imageFile = pickedFile;
    } else {
      debugPrint('이미지 선택 안 함');
    }

    notifyListeners();
  }

  void pickedImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      debugPrint('path: ${pickedFile.path}');
      _imageFile = pickedFile;
    } else {
      debugPrint('이미지 선택 안 함');
    }

    notifyListeners();
  }
}
