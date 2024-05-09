import 'dart:io';
import 'package:weaco/domain/common/file/model/profile_image.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

abstract interface class FileRepository {
  Future<File?> getImage({required bool isOrigin});

  Future<bool> saveImage({required bool isOrigin, required File file});

  Future<List<ProfileImage>> getProfileImageList();
}
