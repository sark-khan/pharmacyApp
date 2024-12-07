import 'package:get_storage/get_storage.dart';

class AuthHelper {
  static final storage = GetStorage();

  static Future<void> saveToken(String token) async {
    await storage.write('authToken', token);
  }

  static String? getToken() {
    return storage.read('authToken');
  }

  static Future<void> clearToken() async {
    await storage.remove('authToken');
  }
}
