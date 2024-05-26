// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:mechanic_app/app/core/local_storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesImpl implements ILocalStorage {
  // SharedPreferencesImpl({
  //   required SharedPreferences instance,
  // }) : _instance = instance;

  // final SharedPreferences _instance;

  @override
  Future<dynamic> get(String key) async {
    final _instance = await SharedPreferences.getInstance();
    final result = _instance.getString(key);

    if (result != null) {
      return jsonDecode(result);
    }
    return null;
  }

  @override
  Future<void> remove(String key) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.remove(key);
  }

  @override
  Future<void> save(String key, value) async {
    final _instance = await SharedPreferences.getInstance();
    _instance.setString(key, json.encode(value));
  }
}
