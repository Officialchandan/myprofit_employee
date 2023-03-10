import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const LOGIN = "Login";
  static const TOKEN = "token";
  static const SELECTEDLANG = "selectedlan";
  static const VENDORID = "vendorid";
  static const LOCATION = "location_id";
  static const DEVICETOKEN = "device_id";
  static const NAME = "name";
  static const MOBILE = "mobile";
  static const EMP_STATUS = "emp_status";
  static const Cus_Reg_Status = "cus_reg_status";

  static Future<String> getStringPreference(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> setStringPreference(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<int> getIntegerPreference(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  static Future<bool> setIntegerPreference(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(key, value);
  }

  static Future<bool> setBooleanPreference(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBooleanPreference(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> clearSharedPreference(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
