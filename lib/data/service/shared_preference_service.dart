import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _preferences;

  Future<void> saveToken(String token) async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.setString('token', token);
  }

  Future<String?> getToken() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences!.getString('token');
  }

  Future<void> clearToken() async {
    _preferences = await SharedPreferences.getInstance();
    await _preferences!.remove('token');
  }
}
