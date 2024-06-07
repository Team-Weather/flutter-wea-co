import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/firebase/firebase_auth_service.dart';
import 'package:weaco/core/firebase/firestore_dto_mapper.dart';
import 'package:weaco/data/user/data_source/remote_user_profile_data_source.dart';
import 'package:weaco/domain/user/model/user_profile.dart';

class RemoteUserProfileDataSourceImpl implements RemoteUserProfileDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuthService _firebaseService;

  const RemoteUserProfileDataSourceImpl({
    required FirebaseFirestore firestore,
    required FirebaseAuthService firebaseService,
  })  : _firestore = firestore,
        _firebaseService = firebaseService;

  @override
  Future<void> saveUserProfile({required UserProfile userProfile}) async {
    try {
      await _firestore
          .collection('user_profiles')
          .add(toUserProfileDto(userProfile: userProfile))
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
    email = email ?? _firebaseService.firebaseAuth.currentUser!.email;

    QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('user_profiles')
        .where('email', isEqualTo: email)
        .get();

    if (snapshot.docs.isEmpty) {
      throw Exception('유저 프로필이 존재하지 않습니다.');
    }

    return toUserProfile(json: snapshot.docs[0].data());
  }

  @override
  Future<void> updateUserProfile({
    required Transaction transaction,
    required UserProfile userProfile,
  }) async {
    try {
      // 기존 프로필 문서를 검색
      final originProfileQuery = await _firestore
          .collection('user_profiles')
          .where('email', isEqualTo: userProfile.email)
          .get();

      if (originProfileQuery.docs.isEmpty) {
        throw Exception('User profile not found');
      }

      final originProfileDocRef = originProfileQuery.docs[0].reference;
      transaction.set(
          originProfileDocRef, toUserProfileDto(userProfile: userProfile));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> removeUserProfile({String? email}) async {
    try {
      email = email ?? _firebaseService.firebaseAuth.currentUser!.email;

      final originProfileDocument = await _firestore
          .collection('user_profiles')
          .where('email', isEqualTo: email)
          .get();

      await _firestore
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
