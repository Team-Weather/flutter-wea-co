import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weaco/core/db/transaction_service.dart';

class FirestoreService implements TransactionService {
  final FirebaseFirestore _fireStore;

  const FirestoreService({
    required FirebaseFirestore fireStore,
  }) : _fireStore = fireStore;

  @override
  Future<bool> run(Function callBack) async {
    return _fireStore.runTransaction<bool>((transaction) async {
      return await callBack(transaction);
    }).then(
      (value) => true,
      onError: (e) {
        print("Error updating document $e");
        throw Exception('피드 업로드에 실패 하였습니다.');
      },
    );
  }
}
