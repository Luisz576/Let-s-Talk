import 'package:shared_preferences/shared_preferences.dart';

class Database{
  static const String _tokenPath = "user_login_token";

  static final _sharedPreferences = SharedPreferences.getInstance();

  static Future<String?> getSavedToken() async{
    final sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString(_tokenPath);
  }

  static Future<bool> saveToken(String token) async{
    final sharedPreferences = await _sharedPreferences;
    return await sharedPreferences.setString(_tokenPath, token);
  }

  static Future<bool> unsaveToken() async{
    final sharedPreferences = await _sharedPreferences;
    return await sharedPreferences.remove(_tokenPath);
  }
}