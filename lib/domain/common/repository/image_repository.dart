import 'package:weaco/domain/feed/model/feed.dart';

abstract interface class ImageRepository {
  Future<Feed> saveCroppedImage(String imagePath);
}
