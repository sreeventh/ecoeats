import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPreferences? sp;
  static Future init() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future setString(String key, String val) async {
    sp!.setString(key, val);
  }

  static String getString(String key) {
    return sp!.getString(key).toString();
  }

  static Future setList(String key, List list) async {
    List<String> stringList = list.map((e) => e.toString()).toList();
    sp!.setStringList(key, stringList);
  }

  static List<String> getList(String key) {
    return sp!.getStringList(key)!;
  }

  static clear() {
    sp!.clear();
  }
}
