import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String> getDataSecureStore(String key) async {
  return await storage.read(key: key);
}

Future<Map<String, String>> getAllDataSecureStore() async {
  return await storage.readAll();
}

void deleteDataSecureStore(String key) async {
  await storage.delete(key: key);
}

void deleteAllDataSecureStore() async {
  await storage.deleteAll();
}

void writeDataSecureStore(String key, String value) {
  storage.write(key: key, value: value);
}
