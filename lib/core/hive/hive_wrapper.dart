import 'package:hive/hive.dart';

class HiveWrapper {
  static late Box<String> dataBox;

  Future<void> writeData(String key, String value) async {
    await dataBox.put(key, value);
  }

  Future<String?> readData(String key) async {
    return dataBox.get(key);
  }
}
