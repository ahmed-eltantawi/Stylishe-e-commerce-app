import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  late final SharedPreferences _preferences;

  //! Here The Initialization of Shared Preferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //! This Method Put Data To local Database of any Type with Key
  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return _preferences.setString(key, value);
    }

    if (value is int) {
      return _preferences.setInt(key, value);
    }

    if (value is bool) {
      return _preferences.setBool(key, value);
    }

    if (value is double) {
      return _preferences.setDouble(key, value);
    }

    if (value is List<String>) {
      return _preferences.setStringList(key, value);
    }

    throw UnsupportedError(
      'The type ${value.runtimeType} is not supported by SharedPreferences.',
    );
  }

  //! This Method Get Data From local Database of any Type with Key
  dynamic getData({required String key}) {
    return _preferences.get(key);
  }

  //! This Method Get String Data From local Database with Key
  String? getString({required String key}) {
    return _preferences.getString(key);
  }

  //! This Method Get Integer Data From local Database with Key
  int? getInt({required String key}) {
    return _preferences.getInt(key);
  }

  //! This Method Get Boolean Data From local Database with Key
  bool? getBool({required String key}) {
    return _preferences.getBool(key);
  }

  //! This Method Get Double Data From local Database with Key
  double? getDouble({required String key}) {
    return _preferences.getDouble(key);
  }

  //! This Method Get String List Data From local Database with Key
  List<String>? getStringList({required String key}) {
    return _preferences.getStringList(key);
  }

  //! This Method Check of this Key is exist
  bool containsKey({required String key}) {
    return _preferences.containsKey(key);
  }

  //! This Method Remove Data From local Database with Key
  Future<bool> removeData({required String key}) {
    return _preferences.remove(key);
  }

  //! This Method Remove All Data From local Database
  Future<bool> clearData() {
    return _preferences.clear();
  }

  //! This Method Update Data
  Future<bool> updateData({
    required String key,
    required dynamic value,
  }) {
    return saveData(key: key, value: value);
  }
}
