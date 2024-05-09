import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:weaco/core/hive/hive_wrapper.dart';

class MockHiveWrapper implements HiveWrapper {
  Box? dataBox;
  String? mockKey;
  String? mockValue;

  Future<void> initMockData() async {
    await setUpTestHive();
    dataBox = await Hive.openBox('weacoBox');
  }

  @override
  Future<void> writeData(String key, String value) async {
    mockKey = key;
    mockValue = value;
    await dataBox!.put(mockKey, value);
  }

  @override
  Future<String> readData(String key) async {
    mockKey = key;
    return await dataBox!.get(key);
  }

  @override
  void deleteData(String key) async {
    await dataBox!.delete(key);
  }
}
