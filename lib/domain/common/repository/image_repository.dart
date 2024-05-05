abstract interface class ImageRepository {
  Future<bool> saveCroppedImage({required List<int> data});
}
