import 'package:get_storage/get_storage.dart';

class ELocalStorage {
  late final GetStorage _storage;

  static ELocalStorage? _instance;

  ELocalStorage._internal();

  factory ELocalStorage.instance() {
    _instance ??= ELocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = ELocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //save data

  Future<void> writeData<E>(String key, E value) async {
    await _storage.write(key, value);
  }

  //read data

  E? readData<E>(String key) {
    return _storage.read<E>(key);
  }

  //remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }
}
