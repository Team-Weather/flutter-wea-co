import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class RemoteUserProfileDataSourceImpl implements RemoteUserProfileDataSource {
  final FirebaseFirestore _firestore;

  RemoteUserProfileDataSourceImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<bool> saveUserProfile({required UserProfile userProfile}) async {
    try {
      return await _firestore
          .collection('user_profiles')
          .add(userProfile.toJson())
          .then((value) => true)
          .catchError(
            (e) => false,
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserProfile> getUserProfile({String? email}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('user_profiles')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('유저 프로필이 존재하지 않습니다.');
      }

      return UserProfile.fromJson(snapshot.docs[0].data());
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateUserProfile({required UserProfile userProfile}) async {
    try {
      final originProfileDocument = await _firestore
          .collection('user_profiles')
          .where('email', isEqualTo: userProfile.email)
          .get();

      return await _firestore
          .collection('user_profiles')
          .doc(originProfileDocument.docs[0].reference.id)
          .set(userProfile.toJson())
          .then((value) => true)
          .catchError(
            (e) => false,
          );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> removeUserProfile({required String email}) async {
    try {
      final originProfileDocument = await _firestore
          .collection('user_profiles')
          .where('email', isEqualTo: email)
          .get();

      return await _firestore
          .collection('user_profiles')
          .doc(originProfileDocument.docs[0].reference.id)
          .delete()
          .then((value) => true)
          .catchError(
            (e) => false,
          );
    } catch (e) {
      throw Exception(e);
    }
  }
}
