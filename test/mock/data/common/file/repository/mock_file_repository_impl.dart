import 'dart:io';
import 'package:weaco/domain/common/file/model/profile_image.dart';
import 'package:weaco/domain/common/file/repository/file_repository.dart';
import 'package:weaco/domain/weather/model/weather_background_image.dart';

class MockFileRepositoryImpl implements FileRepository {
  int getImageCallCount = 0;
  int saveImageCallCount = 0;
  int getProfileImageListCallCount = 0;
  final Map<String, dynamic> methodParameterMap = {};
  File? getImageResult;
  bool saveImageResult = false;
  List<ProfileImage> getProfileImageResult = [];

  void initMockData() {
    getImageCallCount = 0;
    saveImageCallCount = 0;
    getProfileImageListCallCount = 0;
    methodParameterMap.clear();
  }

  @override
  Future<File?> getImage({required bool isOrigin}) async {
    getImageCallCount++;
    return getImageResult;
  }

  @override
  Future<bool> saveImage({required bool isOrigin, required File file}) async {
    saveImageCallCount++;
    methodParameterMap['data'] = file;
    return saveImageResult;
  }

  @override
  Future<List<ProfileImage>> getProfileImageList() async {
    getProfileImageListCallCount++;
    return getProfileImageResult;
  }
}
