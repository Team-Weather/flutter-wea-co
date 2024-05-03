abstract interface class FileRepository {
  Future<bool> saveData({required List<int> data});

  Future<bool> removeCroppedImage();
}
