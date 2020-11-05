import 'package:get_storage/get_storage.dart';

class StorageService {
  final box = GetStorage();

  void remove() {
    box.remove('id');
  }

  void save(String key, String value) {
    try {
      box.write('$key', '$value');
    } catch (e) {
      print(e);
    }
  }

  String read(String key) {
    try {
      var data = box.read('$key');
      return data;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
