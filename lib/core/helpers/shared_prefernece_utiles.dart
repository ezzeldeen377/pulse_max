
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferneceUtiles {
  static String key = 'user';
  static Future<bool> saveData( String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value); 
  }
  static Future<String?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(key); 
  }
  static Future<bool> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key); 
  }
}