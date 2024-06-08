import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:weaco/core/db/transaction_service.dart';

class MockFirestoreServiceImpl implements TransactionService {
  final _fakeFirestore = FakeFirebaseFirestore();

  @override
  Future<bool> run(Function callBack) async {
    return await _fakeFirestore.runTransaction<bool>((transaction) async {
      return await callBack(transaction);
    }).then(
      (value) => true,
      onError: (e) {
        // throw Exception('피드 업로드에 실패 하였습니다.');
        throw Exception(e);
      },
    );
  }
}
