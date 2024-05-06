import 'package:weaco/main.dart';

class HiveWrapper {
  Future<void> writeData<E>(String key, E value) async {
    await dataBox.put(key, value);
  }

  Future<String> readData(String key) async {
    return await dataBox.get(key);
  }

  void deleteData(String key) async {
    await dataBox.delete(key);
  }
}
