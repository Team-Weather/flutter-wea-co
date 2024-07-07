abstract interface class TransactionService {
  Future<bool> run(Function callBack);
}
