import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StorageService {
  final box = GetStorage();

  void remove() {
    box.erase();
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
