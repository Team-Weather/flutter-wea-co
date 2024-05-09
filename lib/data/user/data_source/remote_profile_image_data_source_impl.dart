import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/data/user/data_source/remote_profile_image_data_source.dart';
import 'package:weaco/domain/user/model/profile_image.dart';

class RemoteProfileImageDataSourceImpl implements RemoteProfileImageDataSource {
  final FirebaseFirestore _firestore;

  RemoteProfileImageDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<ProfileImage>> getProfileImageList() async {
    QuerySnapshot<Map<String, dynamic>> result =
        await _firestore.collection('profile_images').get();
    return result.docs
        .map((e) => ProfileImage(id: e.id, imagePath: e.data()['image_path']))
        .toList();
  }
}
