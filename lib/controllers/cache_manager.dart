import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  final box = GetStorage();

  Future<bool> saveToken(String? token) async {
    await box.write('token', token);
    return true;
  }

  String? getToken() {
    return box.read('token');
  }

  Future<void> removeToken() async {
    await box.remove('token');
  }
}
